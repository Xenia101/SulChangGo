<script>
	import '../app.css';
	import '@fortawesome/fontawesome-free/js/all.min.js';

	import Header from './Header/Header.svelte';
	import Footer from './Footer/Footer.svelte';
	import './styles.css';
</script>

<main class="app">
	<Header></Header>

	<main>
		<slot></slot>
	</main>

	<Footer></Footer>
</main>

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
		width: 100%;
		margin: 0 auto;
		box-sizing: border-box;
	}
</style>
