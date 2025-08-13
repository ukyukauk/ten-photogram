document.addEventListener("turbo:load", () => {
  // ポスト
  const postContent = document.getElementById("post-content");
  const postButton = document.getElementById("post-btn");

  if (postContent && postButton) {
    postContent.addEventListener("input", () => {
      if (postContent.value.trim().length > 0) {
        postButton.classList.add("enable");
        postButton.disabled = false;
      } else {
        postButton.classList.remove("enable");
        postButton.disabled = true;
      }
    });
  }


  // コメント
  const commentContent = document.getElementById("comment_content");
  const commentPostButton = document.getElementById("comment-post-btn");

  if (commentContent && commentPostButton) {
    commentContent.addEventListener("input", () => {
      if (commentContent.value.trim().length > 0) {
        commentPostButton.classList.add("enable");
        commentPostButton.disabled = false;
      } else {
        commentPostButton.classList.remove("enable");
        commentPostButton.disabled = true;
      }
    });
  };

});
