import $ from "jquery";

$(document).on("turbo:load", function () {
  const $avatarImage = $("#avatar-image");
  const $avatarInput = $("#avatar-input");
  const $avatarForm = $("#avatar-form");

  if ($avatarImage.length === 0 || $avatarInput.length === 0) return;

  // 画像クリックで input 起動
  $avatarImage.on("click", function () {
    $avatarInput.trigger("click");
  });

  // 画像選択後に自動アップロード
  $avatarInput.on("change", function () {
    $avatarForm.trigger("submit");
  });
});
