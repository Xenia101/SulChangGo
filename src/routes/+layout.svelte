<script>
	import '../app.css';
	import '@fortawesome/fontawesome-free/js/all.min.js';

	import { isLoggedIn } from '$lib/stores';
	import './styles.css';
	import { onMount } from 'svelte';
	import { goto } from '$app/navigation';

	onMount(() => {
		if (!$isLoggedIn) {
			goto('/login');
		} else {
			goto('/home');
		}
	});
</script>

<main class="app">
	<main>
		<slot />
	</main>
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
