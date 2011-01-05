Content-Type: multipart/mixed; boundary="===============1167119828355039088=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v3 4/4] atmodem: implement query for remaining pin retries
Date: Wed, 05 Jan 2011 15:20:40 -0200
Message-ID: <1294248040-14342-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1294248040-14342-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1167119828355039088==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implement query method for the remaining pin retries on huawei modem.
---
 drivers/atmodem/sim.c |   90 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 90 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 1653ede..98fb195 100644
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
@@ -52,6 +54,7 @@ struct sim_data {
 =

 static const char *crsm_prefix[] =3D { "+CRSM:", NULL };
 static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
+static const char *xcpin_prefix[] =3D { "^CPIN:", NULL };
 static const char *clck_prefix[] =3D { "+CLCK:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

@@ -456,6 +459,92 @@ static struct {
 	{ OFONO_SIM_PASSWORD_PHCORP_PUK,	"PH-CORP PUK"	},
 };
 =

+static void at_xcpin_cb(gboolean ok, GAtResult *result, gpointer user_data)
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
+	memset(retries, -1, sizeof(retries));
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
+
+	DBG("");
+
+	if (sd->vendor =3D=3D OFONO_VENDOR_QUALCOMM_MSM) {
+		struct cb_data *cbd =3D cb_data_new(cb, data);
+
+		if (cbd =3D=3D NULL) {
+			CALLBACK_WITH_FAILURE(cb, NULL, data);
+
+			return;
+		}
+
+		if (g_at_chat_send(sd->chat, "AT^CPIN?", xcpin_prefix,
+					at_xcpin_cb, cbd, g_free) > 0)
+			return;
+
+		g_free(cbd);
+
+		CALLBACK_WITH_FAILURE(cb, NULL, data);
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, NULL, data);
+}
+
 static void at_cpin_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -886,6 +975,7 @@ static struct ofono_sim_driver driver =3D {
 	.write_file_cyclic	=3D at_sim_update_cyclic,
 	.read_imsi		=3D at_read_imsi,
 	.query_passwd_state	=3D at_pin_query,
+	.query_pin_retries	=3D at_pin_retries_query,
 	.send_passwd		=3D at_pin_send,
 	.reset_passwd		=3D at_pin_send_puk,
 	.lock			=3D at_pin_enable,
-- =

1.7.3.4


--===============1167119828355039088==--

