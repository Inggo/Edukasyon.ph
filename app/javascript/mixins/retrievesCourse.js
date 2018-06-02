const retrieveCourse = {
  data () {
    return {
      course: null,
      professors: [],
      ratings: [],
      name: "",
      description: "",
      errors: {},
      loading: false
    }
  },
  methods: {
    retrieveCourse (id) {
      this.loading = true;

      axios.get('/api/courses/' + id)
        .then((response) => {
          this.course = response.data;
          this.name = response.data.name;
          this.description = response.data.description;
          this.professors = response.data.professors;
          this.ratings = response.data.ratings;
          this.loading = false;
        })
        .catch((error) => {
          this.$snackbar.open('Unable to get Course with ID #' + id);
          this.$route.go(-1);
        });
    }
  }
}

export default retrieveCourse