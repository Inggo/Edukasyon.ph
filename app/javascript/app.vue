<template>
  <div id="app">
    <navigation></navigation>
    <transition name="default" mode="out-in">
      <router-view></router-view>
    </transition>
  </div>
</template>

<script>
import Navigation from 'components/Navigation'

export default {
  components: { Navigation }
}
</script>
