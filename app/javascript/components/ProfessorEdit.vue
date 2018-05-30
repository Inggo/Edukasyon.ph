<template>
  <section class="section">
    <b-loading :is-full-page="true" :active="loading"></b-loading>
    <main class="container">
      <p-header :title="'Edit Professor #' + $route.params.id" :show-back="true"></p-header>
      <professor-form
        :editing="true"
        :name.sync="name"
        :bio.sync="description"
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
      submitting: false,
      loading: false
    }
  },
  components: {PHeader, ProfessorForm},
  computed: {
    nameStatus () {
      if (_.has(this.errors, 'name') && _.isArray(this.errors.name)) {
        return {
          type: 'is-danger',
          message: 'Name ' + this.errors.name[0]
        }
      }

      return { type: null, message: null }
    }
  },
  mounted () {
    this.loading = true;

    axios.get('/api/professors/' + this.$route.params.id)
      .then((response) => {
        this.name = response.data.name
        this.description = response.data.description
        this.loading = false
      })
      .catch((error) => {
        this.$snackbar.open('Unable to get Professor with ID #' + this.$route.params.id)
        this.$route.go(-1)
      })
  },
  methods: {
    submit () {
      this.submitting = true;

      axios.patch('/api/professors/' + this.$route.params.id, {
          name: this.name,
          bio: this.bio
        })
        .then((response) => {
          this.$snackbar.open('Successfully edited Professor #' + response.data.id);
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