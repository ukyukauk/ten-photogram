import $ from "jquery";

$(document)
  .off("turbo:load.buttons")
  .on("turbo:load.buttons", function () {
    // --- ポスト ---
    $(document)
      .off("click.post", "#post-btn")
      .on("click.post", "#post-btn", function () {
        const $btn = $(this);
        const $form = $("#post-form");
        if ($form.length === 0) return;

        $btn.prop("disabled", true);
        $form.trigger("submit");
      });
  });
