/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

import setupCSRFToken from '../setupCSRFToken'
setupCSRFToken()

// Dependencies
import Vue from 'vue'
import VueRouter from 'vue-router'
import Buefy from 'buefy'

const lodash = require('lodash');
window._ = lodash;

Vue.use(Buefy)
Vue.use(VueRouter)

// Components
import App from '../app'
import Courses from '../components/Courses'
import CourseCreate from '../components/CourseCreate'
import CourseShow from '../components/CourseShow'
import CourseEdit from '../components/CourseEdit'
import Index from '../components/Index'
import Professors from '../components/Professors'
import ProfessorCreate from '../components/ProfessorCreate'
import ProfessorShow from '../components/ProfessorShow'
import ProfessorEdit from '../components/ProfessorEdit'

// Front-end routing
const routes = [
  { path: '/', component: Index },
  { path: '/courses', component: Courses },
  { path: '/courses/create', component: CourseCreate },
  { path: '/courses/:id', component: CourseShow },
  { path: '/courses/:id/edit', component: CourseEdit },
  { path: '/courses/:id/professor/:pid', component: ProfessorShow },
  { path: '/professors', component: Professors },
  { path: '/professors/create', component: ProfessorCreate },
  { path: '/professors/:id/edit', component: ProfessorEdit }
]

const router = new VueRouter({
  routes
})

// App initialization
document.addEventListener('DOMContentLoaded', () => {
  const el = document.body.appendChild(document.createElement('app'))
  const app = new Vue({
    el,
    router,
    render: app => app(App)
  })
})
