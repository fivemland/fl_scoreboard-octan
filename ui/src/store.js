import { writable, get, derived } from 'svelte/store';
export const visible = writable(false);
export const Users = writable([]);
export const serverInfos = writable([]);

window.addEventListener('message', ({ data }) => {
  if (data.visible !== undefined) visible.set(data.visible);
  if (data.Data !== undefined) Users.set(data.Data);
  if (data.serverInfos !== undefined) serverInfos.set(data.serverInfos);
});
