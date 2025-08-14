import axios from "./axios_setup";
import $ from "jquery";

const appendNewComment = (comment) => {
  if ($(".comments-container").find(`[data-comment-id="${comment.id}"]`).length) return;

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
};

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

    // --- コメント ---
    const $page = $("#comments-page");
    if ($page.length) {
      const postId = $page.data("postId");

      $(document)
        .off("click.comment", "#comment-post-btn")
        .on("click.comment", "#comment-post-btn", function () {
          const $btn = $(this);
          const content = ($("#comment_content").val() || "").trim();

          if (!content) {
            window.alert("コメントを入力してください");
            return;
          }

          $btn.prop("disabled", true);

          axios.post(`/posts/${postId}/comments`, { comment: { content: content } }).then((res) => {
            const comment = res.data;
            appendNewComment(comment);
            $("#comment_content").val(""); // 入力欄クリア
          });
        });
    }
  });
