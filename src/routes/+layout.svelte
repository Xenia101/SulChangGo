<script>
	import '@fortawesome/fontawesome-free/js/all.min.js';

	import Header from './Header/Header.svelte';
	import Footer from './Footer/Footer.svelte';
	import './styles.css';

	import { SvelteUIProvider } from '@svelteuidev/core';
</script>

<SvelteUIProvider class="app" themeObserver="dark">
	<Header />

	<main>
		<slot />
	</main>

	<Footer />
</SvelteUIProvider>

<style>
	.app {
		display: flex;
		flex-direction: column;
		min-height: 100vh;
	}

	main {
		flex: 1;
		display: flex;
		flex-direction: column;
		padding: 1rem;
		width: 100%;
		max-width: 64rem;
		margin: 0 auto;
		box-sizing: border-box;
	}
</style>
