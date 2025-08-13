import $ from "jquery";

$(document).on("turbo:load", function () {
  // 入力内容に応じてボタンの状態を切り替え;
  const toggleBtn = ($input, $btn) => {
    const hasText = ($input.val() || "").trim().length > 0;
    $btn.toggleClass("enable", hasText).prop("disabled", !hasText);
  };

  // --- ポスト ---
  // 入力のたびに切り替え
  $(document).on("input", "#post-content", function () {
    toggleBtn($(this), $("#post-btn"));
  });

  // 初期表示時にも正しい状態に
  if ($("#post-content").length && $("#post-btn").length) {
    toggleBtn($("#post-content"), $("#post-btn"));
  }

  // --- コメント ---
  $(document).on("input", "#comment_content", function () {
    toggleBtn($(this), $("#comment-post-btn"));
  });

  if ($("#comment_content").length && $("#comment-post-btn").length) {
    toggleBtn($("#comment_content"), $("#comment-post-btn"));
  }
});
