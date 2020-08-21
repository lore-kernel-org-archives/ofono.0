Content-Type: multipart/mixed; boundary="===============8119957235483773268=="
MIME-Version: 1.0
From: poeschel@lemonage.de
Subject: [PATCH v2] atmodem: Signal quality on quectel serial modems
Date: Fri, 21 Aug 2020 11:24:02 +0200
Message-ID: <20200821092402.1001245-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8119957235483773268==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lars Poeschel <poeschel@lemonage.de>

As the default way of getting the signal quality with +CIND is also
unstable on quectel serial modems (the same as on quectel EC21). In fact
the signal quality is only updated on cell changes. Those trigger a
manual AT+CSQ in ofono and get an update this way, but the URCs do not
work.
So we implement a quectelish way here as well. The quectelish way is
very similar to the way ifx modems work. We can reuse their csq_notify
function.
---
 drivers/atmodem/network-registration.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index 78b1994c..c1309f61 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -780,15 +780,26 @@ static void ifx_xciev_notify(GAtResult *result, gpoin=
ter user_data)
 	 */
 }
 =

-static void ifx_xcsq_notify(GAtResult *result, gpointer user_data)
+static void ifx_quec_csq_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
+	struct at_netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	int rssi, ber, strength;
 	GAtResultIter iter;
+	const char *prefix;
 =

 	g_at_result_iter_init(&iter, result);
 =

-	if (!g_at_result_iter_next(&iter, "+XCSQ:"))
+	switch (nd->vendor) {
+	case  OFONO_VENDOR_QUECTEL_SERIAL:
+		prefix =3D "+CSQN:";
+		break;
+	default:
+		prefix =3D "+XCSQ:";
+		break;
+	}
+
+	if (!g_at_result_iter_next(&iter, prefix))
 		return;
 =

 	if (!g_at_result_iter_next_number(&iter, &rssi))
@@ -2027,7 +2038,7 @@ static void at_creg_set_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 		/* Register for specific signal strength reports */
 		g_at_chat_register(nd->chat, "+XCIEV:", ifx_xciev_notify,
 						FALSE, netreg, NULL);
-		g_at_chat_register(nd->chat, "+XCSQ:", ifx_xcsq_notify,
+		g_at_chat_register(nd->chat, "+XCSQ:", ifx_quec_csq_notify,
 						FALSE, netreg, NULL);
 		g_at_chat_send(nd->chat, "AT+XCSQ=3D1", none_prefix,
 						NULL, NULL, NULL);
@@ -2118,6 +2129,13 @@ static void at_creg_set_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 		g_at_chat_send(nd->chat, "AT+QINDCFG=3D\"act\",1", none_prefix,
 				NULL, NULL, NULL);
 		break;
+	case OFONO_VENDOR_QUECTEL_SERIAL:
+		g_at_chat_register(nd->chat, "+CSQN:",
+				ifx_quec_csq_notify, FALSE, netreg, NULL);
+		/* Register for specific signal strength reports */
+		g_at_chat_send(nd->chat, "AT+QEXTUNSOL=3D\"SQ\",1", none_prefix,
+				NULL, NULL, NULL);
+		break;
 	default:
 		g_at_chat_send(nd->chat, "AT+CIND=3D?", cind_prefix,
 				cind_support_cb, netreg, NULL);
-- =

2.27.0

--===============8119957235483773268==--

