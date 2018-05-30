<template>
  <section class="section">
    <b-loading :is-full-page="true" :active="loading"></b-loading>
    <main class="container">
      <p-header :title="'Edit Course #' + $route.params.id" :show-back="true"></p-header>
      <course-form
        :editing="true"
        :name.sync="name"
        :description.sync="description"
        :submitting="submitting"
        :name-status="nameStatus"
        @submit="submit"
      ></course-form>
    </main>
  </section>
</template>

<script>
import PHeader from './common/Header'
import CourseForm from './CourseForm'

export default {
  data () {
    return {
      name: "",
      errors: {},
      description: "",
      submitting: false,
      loading: false
    }
  },
  components: {PHeader, CourseForm},
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

    axios.get('/api/courses/' + this.$route.params.id)
      .then((response) => {
        this.name = response.data.name
        this.description = response.data.description
        this.loading = false
      })
      .catch((error) => {
        this.$snackbar.open('Unable to get Course with ID #' + this.$route.params.id)
        this.$route.go(-1)
      })
  },
  methods: {
    submit () {
      this.submitting = true;

      axios.patch('/api/courses/' + this.$route.params.id, {
          name: this.name,
          description: this.description
        })
        .then((response) => {
          this.$snackbar.open('Successfully edited Course #' + response.data.id);
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