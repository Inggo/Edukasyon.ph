<template>
  <section class="section">
    <main class="container">
      <p-header :title="'Edit Course #' + $route.params.id" :show-back="true"></p-header>
      <course-form
        :editing="true"
      ></course-form>
    </main>
  </section>
</template>

<script>
import PHeader from './common/Header'
import CourseForm from './CourseForm'

export default {
  components: {PHeader, CourseForm}
}
</script>