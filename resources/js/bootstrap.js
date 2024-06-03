// using axios in our app  
import axios from 'axios';
window.axios = axios;

window.axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';

// using jquery in our app
import $ from 'jquery';
window.$ = window.jQuery = $;