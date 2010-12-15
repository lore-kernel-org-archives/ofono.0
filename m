Content-Type: multipart/mixed; boundary="===============5869406450333233630=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCHv2 1/2] stemodem: Create network interfaces statically
Date: Wed, 15 Dec 2010 22:49:27 +0100
Message-ID: <1292449768-6060-2-git-send-email-sjurbren@gmail.com>
In-Reply-To: <1292449768-6060-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5869406450333233630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

Changes:
o Restructure code so interfaces are created statically when probe is calle=
d,
  instead of creating interfaces dynamically at activation.
o Changed debug messages.
o Removed some of the unnecessary initializations at declaration.
o No longer reporting "default gateway" for PtP IP Interface.
o Bugfix: Handle network initiated deactivation.
---
 drivers/stemodem/gprs-context.c |  149 +++++++++++++++++++++--------------=
---
 1 files changed, 82 insertions(+), 67 deletions(-)

diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-contex=
t.c
index faa3124..7bdcdb8 100644
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

@@ -65,10 +66,18 @@ struct gprs_context_data {
 };
 =

 struct conn_info {
+	/*
+	 * cid is allocated in oFono Core and is identifying
+	 * the Account. cid =3D 0 indicates that it is currently unused.
+	 */
 	unsigned int cid;
-	unsigned int device;
+	/* Id used by CAIF and EPPSD to identify the CAIF channel*/
 	unsigned int channel_id;
-	char interface[10];
+	/* Linux Interface Id */
+	unsigned int ifindex;
+	/* Linux Interface name */
+	char interface[IF_NAMESIZE];
+	gboolean created;
 };
 =

 struct eppsd_response {
@@ -76,7 +85,6 @@ struct eppsd_response {
 	char ip_address[IP_ADDR_LEN];
 	char subnet_mask[IP_ADDR_LEN];
 	char mtu[IP_ADDR_LEN];
-	char default_gateway[IP_ADDR_LEN];
 	char dns_server1[IP_ADDR_LEN];
 	char dns_server2[IP_ADDR_LEN];
 	char p_cscf_server[IP_ADDR_LEN];
@@ -96,8 +104,6 @@ static void start_element_handler(GMarkupParseContext *c=
ontext,
 		rsp->current =3D rsp->subnet_mask;
 	else if (!strcmp(element_name, "mtu"))
 		rsp->current =3D rsp->mtu;
-	else if (!strcmp(element_name, "default_gateway"))
-		rsp->current =3D rsp->default_gateway;
 	else if (!strcmp(element_name, "dns_server") &&
 					rsp->dns_server1[0] =3D=3D '\0')
 		rsp->current =3D rsp->dns_server1;
@@ -123,7 +129,7 @@ static void text_handler(GMarkupParseContext *context,
 =

 	if (rsp->current) {
 		strncpy(rsp->current, text, IP_ADDR_LEN);
-		rsp->current[IP_ADDR_LEN] =3D 0;
+		rsp->current[IP_ADDR_LEN] =3D '\0';
 	}
 }
 =

@@ -153,8 +159,7 @@ static gint conn_compare_by_cid(gconstpointer a, gconst=
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

@@ -162,7 +167,6 @@ static struct conn_info *conn_info_create(unsigned int =
device,
 		return NULL;
 =

 	connection->cid =3D 0;
-	connection->device =3D device;
 	connection->channel_id =3D channel_id;
 =

 	return connection;
@@ -171,7 +175,7 @@ static struct conn_info *conn_info_create(unsigned int =
device,
 /*
  * Creates a new IP interface for CAIF.
  */
-static gboolean caif_if_create(const char *interface, unsigned int connid)
+static gboolean caif_if_create(struct conn_info *conn)
 {
 	return FALSE;
 }
@@ -179,9 +183,8 @@ static gboolean caif_if_create(const char *interface, u=
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
@@ -210,21 +213,13 @@ static void ste_eppsd_down_cb(gboolean ok, GAtResult =
*result,
 		DBG("Did not find data (used caif device) for"
 					"connection with cid; %d",
 					gcd->active_context);
-		goto error;
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		return;
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
-	return;
-
-error:
-	CALLBACK_WITH_FAILURE(cb, cbd->data);
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
 }
 =

 static void ste_eppsd_up_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
@@ -233,7 +228,7 @@ static void ste_eppsd_up_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 	ofono_gprs_context_up_cb_t cb =3D cbd->cb;
 	struct ofono_gprs_context *gc =3D cbd->user;
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
-	struct conn_info *conn =3D NULL;
+	struct conn_info *conn;
 	GAtResultIter iter;
 	GSList *l;
 	int i;
@@ -241,17 +236,15 @@ static void ste_eppsd_up_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 	const char *res_string;
 	const char *dns[MAX_DNS + 1];
 	struct eppsd_response rsp;
-	GMarkupParseContext *context =3D NULL;
+	GMarkupParseContext *context;
 =

 	l =3D g_slist_find_custom(g_caif_devices,
 				GUINT_TO_POINTER(gcd->active_context),
 				conn_compare_by_cid);
 =

 	if (l =3D=3D NULL) {
-		DBG("Did not find data (device and channel id)"
-					"for connection with cid; %d",
-					gcd->active_context);
-		goto error;
+		DBG("CAIF Device gone missing (cid:%d)", gcd->active_context);
+		goto error_no_device;
 	}
 =

 	conn =3D l->data;
@@ -291,31 +284,21 @@ static void ste_eppsd_up_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 	dns[1] =3D rsp.dns_server2;
 	dns[2] =3D NULL;
 =

-	sprintf(conn->interface, "caif%u", conn->device);
-
-	if (!caif_if_create(conn->interface, conn->channel_id)) {
-		ofono_error("Failed to create caif interface %s.",
-				conn->interface);
-		CALLBACK_WITH_SUCCESS(cb, NULL, FALSE, rsp.ip_address,
-				rsp.subnet_mask, rsp.default_gateway,
+	CALLBACK_WITH_SUCCESS(cb, conn->interface, TRUE, rsp.ip_address,
+				rsp.subnet_mask, NULL,
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
-	DBG("ste_eppsd_up_cb error");
-
 	if (context)
 		g_markup_parse_context_free(context);
 =

 	if (conn)
 		conn->cid =3D 0;
 =

+error_no_device:
+	DBG("ste_eppsd_up_cb error");
+	gcd->active_context =3D 0;
 	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
 }
 =

@@ -325,44 +308,45 @@ static void ste_cgdcont_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 	ofono_gprs_context_up_cb_t cb =3D cbd->cb;
 	struct ofono_gprs_context *gc =3D cbd->user;
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
-	struct cb_data *ncbd =3D NULL;
+	struct cb_data *ncbd;
 	char buf[128];
 	struct conn_info *conn;
 	GSList *l;
 =

+	l =3D g_slist_find_custom(g_caif_devices,
+				GUINT_TO_POINTER(gcd->active_context),
+				conn_compare_by_cid);
+
+	if (!l) {
+		DBG("CAIF Device gone missing (cid:%d)", gcd->active_context);
+		goto error_no_device;
+	}
+
+	conn =3D l->data;
+
 	if (!ok) {
 		struct ofono_error error;
 =

+		conn->cid =3D 0;
 		gcd->active_context =3D 0;
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
-	if (l =3D=3D NULL) {
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

-error:
 	g_free(ncbd);
+	conn->cid =3D 0;
 =

+error_no_device:
 	gcd->active_context =3D 0;
-
 	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL,
 				NULL, NULL, cbd->data);
 }
@@ -375,13 +359,32 @@ static void ste_gprs_activate_primary(struct ofono_gp=
rs_context *gc,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[AUTH_BUF_LENGTH];
 	int len;
+	GSList *l;
+	struct conn_info *conn;
 =

 	if (cbd =3D=3D NULL)
-		goto error;
+		goto error_no_device;
 =

 	gcd->active_context =3D ctx->cid;
 	cbd->user =3D gc;
 =

+	/* Find free connection with cid zero */
+	l =3D g_slist_find_custom(g_caif_devices, GUINT_TO_POINTER(0),
+				conn_compare_by_cid);
+
+	if (!l) {
+		DBG("No more available CAIF devices");
+		goto error_no_device;
+	}
+
+	conn =3D l->data;
+	conn->cid =3D ctx->cid;
+
+	if (!conn->created) {
+		DBG("CAIF interface not created (rtnl error?)");
+		goto error;
+	}
+
 	len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IP\"", ctx->cid);
 =

 	if (ctx->apn)
@@ -405,6 +408,9 @@ static void ste_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 	return;
 =

 error:
+	conn->cid =3D 0;
+
+error_no_device:
 	gcd->active_context =3D 0;
 	g_free(cbd);
 =

@@ -431,8 +437,8 @@ static void ste_gprs_deactivate_primary(struct ofono_gp=
rs_context *gc,
 				conn_compare_by_cid);
 =

 	if (l =3D=3D NULL) {
-		DBG("at_gprs_deactivate_primary, did not find"
-			"data (channel id) for connection with cid; %d", id);
+		DBG("did not find data (channel id) "
+				"for connection with cid; %d", id);
 		goto error;
 	}
 =

@@ -446,7 +452,6 @@ static void ste_gprs_deactivate_primary(struct ofono_gp=
rs_context *gc,
 =

 error:
 	g_free(cbd);
-
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

@@ -457,6 +462,7 @@ static void ste_cgact_read_cb(gboolean ok, GAtResult *r=
esult,
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 	gint cid, state;
 	GAtResultIter iter;
+	GSList *l;
 =

 	if (!ok)
 		return;
@@ -480,7 +486,13 @@ static void ste_cgact_read_cb(gboolean ok, GAtResult *=
result,
 		ofono_gprs_context_deactivated(gc, gcd->active_context);
 		gcd->active_context =3D 0;
 =

-		break;
+		/* Mark interface as unused */
+		l =3D g_slist_find_custom(g_caif_devices, GUINT_TO_POINTER(cid),
+				conn_compare_by_cid);
+		if (l !=3D NULL) {
+			struct conn_info *conn =3D l->data;
+			conn->cid =3D 0;
+		}
 	}
 }
 =

@@ -524,9 +536,11 @@ static int ste_gprs_context_probe(struct ofono_gprs_co=
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
@@ -536,6 +550,7 @@ static void ste_gprs_context_remove(struct ofono_gprs_c=
ontext *gc)
 {
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 =

+	g_slist_foreach(g_caif_devices, (GFunc) caif_if_remove, NULL);
 	g_slist_foreach(g_caif_devices, (GFunc) g_free, NULL);
 	g_slist_free(g_caif_devices);
 	g_caif_devices =3D NULL;
-- =

1.7.0.4


--===============5869406450333233630==--

