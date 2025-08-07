document.addEventListener("turbo:load", () => {
  const textArea = document.getElementById("post-content");
  const postButton = document.getElementById("post-btn");

  if (!textArea || !postButton) return;

  textArea.addEventListener("input", () => {
    if (textArea.value.trim().length > 0) {
      postButton.classList.add("enable");
      postButton.disabled = false;
    } else {
      postButton.classList.remove("enable");
      postButton.disabled = true;
    }
  });
});
