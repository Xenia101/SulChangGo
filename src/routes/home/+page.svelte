<script lang="ts">
	import { isLoggedIn } from '../../lib/stores';
	import { goto } from '$app/navigation';

	function logout() {
		isLoggedIn.set(false);
		goto('/');
	}
</script>

<svelte:head>
	<title>Home</title>
	<meta name="description" content="Home Page" />
</svelte:head>

<div class="text-column">
	<p>Home page</p>
	<button on:click={logout}>로그아웃</button>
</div>
