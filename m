Content-Type: multipart/mixed; boundary="===============4351115719339759039=="
MIME-Version: 1.0
From: poeschel@lemonage.de
Subject: [PATCH v2 2/3] atmodem: Get strength and tech the quectel way on EC21
Date: Tue, 11 Aug 2020 13:42:16 +0200
Message-ID: <20200811114217.370049-2-poeschel@lemonage.de>
In-Reply-To: <20200811114217.370049-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4351115719339759039==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lars Poeschel <poeschel@lemonage.de>

I had some trouble getting network strengh and access technology the
standard way on Quectel EC21. It does work - but only kind of. I did not
get URCs when I am sure I should. This way through CIEV, CIND and CMER
is also not documented in Quectel documentation, so I suspect this to be
unsupported.
This is now changed to the "quectelish" way of gettings those values and
this does work more fine-grained and reliable on the Quectel EC21.
---
 drivers/atmodem/network-registration.c | 71 ++++++++++++++++++++++++++
 plugins/quectel.c                      |  2 +-
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index cc702c2c..78b1994c 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -957,6 +957,66 @@ static void tlts_notify(GAtResult *result, gpointer us=
er_data)
 	ofono_netreg_time_notify(netreg, &nd->time);
 }
 =

+static void quectel_qind_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	int rssi, ber, strength;
+	const char *str;
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+QIND:"))
+		return;
+
+	if (!g_at_result_iter_next_string(&iter, &str))
+		return;
+
+	if (g_str_equal("csq", str)) {
+		if (!g_at_result_iter_next_number(&iter, &rssi))
+			return;
+
+		if (!g_at_result_iter_next_number(&iter, &ber))
+			return;
+
+		DBG("rssi %d ber %d", rssi, ber);
+
+		if ((rssi =3D=3D 99) || (rssi =3D=3D 199))
+			strength =3D -1;
+		else if (rssi > 99) {
+			rssi -=3D 100;
+			strength =3D (rssi * 100) / 91;
+		} else
+			strength =3D (rssi * 100) / 31;
+
+		ofono_netreg_strength_notify(netreg, strength);
+		return;
+	}
+
+	if (g_str_equal("act", str)) {
+		nd->tech =3D -1;
+		if (!g_at_result_iter_next_string(&iter, &str))
+			return;
+
+		DBG("technology %s", str);
+		if (g_str_equal("GSM", str))
+			nd->tech =3D ACCESS_TECHNOLOGY_GSM;
+		else if (g_str_equal("EGPRS", str))
+			nd->tech =3D ACCESS_TECHNOLOGY_GSM_EGPRS;
+		else if (g_str_equal("WCDMA", str))
+			nd->tech =3D ACCESS_TECHNOLOGY_UTRAN;
+		else if (g_str_equal("HSDPA", str))
+			nd->tech =3D ACCESS_TECHNOLOGY_UTRAN_HSDPA;
+		else if (g_str_equal("HSUPA", str))
+			nd->tech =3D ACCESS_TECHNOLOGY_UTRAN_HSUPA;
+		else if (g_str_equal("HSDPA&HSUPA", str))
+			nd->tech =3D ACCESS_TECHNOLOGY_UTRAN_HSDPA_HSUPA;
+		else if (g_str_equal("LTE", str))
+			nd->tech =3D ACCESS_TECHNOLOGY_EUTRAN;
+	}
+}
+
 static gboolean notify_time(gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
@@ -2047,6 +2107,17 @@ static void at_creg_set_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 	case OFONO_VENDOR_SAMSUNG:
 		/* Signal strength reporting via CIND is not supported */
 		break;
+	case OFONO_VENDOR_QUECTEL_EC2X:
+		g_at_chat_register(nd->chat, "+QIND:",
+				quectel_qind_notify, FALSE, netreg, NULL);
+		/* Register for specific signal strength reports */
+		g_at_chat_send(nd->chat, "AT+QINDCFG=3D\"csq\",1", none_prefix,
+				NULL, NULL, NULL);
+
+		/* Register for network technology updates */
+		g_at_chat_send(nd->chat, "AT+QINDCFG=3D\"act\",1", none_prefix,
+				NULL, NULL, NULL);
+		break;
 	default:
 		g_at_chat_send(nd->chat, "AT+CIND=3D?", cind_prefix,
 				cind_support_cb, netreg, NULL);
diff --git a/plugins/quectel.c b/plugins/quectel.c
index 8ca901f2..c3343008 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -1286,7 +1286,7 @@ static void quectel_post_online(struct ofono_modem *m=
odem)
 =

 	DBG("%p", modem);
 =

-	ofono_netreg_create(modem, 0, "atmodem", data->aux);
+	ofono_netreg_create(modem, data->vendor, "atmodem", data->aux);
 }
 =

 static struct ofono_modem_driver quectel_driver =3D {
-- =

2.27.0

--===============4351115719339759039==--

