<template>
  <section class="section">
    <main class="container">
      <p-header title="Create Course" :show-back="true"></p-header>
      <div class="columns">
        <div class="column is-three-fifths">
          <b-field label="Name">
            <b-input v-model="name" :disabled="submitting"></b-input>
          </b-field>
          <b-field label="Description">
            <b-input v-model="description" type="textarea" :disabled="submitting"></b-input>
          </b-field>
          <b-field>
            <p class="control">
              <button class="button is-success has-icon" @click="submit" :loading="submitting">
                <b-icon icon="plus"></b-icon>
                <span>Create</span>
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
      description: "",
      submitting: false
    }
  },
  components: {PHeader},
  methods: {
    submit () {
      this.submitting = true;

      axios.post('/api/courses', {
          name: this.name,
          description: this.description
        })
        .then((response) => {
          this.$snackbar.open('Successfully created course ' + response.data.name);
          this.$router.go(-1);
        })
        .catch((error) => {
          console.log(error);
          this.submitting = false;
        })

    }
  }
}
</script>