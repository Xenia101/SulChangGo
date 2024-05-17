<script lang="ts">
	import { isLoggedIn } from '../lib/stores';
	import Login from './login/+page.svelte';
	import Home from './home/+page.svelte';
</script>

<svelte:head>
	<title>{$isLoggedIn ? 'Home' : 'Login'}</title>
	<meta name="description" content={$isLoggedIn ? 'Home' : 'Login'} />
</svelte:head>

{#if $isLoggedIn}
	<Home></Home>
{:else}
	<Login></Login>
{/if}
