<template>
  <div class="level">
    <div class="level-left">
      <h1 class="is-size-2 level-item">{{ title }}</h1>
    </div>
    <div class="level-right">
      <slot name="right"></slot>
      <button class="button level-item is-secondary has-icon" @click="$router.go(-1)" v-if="showBack">
        <b-icon icon="arrow-left" size="is-small"></b-icon>
        <span>Back</span>
      </button>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    title: String,
    showBack: {
      type: Boolean,
      default: false
    }
  }
}
</script>