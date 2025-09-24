import $ from "jquery";
import axios from "./modules/axios";

const handleHeartDisplay = ($post, hasLiked) => {
  $post.find(".active-heart, .inactive-heart").addClass("hidden"); // 一度非表示
  $post.find(hasLiked ? ".active-heart" : ".inactive-heart").removeClass("hidden");
};

const updateLikeText = ($post, text) => {
  const $el = $post.find(".post_liked-by");

  if (text && text.length > 0) {
    $el.text(text).removeClass("hidden");
  } else {
    $el.text("").addClass("hidden");
  }
};

$(document).on("turbo:load", function () {
  $(".js-post").each(function () {
    const $post = $(this);
    const postId = $post.data("postId");
    if (!postId) return;

    // ハートの色でいいねの表示
    axios
      .get(`/api/posts/${postId}/like`)
      .then((res) => {
        handleHeartDisplay($post, res.data.hasLiked);
        updateLikeText($post, res.data.likeText);
      })
      .catch((err) => {
        console.log(err);
        window.alert("いいねの取得に失敗しました。");
      });

    // いいね
    $post.off("click", ".inactive-heart").on("click", ".inactive-heart", function () {
      axios
        .post(`/api/posts/${postId}/like`)
        .then((res) => {
          if (res.data.status === "ok") {
            handleHeartDisplay($post, true);
            updateLikeText($post, res.data.likeText);
          }
        })
        .catch((err) => {
          console.log(err);
          window.alert("いいねに失敗しました。");
        });
    });

    // いいねを解除
    $post.off("click", ".active-heart").on("click", ".active-heart", function () {
      axios
        .delete(`/api/posts/${postId}/like`)
        .then((res) => {
          if (res.data.status === "ok") {
            handleHeartDisplay($post, false);
            updateLikeText($post, res.data.likeText);
          }
        })
        .catch((err) => {
          console.log(err);
          window.alert("いいね解除に失敗している");
        });
    });
  });
});
