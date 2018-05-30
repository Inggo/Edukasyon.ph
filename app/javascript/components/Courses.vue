<template>
  <section class="section">
    <main class="container">
      <p-header title="Course Management">
        <template slot="right">
          <router-link to="/courses/create" class="level-item">
            <a class="button is-success">
              <b-icon icon="plus" size="is-small"></b-icon>
              <span>Create Course</span>
            </a>
          </router-link>
        </template>
      </p-header>
      <course-table :courses="courses" :loading="loading" @confirm-delete="confirmDelete"></course-table>
    </main>
  </section>
</template>

<script>
import PHeader from './common/Header'
import CourseTable from './CourseTable'

export default {
  data () {
    return {
      courses: [],
      loading: false
    }
  },
  components: {PHeader, CourseTable},
  mounted () {
    this.retrieveCourses();
  },
  methods: {
    confirmDelete (course) {
      this.$dialog.confirm({
        message: 'Are you sure you want to delete course <b>' + _.escape(course.name) + '</b>?',
        type: 'is-danger',
        hasIcon: true,
        onConfirm: () => this.delete(course)
      })
    },
    delete (course) {
      this.loading = true;

      axios.delete('/api/courses/' + course.id)
        .then((response) => {
          this.$snackbar.open('Course #' + course.id + ' deleted!');
          this.retrieveCourses();
        })
        .catch((error) => {
          console.log(error);
          this.loading = false;
        })
    },
    retrieveCourses() {
      this.loading = true;

      axios.get('/api/courses')
        .then((response) => {
          this.courses = response.data;
          this.loading = false;
        })
    }
  }
}
</script>