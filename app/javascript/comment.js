import $ from "jquery";
import axios from "./modules/axios";
import { appendNewCommentEvent } from "./modules/comment_display";
import { toggleButtonEvent } from "./modules/button_enabled";

$(document)
  .off("turbo:load.comments")
  .on("turbo:load.comments", function () {
    const $element = $("#comments-page");
    if ($element.length === 0) return;
    const postId = $element.data("postId");

    // コメント投稿ボタン押下
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

        axios
          .post(`/posts/${postId}/comments`, { comment: { content: content } })
          .then((res) => {
            const comment = res.data;
            appendNewCommentEvent(comment);
            $("#comment_content").val(""); // 入力欄クリア
          })
          .catch((err) => {
            console.log(err);
            window.alert("コメントの投稿に失敗しました。");
          })
          .finally(() => {
            // コメント投稿ボタン活性/非活性判断
            toggleButtonEvent($("#comment_content"), $("#comment-post-btn"));
          });
      });

    // コメント表示
    const $container = $element.find(".comments-container");
    if (!postId || $container.length === 0) return;

    axios
      .get(`/posts/${postId}/comments.json`)
      .then((res) => {
        $container.empty();
        const comments = res.data;
        comments.forEach((comment) => {
          appendNewCommentEvent(comment);
        });
        $("#comment_content").val(""); // 入力欄クリア
      })
      .catch((err) => {
        console.log(err);
        window.alert("コメントの取得に失敗しました。");
      });

    // コメント投稿ボタン活性化
    $(document).on("input", "#comment_content", function () {
      toggleButtonEvent($(this), $("#comment-post-btn"));
    });

    // コメント投稿ボタン活性/非活性判断
    if ($("#comment_content").length && $("#comment-post-btn").length) {
      toggleButtonEvent($("#comment_content"), $("#comment-post-btn"));
    }
  });
