<template>
  <b-table
    :data="professors"
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
      <b-table-column field="bio" label="Bio" sortable>
        {{ props.row.bio }}
      </b-table-column>
      <b-table-column label="Actions" numeric v-if="showActions">
        <router-link class="button is-info is-small has-icon" :to="'/professors/' + props.row.id + '/edit'">
          <b-icon icon="pencil" size="is-small"></b-icon>
          <span>Edit</span>
        </router-link>
        <button class="button is-danger is-small has-icon" @click="confirmDelete(props.row)">
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
import retrievesProfessors from '../mixins/retrievesProfessors'

export default {
  components: {Empty},
  mixins: [checkableTable, retrievesProfessors],
  computed: {
    items () {
      return this.professors;
    }
  },
  mounted () {
    this.retrieveProfessors();
  },
  methods: {
    confirmDelete (professor) {
      this.$dialog.confirm({
        message: 'Are you sure you want to delete professor <b>' + _.escape(professor.name) +
          '</b> (#' + _.escape(professor.id) + ')?',
        type: 'is-danger',
        hasIcon: true,
        onConfirm: () => this.delete(professor)
      })
    },
    delete (professor) {
      this.loading = true;

      axios.delete('/api/professors/' + professor.id)
        .then((response) => {
          this.$snackbar.open('Professor #' + professor.id + ' deleted!');
          this.retrieveProfessors();
        })
        .catch((error) => {
          console.log(error);
          this.loading = false;
        })
    }
  }
}
</script>