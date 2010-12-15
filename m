Content-Type: multipart/mixed; boundary="===============7773018976038291930=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCHv2 2/2] stemodem: Use RTNL to create network interfaces.
Date: Wed, 15 Dec 2010 22:49:28 +0100
Message-ID: <1292449768-6060-3-git-send-email-sjurbren@gmail.com>
In-Reply-To: <1292449768-6060-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7773018976038291930==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

---
 drivers/stemodem/gprs-context.c |   43 ++++++++++++++++++++++++++++++++---=
---
 1 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-contex=
t.c
index 7bdcdb8..1762fb3 100644
--- a/drivers/stemodem/gprs-context.c
+++ b/drivers/stemodem/gprs-context.c
@@ -47,6 +47,7 @@
 #include "stemodem.h"
 #include "caif_socket.h"
 #include "if_caif.h"
+#include "caif_rtnl.h"
 =

 #define MAX_CAIF_DEVICES 4
 #define MAX_DNS 2
@@ -172,12 +173,20 @@ static struct conn_info *conn_info_create(unsigned in=
t channel_id)
 	return connection;
 }
 =

-/*
- * Creates a new IP interface for CAIF.
- */
-static gboolean caif_if_create(struct conn_info *conn)
+static void rtnl_callback(int ifindex, const char *ifname, void *user_data)
 {
-	return FALSE;
+	struct conn_info *conn =3D user_data;
+
+	if (ifindex < 0) {
+		conn->created =3D FALSE;
+		ofono_error("Failed to create caif interface %s",
+			conn->interface);
+		return;
+	}
+
+	strncpy(conn->interface, ifname, sizeof(conn->interface));
+	conn->ifindex =3D ifindex;
+	conn->created =3D TRUE;
 }
 =

 /*
@@ -185,6 +194,17 @@ static gboolean caif_if_create(struct conn_info *conn)
  */
 static void caif_if_remove(struct conn_info *conn)
 {
+	if (!conn->created)
+		return;
+
+	if (caif_rtnl_delete_interface(conn->ifindex) < 0) {
+		ofono_error("Failed to delete caif interface %s",
+			conn->interface);
+		return;
+	}
+
+	DBG("removed CAIF interface ch:%d ifname:%s ifindex:%d\n",
+		conn->channel_id, conn->interface, conn->ifindex);
 }
 =

 static void ste_eppsd_down_cb(gboolean ok, GAtResult *result,
@@ -526,7 +546,7 @@ static int ste_gprs_context_probe(struct ofono_gprs_con=
text *gc,
 	GAtChat *chat =3D data;
 	struct gprs_context_data *gcd;
 	struct conn_info *ci;
-	int i;
+	int i, err;
 =

 	gcd =3D g_new0(struct gprs_context_data, 1);
 	gcd->chat =3D g_at_chat_clone(chat);
@@ -539,7 +559,14 @@ static int ste_gprs_context_probe(struct ofono_gprs_co=
ntext *gc,
 		ci =3D conn_info_create(i+1);
 		if (!ci)
 			return -ENOMEM;
-		caif_if_create(ci);
+		err =3D caif_rtnl_create_interface(IFLA_CAIF_IPV4_CONNID,
+						ci->channel_id, FALSE,
+						rtnl_callback, ci);
+		if (err < 0) {
+			DBG("Failed to create IP interface for CAIF");
+			return err;
+		}
+
 		g_caif_devices =3D g_slist_append(g_caif_devices, ci);
 	}
 =

@@ -571,10 +598,12 @@ static struct ofono_gprs_context_driver driver =3D {
 =

 void ste_gprs_context_init()
 {
+	caif_rtnl_init();
 	ofono_gprs_context_driver_register(&driver);
 }
 =

 void ste_gprs_context_exit()
 {
 	ofono_gprs_context_driver_unregister(&driver);
+	caif_rtnl_exit();
 }
-- =

1.7.0.4


--===============7773018976038291930==--

