<template>
  <div class="column is-one-third">
    <div class="card professor-card" @click="$router.push('/courses/' + course.id + '/professor/' + professor.id)">
      <header class="card-header">
        <p class="card-header-title">
          {{ professor.name }}
        </p>
      </header>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    course: Object,
    professor: Object
  }
}
</script>