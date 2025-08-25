'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "c2969d219fa0ccb76c2b4396b43f5a59",
"version.json": "64db5ecdecf13ace9453f3d27547697e",
"index.html": "df64a316dce04b026514d04d5d1f0adb",
"/": "df64a316dce04b026514d04d5d1f0adb",
"main.dart.js": "9d9688e0a91cc02215fccdeb71cb9f3f",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "75a2dd79bc9e424a21c6a2601ecdb8de",
"assets/AssetManifest.json": "fc37de666b48a45b2571a74352aae2d8",
"assets/NOTICES": "4a08deea5c0b946601851fd336e85ecf",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "8011bb5fcde226bb9d4a55efff72542b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "787e7f7179e1926ff87dbb6311d5b553",
"assets/fonts/MaterialIcons-Regular.otf": "d1beed9148e6e8531123d83972f38807",
"assets/assets/formfull.png": "10ca15c517b1b62c5e7f204980586aac",
"assets/assets/buy%2520button.png": "c866d3bf0b35bdd6a500cb6298053dc1",
"assets/assets/Group%25205.png": "8910e5a7972d391ec9437a92cd75c0bc",
"assets/assets/arro_up_green.png": "dfa5c77a767fa5a40b4ed54d073a8487",
"assets/assets/drawer/user_management.png": "22dda3039c97478cc43a52b62e168c51",
"assets/assets/drawer/cameras_dashboard.png": "b215496e708600a0e907a07bca8ee381",
"assets/assets/drawer/alerts_dashboard.png": "2a6806a18875c0c64f143562410d12f9",
"assets/assets/drawer/cameras.png": "814e6c17a1f74382be3c24a17d396786",
"assets/assets/drawer/logout.png": "b18b3bcfcfad05c26bdf7d2a5b3787c5",
"assets/assets/drawer/alert.png": "a7c24583e0c87370ab400eb1eddf7446",
"assets/assets/drawer/data_dashboard.png": "10ea88952e287814708ac52a26064858",
"assets/assets/drawer/header_logo.png": "10e75ec37b90fff7626b0037eea64514",
"assets/assets/drawer/menu_icons.png": "6242322ad1d36a59dc1f9be437d8356e",
"assets/assets/drawer/notification_icon.png": "c60f913a4b85807d205e6d2e2dda4412",
"assets/assets/drawer/analytics.png": "147c6ea97b9932ea69cbf16d176998d2",
"assets/assets/drawer/dashbaord.png": "e9b80d81aae121269d1510ef6fe73d2e",
"assets/assets/drawer/faq.png": "79c92f2a90558c853664ade6e6cbb076",
"assets/assets/drawer/footfall.png": "f00b0cd5dbb073c6e9ef1f563b52b2eb",
"assets/assets/drawer/support_center.png": "7bc58e2d65a4f7890f6f265cd029af2e",
"assets/assets/drawer/setting.png": "63934d1d802ea56bda4277b59f6e02c6",
"assets/assets/menu_bar.png": "e83953f2cbfc9f0cf97ac8075e20f910",
"assets/assets/Group%25206.png": "3d88b91b66f819e69a6e8d3646c8dd86",
"assets/assets/Bitcoin.png": "99af82b411ecb5913afa317580e3016b",
"assets/assets/rotate%25201.png": "3b356cc2b889aecb1cd417cb94ef289c",
"assets/assets/kids.svg": "42ac5e30f46394fdaa08fc45096f3610",
"assets/assets/adults.svg": "2a1d6196f1ba643f1f99672d83532d5d",
"assets/assets/graph_image.png": "556906a9f188cf325e0e13367ceaf981",
"assets/assets/male.svg": "c3f60669327367f516aae0badc06fc5c",
"assets/assets/Customer-Monitoring.png": "76ba62670ed7cfd545855629a0873d74",
"assets/assets/Shade.png": "87e86a369461453e38bee24be2698aad",
"assets/assets/triangle_left.png": "3e3cf5b811ce78e3fe1c25114a92c303",
"assets/assets/adults.png": "08e2426aca3bbf41a6abf58f5831841c",
"assets/assets/kids.png": "7a22ad2581240c728e95cb093b1fc503",
"assets/assets/ArrowFall.png": "05167b1fb2e09a2ff8f64962df93f902",
"assets/assets/packing.png": "639fffb7d06461e6d803f4e2d90b08f3",
"assets/assets/Path_2.png": "5e152b40a4bd188094ce5b58fdd2d5c9",
"assets/assets/Unread.png": "be7b4820a0234b45f5e550f5b826720f",
"assets/assets/Path_3.png": "b173ec0b9786cf00d5782910ac43d526",
"assets/assets/Path.png": "9553a26346f34c8745b5182dd35988e8",
"assets/assets/Customer-Monitoring_setting.png": "dca47b7dddbad7067d5cfe067ec4c468",
"assets/assets/Path_1.png": "6932c0421fda7be4483f2a9e5d596cd5",
"assets/assets/Shade%2520(1).png": "f197a95bdf564afd4bcb2bdb69f2027d",
"assets/assets/buy%2520button.svg": "055f0fba2ee7158c82415fefef5d9734",
"assets/assets/alerts.png": "c4c5b47537751e44ed6cedf32c5256eb",
"assets/assets/Shape.png": "e83953f2cbfc9f0cf97ac8075e20f910",
"assets/assets/RND.png": "41a80103a4e5a583f096e8e53cfdc274",
"assets/assets/Shade%2520(2).png": "86c8a36e0710dc395b59306a9f545129",
"assets/assets/Badge%2520Text.png": "254cd1e81fd7b0efa324c0c0cc3fa915",
"assets/assets/app_logo_login.png": "fd8d2c0bcaa407fec9015090e3376925",
"assets/assets/Badge%2520Text%2520(1).png": "32dd3094f53a70d90eed500ae0f9931e",
"assets/assets/read.png": "491f110dc26e37cf4382890c9e05da7f",
"assets/assets/logo.png": "10e75ec37b90fff7626b0037eea64514",
"assets/assets/adults_new.svg": "0edf66214832341e5c58272594e2b9eb",
"assets/assets/kids_1.svg": "f5673e8f233a35f1b97d0408af8f4f34",
"assets/assets/srb1pkgfcam.png": "6b08940e0f0d05fc96b4e54ff2376578",
"assets/assets/data.png": "a5bdf9871f32ef6fa01db5b04b87f42f",
"assets/assets/filter.png": "4c6637033dad6e279dddfb6a61a08300",
"assets/assets/fullpage.png": "822dd08a50f7bd22e4937ed8a48dcd24",
"assets/assets/Customer-Monitoring_camera.png": "d5282369d1af281b084a3298a3d9a618",
"assets/assets/Shade%2520(3).png": "f17950186f3c9a3d36d115667950ec82",
"assets/assets/footstep%25201.png": "0ebd82e153083172f0be187e51536843",
"assets/assets/Customer-Monitoring%25201.png": "ea93bc1435299712c62bae5fbd997774",
"assets/assets/alert_dash.png": "013e7bde7e87f3a6888faf303d6dc158",
"assets/assets/godavan.png": "1bf6dbe950a3e9f7b4dd22a38856fa22",
"assets/assets/Edit.png": "e6d428ffa770f21e88319a125302917d",
"assets/assets/security.png": "e75cece98641ea06cdc6f86d919ca962",
"assets/assets/container_image.png": "f1ec659ed179df67897606816746a478",
"assets/assets/female.svg": "ee4579de3a76032e949de678d9f92dec",
"assets/assets/app_logo_login.svg": "e1148d93239eea7148420da689f8cd58",
"assets/assets/footpath.png": "07c116ea8c09519991495b12c824d0cb",
"assets/assets/image.png": "1e42a7dcad526315557fbd8434b283fd",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
