import axios from "axios";
import Rails from "@rails/ujs";

Rails.start();

function csrfToken() {
  // まず meta を優先（Turboで更新されるのはこっち）
  const token = document.querySelector('meta[name="csrf-token"]')?.content;
  if (token) return token;

  // 念のため UJS からも
  return Rails.csrfToken?.();
}

// ★毎リクエスト直前に最新トークンを付ける（これが最重要）
axios.interceptors.request.use((config) => {
  const token = csrfToken();
  if (token) {
    config.headers = config.headers || {};
    config.headers["X-CSRF-Token"] = token;
  }
  return config;
});

export default axios;
