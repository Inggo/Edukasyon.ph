const checkableTable = {
  data () {
    return {
      checkedRows: [],
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
  watch: {
    checkedRows (newChecked, oldChecked) {
      this.$emit('update-checked', newChecked);
    },
    initial (newInitial, oldInitial) {
      if (this.itemsLoaded && !this.initialSet) {
        this.$nextTick(() => {
          this.setInitial(newInitial);
        })
        this.initialSet = true;
      } else {
        this.initialSet = false;
      }
    },
    itemsLoaded (newLoaded, oldLoaded) {
      if (newLoaded && !this.initialSet) {
        this.$nextTick(() => {
          this.setInitial(this.initial);
        })
        this.initalSet = true;
      }
    }
  },
  methods: {
    setInitial (initial) {
      this.checkedRows = this.items.filter((item) => {
        for (let i = 0; i < initial.length; i++) {
          if (initial[i].id === item.id) {
            return true;
          }
        }
        return false;
      });
    }
  }
}

export default checkableTable