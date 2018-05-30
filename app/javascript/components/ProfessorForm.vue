<template>
  <div class="columns">
    <div class="column is-three-fifths">
      <b-field label="Name" :type="nameStatus.type" :message="nameStatus.message">
        <b-input :value="name" :disabled="submitting" @input.native="$emit('update:name', $event.target.value)"></b-input>
      </b-field>
      <b-field label="Bio">
        <b-input :value="bio" type="textarea" :disabled="submitting" @input.native="$emit('update:bio', $event.target.value)"></b-input>
      </b-field>
      <b-field>
        <p class="control">
          <button class="button has-icon" :class="{'is-info' : editing, 'is-success': !editing}" @click="$emit('submit')" :loading="submitting">
            <b-icon :icon="editing ? 'pencil' : 'plus'"></b-icon>
            <span v-if="editing">Edit</span>
            <span v-else>Create</span>
          </button>
        </p>
      </b-field>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    submitting: {
      type: Boolean,
      default: false
    },
    editing: {
      type: Boolean,
      default: false
    },
    nameStatus: {
      type: Object,
      default () {
        return {
          type: null,
          message: null
        }
      }
    },
    name: String,
    bio: String
  }
}
</script>
