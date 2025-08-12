import $ from "jquery";
import axios from "axios";
import Rails from "@rails/ujs";

Rails.start();

axios.defaults.headers.common["X-CSRF-Token"] = Rails.csrfToken();

const handleHeartDisplay = ($post, hasLiked) => {
  // 一度非表示にする
  $post.find(".active-heart", ".inactive-heart").addClass("hidden");

  $post.find(hasLiked ? ".active-heart" : ".inactive-heart").removeClass("hidden");
};

document.addEventListener("turbo:load", () => {
  // ループ処理
  $(".js-post").each((_, el) => {
    const $post = $(el);
    const postId = $post.data("postId");

    if (!postId) return;

    // ハートの色でいいねの表示
    axios.get(`/posts/${postId}/like`).then((response) => {
      const hasLiked = response.data.hasLiked;
      handleHeartDisplay($post, hasLiked);
    });

    // いいねする
    $post.off("click", ".inactive-heart").on("click", ".inactive-heart", (e) => {
      axios
        .post(`/posts/${postId}/like`)
        .then((response) => {
          if (response.data.status == "ok") {
            $post.find(".active-heart").removeClass("hidden");
            $post.find(".inactive-heart").addClass("hidden");
          }
        })
        .catch((e) => {
          window.alert("Error");
          console.log(e);
        });
    });

    // いいねを解除
    $post.off("click", ".active-heart").on("click", ".active-heart", (e) => {
      axios
        .delete(`/posts/${postId}/like`)
        .then((response) => {
          if (response.data.status == "ok") {
            $post.find(".active-heart").addClass("hidden");
            $post.find(".inactive-heart").removeClass("hidden");
          }
        })
        .catch((e) => {
          window.alert("Error");
          console.log(e);
        });
    });
  });

  // コメント表示
  const element = document.getElementById("comments-page");
  if (!element) return;

  const postId = element.dataset.postId;
  const $container = $(element).find(".comments-container");
  if (!postId || $container.length === 0) return;

  axios.get(`/posts/${postId}/comments.json`)
    .then((response) => {
      const comments = response.data;
      comments.forEach((comment) => {
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
      })
  });
});
