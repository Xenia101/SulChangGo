<script lang="ts">
	import { isLoggedIn } from '$lib/stores';
	import { goto } from '$app/navigation';
	import * as Card from '$lib/components/ui/card';
	import { Separator } from '$lib/components/ui/select';
	import { Button } from '$lib/components/ui/button/index.js';
	import { ScrollArea } from '$lib/components/ui/scroll-area/index.js';
	import * as Resizable from '$lib/components/ui/resizable';

	const tags = Array.from({ length: 50 }).map((_, i, a) => `v1.2.0-beta.${a.length - i}`);

	function logout() {
		isLoggedIn.set(false);
		goto('/');
	}
</script>

<svelte:head>
	<title>Home</title>
	<meta name="description" content="Home Page" />
</svelte:head>

<div class="h-screen flex items-center justify-center">
	<!-- <div class="flex justify-between items-center">
		<Card.Title>HOME</Card.Title>
		<Button variant="secondary" on:click={logout}>로그아웃</Button>
	</div> -->
	<Resizable.PaneGroup direction="horizontal" class="min-h-[200px] m-1 max-w-md rounded-lg border">
		<Resizable.Pane defaultSize={25}>
			<div class="group flex flex-col gap-4 py-2 data-[collapsed=true]:py-2">
				<nav
					class="grid gap-1 px-2 group-[[data-collapsed=true]]:justify-center group-[[data-collapsed=true]]:px-2"
				>
					<Button href="#" size="sm" class="justify-start">123</Button>
					<Button href="#" size="sm" class="justify-start">123</Button>
					<Button href="#" size="sm" class="justify-start">123</Button>
				</nav>
			</div>
		</Resizable.Pane>
		<Resizable.Handle withHandle />
		<Resizable.Pane defaultSize={75}>
			<div class="flex h-full items-center justify-center p-6">
				<div class="relative">
					<ScrollArea orientation="vertical" class="h-72 rounded-md border">
						<div class="p-4">
							<h4 class="mb-4 text-sm font-medium leading-none">Tags</h4>
							{#each tags as tag}
								<div class="text-sm">
									{tag}
								</div>
							{/each}
						</div>
					</ScrollArea>
				</div>
			</div>
		</Resizable.Pane>
	</Resizable.PaneGroup>
</div>
