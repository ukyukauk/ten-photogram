import $ from "jquery";
import axios from "./axios_setup";
import { toggleButtonEvent } from "./modules/button_enabled";

$(document).on("turbo:load", function () {
  // ポスト投稿ボタン活性化
  $(document).on("input", "#post-content", function () {
    toggleButtonEvent($(this), $("#post-btn"));
  });

  // ポスト投稿ボタン活性/非活性判断
  if ($("#post-content").length && $("#post-btn").length) {
    toggleButtonEvent($("#post-content"), $("#post-btn"));
  }
});
