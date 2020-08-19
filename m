Content-Type: multipart/mixed; boundary="===============7257978413917943026=="
MIME-Version: 1.0
From: poeschel@lemonage.de
Subject: [RFC PATCH] atmodem: Signal quality on quectel serial modems
Date: Wed, 19 Aug 2020 14:43:56 +0200
Message-ID: <20200819124356.881471-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7257978413917943026==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lars Poeschel <poeschel@lemonage.de>

As the default way of getting the signal quality with +CIND is also
unstable on quectel serial modems (the same as on quectel EC21). In fact
the signal quality is only updated on cell changes. Those trigger a
manual AT+CSQ in ofono and get an update this way, but the URCs do not
work.
So we implement a quectelish way here as well.

--- >8 ---

I send this patch as a RFC because the quectel_csqn_notify function
very much duplicates the ifx_xcsq_notify function despite the "+CSQN"
string. I did not see a good way to reuse the already existing
function because the callback interface only has one user defined
pointer and this is used by the struct ofono_netreg pointer already.
Does anyone have a better idea ?

Thanks,
Lars
---
 drivers/atmodem/network-registration.c | 34 ++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index 78b1994c..74829201 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -1017,6 +1017,33 @@ static void quectel_qind_notify(GAtResult *result, g=
pointer user_data)
 	}
 }
 =

+static void quectel_csqn_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	int rssi, ber, strength;
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CSQN:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &rssi))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &ber))
+		return;
+
+	DBG("rssi %d ber %d", rssi, ber);
+
+	if (rssi =3D=3D 99)
+		strength =3D -1;
+	else
+		strength =3D (rssi * 100) / 31;
+
+	ofono_netreg_strength_notify(netreg, strength);
+}
+
 static gboolean notify_time(gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
@@ -2118,6 +2145,13 @@ static void at_creg_set_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 		g_at_chat_send(nd->chat, "AT+QINDCFG=3D\"act\",1", none_prefix,
 				NULL, NULL, NULL);
 		break;
+	case OFONO_VENDOR_QUECTEL_SERIAL:
+		g_at_chat_register(nd->chat, "+CSQN:",
+				quectel_csqn_notify, FALSE, netreg, NULL);
+		/* Register for specific signal strength reports */
+		g_at_chat_send(nd->chat, "AT+QEXTUNSOL=3D\"SQ\",1", none_prefix,
+				NULL, NULL, NULL);
+		break;
 	default:
 		g_at_chat_send(nd->chat, "AT+CIND=3D?", cind_prefix,
 				cind_support_cb, netreg, NULL);
-- =

2.27.0

--===============7257978413917943026==--

