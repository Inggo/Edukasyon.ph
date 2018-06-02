const retrievesCourses = {
  data () {
    return {
      loading: false,
      courses: []
    }
  },
  methods: {
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

export default retrievesCourses