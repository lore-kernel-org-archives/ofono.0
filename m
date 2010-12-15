Content-Type: multipart/mixed; boundary="===============7584387795810613906=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 6/6] atmodem: implement method to query PIN Retry Counter
Date: Tue, 14 Dec 2010 23:36:32 -0200
Message-ID: <1292376992-1888-7-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1292376992-1888-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7584387795810613906==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

PIN retry counter is implemented for huaweimodem and it'd be very
similar for other vendors.
---
 drivers/atmodem/sim.c |   70 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 1653ede..4d0d40c 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -52,6 +52,7 @@ struct sim_data {
 =

 static const char *crsm_prefix[] =3D { "+CRSM:", NULL };
 static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
+static const char *xcpin_prefix[] =3D { "^CPIN:", NULL };
 static const char *clck_prefix[] =3D { "+CLCK:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

@@ -456,6 +457,74 @@ static struct {
 	{ OFONO_SIM_PASSWORD_PHCORP_PUK,	"PH-CORP PUK"	},
 };
 =

+static void at_xcpin_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_retry_counter_cb_t cb =3D cbd->cb;
+	const char *final =3D g_at_result_final_response(result);
+	GAtResultIter iter;
+	int retry;
+	struct ofono_error error;
+
+	decode_at_error(&error, final);
+
+	if (!ok) {
+		cb(&error, -1, cbd->data);
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
+	/*
+	 * Number is optional. In case number is not present, pin is not
+	 * required.
+	 */
+	if (!g_at_result_iter_next_number(&iter, &retry))
+		retry =3D 0;
+
+	cb(&error, retry, cbd->data);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+}
+
+static void at_pin_retry_query(struct ofono_sim *sim,
+				ofono_sim_retry_counter_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	DBG("");
+
+	if (sd->vendor =3D=3D OFONO_VENDOR_QUALCOMM_MSM) {
+		struct cb_data *cbd =3D cb_data_new(cb, data);
+
+		if (cbd =3D=3D NULL) {
+			CALLBACK_WITH_FAILURE(cb, -1, data);
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
+		CALLBACK_WITH_FAILURE(cb, -1, data);
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, 0, data);
+}
+
 static void at_cpin_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -886,6 +955,7 @@ static struct ofono_sim_driver driver =3D {
 	.write_file_cyclic	=3D at_sim_update_cyclic,
 	.read_imsi		=3D at_read_imsi,
 	.query_passwd_state	=3D at_pin_query,
+	.query_retry_counter	=3D at_pin_retry_query,
 	.send_passwd		=3D at_pin_send,
 	.reset_passwd		=3D at_pin_send_puk,
 	.lock			=3D at_pin_enable,
-- =

1.7.3.3


--===============7584387795810613906==--

