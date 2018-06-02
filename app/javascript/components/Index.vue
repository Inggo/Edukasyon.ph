<template>
  <section class="section">
    <main class="container">
      <p-header title="Rate Your Prof! (working name)"></p-header>
      <div class="columns is-multiline">
        <course-card
          v-for="course in courses"
          :course="course"
          :key="course.id"
        ></course-card>
      </div>
    </main>
  </section>
</template>

<script>
import PHeader from './common/Header';
import CourseCard from './CourseCard'
import retrievesCourses from '../mixins/retrievesCourses';

export default {
  components: {PHeader, CourseCard},
  mixins: [retrievesCourses],
  mounted () {
    this.retrieveCourses()
  }
}
</script>