import $ from "jquery";
import { toggleButtonEvent } from "./modules/button_enabled";

$(document)
  .off("turbo:load.posts")
  .on("turbo:load.posts", function () {
    // ポスト投稿ボタン
    $(document)
      .off("click.post", "#post-btn")
      .on("click.post", "#post-btn", function () {
        const $btn = $(this);
        const $form = $("#post-form");
        if ($form.length === 0) return;

        $btn.prop("disabled", true);
        $form.trigger("submit");
      });

    // ポスト投稿ボタン活性化
    $(document).on("input", "#post-content", function () {
      toggleButtonEvent($(this), $("#post-btn"));
    });

    // ポスト投稿ボタン活性/非活性判断
    if ($("#post-content").length && $("#post-btn").length) {
      toggleButtonEvent($("#post-content"), $("#post-btn"));
    }
  });
