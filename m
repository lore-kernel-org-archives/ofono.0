Content-Type: multipart/mixed; boundary="===============8464407492873795543=="
MIME-Version: 1.0
From: ppessi@gmail.com
Subject: [PATCH 3/7] Number of barring services is constant.
Date: Thu, 18 Mar 2010 16:44:27 +0200
Message-ID: <1268923471-29059-3-git-send-email-ppessi@gmail.com>
In-Reply-To: <1268923471-29059-2-git-send-email-ppessi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8464407492873795543==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>


Signed-off-by: Pekka Pessi <Pekka.Pessi@nokia.com>
---
 src/call-barring.c |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/src/call-barring.c b/src/call-barring.c
index 530d64b..eedb41d 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -37,6 +37,7 @@
 #include "common.h"
 =

 #define CALL_BARRING_FLAG_CACHED 0x1
+#define NUM_OF_BARRINGS 5
 =

 static GSList *g_drivers =3D NULL;
 =

@@ -47,8 +48,8 @@ static void set_query_next_lock(struct ofono_call_barring=
 *cb);
 struct ofono_call_barring {
 	int flags;
 	DBusMessage *pending;
-	int *cur_locks;
-	int *new_locks;
+	int cur_locks[NUM_OF_BARRINGS];
+	int new_locks[NUM_OF_BARRINGS];
 	int query_start;
 	int query_end;
 	int query_next;
@@ -1070,9 +1071,6 @@ static void call_barring_remove(struct ofono_atom *at=
om)
 	if (cb->driver && cb->driver->remove)
 		cb->driver->remove(cb);
 =

-	g_free(cb->cur_locks);
-	g_free(cb->new_locks);
-
 	g_free(cb);
 }
 =

@@ -1083,7 +1081,6 @@ struct ofono_call_barring *ofono_call_barring_create(=
struct ofono_modem *modem,
 {
 	struct ofono_call_barring *cb;
 	GSList *l;
-	int lcount;
 =

 	if (driver =3D=3D NULL)
 		return NULL;
@@ -1093,10 +1090,6 @@ struct ofono_call_barring *ofono_call_barring_create=
(struct ofono_modem *modem,
 	if (cb =3D=3D NULL)
 		return NULL;
 =

-	lcount =3D CB_ALL_END - CB_ALL_START + 1;
-
-	cb->cur_locks =3D g_new0(int, lcount);
-	cb->new_locks =3D g_new0(int, lcount);
 	cb->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_CALL_BARRING,
 						call_barring_remove, cb);
 =

-- =

1.6.3.3


--===============8464407492873795543==--

