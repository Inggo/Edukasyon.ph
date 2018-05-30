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
  data () {
    return {
      professors: [],
      loading: false
    }
  },
  components: {PHeader, ProfessorTable},
  mounted () {
    this.retrieveProfessors();
  },
  methods: {
    confirmDelete (professor) {
      this.$dialog.confirm({
        message: 'Are you sure you want to delete professor <b>' + _.escape(professor.name) +
          '</b> (#' + _.escape(professor.id) + ')?',
        type: 'is-danger',
        hasIcon: true,
        onConfirm: () => this.delete(professor)
      })
    },
    delete (professor) {
      this.loading = true;

      axios.delete('/api/professors/' + professor.id)
        .then((response) => {
          this.$snackbar.open('Professor #' + professor.id + ' deleted!');
          this.retrieveProfessors();
        })
        .catch((error) => {
          console.log(error);
          this.loading = false;
        })
    },
    retrieveProfessors() {
      this.loading = true;

      axios.get('/api/professors')
        .then((response) => {
          this.professors = response.data;
          this.loading = false;
        })
        .catch((error) => {
          this.$snackbar.open(error.response.data);
          this.loading = false;
        })
    }
  }
}
</script>