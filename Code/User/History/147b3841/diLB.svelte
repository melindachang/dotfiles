<script lang="ts">
  let { heading, noGap = false, fn = null, fnName = null, children } = $props()
</script>

<div class={['item', !noGap && 'item--gap']}>
  <div class="item__header minor-text">
    <span class="item__header__text">/ {heading}</span>
    {#if fn}
      <button onclick={fn} class="item__header__button">{fnName}</button>
    {/if}
  </div>
  <div class="item__text">
    {@render children()}
  </div>
</div>

<style lang="scss">
  @use '../scss/_variables';

  .item {
    display: flex;
    flex-direction: column;
    &#{&}--gap {
      row-gap: 2.4rem;
    }
    .item__header {
      color: $body-text-color;
      display: flex;
      justify-content: space-between;
      padding-bottom: 0.6rem;
      border-bottom: 0.5px solid $body-text-color;
      .item__header__button {
        cursor: pointer;
        background: none;
        border: none;
        font-family: inherit;
        color: inherit;
        text-transform: uppercase;
        font-size: inherit;
      }
    }

    .item__text {
      line-height: 1.5;
    }
  }
</style>
