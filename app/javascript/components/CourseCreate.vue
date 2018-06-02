<template>
  <section class="section">
    <main class="container">
      <p-header title="Create Course" :show-back="true"></p-header>
      <course-form></course-form>
    </main>
  </section>
</template>

<script>
import PHeader from './common/Header';
import CourseForm from './CourseForm';

export default {
  components: {PHeader, CourseForm}
}
</script>