<template>
  <b-table
    :data="professors"
    :loading="loading"
    :checkable="checkable"
    :checked-rows.sync="checkedRows"
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

export default {
  data () {
    return {
      checkedRows: [],
      professors: [],
      loading: false,
      initialSet: false,
      itemsLoaded: false
    }
  },
  props: {
    showActions: {
      type: Boolean,
      default: true
    },
    checkable: {
      type: Boolean,
      default: false
    },
    initial: {
      type: Array,
      default () {
        return []
      }
    }
  },
  components: {Empty},
  mounted () {
    this.retrieveProfessors();
  },
  watch: {
    checkedRows (newChecked, oldChecked) {
      this.$emit('update-checked', newChecked);
    },
    initial (newInitial, oldInitial) {
      this.$nextTick(() => {
        if (this.itemsLoaded && !this.initialSet) {
          this.setInitial(newInitial);
          this.initialSet = true;
        } else {
          this.initialSet = false;
        }
      })
    },
    itemsLoaded (newLoaded, oldLoaded) {
      this.$nextTick(() => {
        if (newLoaded && !this.initialSet) {
          this.setInitial(this.initial);
          this.initalSet = true;
        }
      })
    }
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
    setInitial (initial) {
      this.checkedRows = this.professors.filter((professor) => {
        for (let i = 0; i < this.initial.length; i++) {
          if (this.initial[i].id === professor.id) {
            return true;
          }
        }
        return false;
      });
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
    },
    retrieveProfessors() {
      this.loading = true;

      axios.get('/api/professors')
        .then((response) => {
          this.professors = response.data;
          this.loading = false;
          this.itemsLoaded = true;
        })
        .catch((error) => {
          this.$snackbar.open(error.response.data);
          this.loading = false;
        })
    }
  }
}
</script>