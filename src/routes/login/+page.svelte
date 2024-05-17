<script lang="ts">
	import { isLoggedIn } from '../../lib/stores';
	import { goto } from '$app/navigation';

	function login() {
		isLoggedIn.set(true);
		goto('/home');
	}
</script>

<svelte:head>
	<title>Login</title>
	<meta name="description" content="Login Page" />
</svelte:head>

<div class="text-column">
	<p>Login page</p>
	<!-- 로그인 버튼 -->
	<button on:click={login}>로그인</button>
</div>
