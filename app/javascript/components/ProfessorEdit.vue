<template>
  <section class="section">
    <main class="container">
      <p-header :title="'Edit Professor #' + $route.params.id" :show-back="true"></p-header>
      <professor-form
        :editing="true"
      ></professor-form>
    </main>
  </section>
</template>

<script>
import PHeader from './common/Header';
import ProfessorForm from './ProfessorForm';

export default {
  components: {PHeader, ProfessorForm}
}
</script>