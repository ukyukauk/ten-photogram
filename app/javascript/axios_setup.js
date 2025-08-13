import axios from "axios";
import $ from "jquery";

// Turboページ読み込みごとに最新トークンをセット
$(document).on("turbo:load", function () {
  const token = $('meta[name="csrf-token"]').attr("content");
  if (token) {
    axios.defaults.headers.common["X-CSRF-Token"] = token;
  }
});

export default axios;
