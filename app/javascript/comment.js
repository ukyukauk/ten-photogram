import $ from "jquery";
import axios from "./axios_setup";
import { appendNewCommentEvent } from "./modules/comment_display"

$(document)
  .off("turbo:load.comments")
  .on("turbo:load", function () {
    const $element = $("#comments-page");
    if ($element.length === 0) return;

    const postId = $element.data("postId");
    const $container = $element.find(".comments-container");
    if (!postId || $container.length === 0) return;

    axios.get(`/posts/${postId}/comments.json`).then((response) => {
      $container.empty();
      const comments = response.data;
      comments.forEach((comment) => {
        appendNewCommentEvent(comment);
      });
      $("#comment_content").val(""); // 入力欄クリア
    });
  });
