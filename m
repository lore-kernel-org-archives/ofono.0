Content-Type: multipart/mixed; boundary="===============5054132880687908525=="
MIME-Version: 1.0
From: Tomasz Gregorek <tomasz.gregorek@gmail.com>
Subject: [PATCH] atmodem: CEREG support for LTE network status reporting in AT
 modem
Date: Thu, 17 Feb 2011 22:52:45 -0500
Message-ID: <1298001165-2105-1-git-send-email-tomasz.gregorek@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5054132880687908525==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Tomasz Gregorek <tomasz.gregorek@stericsson.com>

This is a proposal for CEREG support based on the AT modem.
Support in driver should work, though I have an issue with
the core.

The core has one gprs status currently. In case of having
second status for LTE, there is need of having two satuses,
one for each, 3G and LTE, or to combine those two into one.

I took second approach as it leaves current oFono API, though
it is not perfect.
---
 drivers/atmodem/gprs.c  |  151 +++++++++++++++++++++++++++++++++++++++++++=
----
 drivers/isimodem/gprs.c |    6 +-
 include/gprs.h          |   11 +++-
 src/gprs.c              |   43 ++++++++++++-
 4 files changed, 189 insertions(+), 22 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 6e01994..f6585de 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -43,12 +43,15 @@
 #include "vendor.h"
 =

 static const char *cgreg_prefix[] =3D { "+CGREG:", NULL };
+static const char *cereg_prefix[] =3D { "+CEREG:", NULL };
 static const char *cgdcont_prefix[] =3D { "+CGDCONT:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

 struct gprs_data {
 	GAtChat *chat;
 	unsigned int vendor;
+	ofono_bool_t have_cgreg;
+	ofono_bool_t have_cereg;
 };
 =

 static void at_cgatt_cb(gboolean ok, GAtResult *result, gpointer user_data)
@@ -80,6 +83,31 @@ static void at_gprs_set_attached(struct ofono_gprs *gprs=
, int attached,
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

+static void at_cereg_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_gprs_status_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	int status;
+	struct gprs_data *gd =3D cbd->user;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, -1, GPRS_PS_STATUS_SOURCE_LTE, cbd->data);
+		return;
+	}
+
+	if (at_util_parse_reg(result, "+CEREG:", NULL, &status,
+				NULL, NULL, NULL, gd->vendor) =3D=3D FALSE) {
+		CALLBACK_WITH_FAILURE(cb, -1,
+				GPRS_PS_STATUS_SOURCE_LTE, cbd->data);
+		return;
+	}
+
+	cb(&error, status, GPRS_PS_STATUS_SOURCE_LTE, cbd->data);
+}
+
 static void at_cgreg_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -91,17 +119,28 @@ static void at_cgreg_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 	decode_at_error(&error, g_at_result_final_response(result));
 =

 	if (!ok) {
-		cb(&error, -1, cbd->data);
+		cb(&error, -1, GPRS_PS_STATUS_SOURCE_LTE, cbd->data);
 		return;
 	}
 =

 	if (at_util_parse_reg(result, "+CGREG:", NULL, &status,
 				NULL, NULL, NULL, gd->vendor) =3D=3D FALSE) {
-		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		CALLBACK_WITH_FAILURE(cb, -1,
+				GPRS_PS_STATUS_SOURCE_3G, cbd->data);
+		g_free(cbd);
 		return;
 	}
 =

-	cb(&error, status, cbd->data);
+	cb(&error, status, GPRS_PS_STATUS_SOURCE_3G, cbd->data);
+
+	if (gd->have_cereg) {
+		if (g_at_chat_send(gd->chat, "AT+CEREG?", cereg_prefix,
+				at_cereg_cb, cbd, g_free) =3D=3D FALSE) {
+			CALLBACK_WITH_FAILURE(cb, -1,
+					GPRS_PS_STATUS_SOURCE_LTE, cbd->data);
+			g_free(cbd);
+		}
+	}
 }
 =

 static void at_gprs_registration_status(struct ofono_gprs *gprs,
@@ -132,9 +171,17 @@ static void at_gprs_registration_status(struct ofono_g=
prs *gprs,
 		break;
 	}
 =

-	if (g_at_chat_send(gd->chat, "AT+CGREG?", cgreg_prefix,
-				at_cgreg_cb, cbd, g_free) > 0)
+	if (gd->have_cgreg) {
+		if (g_at_chat_send(gd->chat, "AT+CGREG?", cgreg_prefix,
+			at_cgreg_cb, cbd, NULL) > 0)
 		return;
+	}
+	else {
+		if (g_at_chat_send(gd->chat, "AT+CEREG?", cereg_prefix,
+			at_cereg_cb, cbd, g_free) > 0)
+		return;
+	}
+
 =

 	g_free(cbd);
 =

@@ -151,7 +198,20 @@ static void cgreg_notify(GAtResult *result, gpointer u=
ser_data)
 				NULL, NULL, NULL, gd->vendor) =3D=3D FALSE)
 		return;
 =

-	ofono_gprs_status_notify(gprs, status);
+	ofono_gprs_status_notify(gprs, status, GPRS_PS_STATUS_SOURCE_3G);
+}
+
+static void cereg_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	int status;
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+
+	if (at_util_parse_reg_unsolicited(result, "+CEREG:", &status,
+				NULL, NULL, NULL, gd->vendor) =3D=3D FALSE)
+		return;
+
+	ofono_gprs_status_notify(gprs, status, GPRS_PS_STATUS_SOURCE_LTE);
 }
 =

 static void cgev_notify(GAtResult *result, gpointer user_data)
@@ -226,8 +286,15 @@ static void gprs_initialized(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
 =

 	g_at_chat_register(gd->chat, "+CGEV:", cgev_notify, FALSE, gprs, NULL);
-	g_at_chat_register(gd->chat, "+CGREG:", cgreg_notify,
+
+	if (gd->have_cgreg)
+		g_at_chat_register(gd->chat, "+CGREG:", cgreg_notify,
 						FALSE, gprs, NULL);
+
+	if (gd->have_cereg)
+		g_at_chat_register(gd->chat, "+CEREG:", cereg_notify,
+						FALSE, gprs, NULL);
+
 	g_at_chat_register(gd->chat, "+CPSB:", cpsb_notify, FALSE, gprs, NULL);
 =

 	g_at_chat_send(gd->chat, "AT+CPSB=3D1", none_prefix, NULL, NULL, NULL);
@@ -257,15 +324,15 @@ static void at_cgreg_test_cb(gboolean ok, GAtResult *=
result,
 	const char *cmd;
 =

 	if (!ok)
-		goto error;
+		goto cgreg_notsupported;
 =

 	g_at_result_iter_init(&iter, result);
 =

 	if (!g_at_result_iter_next(&iter, "+CGREG:"))
-		goto error;
+		goto cgreg_notsupported;
 =

 	if (!g_at_result_iter_open_list(&iter))
-		goto error;
+		goto cgreg_notsupported;
 =

 	while (g_at_result_iter_next_range(&iter, &range[0], &range[1])) {
 		if (1 >=3D range[0] && 1 <=3D range[1])
@@ -281,9 +348,16 @@ static void at_cgreg_test_cb(gboolean ok, GAtResult *r=
esult,
 	else if (cgreg1)
 		cmd =3D "AT+CGREG=3D1";
 	else
-		goto error;
+		goto cgreg_notsupported;
+
+	gd->have_cgreg =3D TRUE;
 =

 	g_at_chat_send(gd->chat, cmd, none_prefix, NULL, NULL, NULL);
+
+cgreg_notsupported:
+	if (gd->have_cgreg =3D=3D FALSE && gd->have_cereg =3D=3D FALSE)
+		goto error;
+
 	g_at_chat_send(gd->chat, "AT+CGAUTO=3D0", none_prefix, NULL, NULL, NULL);
 =

 	switch (gd->vendor) {
@@ -354,6 +428,10 @@ static void at_cgdcont_test_cb(gboolean ok, GAtResult =
*result,
 	if (found =3D=3D FALSE)
 		goto error;
 =

+	/* In case of LTE modem reserve lowest cid for Initial PDN */
+	if (gd->have_cereg)
+		min++;
+
 	ofono_gprs_set_cid_range(gprs, min, max);
 =

 	g_at_chat_send(gd->chat, "AT+CGREG=3D?", cgreg_prefix,
@@ -366,6 +444,53 @@ error:
 	ofono_gprs_remove(gprs);
 }
 =

+static void at_cereg_test_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	gint range[2];
+	GAtResultIter iter;
+	int cereg1 =3D 0;
+	int cereg2 =3D 0;
+	const char *cmd;
+
+	if (!ok)
+		goto test_cgdcont;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CEREG:"))
+		goto test_cgdcont;
+
+	if (!g_at_result_iter_open_list(&iter))
+		goto test_cgdcont;
+
+	while (g_at_result_iter_next_range(&iter, &range[0], &range[1])) {
+		if (1 >=3D range[0] && 1 <=3D range[1])
+			cereg1 =3D 1;
+		if (2 >=3D range[0] && 2 <=3D range[1])
+			cereg2 =3D 1;
+	}
+
+	g_at_result_iter_close_list(&iter);
+
+	if (cereg2)
+		cmd =3D "AT+CEREG=3D2";
+	else if (cereg1)
+		cmd =3D "AT+CEREG=3D1";
+	else
+		goto test_cgdcont;
+
+	gd->have_cereg =3D TRUE;
+
+	g_at_chat_send(gd->chat, cmd, none_prefix, NULL, NULL, NULL);
+
+test_cgdcont:
+	g_at_chat_send(gd->chat, "AT+CGDCONT=3D?", cgdcont_prefix,
+			at_cgdcont_test_cb, gprs, NULL);
+}
+
 static int at_gprs_probe(struct ofono_gprs *gprs,
 					unsigned int vendor, void *data)
 {
@@ -381,8 +506,8 @@ static int at_gprs_probe(struct ofono_gprs *gprs,
 =

 	ofono_gprs_set_data(gprs, gd);
 =

-	g_at_chat_send(gd->chat, "AT+CGDCONT=3D?", cgdcont_prefix,
-			at_cgdcont_test_cb, gprs, NULL);
+	g_at_chat_send(gd->chat, "AT+CEREG=3D?", cgdcont_prefix,
+			at_cereg_test_cb, gprs, NULL);
 =

 	return 0;
 }
diff --git a/drivers/isimodem/gprs.c b/drivers/isimodem/gprs.c
index ea90704..7d54df3 100644
--- a/drivers/isimodem/gprs.c
+++ b/drivers/isimodem/gprs.c
@@ -459,11 +459,11 @@ static void status_resp_cb(const GIsiMessage *msg, vo=
id *opaque)
 =

 	suspend_notify(gprs, data[10], data[11]);
 =

-	CALLBACK_WITH_SUCCESS(cb, status, cbd->data);
+	CALLBACK_WITH_SUCCESS(cb, status, GPRS_PS_STATUS_SOURCE_3G, cbd->data);
 	return;
 =

 error:
-	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+	CALLBACK_WITH_FAILURE(cb, -1, GPRS_PS_STATUS_SOURCE_3G, cbd->data);
 }
 =

 static void isi_gprs_attached_status(struct ofono_gprs *gprs,
@@ -485,7 +485,7 @@ static void isi_gprs_attached_status(struct ofono_gprs =
*gprs,
 		return;
 =

 error:
-	CALLBACK_WITH_FAILURE(cb, -1, data);
+	CALLBACK_WITH_FAILURE(cb, -1, GPRS_PS_STATUS_SOURCE_3G, data);
 	g_free(cbd);
 }
 =

diff --git a/include/gprs.h b/include/gprs.h
index 157a6f9..305e12f 100644
--- a/include/gprs.h
+++ b/include/gprs.h
@@ -31,8 +31,14 @@ extern "C" {
 struct ofono_gprs;
 struct ofono_gprs_context;
 =

+enum gprs_ps_status_source {
+	GPRS_PS_STATUS_SOURCE_3G,
+	GPRS_PS_STATUS_SOURCE_LTE,
+};
+
 typedef void (*ofono_gprs_status_cb_t)(const struct ofono_error *error,
-						int status, void *data);
+			int status, enum gprs_ps_status_source status_src,
+			void *data);
 =

 typedef void (*ofono_gprs_cb_t)(const struct ofono_error *error, void *dat=
a);
 =

@@ -55,7 +61,8 @@ enum gprs_suspend_cause {
 	GPRS_SUSPENDED_UNKNOWN_CAUSE,
 };
 =

-void ofono_gprs_status_notify(struct ofono_gprs *gprs, int status);
+void ofono_gprs_status_notify(struct ofono_gprs *gprs,
+		int status, enum gprs_ps_status_source status_src);
 void ofono_gprs_detached_notify(struct ofono_gprs *gprs);
 void ofono_gprs_suspend_notify(struct ofono_gprs *gprs, int cause);
 void ofono_gprs_resume_notify(struct ofono_gprs *gprs);
diff --git a/src/gprs.c b/src/gprs.c
index 33711dc..faccb91 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -80,6 +80,8 @@ struct ofono_gprs {
 	ofono_bool_t powered;
 	ofono_bool_t suspended;
 	int status;
+	int status3G;
+	int statusLTE;
 	int flags;
 	int bearer;
 	guint suspend_timeout;
@@ -138,6 +140,17 @@ struct pri_context {
 	struct ofono_gprs *gprs;
 };
 =

+static const char status_priority[]=3D{
+               0, /* NETWORK_REGISTRATION_STATUS_NOT_REGISTERED */
+               4, /* NETWORK_REGISTRATION_STATUS_REGISTERED */
+               3, /* NETWORK_REGISTRATION_STATUS_SEARCHING */
+               2, /* NETWORK_REGISTRATION_STATUS_DENIED */
+               1, /* NETWORK_REGISTRATION_STATUS_UNKNOWN */
+               5  /* NETWORK_REGISTRATION_STATUS_ROAMING */
+               /*0,  AT+CxREG? error */
+};
+
+
 static void gprs_netreg_update(struct ofono_gprs *gprs);
 static void gprs_deactivate_next(struct ofono_gprs *gprs);
 =

@@ -1370,7 +1383,8 @@ static void gprs_attached_update(struct ofono_gprs *g=
prs)
 }
 =

 static void registration_status_cb(const struct ofono_error *error,
-					int status, void *data)
+			int status, enum gprs_ps_status_source status_src,
+			void *data)
 {
 	struct ofono_gprs *gprs =3D data;
 =

@@ -1378,7 +1392,7 @@ static void registration_status_cb(const struct ofono=
_error *error,
 		error->type, status);
 =

 	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
-		ofono_gprs_status_notify(gprs, status);
+		ofono_gprs_status_notify(gprs, status, status_src);
 =

 	if (gprs->flags & GPRS_FLAG_RECHECK) {
 		gprs->flags &=3D ~GPRS_FLAG_RECHECK;
@@ -1985,11 +1999,32 @@ void ofono_gprs_detached_notify(struct ofono_gprs *=
gprs)
 	 */
 }
 =

-void ofono_gprs_status_notify(struct ofono_gprs *gprs, int status)
+void ofono_gprs_status_notify(struct ofono_gprs *gprs, int status,
+		enum gprs_ps_status_source status_src)
 {
 	DBG("%s status %d", __ofono_atom_get_path(gprs->atom), status);
 =

-	gprs->status =3D status;
+	/*
+	 * Combine statuses from 3G and LTE network into one.
+	 * Use prioryty table as a base.
+	 */
+	if (status !=3D -1) {
+		switch(status_src)
+		{
+			case GPRS_PS_STATUS_SOURCE_3G:
+				gprs->status3G =3D status;
+				break;
+			case GPRS_PS_STATUS_SOURCE_LTE:
+				gprs->statusLTE =3D status;
+				break;
+		}
+
+		gprs->status =3D ((status_priority[gprs->status3G] >=3D
+				status_priority[gprs->statusLTE]) ?
+					gprs->status3G : gprs->statusLTE);
+	}
+	else
+		gprs->status =3D -1;
 =

 	if (status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED &&
 			status !=3D NETWORK_REGISTRATION_STATUS_ROAMING) {
-- =

1.7.4


--===============5054132880687908525==--

