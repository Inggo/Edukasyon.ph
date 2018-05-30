<template>
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
        <button class="button is-danger is-small has-icon" @click="$emit('confirm-delete', props.row)">
          <b-icon icon="delete" size="is-small"></b-icon>
          <span>Delete</span>
        </button>
      </b-table-column>
    </template>
  </b-table>
</template>

<script>
export default {
  props: {
    courses: {
      type: Array,
      default () {
        return []
      }
    },
    loading: Boolean
  }
}
</script>