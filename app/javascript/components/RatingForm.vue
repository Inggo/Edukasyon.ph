<template>
  <div class="columns" v-if="validForm">
    <div class="column is-three-fifths">
      <h3 class="is-size-4">Leave your Review</h3>
      <b-field label="Rating" :type="ratingStatus.type" :message="ratingStatus.message">
        <p>
          <a 
            v-for="star in range"
            :key="star"
            @click="rate(star)"
          >
            <b-icon icon="star" v-if="star <= rating"></b-icon>
            <b-icon icon="star-outline" v-else></b-icon>
          </a>
        </p>
      </b-field>
      <b-field label="Your Email" :type="emailStatus.type" :message="emailStatus.message">
        <b-input type="email" :disabled="submitting" v-model="email"></b-input>
      </b-field>
      <b-field label="Your Review">
        <b-input :value="description" type="textarea" :disabled="submitting" v-model="description"></b-input>
      </b-field>
      <b-field>
        <p class="control">
          <button
            class="button has-icon is-success"
            @click="submit"
            :loading="submitting"
          >
            <b-icon icon="plus"></b-icon>
            <span>Submit Review</span>
          </button>
        </p>
      </b-field>
      <b-loading :is-full-page="true" :active="submitting"></b-loading>
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      rating: 0,
      email: "",
      description: "",
      submitting: false,
      errors: {}
    }
  },
  props: {
    professorId: Number,
    courseId: Number
  },
  computed: {
    range () {
      return _.range(1, 6)
    },
    validForm () {
      return this.professorId == this.$route.params.pid && this.courseId == this.$route.params.id
    },
    emailStatus () {
      if (_.has(this.errors, 'email') && _.isArray(this.errors.email)) {
        return {
          type: 'is-danger',
          message: 'Email ' + this.errors.email[0]
        }
      }

      return { type: null, message: null }
    },
    ratingStatus () {
      if (_.has(this.errors, 'rating') && _.isArray(this.errors.rating)) {
        return {
          type: 'is-danger',
          message: 'Rating ' + this.errors.rating[0]
        }
      }

      return { type: null, message: null }
    },
    formData () {
      return {
        email: this.email,
        description: this.description,
        rating: this.rating,
        professor_id: this.professorId,
        course_id: this.courseId
      }
    }
  },
  methods: {
    rate (rating) {
      this.rating = rating;
    },
    submit () {
      this.submitting = true;

      axios.post('/api/ratings/', this.formData)
        .then((response) => {
          this.$snackbar.open('Successfully submitted review');
          this.$emit('review-submitted')
        })
        .catch((error) => {
          this.errors = error.response.data.errors;
        })
        .finally(() => {
          this.submitting = false;
        })
    },
  }
}
</script>
