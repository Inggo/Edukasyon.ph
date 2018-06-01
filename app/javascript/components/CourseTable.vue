<template>
  <b-table
    :data="courses"
    :loading="loading"
    :checkable="checkable"
    :checked-rows.sync="checkedRows"
    :paginated="true"
    :per-page="showActions ? 100 : 5"
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
      <b-table-column label="Actions" numeric v-if="showActions">
        <router-link class="button is-info is-small has-icon" :to="'/courses/' + props.row.id + '/edit'">
          <b-icon icon="pencil" size="is-small"></b-icon>
          <span>Edit</span>
        </router-link>
        <button class="button is-danger is-small has-icon" @click="$emit('confirm-delete', props.row)">
          <b-icon icon="delete" size="is-small"></b-icon>
          <span>Delete</span>
        </button>
      </b-table-column>
    </template>
    <empty slot="empty" v-if="!loading"></empty>
  </b-table>
</template>

<script>
import Empty from './Empty'
import checkableTable from '../mixins/checkableTable'

export default {
  data () {
    return {
      courses: [],
    }
  },
  components: {Empty},
  mixins: [checkableTable],
  computed: {
    items () {
      return this.courses;
    }
  },
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
          this.$snackbar.open('Course #' + course.id + ' deleted!');
          this.retrieveCourses();
        })
        .catch((error) => {
          console.log(error);
          this.loading = false;
        })
    },
    retrieveCourses() {
      this.loading = true;

      axios.get('/api/courses')
        .then((response) => {
          this.courses = response.data;
          this.loading = false;
          this.itemsLoaded = true;
        })
    }
  }
}
</script>