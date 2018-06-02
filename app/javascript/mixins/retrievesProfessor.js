const retrieveCourse = {
  data () {
    return {
      professor: null,
      courses: [],
      ratings: [],
      name: "",
      bio: "",
      errors: {},
      loading: false
    }
  },
  methods: {
    retrieveProfessor (id) {
      this.loading = true;

      axios.get('/api/professors/' + id)
        .then((response) => {
          this.professor = response.data;
          this.name = response.data.name;
          this.description = response.data.description;
          this.courses = response.data.courses;
          this.ratings = response.data.ratings;
          this.loading = false;
        })
        .catch((error) => {
          this.$snackbar.open('Unable to get Professor with ID #' + id);
          this.$route.go(-1);
        });
    }
  }
}

export default retrieveCourse