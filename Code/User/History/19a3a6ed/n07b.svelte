<script lang="ts">
  let { title, amount = 0 } = $props()
</script>

<header>
  <h1>{@html title}</h1>
  {#if amount > 0}
    <small>({amount})</small>
  {/if}
</header>

<style lang="scss">
  @use '$lib/scss/_variables';
  header {
    margin: 4em 0 5.6rem 0;
    display: flex;
    align-items: start;
    h1 {
      color: $major-text-color;
      font-size: $section-title-font-size;
    }
    small {
      color: $graphic-color;
      font-size: 2.2rem;
    }
  }
</style>
