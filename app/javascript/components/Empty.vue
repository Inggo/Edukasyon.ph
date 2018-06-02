<template>
  <section class="section">
    <div class="content has-text-grey has-text-centered">
      <p><b-icon icon="emoticon-sad" size="is-large"></b-icon></p>
      <p>{{ message }}</p>
    </div>
  </section>
</template>

<script>
export default {
  props: {
    message: String,
    default: "Nothing here."
  }
}
</script>