Content-Type: multipart/mixed; boundary="===============1155853219427146132=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 15/19] plugins/ublox: enable ubloxmodem driver when possible
Date: Wed, 09 Mar 2016 16:44:56 +0100
Message-ID: <1457538300-7183-16-git-send-email-dragos@endocode.com>
In-Reply-To: <1457538300-7183-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1155853219427146132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Where possible means Toby L2 in high speed mode.

The bridge mode is set before enabling the modem because the
driver requires this.
---
 plugins/ublox.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index bdc0fa1..032a3c4 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -142,6 +142,11 @@ static void cfun_enable(gboolean ok, GAtResult *result=
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

@@ -295,8 +300,15 @@ static void ublox_post_sim(struct ofono_modem *modem)
 =

 	gprs =3D ofono_gprs_create(modem, data->vendor_family, "atmodem",
 					data->aux);
-	gc =3D ofono_gprs_context_create(modem, data->vendor_family, "atmodem",
-					data->modem ? data->modem : data->aux);
+	if (data->model_id =3D=3D TOBYL2_HIGH_THROUGHPUT_MODE)
+		gc =3D ofono_gprs_context_create(modem, data->vendor_family,
+						"ubloxmodem",
+						data->modem ? data->modem : data->aux);
+
+	else
+		gc =3D ofono_gprs_context_create(modem, data->vendor_family,
+						"atmodem",
+						data->modem ? data->modem : data->aux);
 =

 	if (gprs && gc)
 		ofono_gprs_add_context(gprs, gc);
-- =

2.5.0


--===============1155853219427146132==--

