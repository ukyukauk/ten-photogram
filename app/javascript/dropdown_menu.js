// script.js
document.addEventListener("DOMContentLoaded", () => {
  const hamburger = document.querySelector(".hamburger");
  const nav = document.querySelector(".nav");

  hamburger.addEventListener("click", () => {
    hamburger.classList.toggle("active");
    nav.classList.toggle("active");
  });

  // メニューの外側をクリックした時の処理
  document.addEventListener("click", (e) => {
    if (!e.target.closest(".nav") && !e.target.closest(".hamburger") && nav.classList.contains("active")) {
      hamburger.classList.remove("active");
      nav.classList.remove("active");
    }
  });
});
