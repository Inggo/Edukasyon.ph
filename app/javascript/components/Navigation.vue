<template>
  <nav class="navbar is-primary">
    <div class="container">
      <div class="navbar-brand">
        <a class="navbar-item" href="/">
          <img src="http://via.placeholder.com/160x69" alt="">
        </a>

        <a role="button" class="navbar-burger" aria-label="menu" aria-expanded="false">
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
        </a>
      </div>
      <div class="navbar-menu">
        <div class="navbar-end">
          <b-dropdown position="is-bottom-left" class="navbar-item">
            <button class="button is-warning" slot="trigger">
                <b-icon icon="cogs" size="is-small"></b-icon>
                <span>Manage</span>
                <b-icon icon="chevron-down"></b-icon>
            </button>
            <b-dropdown-item has-link>
              <router-link to="/courses">
                <b-icon icon="school" size="is-small"></b-icon>
                <span>Courses</span>
              </router-link>
            </b-dropdown-item>
          </b-dropdown>
        </div>
      </div>
    </div>
  </nav>
</template>