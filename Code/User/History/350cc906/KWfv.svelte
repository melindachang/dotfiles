<script lang="ts">
  import { afterNavigate, goto } from '$app/navigation'
  import { onMount } from 'svelte'

  let innerWidth = $state(0)
  const pages = $state([
    { name: 'About', keypress: 'A', local: true, href: '/', active: false },
    {
      name: 'Writing',
      keypress: 'W',
      local: true,
      href: '/writing',
      active: false,
    },
    {
      name: 'CV',
      keypress: 'C',
      local: false,
      href: 'https://melindachang.codeberg.page/cv-latex/output.pdf',
      active: false,
    },
  ])

  const toggleActive = (i: number) => {
    pages.forEach(el => (el.active = false))
    if (i < 0) return
    pages[i].active = true
  }

  const handleKeypress = (e: KeyboardEvent) => {
    let i = pages.findIndex(el => el.keypress === e.key.toUpperCase())
    if (i < 0) return
    if (pages[i].local) {
      toggleActive(i)
      goto(pages[i].href)
    } else window.open(pages[i].href, '_blank')
  }

  const toggleOnArrival = () => {
    toggleActive(pages.findIndex(el => el.href === window.location.pathname))
  }

  onMount(() => {
    toggleOnArrival()
  })

  afterNavigate(() => {
    toggleOnArrival()
  })
</script>

<svelte:window on:keypress={e => handleKeypress(e)} bind:innerWidth />

<div class="nav">
  <div class="nav__content">
    <div class="nav__links">
      {#each pages as page, i}
        <a
          class={['nav__link', page.active && 'active']}
          href={page.href}
          target={!page.local ? '_blank' : null}
          onclick={page.local ? () => toggleActive(i) : null}
          data-sveltekit-preload-data>
          {innerWidth >= 992
            ? `[${page.keypress}] ${page.name}`
            : page.name}</a>
      {/each}
    </div>
  </div>
</div>

<style lang="scss">
  @use '../scss/_variables';
  @use '../scss/_breakpoints';

  .nav {
    position: fixed;
    z-index: 99;
    top: 0;
    left: 0;
    width: 100%;
    margin: 0 auto;
    padding: 1em;
    justify-content: center;
    background-image: linear-gradient(
      to bottom,
      variables.$background-color,
      rgba(0, 0, 0, 0)
    );
    pointer-events: none;
    .nav__content {
      width: 100%;
      display: grid;
      .nav__links {
        display: flex;
        justify-content: start;
        .nav__link {
          pointer-events: auto;
          display: flex;
          background: variables.$button-color;
          font-size: 1.2rem;
          line-height: 1.2;
          text-decoration: none;
          color: variables.$button-color;
          padding: 0.5rem 0.8rem;
          text-transform: uppercase;
          font-family: variables.$font-monospace;
          letter-spacing: -0.3px;
          border-radius: 2px;
          &.active,
          &:hover {
            background: variables.$text-color;
            color: variables.$background-color;
          }
          &:not(:last-child) {
            margin-right: 0.3rem;
          }
        }
      }
    }
  }
</style>
