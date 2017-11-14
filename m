Content-Type: multipart/mixed; boundary="===============6184008579482962661=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH] watchlist: added macro for notifying with no args
Date: Tue, 14 Nov 2017 09:24:36 -0800
Message-ID: <1510680276-1215-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6184008579482962661==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The macros currently did not support notifying a watchlist with
no extra arguments.
---
 src/watchlist.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/src/watchlist.h b/src/watchlist.h
index 737b80d..3d87810 100644
--- a/src/watchlist.h
+++ b/src/watchlist.h
@@ -2,7 +2,7 @@
  *
  *  Wireless daemon for Linux
  *
- *  Copyright (C) 2016  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2016-2017  Intel Corporation. All rights reserved.
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -92,3 +92,19 @@ void __watchlist_prune_stale(struct watchlist *watchlist=
);
 		if ((watchlist)->stale_items)				\
 			__watchlist_prune_stale(watchlist);		\
 	} while	(false)
+
+#define WATCHLIST_NOTIFY_NO_ARGS(watchlist, type)			\
+	do {								\
+		const struct l_queue_entry *entry =3D			\
+				l_queue_get_entries((watchlist)->items);\
+									\
+		(watchlist)->in_notify =3D true;				\
+		for (; entry; entry =3D entry->next) {			\
+			struct watchlist_item *item =3D entry->data;	\
+			type t =3D item->notify;				\
+			t(item->notify_data);			\
+		}							\
+		(watchlist)->in_notify =3D false;				\
+		if ((watchlist)->stale_items)				\
+			__watchlist_prune_stale(watchlist);		\
+	} while	(false)
-- =

2.7.4


--===============6184008579482962661==--

