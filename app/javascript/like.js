import $ from "jquery";
import axios from "./axios_setup";

const handleHeartDisplay = ($post, hasLiked) => {
  $post.find(".active-heart, .inactive-heart").addClass("hidden"); // 一度非表示
  $post.find(hasLiked ? ".active-heart" : ".inactive-heart").removeClass("hidden");
};

$(document).on("turbo:load", function () {
  $(".js-post").each(function () {
    const $post = $(this);
    const postId = $post.data("postId");
    if (!postId) return;

    // ハートの色でいいねの表示
    axios.get(`/posts/${postId}/like`).then((response) => {
      const hasLiked = response.data.hasLiked;
      handleHeartDisplay($post, hasLiked);
    });

    // いいね
    $post.off("click", ".inactive-heart").on("click", ".inactive-heart", function () {
      axios
        .post(`/posts/${postId}/like`)
        .then((response) => {
          if (response.data.status === "ok") {
            handleHeartDisplay($post, true);
          }
        })
        .catch((e) => {
          window.alert("Error");
          console.log(e);
        });
    });

    // いいねを解除
    $post.off("click", ".active-heart").on("click", ".active-heart", function () {
      axios
        .delete(`/posts/${postId}/like`)
        .then((response) => {
          if (response.data.status === "ok") {
            handleHeartDisplay($post, false);
          }
        })
        .catch((e) => {
          window.alert("Error");
          console.log(e);
        });
    });
  });
});
