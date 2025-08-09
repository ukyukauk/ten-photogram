document.addEventListener("turbo:load", () => {
  const avatarImage = document.getElementById("avatar-image");
  const avatarInput = document.getElementById("avatar-input");
  const avatarForm = document.getElementById("avatar-form");

  if (avatarImage && avatarInput) {
    avatarImage.addEventListener("click", () => {
      avatarInput.click(); // 画像クリックでinput起動
    });

    avatarInput.addEventListener("change", () => {
      avatarForm.submit(); // 自動アップロード
    });
  }
});
