document.addEventListener("turbo:load", () => {
  const albumButton = document.getElementById("album-button");
  const imageInput = document.getElementById("image-input");
  const previewContainer = document.getElementById("preview-container");

  if (!albumButton || !imageInput || !previewContainer) return;

  albumButton.addEventListener("click", function () {
    imageInput.click();
  });

  imageInput.addEventListener("change", function () {
    const files = Array.from(imageInput.files);

    // 3枚以上選んだらアラートしてリセット
    if (files.length > 3) {
      alert("画像は3枚までしか選べません。");
      imageInput.value = ""; // 選択をリセット
      previewContainer.innerHTML = "";
      return;
    }

    // プレビュー表示
    previewContainer.innerHTML = "";
    files.forEach((file) => {
      const reader = new FileReader();

      reader.onload = function (e) {
        const img = document.createElement("img");
        img.src = e.target.result;
        img.classList.add("preview-image");
        previewContainer.appendChild(img);
      };

      reader.readAsDataURL(file);
    });
  });
});
