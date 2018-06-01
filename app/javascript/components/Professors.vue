<template>
  <section class="section">
    <main class="container">
      <p-header title="Professor Management">
        <template slot="right">
          <router-link to="/professors/create" class="level-item">
            <a class="button is-success">
              <b-icon icon="plus" size="is-small"></b-icon>
              <span>Create Professor</span>
            </a>
          </router-link>
        </template>
      </p-header>
      <professor-table :professors="professors" :loading="loading" @confirm-delete="confirmDelete"></professor-table>
    </main>
  </section>
</template>

<script>
import PHeader from './common/Header'
import ProfessorTable from './ProfessorTable'

export default {
  components: {PHeader, ProfessorTable}
}
</script>