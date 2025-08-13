import $ from "jquery";

$(document).on("turbo:load", function () {
  const $albumButton = $("#album-button");
  const $imageInput = $("#image-input");
  const $previewContainer = $("#preview-container");

  if ($albumButton.length === 0 || $imageInput.length === 0 || $previewContainer.length === 0) return;

  // アルバムボタンクリックでファイル選択を開く
  $albumButton.on("click", function () {
    $imageInput.trigger("click");
  });

  // ファイル選択時の処理
  $imageInput.on("change", function () {
    const files = Array.from(this.files);

    // 4枚以上選んだらアラートしてリセット
    if (files.length > 4) {
      alert("画像は4枚までしか選べません。");
      $imageInput.val(""); // 選択をリセット
      $previewContainer.empty(); // プレビュー削除
      return;
    }

    // プレビュー表示
    $previewContainer.empty();
    files.forEach((file) => {
      const reader = new FileReader();
      reader.onload = function (e) {
        $("<img>").attr("src", e.target.result).addClass("preview-image").appendTo($previewContainer);
      };
      reader.readAsDataURL(file);
    });
  });
});
