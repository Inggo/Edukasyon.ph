<template>
  <nav class="navbar is-primary">
    <div class="container">
      <div class="navbar-brand">
        <a class="navbar-item" href="/">
          <b-icon icon="school" type="is-secondary"></b-icon>
        </a>

        <a
          role="button"
          class="navbar-burger"
          aria-label="menu"
          aria-expanded="false"
          @click="() => active = !active"
          :class="{ 'is-active' : active }"
        >
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
        </a>
      </div>
      <div class="navbar-menu" :class="{ 'is-active' : active }">
        <div class="navbar-end">
          <b-dropdown position="is-bottom-left" class="navbar-item">
            <button class="button is-warning has-icon" slot="trigger">
                <b-icon icon="cogs" size="is-small"></b-icon>
                <span>Manage</span>
                <b-icon icon="chevron-down"></b-icon>
            </button>
            <b-dropdown-item has-link>
              <router-link to="/courses">
                <b-icon icon="school" size="is-small"></b-icon>
                <span>Courses</span>
              </router-link>
              <router-link to="/professors">
                <b-icon icon="human-greeting" size="is-small"></b-icon>
                <span>Professors</span>
              </router-link>
            </b-dropdown-item>
          </b-dropdown>
        </div>
      </div>
    </div>
  </nav>
</template>

<script>
export default {
  data () {
    return {
      active: false
    }
  }
}
</script>
