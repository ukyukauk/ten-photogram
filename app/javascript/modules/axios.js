import axios from "axios";
import Rails from "@rails/ujs";

Rails.start();

axios.defaults.headers.common["X-CSRF-Token"] = Rails.csrfToken();

export default axios;
