<!-- App.svelte -->

<script lang="ts">
	import { onMount } from 'svelte';
	import { goto } from '@sapper/app';
	import '../app.css';
	import '@fortawesome/fontawesome-free/js/all.min.js';

	import Header from './Header/Header.svelte';
	import Footer from './Footer/Footer.svelte';
	import './styles.css';

	let isLoggedIn = false;

	onMount(() => {
		// 여기에 로그인 여부를 확인하는 로직을 추가하세요.
		// 예를 들어, 로그인 정보가 쿠키나 로컬 스토리지에 저장되어 있는지 확인하고,
		// 그에 따라 isLoggedIn 변수를 변경할 수 있습니다.
		// 이 코드는 임시 예시로, 항상 로그인되어 있다고 가정합니다.
		isLoggedIn = true;
	});
</script>

<main class="app">
	<Header></Header>

	{#if isLoggedIn}
		<Router>
			<!-- 여기에 Home 페이지의 컴포넌트를 넣으세요. -->
		</Router>
	{:else}
		<Router>
			<!-- 여기에 Login 페이지의 컴포넌트를 넣으세요. -->
		</Router>
	{/if}

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
