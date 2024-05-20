<script lang="ts">
	import { isLoggedIn } from '$lib/stores';
	import { goto } from '$app/navigation';
	import * as Card from '$lib/components/ui/card';
	import { Button } from '$lib/components/ui/button/index.js';
	import { Label } from '$lib/components/ui/label';
	import { Input } from '$lib/components/ui/input';
	import { Checkbox } from '$lib/components/ui/checkbox/index.js';

	let checked = false;

	function login() {
		isLoggedIn.set(true);
		goto('/home');
	}
</script>

<svelte:head>
	<title>Login</title>
	<meta name="description" content="Login Page" />
</svelte:head>

<div class="h-screen flex items-center justify-center">
	<Card.Root class="w-[350px]">
		<Card.Header class="flex items-center">
			<Card.Title>SulChangGo</Card.Title>
		</Card.Header>
		<form>
			<Card.Content>
				<div class="grid w-full items-center gap-4">
					<div class="flex flex-col space-y-1.5">
						<Label for="email">Email</Label>
						<Input id="email" type="email" placeholder="Email" />
					</div>
					<div class="flex flex-col space-y-1.5">
						<Label for="password">Password</Label>
						<Input id="password" type="password" placeholder="Password" />
					</div>
				</div>
			</Card.Content>
			<Card.Footer class="flex justify-between">
				<div class="flex items-center">
					<Checkbox class="mr-2" id="terms" bind:checked aria-labelledby="terms-label" />
					<Label id="terms-label" for="terms">Remember me</Label>
				</div>
				<Button on:click={login}>로그인</Button>
			</Card.Footer>
		</form>
	</Card.Root>
</div>
