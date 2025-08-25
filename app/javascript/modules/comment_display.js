import $ from "jquery";

const appendNewCommentEvent = (comment) => {
  if ($(".comments-container").find(`[data-comment-id="${comment.id}"]`).length) return;

  $(".comments-container").append(
    `
    <div class="comment">
      <div class="comment_meta">
        <div class="comment_icon">
          <a href="/accounts/${comment.user.id}">
            <img src="${comment.user.avatar_image}">
          </a>
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

export { appendNewCommentEvent };
