<div class="effect"></div>

<style lang="scss">
  @use '$lib/scss/_animations';

  .effect {
    position: fixed;
    top: -4px;
    right: 0;
    bottom: 0;
    left: 0;
    background: linear-gradient(180deg, #323232 2px, #dcdcdc 0);
    z-index: 999;
    background-size: 100% 4px;
    opacity: 0.07;
    animation: crt-line-movement 0.5s linear 0s infinite normal none running;
    pointer-events: none;
  }
</style>
