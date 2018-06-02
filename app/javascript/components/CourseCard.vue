<template>
  <div class="column">
    <div class="card" @click="$router.push('/rate/' + course.id)">
      <header class="card-header">
        <p class="card-header-title">
          {{ course.name }}
        </p>
      </header>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    course: Object
  }
}
</script>