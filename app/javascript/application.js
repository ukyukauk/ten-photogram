// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "./avatar_upload";
import "./album_upload";
import "./postBtn_enable";
import "./postBtn_click";

import $ from "jquery";
import axios from 'axios';

document.addEventListener('turbo:load', () => {
  $(".post_author_upper").on('click', () => {
    axios.get('/')
      .then((response) => {
        console.log(response)
      })
  })
})
