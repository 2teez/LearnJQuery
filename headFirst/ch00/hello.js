"use strict";

$(() => {
  $(".move-up").click(() => {
    $(".change-me").animate({ top: 30 }, 200);
  }); // end move-up click
  $(".move-down").click(() => {
    $(".change-me").animate({ top: 500 }, 2000);
  }); // end move-down click
  $(".color").click(() => {
    $(".change-me").css({ color: "purple" });
  }); // end color click
  $(".disappear").click(() => {
    $(".change-me").toggle("slow");
  }); // end disappear click
});
