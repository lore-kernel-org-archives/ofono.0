Content-Type: multipart/mixed; boundary="===============8892285153313184188=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 09/19] atmodem: work around CGREG issues in UBlox Toby L2
Date: Wed, 09 Mar 2016 16:44:50 +0100
Message-ID: <1457538300-7183-10-git-send-email-dragos@endocode.com>
In-Reply-To: <1457538300-7183-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8892285153313184188==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Don't use CGREG for network notifications. It will return
4 both when registered in LTE and in unknown state.

For the CGREG? query, interpret 4 as registered.
---
 drivers/atmodem/gprs.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 4505477..0b4bce8 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -101,6 +101,17 @@ static void at_cgreg_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 		return;
 	}
 =

+	if (gd->vendor =3D=3D OFONO_VENDOR_UBLOX_TOBY_L2 && status =3D=3D 4) {
+		/*
+		 * UBX-13002752-R33 says:
+		 * If the module is registered to E-UTRAN the <stat> parameter is 4.
+		 * So this means we are actually registered.
+		 * It could also mean that state is unknown, but if we are
+		 * here we know we already registered.
+		 */
+		 status =3D 1;
+	}
+
 	cb(&error, status, cbd->data);
 }
 =

@@ -342,16 +353,23 @@ static void gprs_initialized(gboolean ok, GAtResult *=
result, gpointer user_data)
 	struct gprs_data *gd =3D ofono_gprs_get_data(gprs);
 =

 	g_at_chat_register(gd->chat, "+CGEV:", cgev_notify, FALSE, gprs, NULL);
-	g_at_chat_register(gd->chat, "+CGREG:", cgreg_notify,
-						FALSE, gprs, NULL);
+
+	/*
+	 * You really don't want to get CGREG notifications on Toby l2.
+	 * It sends 4 when BOTH for unknown state and for registered in LTE.
+	 * +UREG usage is recommended by them.
+	 */
+	if (gd->vendor !=3D OFONO_VENDOR_UBLOX_TOBY_L2)
+		g_at_chat_register(gd->chat, "+CGREG:", cgreg_notify,
+							FALSE, gprs, NULL);
 =

 	switch (gd->vendor) {
 	case OFONO_VENDOR_HUAWEI:
 		g_at_chat_register(gd->chat, "^MODE:", huawei_mode_notify,
 						FALSE, gprs, NULL);
 		break;
-	case OFONO_VENDOR_UBLOX:
 	case OFONO_VENDOR_UBLOX_TOBY_L2:
+	case OFONO_VENDOR_UBLOX:
 		g_at_chat_register(gd->chat, "+UREG:", ublox_ureg_notify,
 						FALSE, gprs, NULL);
 		g_at_chat_send(gd->chat, "AT+UREG=3D1", none_prefix,
-- =

2.5.0


--===============8892285153313184188==--

