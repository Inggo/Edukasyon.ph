const retrievesProfessors = {
  data () {
    return {
      loading: false,
      professors: []
    }
  },
  methods: {
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

export default retrievesProfessors