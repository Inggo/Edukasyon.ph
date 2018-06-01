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
      <course-table></course-table>
    </main>
  </section>
</template>

<script>
import PHeader from './common/Header'
import CourseTable from './CourseTable'

export default {
  components: {PHeader, CourseTable}
}
</script>