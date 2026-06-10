"use strict";

$(document).ready(() => {
  $("img:odd")
    .mouseenter((e) => {
      $(this).css("opacity", 0.5);
    })
    .mouseout((e) => {
      $(this).css("opacity", 1);
    });
});
