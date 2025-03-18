import { registerPlugin } from '@capacitor/core';

import type { WatchSyncPlugin } from './definitions';

const WatchSync = registerPlugin<WatchSyncPlugin>('WatchSync', {});

export * from './definitions';
export { WatchSync };
