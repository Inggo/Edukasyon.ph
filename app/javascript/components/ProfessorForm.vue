<template>
  <div class="columns">
    <div class="column is-three-fifths">
      <b-field label="Name" :type="nameStatus.type" :message="nameStatus.message">
        <b-input :value="name" :disabled="submitting" @input.native="$emit('update:name', $event.target.value)"></b-input>
      </b-field>
      <b-field label="Bio">
        <b-input :value="bio" type="textarea" :disabled="submitting" @input.native="$emit('update:bio', $event.target.value)"></b-input>
      </b-field>
      <b-field label="Courses">
        <course-table
          :show-actions="false"
          :checkable="true"
          :initial="courses"
          @update-checked="updateChecked"
        ></course-table>
      </b-field>
      <b-field>
        <p class="control">
          <button
            class="button has-icon" :class="{'is-info' : editing, 'is-success': !editing}"
            @click="submit"
            :loading="submitting"
          >
            <b-icon :icon="editing ? 'pencil' : 'plus'"></b-icon>
            <span v-if="editing">Edit</span>
            <span v-else>Create</span>
          </button>
        </p>
      </b-field>
      <b-loading :is-full-page="true" :active="submitting"></b-loading>
    </div>
  </div>
</template>

<script>
import CourseTable from "./CourseTable";
import retrievesProfessor from '../mixins/retrievesProfessor'

export default {
  data () {
    return {
      checked: [],
      submitting: false,
    }
  },
  components: {CourseTable},
  mixins: [retrievesProfessor],
  props: {
    editing: {
      type: Boolean,
      default: false
    }
  },
  computed: {
    nameStatus () {
      if (_.has(this.errors, 'name') && _.isArray(this.errors.name)) {
        return {
          type: 'is-danger',
          message: 'Name ' + this.errors.name[0]
        }
      }

      return { type: null, message: null }
    },
    formData () {
      return {
        name: this.name,
        bio: this.bio,
        courses: this.checked.map((course) => {
          return course.id
        })
      }
    },
    method () {
      return this.editing ? 'patch' : 'post';
    },
    url () {
      return '/api/professors/' + (
        this.editing
          ? this.$route.params.id
          : ''
      );
    },
    action () {
      return this.editing
        ? 'updated'
        : 'created'
      ;
    }
  },
  mounted () {
    if (!this.editing) {
      return;
    }
    this.loading = true;

    this.retrieveProfessor(this.$route.params.id)
  },
  methods: {
    updateChecked (checked) {
      this.checked = checked;
    },
    submit () {
      this.submitting = true;

      axios[this.method](this.url, this.formData)
        .then((response) => {
          this.$snackbar.open('Successfully ' + this.action + ' Professor #' + response.data.id);
          this.$router.go(-1);
        })
        .catch((error) => {
          this.errors = error.response.data.errors;
          this.submitting = false;
        })
    },
  }
}
</script>
