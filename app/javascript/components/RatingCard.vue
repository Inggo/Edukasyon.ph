<template>
  <div class="column is-one-third">
    <div class="card rating-card">
      <header class="card-header">
        <p class="card-header-title">
          <stars :rating="rating.rating"></stars>
        </p>
      </header>
      <div class="card-content">
        <p class="rating-review">{{ rating.description }}</p>
        <p class="has-text-grey">{{ updatedAt }}</p>
      </div>
    </div>
  </div>
</template>

<script>
import Stars from './common/Stars'
import moment from 'moment'

export default {
  components: {Stars},
  props: {
    rating: Object
  },
  computed: {
    updatedAt () {
      return moment(this.rating.updated_at).fromNow();
    }
  }
}
</script>