Content-Type: multipart/mixed; boundary="===============0173659722918085158=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH v2 3/3] atmodem: Implement the list_activated_contexts callback
Date: Mon, 12 Aug 2019 23:31:30 +0200
Message-ID: <20190812213130.23420-3-richard.rojfors@gmail.com>
In-Reply-To: <20190812213130.23420-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0173659722918085158==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

The callback calls cgact and cgdcont to get information
regarding any activate context.
---
 drivers/atmodem/gprs.c | 167 +++++++++++++++++++++++++++++++++--------
 1 file changed, 134 insertions(+), 33 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 10108281..81e4c30f 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -29,6 +29,7 @@
 #include <stdio.h>
 #include <errno.h>
 =

+#include <ell/ell.h>
 #include <glib.h>
 =

 #include <ofono/log.h>
@@ -41,6 +42,8 @@
 #include "atmodem.h"
 #include "vendor.h"
 =

+#define MAX_CONTEXTS 255
+
 static const char *cgreg_prefix[] =3D { "+CGREG:", NULL };
 static const char *cgdcont_prefix[] =3D { "+CGDCONT:", NULL };
 static const char *cgact_prefix[] =3D { "+CGACT:", NULL };
@@ -54,6 +57,47 @@ struct gprs_data {
 	int attached;
 };
 =

+struct list_contexts_data
+{
+	struct ofono_gprs *gprs;
+	void *cb;
+	void *data;
+	struct l_uintset *active_cids;
+	int ref_count;
+};
+
+static struct list_contexts_data *
+list_contexts_data_new(struct ofono_gprs *gprs, void *cb, void *data)
+{
+	struct list_contexts_data *ret;
+
+	ret =3D g_new0(struct list_contexts_data, 1);
+	ret->ref_count =3D 1;
+	ret->gprs =3D gprs;
+	ret->cb =3D cb;
+	ret->data =3D data;
+
+	return ret;
+}
+
+static struct list_contexts_data *
+list_contexts_data_ref(struct list_contexts_data *ld)
+{
+	ld->ref_count++;
+	return ld;
+}
+
+static void list_contexts_data_unref(gpointer user_data)
+{
+	struct list_contexts_data *ld =3D user_data;
+
+	if (--ld->ref_count)
+		return;
+
+	l_uintset_free(ld->active_cids);
+	g_free(ld);
+}
+
 static void at_cgatt_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -146,14 +190,43 @@ static void at_gprs_registration_status(struct ofono_=
gprs *gprs,
 	CALLBACK_WITH_FAILURE(cb, -1, data);
 }
 =

+static void at_cgdcont_parse(struct ofono_gprs *gprs, GAtResult *result,
+				struct l_uintset *cids)
+{
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	while (g_at_result_iter_next(&iter, "+CGDCONT:")) {
+		int read_cid;
+		const char *apn =3D NULL;
+
+		if (!g_at_result_iter_next_number(&iter, &read_cid))
+			break;
+
+		if (!l_uintset_contains(cids, read_cid))
+			continue;
+
+		/* ignore protocol */
+		g_at_result_iter_skip_next(&iter);
+
+		g_at_result_iter_next_string(&iter, &apn);
+
+		if (apn)
+			ofono_gprs_cid_activated(gprs, read_cid, apn);
+		else
+			ofono_warn("cid %d: Activated but no apn present",
+					read_cid);
+	}
+}
+
 static void at_cgdcont_read_cb(gboolean ok, GAtResult *result,
 				gpointer user_data)
 {
 	struct ofono_gprs *gprs =3D user_data;
 	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
 	int activated_cid =3D gd->last_auto_context_id;
-	const char *apn =3D NULL;
-	GAtResultIter iter;
+	struct l_uintset *cids;
 =

 	DBG("ok %d", ok);
 =

@@ -162,47 +235,52 @@ static void at_cgdcont_read_cb(gboolean ok, GAtResult=
 *result,
 		return;
 	}
 =

-	if (gd->last_auto_context_id =3D=3D -1) {
+	if (activated_cid =3D=3D -1) {
 		DBG("Context got deactivated while calling CGDCONT");
 		return;
 	}
 =

-	g_at_result_iter_init(&iter, result);
+	cids =3D l_uintset_new(activated_cid);
 =

-	while (g_at_result_iter_next(&iter, "+CGDCONT:")) {
-		int read_cid;
-
-		if (!g_at_result_iter_next_number(&iter, &read_cid))
-			break;
+	l_uintset_put(cids, activated_cid);
 =

-		if (read_cid !=3D activated_cid)
-			continue;
+	at_cgdcont_parse(gprs, result, cids);
 =

-		/* ignore protocol */
-		g_at_result_iter_skip_next(&iter);
+	l_uintset_free(cids);
+}
 =

-		g_at_result_iter_next_string(&iter, &apn);
+static void at_cgdcont_act_read_cb(gboolean ok, GAtResult *result,
+					gpointer user_data)
+{
+	struct list_contexts_data *ld =3D user_data;
+	ofono_gprs_cb_t cb =3D ld->cb;
+	struct ofono_error error;
 =

-		break;
-	}
+	decode_at_error(&error, g_at_result_final_response(result));
 =

-	if (apn)
-		ofono_gprs_cid_activated(gprs, activated_cid, apn);
+	if (!ok)
+		ofono_warn("Can't read CGDCONT context.");
 	else
-		ofono_warn("cid %u: Received activated but no apn present",
-				activated_cid);
+		at_cgdcont_parse(ld->gprs, result, ld->active_cids);
+
+	cb(&error, ld->data);
 }
 =

 static void at_cgact_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
-	struct ofono_gprs *gprs =3D user_data;
-	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	struct list_contexts_data *ld =3D user_data;
+	struct gprs_data *gd =3D ofono_gprs_get_data(ld->gprs);
+	ofono_gprs_cb_t cb =3D ld->cb;
+	struct ofono_error error;
 	GAtResultIter iter;
 =

-	DBG("ok %d", ok);
+	decode_at_error(&error, g_at_result_final_response(result));
 =

 	if (!ok) {
 		ofono_warn("Can't read CGACT contexts.");
+
+		cb(&error, ld->data);
+
 		return;
 	}
 =

@@ -222,19 +300,45 @@ static void at_cgact_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 			continue;
 =

 		/* Flag this as auto context as it was obviously active */
-		if (gd->last_auto_context_id =3D=3D 0)
+		if (gd->last_auto_context_id =3D=3D -1)
 			gd->last_auto_context_id =3D read_cid;
 =

-		if (read_cid !=3D gd->last_auto_context_id)
-			continue;
+		if (!ld->active_cids)
+			ld->active_cids =3D l_uintset_new(MAX_CONTEXTS);
 =

-		g_at_chat_send(gd->chat, "AT+CGDCONT?", cgdcont_prefix,
-				at_cgdcont_read_cb, gprs, NULL);
+		l_uintset_put(ld->active_cids, read_cid);
+	}
 =

-		break;
+	if (ld->active_cids !=3D NULL) {
+		if (g_at_chat_send(gd->chat, "AT+CGDCONT?", cgdcont_prefix,
+					at_cgdcont_act_read_cb, ld,
+					list_contexts_data_unref)) {
+			list_contexts_data_ref(ld);
+			return;
+		}
+
+		CALLBACK_WITH_FAILURE(cb, ld->data);
+	} else {
+		/* No active contexts found */
+		cb(&error, ld->data);
 	}
 }
 =

+static void at_gprs_list_active_contexts(struct ofono_gprs *gprs,
+						ofono_gprs_cb_t cb, void *data)
+{
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	struct list_contexts_data *ld =3D list_contexts_data_new(gprs, cb, data);
+
+	if (g_at_chat_send(gd->chat, "AT+CGACT?", cgact_prefix,
+				at_cgact_cb, ld, list_contexts_data_unref))
+		return;
+
+	list_contexts_data_unref(ld);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
 static void cgreg_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_gprs *gprs =3D user_data;
@@ -538,10 +642,6 @@ static void gprs_initialized(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 		break;
 	}
 =

-	/* Check if there is any already activated contexts at init */
-	g_at_chat_send(gd->chat, "AT+CGACT?", cgact_prefix,
-			at_cgact_cb, gprs, NULL);
-
 	ofono_gprs_register(gprs);
 }
 =

@@ -705,6 +805,7 @@ static const struct ofono_gprs_driver driver =3D {
 	.remove			=3D at_gprs_remove,
 	.set_attached		=3D at_gprs_set_attached,
 	.attached_status	=3D at_gprs_registration_status,
+	.list_active_contexts	=3D at_gprs_list_active_contexts,
 };
 =

 void at_gprs_init(void)
-- =

2.20.1


--===============0173659722918085158==--

