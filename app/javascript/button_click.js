document.addEventListener("turbo:load", () => {
  const postButton = document.getElementById("post-btn");
  const postForm = document.getElementById("post-form");

  if (!postButton) return;

  postButton.addEventListener("click", () => {
    postButton.disabled = true;
    postForm.submit();
  });
});
