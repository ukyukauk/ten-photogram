import $ from "jquery";
import axios from "./axios_setup";

const appendNewComment = (comment) => {
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

$(document).on("turbo:load", function () {
  const $element = $("#comments-page");
  if ($element.length === 0) return;

  const postId = $element.data("postId");
  const $container = $element.find(".comments-container");
  if (!postId || $container.length === 0) return;

  axios.get(`/posts/${postId}/comments.json`).then((response) => {
    const comments = response.data;
    comments.forEach((comment) => {
      appendNewComment(comment);
    });
  });
});
