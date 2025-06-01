<script lang="ts">
  import { onMount, type Snippet } from 'svelte'
  import { DotLottieSvelte } from '@lottiefiles/dotlottie-svelte'
  import { gsap } from 'gsap'
  import { userState } from '$lib/data/state.svelte'
  import type { Track } from '@spotify/web-api-ts-sdk'

  let closed = $state(false)
  let artist = $state<HTMLSpanElement>()
  let artistName = $derived(
    userState.playback_state
      ? userState.playback_state.artists.map(a => a.name).join(', ')
      : '',
  )
  let visibleWidth = $state(0)
  let fullWidth = $state(0)
  let scrollAmt = $derived(visibleWidth! - fullWidth!)

  $effect(() => {
    if (artistName.length) {
      tl.clear()
      tl.to(artist!, {
        marginLeft: scrollAmt < 0 ? `${scrollAmt}px` : '0px',
        ease: 'linear',
        duration: -(scrollAmt / 100),
      })
    }
  })

  const tl = gsap.timeline()

  const update_song = async () => {
    userState.playback_state = (await fetch('/api/spotify').then(res =>
      res.json(),
    )) as Track
  }

  onMount(async () => {
    update_song()
    setInterval(update_song, 10000)
  })
</script>

{#snippet xIcon()}
  <svg
    xmlns="http://www.w3.org/2000/svg"
    fill="none"
    viewBox="0 0 24 24"
    stroke-width="1.5"
    stroke="currentColor"
    class="size-6">
    <path
      stroke-linecap="round"
      stroke-linejoin="round"
      d="M6 18 18 6M6 6l12 12" />
  </svg>
{/snippet}

{#snippet player(ico?: Snippet, body?: Snippet)}
  <div class="player__heading">
    <button class="player__heading__x" onclick={() => (closed = true)}>
      {@render xIcon()}
    </button>
    <span class="player__heading__title">Now Playing &mdash; Spotify</span>
    {@render ico?.()}
  </div>
  {@render body?.()}
{/snippet}

{#snippet npIcon()}
  <div class="player__heading__icon">
    <DotLottieSvelte src="/now-playing.lottie" loop autoplay />
  </div>
{/snippet}

<!-- svelte-ignore a11y_no_static_element_interactions -->
<!-- svelte-ignore a11y_mouse_events_have_key_events -->
{#snippet playerBody()}
  <div class="player__background">
    <div
      class="player__img"
      style:background-color="gray"
      style:background-image={`url('${userState.playback_state!.album.images[0].url}')`}>
    </div>
    <div class="player__text">
      <a
        href={userState.playback_state!.href}
        target="_blank"
        class="player__text__title">{userState.playback_state!.name}</a>
      <div
        class="player__text__artist"
        onmouseover={() => tl.play()}
        onmouseleave={() => tl.seek(0).pause()}
        bind:clientWidth={visibleWidth}>
        <span bind:this={artist} bind:clientWidth={fullWidth}
          >{artistName}</span>
      </div>
    </div>
  </div>
{/snippet}

{#if !closed}
  <div class="player">
    {#if userState.playback_state}
      {@render player(npIcon, playerBody)}
    {:else}
      {@render player()}
    {/if}
  </div>
{/if}

<style lang="scss">
  @use '../scss/_variables';
  @use '../scss/_breakpoints';

  .player {
    margin: 1em 0 3em 0;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 6px;
    padding: 4px;
    background: variables.$background-color;
    border: 0.5px solid variables.$major-text-color;
    max-width: 23em;
    .player__heading {
      color: variables.$major-text-color;
      width: 100%;
      position: relative;
      display: flex;
      align-items: center;
      justify-content: end;
      gap: 0.1em;
      .player__heading__title {
        text-transform: uppercase;
        font-size: 1rem;
        line-height: 1;
        font-family: variables.$font-monospace;
        margin-left: 1em;
      }
      .player__heading__icon {
        height: 1.4rem;
      }
      .player__heading__x {
        height: 1.2rem;
        line-height: 1;
        width: 1.2rem;
        margin-right: auto;
        background: none;
        border: none;
        cursor: pointer;
        svg {
          color: variables.$body-text-color;
          height: 100%;
          position: absolute;
          top: 0;
          left: 0;
        }
      }
    }
    .player__background {
      position: relative;
      border: 0.5px solid variables.$major-text-color;
      width: 100%;
      display: flex;
      gap: 1em;
      padding: 1em;
      overflow: hidden;
      .player__text {
        display: grid;
        gap: 0.25em;
        width: calc(12em - 6px);
        align-content: end;
        .player__text__title {
          text-decoration: none;
          overflow: hidden;
          text-overflow: ellipsis;
          display: -webkit-box;
          -webkit-box-orient: vertical;
          -webkit-line-clamp: 2;
          line-clamp: 2;
          line-height: 1.5em;
          max-height: 3em;
          &:hover {
            text-decoration: underline;
          }
        }
        .player__text__artist {
          overflow: hidden;
          color: variables.$body-text-color;
          display: -webkit-box;
          -webkit-box-orient: vertical;
          -webkit-line-clamp: 1;
          line-clamp: 1;
          line-height: 1em;
          max-height: 1em;
          position: relative;
          span {
            display: inline-block;
            overflow: hidden;
            text-wrap: nowrap;
          }
        }
        &::before {
          content: '';
          position: absolute;
          right: 0;
          top: 0;
          height: 100%;
          width: 2em;
          background-image: linear-gradient(
            to right,
            rgba(255, 0, 0, 0),
            variables.$background-color
          );
        }
        &:hover {
          &::before {
            background: transparent;
          }
        }
      }
      .player__img {
        height: 6em;
        aspect-ratio: 1/1;
        border: 0.5px solid variables.$body-text-color;
        filter: grayscale(50%);
        background-size: cover;
        background-position: 50% 50%;
      }
    }
  }
</style>
