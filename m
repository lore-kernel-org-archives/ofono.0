Content-Type: multipart/mixed; boundary="===============3817658121893453749=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 6/7] atmodem: dummy set_attach_policy
Date: Mon, 07 Feb 2011 16:03:11 +0200
Message-ID: <1297087392-31030-6-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <201102071602.20179.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3817658121893453749==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/gprs.c |   30 ++++++++----------------------
 1 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 6e01994..3fcf17d 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -51,31 +51,17 @@ struct gprs_data {
 	unsigned int vendor;
 };
 =

-static void at_cgatt_cb(gboolean ok, GAtResult *result, gpointer user_data)
-{
-	struct cb_data *cbd =3D user_data;
-	ofono_gprs_cb_t cb =3D cbd->cb;
-	struct ofono_error error;
-
-	decode_at_error(&error, g_at_result_final_response(result));
-
-	cb(&error, cbd->data);
-}
-
-static void at_gprs_set_attached(struct ofono_gprs *gprs, int attached,
+static void at_gprs_set_attach_policy(struct ofono_gprs *gprs,
+					ofono_bool_t always_on,
 					ofono_gprs_cb_t cb, void *data)
 {
-	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
-	struct cb_data *cbd =3D cb_data_new(cb, data);
-	char buf[64];
-
-	snprintf(buf, sizeof(buf), "AT+CGATT=3D%i", attached ? 1 : 0);
+	/* TODO: vendor specific stuff */
 =

-	if (g_at_chat_send(gd->chat, buf, none_prefix,
-				at_cgatt_cb, cbd, g_free) > 0)
+	/* Pure standard modems only support demand-attach policy */
+	if (!always_on) {
+		CALLBACK_WITH_SUCCESS(cb, data);
 		return;
-
-	g_free(cbd);
+	}
 =

 	CALLBACK_WITH_FAILURE(cb, data);
 }
@@ -401,7 +387,7 @@ static struct ofono_gprs_driver driver =3D {
 	.name			=3D "atmodem",
 	.probe			=3D at_gprs_probe,
 	.remove			=3D at_gprs_remove,
-	.set_attached		=3D at_gprs_set_attached,
+	.set_attach_policy	=3D at_gprs_set_attach_policy,
 	.attached_status	=3D at_gprs_registration_status,
 };
 =

-- =

1.7.1


--===============3817658121893453749==--

