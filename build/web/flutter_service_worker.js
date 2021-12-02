'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "fb800d37cb51ce25f91a8114a375508b",
"index.html": "d64ea7c8c3953c28246b61d42a4e796b",
"/": "d64ea7c8c3953c28246b61d42a4e796b",
"main.dart.js": "d8a266b8c1756a45c0319cf1d844655e",
"favicon.png": "16e70eeb72837dad79346dff9d9e4fda",
"icons/Icon-192.png": "c0d3d516e77f32d502620dd141733b68",
"icons/Icon-maskable-192.png": "c0d3d516e77f32d502620dd141733b68",
"icons/Icon-maskable-512.png": "2155ead110c292a12c20ed9cf0e28dbf",
"icons/Icon-512.png": "2155ead110c292a12c20ed9cf0e28dbf",
"manifest.json": "c703105f2d723d8efa45c97d00d6d89d",
"assets/AssetManifest.json": "7f00b4a2c40a7334df42ec8003dbce34",
"assets/NOTICES": "f5fdf2c7ff070333a273ffa4031dbdbd",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/assets/images/appstore.svg": "07f5c49733c060b175956d726514f794",
"assets/assets/images/instagram.svg": "d0e7f41ed1671852eeddf74fef76b377",
"assets/assets/images/topup-icon.svg": "77d1372b002b58ce5636096dceb77542",
"assets/assets/images/venezuela.svg": "b8f35fd7d50c4743c91e7766269b64bf",
"assets/assets/images/colombia.svg": "58b851da144daa4840249b1b8ea687a4",
"assets/assets/images/chile.svg": "e11e978786094053e834efbe3a5bdbf5",
"assets/assets/images/facebook.svg": "9ece39d9f7f568ced10333815fa052aa",
"assets/assets/images/whatsApp.svg": "1d0ec80d99309f6b744dc8cdc4648605",
"assets/assets/images/playstore.svg": "70d96d3efd3cd1a7923bc3d6cb20653d",
"assets/assets/images/call-sms-icon.svg": "b0458b972f2f2479791523e49e12d172",
"assets/assets/images/topup-service.svg": "71d75dfb297271f3e3eede954535bcb7",
"assets/assets/images/logo.svg": "f88454e30b50bd0c80414140671bd17f",
"assets/assets/images/voip-service.svg": "a67a9a555c4ddedc09b41c123e7e73b8",
"assets/assets/images/exchange-icon.svg": "e01ef36cabe3a604a815e23932992048",
"assets/assets/images/bg.jpg": "f739304ede6f9ecd32c9150cec3644f6",
"assets/assets/lottie/empty.json": "7f1578e46268212b12f1d29b95c97055",
"assets/assets/lottie/splash.json": "ffb13367b1001732f359265e98552c26",
"assets/assets/lottie/notfound.json": "9df9a2f2c2dadfb7d87558f826ebf309"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
