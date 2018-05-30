<template>
  <section class="section">
    <b-loading :is-full-page="true" :active="submitting"></b-loading>
    <main class="container">
      <p-header title="Create Professor" :show-back="true"></p-header>
      <professor-form
        :name.sync="name"
        :bio.sync="bio"
        :submitting="submitting"
        :name-status="nameStatus"
        @submit="submit"
      ></professor-form>
    </main>
  </section>
</template>

<script>
import PHeader from './common/Header'
import ProfessorForm from './ProfessorForm'

export default {
  data () {
    return {
      name: "",
      errors: {},
      bio: "",
      submitting: false
    }
  },
  components: {PHeader, ProfessorForm},
  computed: {
    nameStatus () {
      if (this.errors.name) {
        return {
          type: 'is-danger',
          message: 'Name ' + this.errors.name[0]
        }
      }
      return { type: null, message: null }
    }
  },
  methods: {
    submit () {
      this.submitting = true;

      axios.post('/api/professors', {
          name: this.name,
          bio: this.bio
        })
        .then((response) => {
          this.$snackbar.open('Successfully created Professor #' + response.data.id);
          this.$router.go(-1);
        })
        .catch((error) => {
          this.errors = error.response.data.errors;
          this.submitting = false;
        })

    }
  }
}
</script>