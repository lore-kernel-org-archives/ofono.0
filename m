Content-Type: multipart/mixed; boundary="===============5965530818908520332=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCH 2/2] stemodem: Use RTNL to create network interfaces.
Date: Sun, 14 Nov 2010 19:51:03 +0100
Message-ID: <1289760663-10334-2-git-send-email-sjurbren@gmail.com>
In-Reply-To: <1289760663-10334-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5965530818908520332==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

---
 drivers/stemodem/gprs-context.c |   43 +++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-contex=
t.c
index d8db23b..899379c 100644
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
@@ -172,12 +173,38 @@ static struct conn_info *conn_info_create(unsigned in=
t channel_id)
 	return connection;
 }
 =

+static void rtnl_callback(int ifindex, char *ifname, void *user_data)
+{
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
+}
+
 /*
  * Creates a new IP interface for CAIF.
  */
 static gboolean caif_if_create(struct conn_info *conn)
 {
-	return FALSE;
+	int err;
+
+	err =3D caif_rtnl_create_interface(IFLA_CAIF_IPV4_CONNID,
+						conn->channel_id, FALSE,
+						rtnl_callback, conn);
+	if (err < 0) {
+		DBG("Failed to create IP interface for CAIF");
+		return FALSE;
+	}
+
+	return TRUE;
 }
 =

 /*
@@ -185,6 +212,18 @@ static gboolean caif_if_create(struct conn_info *conn)
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
+	return;
 }
 =

 static void ste_eppsd_down_cb(gboolean ok, GAtResult *result,
@@ -573,10 +612,12 @@ static struct ofono_gprs_context_driver driver =3D {
 =

 void ste_gprs_context_init()
 {
+	caif_rtnl_init();
 	ofono_gprs_context_driver_register(&driver);
 }
 =

 void ste_gprs_context_exit()
 {
+	caif_rtnl_exit();
 	ofono_gprs_context_driver_unregister(&driver);
 }
-- =

1.7.0.4


--===============5965530818908520332==--

