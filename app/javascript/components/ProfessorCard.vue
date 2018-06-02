<template>
  <div class="column is-one-third">
    <div class="card professor-card" @click="$router.push('/courses/' + course.id + '/professor/' + professor.id)">
      <header class="card-header">
        <p class="card-header-title">
          {{ professor.name }}
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
    course: Object,
    professor: Object
  },
  components: {Stars},
  computed: {
    averageRating () {
      if (!this.professorRatings || this.professorRatings.length == 0) {
        return 0;
      }

      return this.professorRatings.reduce((sum, review) => {
        return sum + review.rating;
      }, 0)/this.professorRatings.length;
    },
    professorRatings () {
      return this.course.ratings.filter(rating => {
        return rating.professor_id === this.professor.id;
      });
    }
  }
}
</script>