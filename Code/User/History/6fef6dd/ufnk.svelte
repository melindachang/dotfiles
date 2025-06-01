<script lang="ts">
  import GridItem from '$lib/components/GridItem.svelte'
  import Entry from '$lib/components/Entry.svelte'
  import PlusMinusIcon from '$lib/assets/icons/PlusMinusIcon.svelte'
  import FolderIcon from '$lib/assets/icons/FolderIcon.svelte'
  import Checkbox from '$lib/assets/icons/Checkbox.svelte'
  import { onMount } from 'svelte'
  let { data } = $props()
  import { gsap } from 'gsap'
  import { map_to_entry } from '$lib/utils/utils.js'

  let tags = $state(data.tags),
    open = $state(true),
    titleHeight = $state(0),
    bodyHeight = $state(0),
    filter_wrapper: HTMLDivElement

  const tl = gsap.timeline()

  let activeFilters = $derived(tags.filter(t => t.checked).map(t => t.name))

  $effect(() => {
    open ? tl.reverse() : tl.play()
  })

  onMount(() => {
    tl.fromTo(
      filter_wrapper,
      { height: `${titleHeight + bodyHeight + 8}px` },
      { height: `${titleHeight}px`, duration: 0.2, ease: 'power1.inOut' },
    )
  })
</script>

<div class="grid">
  <div class="filters__wrapper">
    <GridItem heading="Filters">
      <div class="filters" bind:this={filter_wrapper}>
        <div class="filters__folder" bind:clientHeight={titleHeight}>
          <button
            class="filters__folder__button"
            onclick={() => (open = !open)}>
            <PlusMinusIcon expanded={open} width={14} height={14} />
          </button>
          <FolderIcon {open} width="22" height="22" />
          <span class="filters__folder__label">Topics</span>
        </div>
        <div class="filters__list" bind:clientHeight={bodyHeight}>
          {#each tags as tag}
            <button
              class={['filters__list__item', tag.checked && 'highlight']}
              onclick={() => (tag.checked = !tag.checked)}>
              <Checkbox bind:checked={tag.checked} width={20} height={20} />
              <span class="filters__list__item__label"
                >{tag.name} ({tag.amount})</span>
            </button>
          {/each}
        </div>
      </div>
    </GridItem>
  </div>
  <GridItem heading="Entries" noGap>
    {#each data.articles as article}
      {#if !activeFilters.length || activeFilters.some( f => article.tags.includes(f), )}
        <Entry data={map_to_entry(article)} isFailure={false} />
      {/if}
    {/each}
  </GridItem>
</div>

<style lang="scss">
  @use '$lib/scss/_breakpoints';
  @use '$lib/scss/_variables';

  .grid {
    display: grid;
    gap: 5.6rem;
    @include breakpoints.lg {
      grid-template-columns: 1fr 3fr;
    }
    .filters__wrapper {
      display: none;
      @include breakpoints.lg {
        display: block;
      }
      .filters {
        display: grid;
        row-gap: 8px;
        overflow-y: hidden;
        .filters__folder {
          display: flex;
          justify-content: flex-start;
          gap: 6px;
          align-items: center;
          .filters__folder__button {
            background: none;
            border: none;
            cursor: pointer;
            display: flex;
            align-items: center;
          }
        }
        .filters__list {
          position: relative;
          margin-left: 1.4rem;
          padding-left: 1.8rem;
          display: grid;
          row-gap: 8px;
          border-left: 0.5px solid variables.$dotted-border-color;
          .filters__list__item {
            padding: 0;
            background: none;
            border: none;
            color: inherit;
            opacity: 0.5;
            display: flex;
            align-items: center;
            gap: 8px;
            &:hover {
              opacity: 1;
            }
            &.highlight {
              opacity: 1;
              .filters__list__item__label {
                color: variables.$text-inverted-color;
                background-color: variables.$highlight-color;
              }
            }
            .filters__list__item__label {
              font-family: variables.$font-monospace;
              text-transform: uppercase;
              font-size: 1.2rem;
              line-height: 100%;
            }
          }
        }
      }
    }
  }
</style>
