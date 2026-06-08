#!/usr/bin/env bash
# Date: 05/06/2026
# Description: Learning CSS from the Beginning to Professional Level,
# 	       using 12 tiny projects.
# Author: omitida
#

function help_file() {
echo "${0} -<option> <filename>"

echo "Avaliable Options:"

echo "  -d: Delete the specified file."
echo "  -g: Create a generic css file attached to a html file."
echo "  -h: Display this help option."
echo "  -p: Create a full flage project directory with seperate folders for"
echo "      css, js and an index.html or index.php file"
echo "  -i: inline jquery file in a html file."
}

# global filename
filename="main"

HTMLFILE="
<!DOCTYPE html>
<html lang=\"en\">
    <head>
    <!-- Required meta tags always come first -->
    <meta charset=\"utf-8\" />
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" />
        <title>JQuery Practice</title>

        <!-- CSS -->
        <link
            rel=\"stylesheet\" text=\"text/css\" href=\"${filename##.*}.css\"
        >
        <!-- JQuery -->
        <script src=\"jquery.js\"></script>
        <script src=\"${filename##.*}.js\"></script>
    </head>
    <body>
        <?php
            echo \"Hello, World\n\";
        ?>

        <!-- JS. -->
        <script src=""></script>
    </body>
</html>
"

CSSFILE="
*{

}
"

[[ "${#}" -ne 2 ]] && { help_file; exit; }

optionstrings="d:g:p:i:h"

while getopts ${optionstrings} opt; do
    case ${opt} in
        d)
            echo "Deleting ${OPTARG}..."
            filename=$(basename "${OPTARG}")
            while read -r -p "Are you sure you want to delete ${filename}? (y/n): " answer; do
                case ${answer} in
                    y)
                        [[ -d "${filename}" ]] && { rm -rf "$filename"; break; }
                        rm -f "${filename}"
                        break
                        ;;
                    n)
                        echo "Deletion cancelled."
                        break
                        ;;
                    *)
                        echo "Invalid input. Please enter 'y' or 'n'."
                        ;;
                esac
            done
            ;;
        g)
            echo "Creating generic css file with html file with default content..."
            filename="${OPTARG}"
            echo "${CSSFILE}" > "${filename##.*}.css"
            echo "${HTMLFILE}" > "${filename##.*}.html"
            ! [[ -e "jquery.js" ]] && cp "$HOME/jquery-js-dwns/jquery-3.7.1.min.js" "jquery.js"
            touch "${filename##.*}.js"
            ;;
        p)
            echo "Creating project ${OPTARG}..."
            filename=$(basename "${OPTARG}")
            mkdir -p "${filename}" "${filename}/css" "${filename}/js"

            touch "${filename}/js/main.js"
            cp "$HOME/jquery-js-dwns/jquery-3.7.1.min.js" "${filename}/js/jquery.js"
            echo "${CSSFILE}" > "${filename}/css/main.css"
            echo "${HTMLFILE}" > "${filename}/index.html"
            perl -pi -e 's|href="main.css"|href="css/main.css"|g' "${filename}/index.html"
            perl -pi -e 's|src="jquery.js"|src="js/jquery.js"|g' "${filename}/index.html"
            perl -pi -e 's|src="main.js"|src="js/main.js"|g' "${filename}/index.html"
            ;;

        i)
            echo "Inlining jquery file in ${OPTARG}..."
            filename="${OPTARG}"
            css_file="${filename##.*}.css"
            html_file="${filename##.*}.html"
            echo "${CSSFILE}" > "${css_file}"
            echo "${HTMLFILE}" > "${html_file}"
            ! [[ -e "jquery.js" ]] && cp "$HOME/jquery-js-dwns/jquery-3.7.1.min.js" "jquery.js"
            perl -pi -e "s|src=\"main.js\"||g" "${html_file}"
            perl -pi -e "s|href=\"main.css\"|href=\"${css_file}\"|g" "${html_file}"
            ;;

        *)
            echo "Invalid option: -${OPTARG}" >&2
            exit 1
            ;;
    esac
done
