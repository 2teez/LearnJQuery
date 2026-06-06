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
        <title>CSS Projects</title>

        <!-- CSS -->
        <link
            rel=\"stylesheet\" text=\"text/css\" href=\"${filename##.*}.css\"
        >
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

optionstrings="d:g:p:h"

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
            ;;
        p)
            echo "Creating project ${OPTARG}..."
            filename=$(basename "${OPTARG}")
            mkdir -p "${filename}" "${filename}/css" "${filename}/js"

            touch "${filename}/js/main.js"
            echo "${CSSFILE}" > "${filename}/css/main.css"
            echo "${HTMLFILE}" > "${filename}/index.html"
            perl -pi -e 's|href="main.css"|href="css/main.css"|g' "${filename}/index.html"
            ;;
        *)
            echo "Invalid option: -${OPTARG}" >&2
            exit 1
            ;;
    esac
done
