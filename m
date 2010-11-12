Content-Type: multipart/mixed; boundary="===============7364834416798130473=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCH v5b 2/3] stemodem: Create network interfaces statically
Date: Fri, 12 Nov 2010 16:02:39 +0100
Message-ID: <1289574160-22899-3-git-send-email-sjurbren@gmail.com>
In-Reply-To: <1289574160-22899-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7364834416798130473==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

Create the network interfaces statically at start up
instead of dynamically for each PDP activation.
---
 drivers/stemodem/gprs-context.c |   98 ++++++++++++++++++++---------------=
---
 1 files changed, 52 insertions(+), 46 deletions(-)

diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-contex=
t.c
index 05fec3f..62643ee 100644
--- a/drivers/stemodem/gprs-context.c
+++ b/drivers/stemodem/gprs-context.c
@@ -28,6 +28,7 @@
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
+#include <errno.h>
 =

 #include <glib.h>
 =

@@ -153,8 +154,7 @@ static gint conn_compare_by_cid(gconstpointer a, gconst=
pointer b)
 	return 0;
 }
 =

-static struct conn_info *conn_info_create(unsigned int device,
-						unsigned int channel_id)
+static struct conn_info *conn_info_create(unsigned int channel_id)
 {
 	struct conn_info *connection =3D g_try_new0(struct conn_info, 1);
 =

@@ -162,7 +162,6 @@ static struct conn_info *conn_info_create(unsigned int =
device,
 		return NULL;
 =

 	connection->cid =3D 0;
-	connection->device =3D device;
 	connection->channel_id =3D channel_id;
 =

 	return connection;
@@ -171,7 +170,7 @@ static struct conn_info *conn_info_create(unsigned int =
device,
 /*
  * Creates a new IP interface for CAIF.
  */
-static gboolean caif_if_create(const char *interface, unsigned int connid)
+static gboolean caif_if_create(struct conn_info *conn)
 {
 	return FALSE;
 }
@@ -179,9 +178,8 @@ static gboolean caif_if_create(const char *interface, u=
nsigned int connid)
 /*
  * Removes IP interface for CAIF.
  */
-static gboolean caif_if_remove(const char *interface, unsigned int connid)
+static void caif_if_remove(struct conn_info *conn)
 {
-	return FALSE;
 }
 =

 static void ste_eppsd_down_cb(gboolean ok, GAtResult *result,
@@ -191,7 +189,7 @@ static void ste_eppsd_down_cb(gboolean ok, GAtResult *r=
esult,
 	ofono_gprs_context_cb_t cb =3D cbd->cb;
 	struct ofono_gprs_context *gc =3D cbd->user;
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
-	struct conn_info *conn;
+	struct conn_info *conn =3D NULL;
 	GSList *l;
 =

 	if (!ok) {
@@ -214,13 +212,8 @@ static void ste_eppsd_down_cb(gboolean ok, GAtResult *=
result,
 	}
 =

 	conn =3D l->data;
-
-	if (!caif_if_remove(conn->interface, conn->channel_id)) {
-		DBG("Failed to remove caif interface %s.",
-				conn->interface);
-	}
-
 	conn->cid =3D 0;
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
 	return;
 =

 error:
@@ -248,9 +241,7 @@ static void ste_eppsd_up_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 				conn_compare_by_cid);
 =

 	if (!l) {
-		DBG("Did not find data (device and channel id)"
-					"for connection with cid; %d",
-					gcd->active_context);
+		DBG("CAIF Device gone missing (cid:%d)", gcd->active_context);
 		goto error;
 	}
 =

@@ -291,20 +282,9 @@ static void ste_eppsd_up_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 	dns[1] =3D rsp.dns_server2;
 	dns[2] =3D NULL;
 =

-	sprintf(conn->interface, "caif%u", conn->device);
-
-	if (!caif_if_create(conn->interface, conn->channel_id)) {
-		ofono_error("Failed to create caif interface %s.",
-				conn->interface);
-		CALLBACK_WITH_SUCCESS(cb, NULL, FALSE, rsp.ip_address,
+	CALLBACK_WITH_SUCCESS(cb, conn->interface, TRUE, rsp.ip_address,
 				rsp.subnet_mask, rsp.default_gateway,
 				dns, cbd->data);
-	} else {
-		CALLBACK_WITH_SUCCESS(cb, conn->interface,
-				FALSE, rsp.ip_address, rsp.subnet_mask,
-				rsp.default_gateway, dns, cbd->data);
-	}
-
 	return;
 =

 error:
@@ -316,6 +296,7 @@ error:
 	if (conn)
 		conn->cid =3D 0;
 =

+	gcd->active_context =3D 0;
 	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
 }
 =

@@ -327,38 +308,43 @@ static void ste_cgdcont_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 	struct cb_data *ncbd =3D NULL;
 	char buf[128];
-	struct conn_info *conn;
+	struct conn_info *conn =3D NULL;
 	GSList *l;
 =

+	l =3D g_slist_find_custom(g_caif_devices,
+				GUINT_TO_POINTER(gcd->active_context),
+				conn_compare_by_cid);
+
+	if (!l) {
+		DBG("CAIF Device gone missing (cid:%d)", gcd->active_context);
+		goto error;
+	}
+
+	conn =3D l->data;
+
 	if (!ok) {
 		struct ofono_error error;
 =

+		conn->cid =3D 0;
 		gcd->active_context =3D 0;
+
 		decode_at_error(&error, g_at_result_final_response(result));
 		cb(&error, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
 		return;
 	}
 =

-	ncbd =3D g_memdup(cbd, sizeof(struct cb_data));
-
-	l =3D g_slist_find_custom(g_caif_devices, GUINT_TO_POINTER(0),
-				conn_compare_by_cid);
-
-	if (!l) {
-		DBG("at_cgdcont_cb, no more available devices");
-		goto error;
-	}
-
-	conn =3D l->data;
-	conn->cid =3D gcd->active_context;
 	snprintf(buf, sizeof(buf), "AT*EPPSD=3D1,%u,%u",
 			conn->channel_id, conn->cid);
+	ncbd =3D g_memdup(cbd, sizeof(struct cb_data));
 =

 	if (g_at_chat_send(gcd->chat, buf, NULL,
 				ste_eppsd_up_cb, ncbd, g_free) > 0)
 		return;
 =

 error:
+	if (conn)
+		conn->cid =3D 0;
+
 	g_free(ncbd);
 =

 	gcd->active_context =3D 0;
@@ -375,6 +361,8 @@ static void ste_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[AUTH_BUF_LENGTH];
 	int len;
+	GSList *l;
+	struct conn_info *conn =3D NULL;
 =

 	if (!cbd)
 		goto error;
@@ -382,6 +370,18 @@ static void ste_gprs_activate_primary(struct ofono_gpr=
s_context *gc,
 	gcd->active_context =3D ctx->cid;
 	cbd->user =3D gc;
 =

+	/* Find free connection with cid zero */
+	l =3D g_slist_find_custom(g_caif_devices, GUINT_TO_POINTER(0),
+				conn_compare_by_cid);
+
+	if (!l) {
+		DBG("No more available CAIF devices");
+		goto error;
+	}
+
+	conn =3D l->data;
+	conn->cid =3D ctx->cid;
+
 	len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IP\"", ctx->cid);
 =

 	if (ctx->apn)
@@ -405,6 +405,9 @@ static void ste_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 	return;
 =

 error:
+	if (conn)
+		conn->cid =3D 0;
+
 	gcd->active_context =3D 0;
 	g_free(cbd);
 =

@@ -431,8 +434,8 @@ static void ste_gprs_deactivate_primary(struct ofono_gp=
rs_context *gc,
 				conn_compare_by_cid);
 =

 	if (!l) {
-		DBG("at_gprs_deactivate_primary, did not find"
-			"data (channel id) for connection with cid; %d", id);
+		DBG("did not find data (channel id) "
+				"for connection with cid; %d", id);
 		goto error;
 	}
 =

@@ -524,9 +527,11 @@ static int ste_gprs_context_probe(struct ofono_gprs_co=
ntext *gc,
 	ofono_gprs_context_set_data(gc, gcd);
 =

 	for (i =3D 0; i < MAX_CAIF_DEVICES; i++) {
-		ci =3D conn_info_create(i, i+1);
-		if (ci)
-			g_caif_devices =3D g_slist_append(g_caif_devices, ci);
+		ci =3D conn_info_create(i+1);
+		if (!ci)
+			return -ENOMEM;
+		caif_if_create(ci);
+		g_caif_devices =3D g_slist_append(g_caif_devices, ci);
 	}
 =

 	return 0;
@@ -536,6 +541,7 @@ static void ste_gprs_context_remove(struct ofono_gprs_c=
ontext *gc)
 {
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 =

+	g_slist_foreach(g_caif_devices, (GFunc) caif_if_remove, NULL);
 	g_slist_foreach(g_caif_devices, (GFunc) g_free, NULL);
 	g_slist_free(g_caif_devices);
 	g_caif_devices =3D NULL;
-- =

1.6.3.3


--===============7364834416798130473==--

