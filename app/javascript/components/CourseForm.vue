<template>
  <div class="columns">
    <div class="column is-three-fifths">
      <b-field label="Name" :type="nameStatus.type" :message="nameStatus.message">
        <b-input :disabled="submitting" v-model="name"></b-input>
      </b-field>
      <b-field label="Description">
        <b-input :value="description" type="textarea" :disabled="submitting" v-model="description"></b-input>
      </b-field>
      <b-field label="Professors">
        <professor-table
          :show-actions="false"
          :checkable="true"
          :initial="professors"
          @update-checked="updateChecked"
        ></professor-table>
      </b-field>
      <b-field>
        <p class="control">
          <button
            class="button has-icon"
            :class="{'is-info' : editing, 'is-success': !editing}"
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
import ProfessorTable from "./ProfessorTable";

export default {
  data () {
    return {
      checked: [],
      professors: [],
      name: "",
      description: "",
      errors: {},
      submitting: false,
      loading: false
    }
  },
  components: {ProfessorTable},
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
        description: this.description,
        professors: this.checked.map((professor) => {
          return professor.id
        })
      }
    },
    method () {
      return this.editing ? 'patch' : 'post';
    },
    url () {
      return '/api/courses/' + (
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

    axios.get('/api/courses/' + this.$route.params.id)
      .then((response) => {
        this.name = response.data.name
        this.description = response.data.description
        this.professors = response.data.professors
        this.loading = false
      })
      .catch((error) => {
        this.$snackbar.open('Unable to get Course with ID #' + this.$route.params.id)
        this.$route.go(-1)
      })
  },
  methods: {
    updateChecked (checked) {
      this.checked = checked;
    },
    submit () {
      this.submitting = true;

      axios[this.method](this.url, this.formData)
        .then((response) => {
          this.$snackbar.open('Successfully ' + this.action + ' Course #' + response.data.id);
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
