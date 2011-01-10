Content-Type: multipart/mixed; boundary="===============1357760832977196279=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 1/2] atmodem: implement query for remaining pin retries
Date: Mon, 10 Jan 2011 19:59:53 -0200
Message-ID: <1294696794-28903-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1357760832977196279==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implement query method for the remaining pin retries on huawei modem.
---
 drivers/atmodem/sim.c |   96 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 96 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 33f756d..5fd15d2 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -44,6 +44,8 @@
 #define EF_STATUS_INVALIDATED 0
 #define EF_STATUS_VALID 1
 =

+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
 struct sim_data {
 	GAtChat *chat;
 	unsigned int vendor;
@@ -53,6 +55,7 @@ struct sim_data {
 static const char *crsm_prefix[] =3D { "+CRSM:", NULL };
 static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
 static const char *clck_prefix[] =3D { "+CLCK:", NULL };
+static const char *huawei_cpin_prefix[] =3D { "^CPIN:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

 static void at_crsm_info_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
@@ -458,6 +461,98 @@ static struct {
 	{ OFONO_SIM_PASSWORD_PHCORP_PUK,	"PH-CORP PUK"	},
 };
 =

+static void huawei_cpin_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_pin_retries_cb_t cb =3D cbd->cb;
+	const char *final =3D g_at_result_final_response(result);
+	GAtResultIter iter;
+	struct ofono_error error;
+	int retries[OFONO_SIM_PASSWORD_INVALID];
+	size_t i;
+	static enum ofono_sim_password_type _password_types[] =3D {
+		OFONO_SIM_PASSWORD_SIM_PUK,
+		OFONO_SIM_PASSWORD_SIM_PIN,
+		OFONO_SIM_PASSWORD_SIM_PUK2,
+		OFONO_SIM_PASSWORD_SIM_PIN2,
+	};
+
+	decode_at_error(&error, final);
+
+	if (!ok) {
+		cb(&error, NULL, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "^CPIN:"))
+		goto error;
+
+	/* Skip status since we are not interested in this */
+	if (!g_at_result_iter_skip_next(&iter))
+		goto error;
+
+	/* Skip "overall counter" since we'll grab each one individually */
+	if (!g_at_result_iter_skip_next(&iter))
+		goto error;
+
+	for (i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++)
+		retries[i] =3D -1;
+
+	for (i =3D 0; i < ARRAY_SIZE(_password_types); i++) {
+		int val;
+
+		if (!g_at_result_iter_next_number(&iter, &val))
+			goto error;
+
+		retries[_password_types[i]]=3D val;
+
+		DBG("retry counter id=3D%d, val=3D%d", _password_types[i],
+						retries[_password_types[i]]);
+	}
+
+	cb(&error, retries, cbd->data);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+}
+
+static void at_pin_retries_query(struct ofono_sim *sim,
+				ofono_sim_pin_retries_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	int retries[OFONO_SIM_PASSWORD_INVALID];
+	int i;
+
+	DBG("");
+
+	if (sd->vendor =3D=3D OFONO_VENDOR_HUAWEI) {
+		struct cb_data *cbd =3D cb_data_new(cb, data);
+
+		if (cbd =3D=3D NULL) {
+			CALLBACK_WITH_FAILURE(cb, NULL, data);
+
+			return;
+		}
+
+		if (g_at_chat_send(sd->chat, "AT^CPIN?", huawei_cpin_prefix,
+					huawei_cpin_cb, cbd, g_free) > 0)
+			return;
+
+		g_free(cbd);
+
+		CALLBACK_WITH_FAILURE(cb, NULL, data);
+	}
+
+	for(i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++)
+		retries[i] =3D -1;
+
+	CALLBACK_WITH_SUCCESS(cb, retries, data);
+}
+
 static void at_cpin_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -888,6 +983,7 @@ static struct ofono_sim_driver driver =3D {
 	.write_file_cyclic	=3D at_sim_update_cyclic,
 	.read_imsi		=3D at_read_imsi,
 	.query_passwd_state	=3D at_pin_query,
+	.query_pin_retries	=3D at_pin_retries_query,
 	.send_passwd		=3D at_pin_send,
 	.reset_passwd		=3D at_pin_send_puk,
 	.lock			=3D at_pin_enable,
-- =

1.7.3.5


--===============1357760832977196279==--

