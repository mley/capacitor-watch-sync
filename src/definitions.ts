export interface WatchSyncPlugin {
  pushDataToWatch(data: object): Promise<void>;
}
