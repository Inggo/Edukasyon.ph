<template>
  <section class="section">
    <main class="container" v-if="professor">
      <p-header :title="course.name" :show-back="true"></p-header>

      <h2 class="is-size-3">{{ name }}</h2>
      <div class="box" v-if="professor.bio">
        <p>
          {{ professor.bio }}
        </p>
      </div>

      <div class="sub-section">
        <h2 class="is-size-4">Reviews</h2>
        <div class="columns">
          <div class="column is-narrow">
            Average for this course:
          </div>
          <div class="column is-narrow">
            <stars :rating="averageRating"></stars>
          </div>
          <div class="column"></div>
          <div class="column is-narrow">
            Average overall:
          </div>
          <div class="column is-narrow">
            <stars :rating="overallAverageRating"></stars>
          </div>
        </div>
        <div class="columns is-multiline" v-if="hasRatings">
          <rating-card
            v-for="rating in courseRatings"
            :key="rating.id"
            :rating="rating"
          ></rating-card>
        </div>
        <empty message="No reviews, be the first?" v-else></empty>
      </div>
      <div class="sub-section">
        <rating-form
          :professor-id="professor.id"
          :course-id="courseId"
          @review-submitted="retrieveProfessor($route.params.pid)"
        ></rating-form>
      </div>
    </main>
    <b-loading :is-full-page="true" :active="loading"></b-loading>
  </section>
</template>

<script>
import PHeader from './common/Header';
import Stars from './common/Stars';
import RatingCard from './RatingCard';
import RatingForm from './RatingForm';
import Empty from './Empty';
import retrievesProfessor from '../mixins/retrievesProfessor';

export default {
  components: {PHeader, Stars, RatingForm, RatingCard, Empty},
  mixins: [retrievesProfessor],
  computed: {
    averageRating () {
      if (!this.hasRatings) {
        return 0;
      }

      return this.courseRatings.reduce((sum, review) => {
        return sum + review.rating;
      }, 0)/this.courseRatings.length;
    },

    course () {
      if (!this.courses || this.courses.length == 0) {
        return { name: null };
      }

      return this.courses.filter(course => {
        return course.id == this.courseId;
      })[0];
    },

    courseRatings () {
      return this.ratings.filter(rating => {
        return rating.course_id == this.courseId;
      });
    },

    hasRatings () {
      return this.courseRatings && this.courseRatings.length > 0;
    },
    
    overallAverageRating () {
      if (!this.ratings || this.ratings.length == 0) {
        return 0;
      }

      return this.ratings.reduce((sum, review) => {
        return sum + review.rating;
      }, 0)/this.ratings.length;
    },

    courseId () {
      return parseInt(this.$route.params.id);
    }
  },
  mounted () {
    this.retrieveProfessor(this.$route.params.pid);
  }
}
</script>