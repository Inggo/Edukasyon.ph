<template>
  <section class="section">
    <main class="container">
      <p-header title="Course Management">
        <template slot="right">
          <router-link to="/courses/create" class="level-item">
            <a class="button is-success">
              <b-icon icon="plus" size="is-small"></b-icon>
              <span>Create Course</span>
            </a>
          </router-link>
        </template>
      </p-header>
      <b-table
        :data="courses"
        :loading="loading"
      >
        <template slot-scope="props">
          <b-table-column field="id" label="ID" sortable>
            {{ props.row.id }}
          </b-table-column>
          <b-table-column field="name" label="Name" sortable>
            {{ props.row.name }}
          </b-table-column>
          <b-table-column field="description" label="Description" sortable>
            {{ props.row.description }}
          </b-table-column>
          <b-table-column label="Actions" numeric>
            <router-link class="button is-info is-small has-icon" :to="'/courses/' + props.row.id + '/edit'">
              <b-icon icon="pencil" size="is-small"></b-icon>
              <span>Edit</span>
            </router-link>
            <button class="button is-danger is-small has-icon" @click="confirmDelete(props.row)">
              <b-icon icon="delete" size="is-small"></b-icon>
              <span>Delete</span>
            </button>
          </b-table-column>
        </template>
      </b-table>
    </main>
  </section>
</template>

<script>
import PHeader from './common/Header'

export default {
  data () {
    return {
      courses: [],
      loading: false
    }
  },
  components: {PHeader},
  mounted () {
    this.retrieveCourses();
  },
  methods: {
    confirmDelete (course) {
      this.$dialog.confirm({
        message: 'Are you sure you want to delete course <b>' + _.escape(course.name) + '</b>?',
        type: 'is-danger',
        hasIcon: true,
        onConfirm: () => this.delete(course)
      })
    },
    delete (course) {
      this.loading = true;

      axios.delete('/api/courses/' + course.id)
        .then((response) => {
          this.$snackbar.open(course.name + ' deleted!');
          this.retrieveCourses();
        })
        .catch((error) => {
          console.log(error);
        })
        .finally(() => {
          this.loading = false;
        })
    },
    retrieveCourses() {  
      axios.get('/api/courses')
        .then((response) => {
          this.courses = response.data;
        })
    }
  }
}
</script>