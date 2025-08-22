import $ from "jquery";
import axios from "./modules/axios";

$(document)
  .off("turbo:load.follow")
  .on("turbo:load.follow", function () {

  $(document)
    .off("click.follow", "#follow-btn")
    .on("click.follow", "#follow-btn", function () {
      const $btn = $(this);
      const $wrap = $btn.closest(".follow_actions");
      const userId = $wrap.data("userId");
      const followed = $btn.data("followed") === true || $btn.data("followed") === "true";

      $btn.prop("disabled", true);

      const url = followed
          ? `/accounts/${userId}/unfollows`
          : `/accounts/${userId}/follows`;

      axios
        .post(url)
        .then((res) => {
          const data = res.data
          $btn.text(data.followed ? "Unfollow" : "Follow");
          $btn.data("followed", data.followed);
          $("#followers-count").text(data.followers_count);
        })
        .catch((err) => {
          console.log(err);
          window.alert("フォローに失敗しました。");
        })
        .finally(() => {
          $btn.prop("disabled", false);
        })
    });
  });
