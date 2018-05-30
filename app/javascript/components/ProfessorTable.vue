<template>
  <b-table
    :data="professors"
    :loading="loading"
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
      <b-table-column label="Actions" numeric>
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
  props: {
    professors: {
      type: Array,
      default () {
        return []
      }
    },
    loading: Boolean
  },
  components: {Empty}
}
</script>