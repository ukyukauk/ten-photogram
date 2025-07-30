document.addEventListener("DOMContentLoaded", function () {
  const menuButton = document.querySelector(".menu-button");
  const dropdownMenu = document.querySelector(".dropdown-menu");
  const menuContainer = document.querySelector(".postPage_menu");

  if (menuButton && dropdownMenu && menuContainer) {
    // アイコン切り替え用の要素を追加
    const barsIcon = document.createElement("i");
    barsIcon.className = "fa-solid fa-bars";

    const xIcon = document.createElement("i");
    xIcon.className = "fa-solid fa-xmark";

    // if (!menuButton.querySelector(".fa-bars")) menuButton.appendChild(barsIcon);
    if (!menuButton.querySelector(".fa-xmark")) menuButton.appendChild(xIcon);

    menuButton.addEventListener("click", function (e) {
      e.stopPropagation();
      menuButton.classList.toggle("open");
      menuContainer.classList.toggle("active");
    });

    document.addEventListener("click", function (e) {
      if (!menuContainer.contains(e.target)) {
        menuButton.classList.remove("open");
        menuContainer.classList.remove("active");
      }
    });
  }
});
