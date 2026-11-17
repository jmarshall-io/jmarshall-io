// Self-unregistering service worker to evict legacy cached Flutter bundles
self.addEventListener('install', (event) => {
  self.skipWaiting();
});

self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((cacheNames) =>
      Promise.all(cacheNames.map((cacheName) => caches.delete(cacheName)))
    ).then(() => self.registration.unregister())
     .then(() => self.clients.matchAll({ type: 'window' }))
     .then((clients) => {
       clients.forEach((client) => {
         if ('navigate' in client) {
           client.navigate(client.url);
         }
       });
     })
  );
});
