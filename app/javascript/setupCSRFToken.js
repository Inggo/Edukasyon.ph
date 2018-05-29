// app/javascript/setupCSRFToken.js
import axios from 'axios'

export default function() {
  const csrfToken = document.querySelector('meta[name="csrf-token"]').content
  axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
  window.axios = axios;
}
