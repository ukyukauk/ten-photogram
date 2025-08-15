// 入力内容に応じてボタンの状態を切り替え;
const toggleButtonEvent = ($input, $btn) => {
  const hasText = ($input.val() || "").trim().length > 0;
  $btn.toggleClass("enable", hasText).prop("disabled", !hasText);
};

export { toggleButtonEvent };
