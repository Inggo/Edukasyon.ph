<template>
  <div class="column is-one-third">
    <div class="card course-card" @click="$router.push('/courses/' + course.id)">
      <header class="card-header">
        <p class="card-header-title">
          {{ course.name }}
        </p>
      </header>
      <div class="card-content">
        <div class="content">
          <div class="columns">
            <div class="column is-narrow">
              Average rating:
            </div>
            <div class="column is-narrow">
              <stars :rating="averageRating"></stars>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Stars from './common/Stars';

export default {
  props: {
    course: Object
  },
  components: {Stars},
  computed: {
    averageRating () {
      if (!this.course.ratings || this.course.ratings.length == 0) {
        return 0;
      }

      return this.course.ratings.reduce((sum, review) => {
        return sum + review.rating;
      }, 0)/this.course.ratings.length;
    }
  }
}
</script>