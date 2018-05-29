<template>
  <section class="section">
    <main class="container">
      <div class="level">
        <div class="level-left">
          <h1 class="is-size-2 level-item">Create Course</h1>
        </div>
        <div class="level-right">
            <button class="button level-item is-secondary has-icon" @click="$router.go(-1)">
              <b-icon icon="arrow-left" size="is-small"></b-icon>
              <span>Back</span>
            </button>
          </button>
        </div>
      </div>
      <div class="columns">
        <div class="column is-three-fifths">
          <b-field label="Name">
            <b-input v-model="name"></b-input>
          </b-field>

          <b-field label="Description">
            <b-input v-model="description" type="textarea"></b-input>
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
export default {
  data () {
    return {
      name: "",
      description: "",
      submitting: false
    }
  },
  methods: {
    submit () {
      this.submitting = true;

      axios.post('/api/courses', {
          name: this.name,
          description: this.description
        })
        .then((response) => {
          console.log(response);
        })
        .catch((error) => {
          console.log(error);
        })

    }
  }
}
</script>