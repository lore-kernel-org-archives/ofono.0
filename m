Content-Type: multipart/mixed; boundary="===============1087197520435209658=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 3/7] plugins/ublox: enable ubloxmodem driver when possible
Date: Thu, 17 Mar 2016 13:38:29 +0100
Message-ID: <1458218313-26966-4-git-send-email-dragos@endocode.com>
In-Reply-To: <1458218313-26966-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1087197520435209658==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Where possible means Toby L2 in high speed mode.

The bridge mode is set before enabling the modem because the
driver requires this.
---
 plugins/ublox.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index 938777c..544d429 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -141,6 +141,11 @@ static void cfun_enable(gboolean ok, GAtResult *result=
, gpointer user_data)
 		return;
 	}
 =

+	if (data->model_id =3D=3D TOBYL2_HIGH_THROUGHPUT_MODE)
+		/* use bridged mode until routed mode support is added */
+		g_at_chat_send(data->aux, "AT+UBMCONF=3D2", none_prefix,
+						NULL, NULL, NULL);
+
 	ofono_modem_set_powered(modem, TRUE);
 }
 =

@@ -288,13 +293,19 @@ static void ublox_post_sim(struct ofono_modem *modem)
 	struct ublox_data *data =3D ofono_modem_get_data(modem);
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
+	GAtChat *chat =3D data->modem ? data->modem : data->aux;
 =

 	DBG("%p", modem);
 =

 	gprs =3D ofono_gprs_create(modem, data->vendor_family, "atmodem",
 					data->aux);
-	gc =3D ofono_gprs_context_create(modem, data->vendor_family, "atmodem",
-					data->modem ? data->modem : data->aux);
+	if (data->model_id =3D=3D TOBYL2_HIGH_THROUGHPUT_MODE)
+		gc =3D ofono_gprs_context_create(modem, data->vendor_family,
+						"ubloxmodem", chat);
+
+	else
+		gc =3D ofono_gprs_context_create(modem, data->vendor_family,
+						"atmodem", chat);
 =

 	if (gprs && gc)
 		ofono_gprs_add_context(gprs, gc);
-- =

2.5.0


--===============1087197520435209658==--

