Content-Type: multipart/mixed; boundary="===============2854567202960994719=="
MIME-Version: 1.0
From: Marit Henriksen <maritsofie.henriksen8@gmail.com>
Subject: [PATCH 2/2] stemodem: Add support for multiple pdp contexts.
Date: Tue, 08 Feb 2011 12:17:48 +0100
Message-ID: <1297163868-27859-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2854567202960994719==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Marit Henriksen <marit.henriksen@stericsson.com>

Redesigned, there will be only one contexts for each instance of
the driver and only one CAIF interface, no longer need the list
of caif devices.
---
 drivers/stemodem/gprs-context.c |  273 ++++++++---------------------------=
----
 1 files changed, 57 insertions(+), 216 deletions(-)

diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-contex=
t.c
index e247f35..c0496f7 100644
--- a/drivers/stemodem/gprs-context.c
+++ b/drivers/stemodem/gprs-context.c
@@ -50,29 +50,17 @@
 #include "caif_rtnl.h"
 #include "common.h"
 =

-#define MAX_CAIF_DEVICES 4
 #define MAX_DNS 2
 #define IP_ADDR_LEN 20
 =

 #define AUTH_BUF_LENGTH (OFONO_GPRS_MAX_USERNAME_LENGTH + \
 			OFONO_GPRS_MAX_PASSWORD_LENGTH + 128)
 =

-static const char *cgact_prefix[] =3D { "+CGACT:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

-static GSList *g_caif_devices;
-
 struct gprs_context_data {
 	GAtChat *chat;
 	unsigned int active_context;
-};
-
-struct conn_info {
-	/*
-	 * cid is allocated in oFono Core and is identifying
-	 * the Account. cid =3D 0 indicates that it is currently unused.
-	 */
-	unsigned int cid;
 	/* Id used by CAIF and EPPSD to identify the CAIF channel*/
 	unsigned int channel_id;
 	/* Linux Interface Id */
@@ -150,62 +138,19 @@ static GMarkupParser parser =3D {
 	error_handler
 };
 =

-static gint conn_compare_by_cid(gconstpointer a, gconstpointer b)
-{
-	const struct conn_info *conn =3D a;
-	unsigned int used =3D GPOINTER_TO_UINT(b);
-
-	if (used !=3D conn->cid)
-		return 1;
-
-	return 0;
-}
-
-static struct conn_info *conn_info_create(unsigned int channel_id)
-{
-	struct conn_info *connection =3D g_try_new0(struct conn_info, 1);
-
-	if (connection =3D=3D NULL)
-		return NULL;
-
-	connection->cid =3D 0;
-	connection->channel_id =3D channel_id;
-
-	return connection;
-}
-
 static void rtnl_callback(int ifindex, const char *ifname, void *user_data)
 {
-	struct conn_info *conn =3D user_data;
+	struct gprs_context_data *gcd =3D user_data;
 =

 	if (ifindex < 0) {
-		conn->created =3D FALSE;
-		ofono_error("Failed to create caif interface %s",
-			conn->interface);
+		gcd->created =3D FALSE;
+		ofono_error("Failed to create caif interface");
 		return;
 	}
 =

-	strncpy(conn->interface, ifname, sizeof(conn->interface));
-	conn->ifindex =3D ifindex;
-	conn->created =3D TRUE;
-}
-
-/*
- * Removes IP interface for CAIF.
- */
-static void caif_if_remove(struct conn_info *conn)
-{
-	if (!conn->created)
-		return;
-
-	if (caif_rtnl_delete_interface(conn->ifindex) < 0) {
-		ofono_error("Failed to delete caif interface %s",
-			conn->interface);
-		return;
-	}
-
-	DBG("removed CAIF interface ch:%d ifname:%s ifindex:%d\n",
-		conn->channel_id, conn->interface, conn->ifindex);
+	strncpy(gcd->interface, ifname, sizeof(gcd->interface));
+	gcd->ifindex =3D ifindex;
+	gcd->created =3D TRUE;
 }
 =

 static void ste_eppsd_down_cb(gboolean ok, GAtResult *result,
@@ -215,8 +160,6 @@ static void ste_eppsd_down_cb(gboolean ok, GAtResult *r=
esult,
 	ofono_gprs_context_cb_t cb =3D cbd->cb;
 	struct ofono_gprs_context *gc =3D cbd->user;
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
-	struct conn_info *conn;
-	GSList *l;
 =

 	if (!ok) {
 		struct ofono_error error;
@@ -226,20 +169,7 @@ static void ste_eppsd_down_cb(gboolean ok, GAtResult *=
result,
 		return;
 	}
 =

-	l =3D g_slist_find_custom(g_caif_devices,
-				GUINT_TO_POINTER(gcd->active_context),
-				conn_compare_by_cid);
-
-	if (l =3D=3D NULL) {
-		DBG("Did not find data (used caif device) for"
-					"connection with cid; %d",
-					gcd->active_context);
-		CALLBACK_WITH_FAILURE(cb, cbd->data);
-		return;
-	}
-
-	conn =3D l->data;
-	conn->cid =3D 0;
+	gcd->active_context =3D 0;
 	CALLBACK_WITH_SUCCESS(cb, cbd->data);
 }
 =

@@ -249,9 +179,7 @@ static void ste_eppsd_up_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 	ofono_gprs_context_up_cb_t cb =3D cbd->cb;
 	struct ofono_gprs_context *gc =3D cbd->user;
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
-	struct conn_info *conn;
 	GAtResultIter iter;
-	GSList *l;
 	int i;
 	gsize length;
 	const char *res_string;
@@ -259,21 +187,9 @@ static void ste_eppsd_up_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 	struct eppsd_response rsp;
 	GMarkupParseContext *context;
 =

-	l =3D g_slist_find_custom(g_caif_devices,
-				GUINT_TO_POINTER(gcd->active_context),
-				conn_compare_by_cid);
-
-	if (l =3D=3D NULL) {
-		DBG("CAIF Device gone missing (cid:%d)", gcd->active_context);
-		goto error_no_device;
-	}
-
-	conn =3D l->data;
-
 	if (!ok) {
 		struct ofono_error error;
 =

-		conn->cid =3D 0;
 		gcd->active_context =3D 0;
 		decode_at_error(&error, g_at_result_final_response(result));
 		cb(&error, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
@@ -305,20 +221,17 @@ static void ste_eppsd_up_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 	dns[1] =3D rsp.dns_server2;
 	dns[2] =3D NULL;
 =

-	CALLBACK_WITH_SUCCESS(cb, conn->interface, TRUE, rsp.ip_address,
+	CALLBACK_WITH_SUCCESS(cb, gcd->interface, TRUE, rsp.ip_address,
 				rsp.subnet_mask, NULL,
 				dns, cbd->data);
 	return;
 =

 error:
+	DBG("ste_eppsd_up_cb error");
+
 	if (context)
 		g_markup_parse_context_free(context);
 =

-	if (conn)
-		conn->cid =3D 0;
-
-error_no_device:
-	DBG("ste_eppsd_up_cb error");
 	gcd->active_context =3D 0;
 	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
 }
@@ -331,32 +244,19 @@ static void ste_cgdcont_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 	struct cb_data *ncbd;
 	char buf[128];
-	struct conn_info *conn;
-	GSList *l;
-
-	l =3D g_slist_find_custom(g_caif_devices,
-				GUINT_TO_POINTER(gcd->active_context),
-				conn_compare_by_cid);
-
-	if (!l) {
-		DBG("CAIF Device gone missing (cid:%d)", gcd->active_context);
-		goto error_no_device;
-	}
-
-	conn =3D l->data;
 =

 	if (!ok) {
 		struct ofono_error error;
 =

-		conn->cid =3D 0;
 		gcd->active_context =3D 0;
 		decode_at_error(&error, g_at_result_final_response(result));
 		cb(&error, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
 		return;
 	}
 =

-	snprintf(buf, sizeof(buf), "AT*EPPSD=3D1,%u,%u",
-			conn->channel_id, conn->cid);
+	snprintf(buf, sizeof(buf), "AT*EPPSD=3D1,%x,%u",
+			gcd->channel_id, gcd->active_context);
+
 	ncbd =3D g_memdup(cbd, sizeof(struct cb_data));
 =

 	if (g_at_chat_send(gcd->chat, buf, NULL,
@@ -364,12 +264,8 @@ static void ste_cgdcont_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 		return;
 =

 	g_free(ncbd);
-	conn->cid =3D 0;
-
-error_no_device:
 	gcd->active_context =3D 0;
-	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL,
-				NULL, NULL, cbd->data);
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
 }
 =

 static void ste_gprs_activate_primary(struct ofono_gprs_context *gc,
@@ -380,25 +276,11 @@ static void ste_gprs_activate_primary(struct ofono_gp=
rs_context *gc,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[AUTH_BUF_LENGTH];
 	int len;
-	GSList *l;
-	struct conn_info *conn;
 =

 	gcd->active_context =3D ctx->cid;
 	cbd->user =3D gc;
 =

-	/* Find free connection with cid zero */
-	l =3D g_slist_find_custom(g_caif_devices, GUINT_TO_POINTER(0),
-				conn_compare_by_cid);
-
-	if (!l) {
-		DBG("No more available CAIF devices");
-		goto error_no_device;
-	}
-
-	conn =3D l->data;
-	conn->cid =3D ctx->cid;
-
-	if (!conn->created) {
+	if (!gcd->created) {
 		DBG("CAIF interface not created (rtnl error?)");
 		goto error;
 	}
@@ -406,7 +288,7 @@ static void ste_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 	len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IP\"", ctx->cid);
 =

 	if (ctx->apn)
-		snprintf(buf + len, sizeof(buf) - len - 3, ",\"%s\"",
+		snprintf(buf + len, sizeof(buf) - len, ",\"%s\"",
 				ctx->apn);
 =

 	if (g_at_chat_send(gcd->chat, buf, none_prefix,
@@ -426,9 +308,6 @@ static void ste_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 	return;
 =

 error:
-	conn->cid =3D 0;
-
-error_no_device:
 	gcd->active_context =3D 0;
 	g_free(cbd);
 =

@@ -441,82 +320,27 @@ static void ste_gprs_deactivate_primary(struct ofono_=
gprs_context *gc,
 {
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
-	struct conn_info *conn;
 	char buf[64];
-	GSList *l;
 =

-	gcd->active_context =3D id;
 	cbd->user =3D gc;
 =

-	l =3D g_slist_find_custom(g_caif_devices, GUINT_TO_POINTER(id),
-				conn_compare_by_cid);
-
-	if (l =3D=3D NULL) {
-		DBG("did not find data (channel id) "
-				"for connection with cid; %d", id);
-		goto error;
-	}
-
-	conn =3D l->data;
-
-	snprintf(buf, sizeof(buf), "AT*EPPSD=3D0,%u,%u", conn->channel_id, id);
+	snprintf(buf, sizeof(buf), "AT*EPPSD=3D0,%x,%u", gcd->channel_id, id);
 =

 	if (g_at_chat_send(gcd->chat, buf, none_prefix,
 				ste_eppsd_down_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

-static void ste_cgact_read_cb(gboolean ok, GAtResult *result,
-				gpointer user_data)
-{
-	struct ofono_gprs_context *gc =3D user_data;
-	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
-	gint cid, state;
-	GAtResultIter iter;
-	GSList *l;
-
-	if (!ok)
-		return;
-
-	g_at_result_iter_init(&iter, result);
-
-	while (g_at_result_iter_next(&iter, "+CGACT:")) {
-
-		if (!g_at_result_iter_next_number(&iter, &cid))
-			continue;
-
-		if ((unsigned int) cid !=3D gcd->active_context)
-			continue;
-
-		if (!g_at_result_iter_next_number(&iter, &state))
-			continue;
-
-		if (state =3D=3D CONTEXT_STATUS_ACTIVATED)
-			continue;
-
-		ofono_gprs_context_deactivated(gc, gcd->active_context);
-		gcd->active_context =3D 0;
-
-		/* Mark interface as unused */
-		l =3D g_slist_find_custom(g_caif_devices, GUINT_TO_POINTER(cid),
-				conn_compare_by_cid);
-		if (l !=3D NULL) {
-			struct conn_info *conn =3D l->data;
-			conn->cid =3D 0;
-		}
-	}
-}
-
 static void cgev_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_gprs_context *gc =3D user_data;
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 	GAtResultIter iter;
 	const char *event;
+	int cid;
 =

 	g_at_result_iter_init(&iter, result);
 =

@@ -526,9 +350,20 @@ static void cgev_notify(GAtResult *result, gpointer us=
er_data)
 	if (!g_at_result_iter_next_unquoted_string(&iter, &event))
 		return;
 =

-	/* Ask what primary contexts are active now */
-	g_at_chat_send(gcd->chat, "AT+CGACT?", cgact_prefix,
-			ste_cgact_read_cb, gc, NULL);
+	if (g_str_has_prefix(event, "NW DEACT") =3D=3D FALSE)
+		return;
+
+	if (!g_at_result_iter_skip_next(&iter))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &cid))
+		return;
+
+	if ((unsigned int) cid !=3D gcd->active_context)
+		return;
+
+	ofono_gprs_context_deactivated(gc, gcd->active_context);
+	gcd->active_context =3D 0;
 }
 =

 static int ste_gprs_context_probe(struct ofono_gprs_context *gc,
@@ -536,29 +371,24 @@ static int ste_gprs_context_probe(struct ofono_gprs_c=
ontext *gc,
 {
 	GAtChat *chat =3D data;
 	struct gprs_context_data *gcd;
-	struct conn_info *ci;
-	int i, err;
+	int err;
 =

 	gcd =3D g_new0(struct gprs_context_data, 1);
 	gcd->chat =3D g_at_chat_clone(chat);
 =

 	g_at_chat_register(gcd->chat, "+CGEV:", cgev_notify, FALSE, gc, NULL);
 =

+	/* Need a unique channel id */
+	gcd->channel_id =3D (unsigned int)gc;
+
 	ofono_gprs_context_set_data(gc, gcd);
 =

-	for (i =3D 0; i < MAX_CAIF_DEVICES; i++) {
-		ci =3D conn_info_create(i+1);
-		if (!ci)
-			return -ENOMEM;
-		err =3D caif_rtnl_create_interface(IFLA_CAIF_IPV4_CONNID,
-						ci->channel_id, FALSE,
-						rtnl_callback, ci);
-		if (err < 0) {
-			DBG("Failed to create IP interface for CAIF");
-			return err;
-		}
-
-		g_caif_devices =3D g_slist_append(g_caif_devices, ci);
+	err =3D caif_rtnl_create_interface(IFLA_CAIF_IPV4_CONNID,
+					gcd->channel_id, FALSE,
+					rtnl_callback, gcd);
+	if (err < 0) {
+		DBG("Failed to create IP interface for CAIF");
+		return err;
 	}
 =

 	return 0;
@@ -568,11 +398,22 @@ static void ste_gprs_context_remove(struct ofono_gprs=
_context *gc)
 {
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 =

-	g_slist_foreach(g_caif_devices, (GFunc) caif_if_remove, NULL);
-	g_slist_foreach(g_caif_devices, (GFunc) g_free, NULL);
-	g_slist_free(g_caif_devices);
-	g_caif_devices =3D NULL;
+	/*
+	 * Removes IP interface for CAIF.
+	 */
+	if (!gcd->created)
+		goto out;
+
+	if (caif_rtnl_delete_interface(gcd->ifindex) < 0) {
+		ofono_error("Failed to delete caif interface %s",
+				gcd->interface);
+		goto out;
+	}
+
+	DBG("removed CAIF interface ch:%d ifname:%s ifindex:%d\n",
+			gcd->channel_id, gcd->interface, gcd->ifindex);
 =

+out:
 	ofono_gprs_context_set_data(gc, NULL);
 =

 	g_at_chat_unref(gcd->chat);
-- =

1.7.1


--===============2854567202960994719==--

