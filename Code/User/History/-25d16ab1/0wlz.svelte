<script lang="ts">
  import { page } from '$app/state'
  import CrtLines from '$lib/components/CrtLines.svelte'
  import Header from '$lib/components/Header.svelte'
  import Navigation from '$lib/components/Navigation.svelte'
  import '$lib/scss/app.scss'

  let { children } = $props()
</script>

<svelte:head>
  <title>{page.data.title} &mdash; Melinda Chang</title>
  <meta charset="utf-8" />
  <meta http-equiv="x-ua-compatible" content="ie=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
</svelte:head>

<!-- <CrtLines /> -->
<Navigation />
<main>
  <div class="header">
    <Header title={page.data.title} amount={page.data.amount} />
  </div>
  {@render children()}
</main>

<style lang="scss">
  @use '$lib/scss/_breakpoints';
  main {
    width: 100%;
    padding: 4em 1em;
    .header {
      width: fit-content;
    }
  }
</style>
