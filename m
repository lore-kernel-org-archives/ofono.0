Content-Type: multipart/mixed; boundary="===============7189252971193262736=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH v4 5/6] ublox: extend LTE driver
Date: Wed, 13 Mar 2019 22:36:00 +0100
Message-ID: <20190313213601.24971-5-jonas@norrbonn.se>
In-Reply-To: <20190313213601.24971-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7189252971193262736==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There are a couple of semi-independent changes here:

* use the 'vendor' parameter to pass the modem 'model'
* support TOBY L4 modem which uses a fixed CID for configuring the EPS
default bearer
* add the setup of authentication parameters that was recently added to
the atmodem LTE driver
---
 drivers/ubloxmodem/lte.c | 101 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 89 insertions(+), 12 deletions(-)

diff --git a/drivers/ubloxmodem/lte.c b/drivers/ubloxmodem/lte.c
index 34397dfe..eb9062d9 100644
--- a/drivers/ubloxmodem/lte.c
+++ b/drivers/ubloxmodem/lte.c
@@ -39,24 +39,85 @@
 =

 #include "ubloxmodem.h"
 =

-static const char *ucgdflt_prefix[] =3D { "+UCGDFLT:", NULL };
+static const char *none_prefix[] =3D { NULL };
 =

 struct lte_driver_data {
 	GAtChat *chat;
+	const struct ublox_model *model;
+	struct ofono_lte_default_attach_info pending_info;
 };
 =

-static void ucgdflt_cb(gboolean ok, GAtResult *result, gpointer user_data)
+static void at_lte_set_auth_cb(gboolean ok, GAtResult *result,
+							gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
 	ofono_lte_cb_t cb =3D cbd->cb;
 	struct ofono_error error;
 =

-	DBG("ok %d", ok);
-
 	decode_at_error(&error, g_at_result_final_response(result));
 	cb(&error, cbd->data);
 }
 =

+static void at_lte_set_default_attach_info_cb(gboolean ok, GAtResult *resu=
lt,
+							gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_lte_cb_t cb =3D cbd->cb;
+	void *data =3D cbd->data;
+	struct lte_driver_data *ldd =3D cbd->user;
+	struct ofono_error error;
+	char buf[32 + OFONO_GPRS_MAX_USERNAME_LENGTH +
+					OFONO_GPRS_MAX_PASSWORD_LENGTH  + 1];
+	enum ofono_gprs_auth_method auth_method;
+	int cid;
+
+	if (!ok) {
+		decode_at_error(&error, g_at_result_final_response(result));
+		cb(&error, data);
+		return;
+	}
+
+	if (ublox_is_toby_l2(ldd->model)) {
+		/* If CGDCONT has already been used to set up cid 4 then
+		 * the EPS default bearer will be configured from another
+		 * cid (see documentation for how this is selected).  Avoid
+		 * doing so as this assumes as much...
+		 */
+		cid =3D 4;
+	} else if (ublox_is_toby_l4(ldd->model)) {
+		cid =3D 1;
+	} else {
+		ofono_error("Unknown model; "
+			"unable to determine EPS default bearer CID");
+		goto out;
+	}
+
+	auth_method =3D ldd->pending_info.auth_method;
+
+	/* change the authentication method if the  parameters are invalid */
+	if (!*ldd->pending_info.username || !*ldd->pending_info.password)
+		auth_method =3D OFONO_GPRS_AUTH_METHOD_NONE;
+
+	/* In contrast to CGAUTH, all four parameters are _required_ here;
+	 * if auth type is NONE then username and password must be set to
+	 * empty strings.
+	 */
+	sprintf(buf, "AT+UAUTHREQ=3D%d,%d,\"%s\",\"%s\"",
+			cid,
+			at_util_gprs_auth_method_to_auth_prot(auth_method),
+			ldd->pending_info.username,
+			ldd->pending_info.password);
+
+	cbd =3D cb_data_ref(cbd);
+	if (g_at_chat_send(ldd->chat, buf, none_prefix,
+			at_lte_set_auth_cb, cbd, cb_data_unref) > 0)
+		return;
+
+out:
+	cb_data_unref(cbd);
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
 static void ublox_lte_set_default_attach_info(const struct ofono_lte *lte,
 			const struct ofono_lte_default_attach_info *info,
 			ofono_lte_cb_t cb, void *data)
@@ -67,17 +128,32 @@ static void ublox_lte_set_default_attach_info(const st=
ruct ofono_lte *lte,
 =

 	DBG("LTE config with APN: %s", info->apn);
 =

-	if (strlen(info->apn) > 0)
-		snprintf(buf, sizeof(buf), "AT+UCGDFLT=3D0,\"IP\",\"%s\"",
+	cbd->user =3D ldd;
+	memcpy(&ldd->pending_info, info, sizeof(ldd->pending_info));
+
+	if (ublox_is_toby_l2(ldd->model)) {
+		if (strlen(info->apn) > 0)
+			snprintf(buf, sizeof(buf), "AT+UCGDFLT=3D0,%s,\"%s\"",
+				at_util_gprs_proto_to_pdp_type(info->proto),
+				info->apn);
+		else
+			snprintf(buf, sizeof(buf), "AT+UCGDFLT=3D0");
+
+	} else if (ublox_is_toby_l4(ldd->model)) {
+		if (strlen(info->apn) > 0)
+			snprintf(buf, sizeof(buf), "AT+CGDCONT=3D1,%s,\"%s\"",
+				at_util_gprs_proto_to_pdp_type(info->proto),
 				info->apn);
-	else
-		snprintf(buf, sizeof(buf), "AT+UCGDFLT=3D0");
+		else
+			snprintf(buf, sizeof(buf), "AT+CGDCONT=3D1");
+	}
 =

-	/* We can't do much in case of failure so don't check response. */
-	if (g_at_chat_send(ldd->chat, buf, ucgdflt_prefix,
-				ucgdflt_cb, cbd, g_free) > 0)
+	if (g_at_chat_send(ldd->chat, buf, none_prefix,
+			at_lte_set_default_attach_info_cb,
+			cbd, cb_data_unref) > 0)
 		return;
 =

+	cb_data_unref(cbd);
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

@@ -91,7 +167,7 @@ static gboolean lte_delayed_register(gpointer user_data)
 }
 =

 static int ublox_lte_probe(struct ofono_lte *lte,
-					unsigned int vendor, void *data)
+					unsigned int model_id, void *data)
 {
 	GAtChat *chat =3D data;
 	struct lte_driver_data *ldd;
@@ -103,6 +179,7 @@ static int ublox_lte_probe(struct ofono_lte *lte,
 		return -ENOMEM;
 =

 	ldd->chat =3D g_at_chat_clone(chat);
+	ldd->model =3D ublox_model_from_id(model_id);
 =

 	ofono_lte_set_data(lte, ldd);
 =

-- =

2.19.1


--===============7189252971193262736==--

