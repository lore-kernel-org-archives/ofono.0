Content-Type: multipart/mixed; boundary="===============1145346413166574892=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: [PATCH 5/6] gprs: add support for u-blox +UREG URCs
Date: Thu, 26 Jun 2014 20:28:17 +0200
Message-ID: <1403807298-14588-6-git-send-email-philip@paeps.cx>
In-Reply-To: <1403807298-14588-1-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1145346413166574892==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/gprs.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 3005867..5551316 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -282,6 +282,44 @@ static void telit_mode_notify(GAtResult *result, gpoin=
ter user_data)
 	ofono_gprs_bearer_notify(gprs, bearer);
 }
 =

+static void ublox_ureg_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	GAtResultIter iter;
+	gint state, bearer;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+UREG:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &state))
+		return;
+
+	switch (state) {
+	case 4:
+		bearer =3D 5;
+		break;
+	case 5:
+		bearer =3D 4;
+		break;
+	case 7:
+		/* XXX: reserved - assume none. */
+		bearer =3D 0;
+		break;
+	case 8:
+		bearer =3D 1;
+		break;
+	case 9:
+		bearer =3D 2;
+		break;
+	default:
+		bearer =3D state;
+	}
+
+	ofono_gprs_bearer_notify(gprs, bearer);
+}
+
 static void cpsb_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_gprs *gprs =3D user_data;
@@ -316,6 +354,12 @@ static void gprs_initialized(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 		g_at_chat_register(gd->chat, "^MODE:", huawei_mode_notify,
 						FALSE, gprs, NULL);
 		break;
+	case OFONO_VENDOR_UBLOX:
+		g_at_chat_register(gd->chat, "+UREG:", ublox_ureg_notify,
+						FALSE, gprs, NULL);
+		g_at_chat_send(gd->chat, "AT+UREG=3D1", none_prefix,
+						NULL, NULL, NULL);
+		break;
 	case OFONO_VENDOR_TELIT:
 		g_at_chat_register(gd->chat, "#PSNT:", telit_mode_notify,
 						FALSE, gprs, NULL);
-- =

1.7.10.4


--===============1145346413166574892==--

