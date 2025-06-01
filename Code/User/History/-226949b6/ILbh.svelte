<script lang="ts">
  import Entry from '$lib/components/Entry.svelte'
  import GridItem from '$lib/components/GridItem.svelte'
  import LinkEntry from '$lib/components/LinkEntry.svelte'
  import SpotifyWidget from '$lib/components/SpotifyWidget.svelte'
  import { map_to_entry } from '$lib/utils/utils'
  import { userState } from '$lib/data/state.svelte.js'
  import { onMount } from 'svelte'

  let showFailures = $state(false)
  let time = $state(new Date()),
    locale_str = $derived(
      time.toLocaleTimeString('en-US', { timeZone: 'America/Chicago' }),
    )

  onMount(() => {
    const interval = setInterval(() => {
      time = new Date()
    }, 1000)

    return () => {
      clearInterval(interval)
    }
  })
</script>

<svelte:head>
  <title>Melinda Chang</title>
</svelte:head>

<div class="grid">
  <div class="grid__column--left">
    <GridItem heading="Info">
      <p class="grid__item--info-text">
        It is <span class="grid__item--info-text-time">{locale_str}</span> in Evanston,
        IL
      </p>
      <SpotifyWidget />
    </GridItem>
  </div>
  <div class="grid__column--right">
    <GridItem heading="Bio">
      <LinkEntry
        links={[
          {
            type: 'Software',
            href: 'https://www.github.com/melindachang',
            external: true,
          },
          { type: 'Writing', href: '/writing', external: false },
        ]}>
        <p>
          Hello! I'm a first-year student at Northwestern majoring in <b
            >Computer Science</b>
          and <b>Comparative Literary Studies</b>.
        </p>
        <p>
          My research interests span natural language processing (NLP), computer
          vision, and cultural analytics. That is, I want to leverage <em
            >humanistic</em>
          theoretical resources to develop
          <em>computational</em>
          tools and methods, as well as explore their affordances in the study of
          cultural objects and cultural production broadly defined.
        </p>
        <p>
          Elsewhere: 19th- and 20th-century European literature, Sinophone
          cinema, aesthetics, global modernism. I also take pictures of Chicago
          and write whatever I want.
        </p>
      </LinkEntry>
    </GridItem>
    <GridItem
      heading="Work"
      noGap
      fn={() => (showFailures = !showFailures)}
      fnName={showFailures ? 'Hide Failures' : 'Show Failures'}>
      {#each userState.work_timeline as work}
        {#if !work.isFailure || showFailures}
          <Entry data={map_to_entry(work)} isFailure={work.isFailure} />
        {/if}
      {/each}
    </GridItem>
    <GridItem heading="Publications">
      <div class="publications">
        {#each userState.publications as { title, authors, venue, links }}
          <LinkEntry {links}>
            <h2 class="publication__title">{title}</h2>
            <p class="publication__subtitle">
              {@html `${authors
                .map(a => (a === 'Melinda Chang' ? `<em>${a}</em>` : a))
                .join(', ')} &mdash; ${venue}`}
            </p>
          </LinkEntry>
        {/each}
      </div>
    </GridItem>
    <GridItem heading="Everywhere">
      <p>
        You can reach me via email at <code
          >melinda [at] u.northwestern.edu</code
        >. I'm also on
        <a href="https://goodreads.com/hychang" target="_blank">Goodreads</a>
        and
        <a href="https://letterboxd.com/hychang" target="_blank">Letterboxd</a>.
      </p>
      <p class="grid__item--social">
        <a
          class="grid__item--social-link tag"
          href="https://github.com/melindachang"
          target="_blank">
          GitHub
        </a>
        <a
          class="grid__item--social-link tag"
          href="https://linkedin.com/in/melindahchang"
          target="_blank">
          Linkedin
        </a>
        <a
          class="grid__item--social-link tag"
          href="https://instagram.com/changrybird"
          target="_blank">
          Instagram
        </a>
      </p>
    </GridItem>
  </div>
</div>

<style lang="scss">
  .grid {
    display: grid;
    @include breakpoint-lg {
      grid-template-columns: 1fr 3fr;
      column-gap: 5.6rem;
    }
    &__column {
      &--left {
        height: fit-content;
        will-change: auto;
        @include breakpoint-lg {
          top: 4em;
          position: sticky;
        }
      }
      &--right {
        display: grid;
        line-height: 1.5;
        row-gap: 5.6rem;
      }
    }

    &__item {
      &--info {
        &-text {
          color: $major-text-color;
        }
      }
    }
  }
</style>
