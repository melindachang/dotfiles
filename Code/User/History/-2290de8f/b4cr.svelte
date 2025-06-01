<script lang="ts">
  let { text } = $props()
</script>

<span><i class="entry__action__icon--square"></i>{text}</span>

<style lang="scss">
  @use '$lib/scss/_variables';
  span {
    color: variables.$minor-text-color;
    font-size: 1.2rem;
    display: inline-flex;
    gap: 1rem;
    align-items: center;
    i {
      background: variables.$minor-text-color;
      height: 0.6rem;
      width: 0.6rem;
    }
  }
</style>
