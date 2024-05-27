<script lang="ts">
	import { cn } from '$lib/utils.js';
	import { Button } from '$lib/components/ui/button/index.js';
	import { ScrollArea } from '$lib/components/ui/scroll-area/index.js';
	import { Icon } from 'lucide-svelte';

	let className: string | null | undefined = undefined;
	export { className as class };
</script>

<div class={cn('pb-12', className)}>
	<div class="space-y-4 py-4">
		<div class="px-3 py-2">
			<h2 class="mb-2 px-4 text-lg font-semibold tracking-tight">Menu</h2>
			<div class="space-y-1">
				<Button variant="secondary" class="w-full justify-start">
					<svg
						xmlns="http://www.w3.org/2000/svg"
						viewBox="0 0 24 24"
						fill="none"
						stroke="currentColor"
						stroke-width="2"
						stroke-linecap="round"
						stroke-linejoin="round"
						class="mr-2 h-4 w-4"
					>
						<circle cx="12" cy="12" r="10" />
						<polygon points="10 8 16 12 10 16 10 8" />
					</svg>
					Dashboard
				</Button>
				<Button variant="ghost" class="w-full justify-start">
					<svg
						xmlns="http://www.w3.org/2000/svg"
						viewBox="0 0 24 24"
						fill="none"
						stroke="currentColor"
						stroke-width="2"
						stroke-linecap="round"
						stroke-linejoin="round"
						class="mr-2 h-4 w-4"
					>
						<rect width="7" height="7" x="3" y="3" rx="1" />
						<rect width="7" height="7" x="14" y="3" rx="1" />
						<rect width="7" height="7" x="14" y="14" rx="1" />
						<rect width="7" height="7" x="3" y="14" rx="1" />
					</svg>
					Browse
				</Button>
			</div>
		</div>
	</div>
</div>
