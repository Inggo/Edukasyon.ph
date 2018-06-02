<template>
  <p>
    <span
      v-for="star in range"
      :key="star"
    >
      <b-icon :type="iconClass" icon="star" v-if="star <= rating"></b-icon>
      <b-icon :type="iconClass" icon="star-half" v-else-if="(star - .5) <= rating"></b-icon>
      <b-icon :type="iconClass" icon="star-outline" v-else></b-icon>
    </span>
  </p>
</template>

<script>
export default {
  props: {
    rating: Number
  },
  computed: {
    range () {
      return _.range(1, 6)
    },
    iconClass () {
      if (this.rating >= 3.5) {
        return 'is-success';
      }

      if (this.rating >= 2) {
        return 'is-warning';
      }

      return 'is-danger';
    }
  }
}
</script>