<template>
  <section class="section">
    <main class="container" v-if="course">
      <p-header :title="name" :show-back="true"></p-header>

      <div class="box" v-if="description">
        <p>
          {{ description }}
        </p>
      </div>

      <h2 class="is-size-3">Professors</h2>
      <div class="columns is-multiline">
        <professor-card
          v-for="professor in course.professors"
          :key="professor.id"
          :professor="professor"
          :course="course"
        ></professor-card>
      </div>
    </main>
    <b-loading :is-full-page="true" :active="loading"></b-loading>
  </section>
</template>

<script>
import PHeader from './common/Header';
import ProfessorCard from './ProfessorCard';
import retrievesCourse from '../mixins/retrievesCourse';

export default {
  components: {PHeader, ProfessorCard},
  mixins: [retrievesCourse],
  mounted () {
    this.retrieveCourse(this.$route.params.id);
  },
  
}
</script>