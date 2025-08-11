# Pin npm packages by running ./bin/importmap

pin 'application'
pin '@hotwired/turbo-rails', to: 'turbo.min.js'
pin '@hotwired/stimulus', to: 'stimulus.min.js'
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js'
pin_all_from 'app/javascript/controllers', under: 'controllers'
# pin "jquery", integrity: "sha384-VlCj71LMLSNZ5b0MVT7pm3f5SZxz5s4bLP01b0r/ARBJcDvR7c04QjppG5nvye9m" # @3.7.1
pin 'jquery', to: 'https://ga.jspm.io/npm:jquery@3.7.1/dist/jquery.js'
pin 'axios', to: 'https://cdn.skypack.dev/axios@1.11.0'
pin '@rails/ujs', to: '@rails--ujs.js' # @7.1.3
