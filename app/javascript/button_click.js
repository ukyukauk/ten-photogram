import axios from "./axios_setup";
import $ from "jquery";

$(document).on("turbo:load", function () {
  // 毎回最新の CSRF をセット
  const token = $('meta[name="csrf-token"]').attr("content");
  if (token) {
    axios.defaults.headers.common["X-CSRF-Token"] = token;
  }

  // --- ポスト ---
  $(document).on("click", "#post-btn", function () {
    const $btn = $(this);
    const $form = $("#post-form");
    if ($form.length === 0) return;

    $btn.prop("disabled", true);
    $form.trigger("submit");
  });

  // --- コメント ---
  const $page = $("#comments-page");
  if ($page.length) {
    const postId = $page.data("postId");

    $(document).on("click", "#comment-post-btn", function () {
      const $btn = $(this);
      const content = ($("#comment_content").val() || "").trim();

      if (!content) {
        window.alert("コメントを入力してください");
        return;
      }

      $btn.prop("disabled", true);

      axios.post(`/posts/${postId}/comments`, { comment: { content: content } }).then((res) => {
        const comment = res.data;
        $(".comments-container").append(
          `
            <div class="comment">
              <div class="comment_meta">
                <div class="comment_icon">
                  <img src="${comment.user.avatar_image}">
                </div>
                <div class="comment_text">
                  <div class="comment_author">${comment.user.account}</div>
                  <div class="comment_content">${comment.content}</div>
                </div>
              </div>
            </div>
            `
        );
        $("#comment_content").val(""); // 入力欄クリア
      });
    });
  }
});
