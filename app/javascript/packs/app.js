/* eslint no-console: 0 */

// Set-up CSRF token for API requests
import setupCSRFToken from '../setupCSRFToken';
setupCSRFToken();

// Dependencies from vendor packages
import Vue from 'vue';
import VueRouter from 'vue-router';
import Buefy from 'buefy';

// Globally register lodash
const lodash = require('lodash');
window._ = lodash;

// Use vue vendor packages
Vue.use(Buefy);
Vue.use(VueRouter);

// Load Components used in routes
import App from '../app';
import Courses from '../components/Courses';
import CourseCreate from '../components/CourseCreate';
import CourseShow from '../components/CourseShow';
import CourseEdit from '../components/CourseEdit';
import Index from '../components/Index';
import Professors from '../components/Professors';
import ProfessorCreate from '../components/ProfessorCreate';
import ProfessorShow from '../components/ProfessorShow';
import ProfessorEdit from '../components/ProfessorEdit';

// Define front-end routes
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
];

// Initialize router
const router = new VueRouter({
  routes
});

// App initialization
document.addEventListener('DOMContentLoaded', () => {
  const el = document.body.appendChild(document.createElement('app'));
  const app = new Vue({
    el,
    router,
    render: app => app(App)
  });
});
