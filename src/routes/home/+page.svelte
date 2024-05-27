<script lang="ts">
	import { isLoggedIn } from '$lib/stores';
	import { goto } from '$app/navigation';
	import * as Card from '$lib/components/ui/card';
	import { Separator } from '$lib/components/ui/select';
	import { Button } from '$lib/components/ui/button/index.js';
	import { ScrollArea } from '$lib/components/ui/scroll-area/index.js';
	import * as Tabs from '$lib/components/ui/tabs';
	import { Menu, Sidebar } from './(components)/index';

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

<div class="h-screen">
	<Menu />
	<div class="border-t">
		<div class="bg-background">
			<div class="grid lg:grid-cols-5">
				<Sidebar class="hidden lg:block" />
				<div class="col-span-3 lg:col-span-4 lg:border-l">
					<div class="h-full px-4 py-6 lg:px-8">
						<div>item</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
