<script lang="ts">
  import type { Link } from '$lib/utils/interfaces'
  import type { Snippet } from 'svelte'

  let { links, children }: { links: Link[]; children: Snippet } = $props()
</script>

{#snippet arrowIcon()}
  <svg
    class="entry__action__icon--arrow"
    width="24"
    height="24"
    fill="none"
    viewBox="0 0 24 24">
    <path
      stroke="currentColor"
      stroke-linecap="round"
      stroke-linejoin="round"
      stroke-width="1.5"
      d="M17.25 15.25V6.75H8.75"></path>
    <path
      stroke="currentColor"
      stroke-linecap="round"
      stroke-linejoin="round"
      stroke-width="1.5"
      d="M17 7L6.75 17.25"></path>
  </svg>
{/snippet}

<div class="entry">
  <div class="entry__info">
    {@render children()}
  </div>
  <div class="entry__actions">
    {#each links as link}
      <a
        href={link.href}
        target={link.external ? '_blank' : undefined}
        class="entry__action">
        <div class="entry__action__left">
          <i class="entry__action__icon--square"></i>{link.type}
        </div>
        {@render arrowIcon()}
      </a>
    {/each}
  </div>
</div>

<style lang="scss">
  @use '../scss/_variables';
  @use '../scss/_breakpoints';

  .entry {
    color: variables.$minor-text-color
    display: flex;
    flex-direction: column;
    column-gap: 2.4rem;
    border-bottom: 0.5px dotted variables.$minor-text-color;
    padding-bottom: 2.4rem;
    @include breakpoints.lg {
      gap: 5.6rem;
      flex-direction: row;
    }
    .entry__info {
      display: flex;
      flex-direction: column;
      gap: 0.8em;
      @include breakpoints.lg {
        flex: 3;
      }
    }
    .entry__actions {
      display: flex;
      flex-direction: column;
      @include breakpoints.lg {
        flex: 2;
      }
      .entry__action {
        text-decoration: none;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 1.6rem 0;
        font-size: 1.2rem;
        line-height: 100%;
        text-transform: uppercase;
        font-family: variables.$font-monospace;
        &:not(:last-child) {
          border-bottom: 0.5px dotted variables.$body-text-color;
        }
        &:hover {
          cursor: pointer;
          color: variables.$inverted-text-color;
          background: variables.$highlight-color;
          .entry__action__icon {
            &--square {
              background: variables.$inverted-text-color;
            }
            &--arrow {
              color: variables.$inverted-text-color;
            }
          }
        }
        .entry__action__icon {
          &--square {
            display: inline-flex;
            height: 1rem;
            width: 1rem;
            background: variables.$minor-text-color;
            margin-right: 1rem;
          }
          &--arrow {
            display: inline-flex;
            height: 1.4em;
            width: 1.4em;
            color: variables.$minor-text-color;
          }
        }
      }
    }
  }
</style>
