<template>
  <div id="app">
    <navigation></navigation>
    <router-view></router-view>
  </div>
</template>

<script>
import Navigation from 'components/Navigation'

export default {
  data: function () {
    return {
      message: "Hello Vue!"
    }
  },
  components: { Navigation }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
