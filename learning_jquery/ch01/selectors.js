"use strict";

$(() => {
  $("#selected-plays > li").addClass("horizontal").addClass("big-letter");
  $("#selected-plays li:not(.horizontal)").addClass("sub-level");
});
