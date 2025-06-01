<script lang="ts">
  import PlusMinusIcon from '$lib/assets/icons/PlusMinusIcon.svelte'
  import type { Article, Entry, Work } from '$lib/utils/interfaces'
  import { gsap } from 'gsap'
  import { onMount, type Snippet } from 'svelte'

  type Props = { data: Entry<Article> | Entry<Work>; isFailure: boolean }
  let { data, isFailure = false }: Props = $props()

  let expanded = $state(false),
    collapsible: HTMLDivElement,
    collapsibleBody: HTMLDivElement,
    titleHeight = $state(0)

  const tl = gsap.timeline()

  $effect(() => {
    expanded ? tl.play() : tl.reverse()
  })

  onMount(() => {
    tl.fromTo(
      collapsible,
      { height: `${titleHeight}px` },
      {
        height: `${titleHeight + collapsibleBody.clientHeight}px`,
        duration: 0.35,
        ease: 'power1.inOut',
      },
    ).fromTo(
      collapsibleBody,
      { autoAlpha: 0 },
      { autoAlpha: 1, duration: 0.35, ease: 'power1.inOut' },
      '<',
    )
  })
</script>

{#snippet entryItem(
  key: string,
  value: string | string[],
  snippet: Snippet<[any]>,
)}
  <div class="entry__item">
    <div class="entry__caption">
      <span class="entry__caption__text">{key.toUpperCase()}: </span>
    </div>
    {@render snippet(value)}
  </div>
{/snippet}

{#snippet tags(value: string[])}
  <div class="entry__item__tags">
    {#each value as tag}
      <span class="tag">{tag}</span>
    {/each}
  </div>
{/snippet}

{#snippet text(value: string)}
  <p class="entry__item__text">{@html value}</p>
{/snippet}

<div class={['entry', isFailure && 'entry--failure']} bind:this={collapsible}>
  <div class="entry__title" bind:clientHeight={titleHeight}>
    <div class="entry__date">
      <div class="entry__date__text">
        <i class="entry__date__text__icon"></i>
        <span>{data.title.date}</span>
      </div>
    </div>
    <a class="entry__title__text" href={data.title.href}
      >{@html data.title.title}</a>
    <button class="entry__title__icon" onclick={() => (expanded = !expanded)}>
      <PlusMinusIcon {expanded} width={18} height={18} />
    </button>
  </div>
  <div class="entry__body" bind:this={collapsibleBody}>
    {#each Object.entries(data.body).filter(el => typeof el[1] != 'boolean') as [key, value]}
      {@render entryItem(
        key,
        value as string | string[],
        key === 'tags' ? tags : text,
      )}
    {/each}
  </div>
</div>

<style lang="scss">
  @use '$lib/scss/_variables';
  @use '$lib/scss/_breakpoints';

  .entry {
    display: grid;
    border-bottom: 0.5px solid variables.$body-text-color;
    overflow-y: hidden;
    @include breakpoints.lg {
      column-gap: 4px;
      grid-template-columns: 2fr 11fr;
    }
    &--failure {
      .entry__date__icon {
        background: variables.$graphic-color !important;
      }
      .entry__title__text {
        color: variables.$graphic-color;
      }
    }

    p,
    a {
      text-decoration: none;
      margin: 0;
      padding: 0;
      color: inherit;
      letter-spacing: -0.04em;
    }
    &__caption {
      text-transform: uppercase;
      font-family: variables.$font-monospace;
      font-size: 1.2rem;
      line-height: 100%;
      display: flex;
      align-items: flex-start;
      grid-column: 1 / -1;
      @include breakpoints.lg {
        grid-column: 1;
      }
      &__text {
        display: flex;
        align-items: center;
        justify-content: center;
        &::after {
          content: 'A';
          visibility: hidden;
          font-size: 2rem;
        }
      }
    }
    &__title {
      color: variables.$major-text-color;
      text-decoration: none;
      grid-column: 1 / -1;
      display: grid;
      grid-auto-rows: min-content;
      align-items: center;
      grid-template-columns: 10fr 1fr;
      @include breakpoints.lg {
        gap: 1rem;
        grid-template-columns: 2fr 10fr 1fr;
      }
      &:hover {
        color: variables.$text-inverted-color;
        background: variables.$highlight-color;
      }
      &__text {
        padding: 1.3rem 0;
        font-size: 2.2rem;
        line-height: 100%;
        @include breakpoints.md {
          font-size: 2.5rem;
        }
      }
      &__icon {
        cursor: pointer;
        background: none;
        color: variables.$major-text-color;
        border: none;
      }
    }
    &__date {
      font-family: variables.$font-monospace;
      text-transform: uppercase;
      font-size: 1.2rem;
      padding-top: 1.3rem;
      @include breakpoints.lg {
        padding: 0;
      }
      &__text {
        color: variables.$minor-text-color;
        display: inline-flex;
        gap: 1rem;
        align-items: center;
        &__icon {
          background: variables.$minor-text-color;
          height: 0.6rem;
          width: 0.6rem;
        }
      }
    }

    &__body {
      grid-column: 1 / -1;
      padding: 2.4rem 0;
      display: grid;
      grid-template-columns: subgrid;
      font-size: 2rem;

      & > div {
        &:not(:last-child) {
          margin-bottom: 1em;
        }
        grid-column: 1 / -1;
        display: grid;
        grid-template-columns: subgrid;
        row-gap: 1rem;
        line-height: 1.3;
      }
      .entry__item__text {
        font-size: 2rem;
      }
      .entry__item__tags {
        display: flex;
        align-items: flex-start;
        flex-wrap: wrap;
        gap: 2px;
        .tag {
          white-space: nowrap;
          cursor: pointer;
          text-decoration: none;
          font-size: 1.2rem;
          text-transform: uppercase;
          font-family: variables.$font-monospace;
          color: variables.$tag-text-color;
          border: 0.5px dotted variables.$tag-text-color;
          padding: 1px 4px 3px 4px;
          border-radius: 4px;
          &:hover {
            color: variables.$text-inverted-color;
            background: variables.$tag-text-color;
          }
        }
      }
    }
  }
</style>
