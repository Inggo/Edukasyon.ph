<template>
  <section class="section">
    <b-loading :is-full-page="true" :active="loading"></b-loading>
    <main class="container">
      <p-header :title="'Edit Course #' + $route.params.id" :show-back="true"></p-header>
      <div class="columns">
        <div class="column is-three-fifths">
          <b-field label="Name" :type="nameStatus.type" :message="nameStatus.message">
            <b-input v-model="name" :disabled="submitting"></b-input>
          </b-field>
          <b-field label="Description">
            <b-input v-model="description" type="textarea" :disabled="submitting"></b-input>
          </b-field>
          <b-field>
            <p class="control">
              <button class="button is-info has-icon" @click="submit" :loading="submitting">
                <b-icon icon="pencil"></b-icon>
                <span>Edit</span>
              </button>
            </p>
          </b-field>
        </div>
      </div>
    </main>
  </section>
</template>

<script>
import PHeader from './common/Header'

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
  components: {PHeader},
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