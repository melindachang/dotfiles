<script lang="ts">
  import type { Snippet } from 'svelte'

  let { checked = $bindable(), width, height } = $props()
</script>

{#snippet svg(box: Snippet)}
  <div class="checkbox" style:width={`${width}px`} style:height={`${height}px`}>
    <svg
      xmlns="http://www.w3.org/2000/svg"
      class="ionicon"
      viewBox="0 0 512 512">
      {@render box()}
    </svg>
  </div>
{/snippet}

{#snippet checked_box()}
  <path
    fill="none"
    stroke="currentColor"
    stroke-linecap="round"
    stroke-linejoin="round"
    stroke-width="32"
    d="M352 176L217.6 336 160 272" /><rect
    x="64"
    y="64"
    width="384"
    height="384"
    rx="48"
    ry="48"
    fill="none"
    stroke="currentColor"
    stroke-linejoin="round"
    stroke-width="32" />
{/snippet}

{#snippet unchecked_box()}
  <path
    d="M416 448H96a32.09 32.09 0 01-32-32V96a32.09 32.09 0 0132-32h320a32.09 32.09 0 0132 32v320a32.09 32.09 0 01-32 32z"
    fill="none"
    stroke="currentColor"
    stroke-linecap="round"
    stroke-linejoin="round"
    stroke-width="32" />
{/snippet}

{@render svg(checked ? checked_box : unchecked_box)}

<style lang="scss">
  @use '$lib/scss/_variables';
  .checkbox {
    svg {
      color: inherit;
    }
  }
</style>
