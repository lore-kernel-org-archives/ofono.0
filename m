Content-Type: multipart/mixed; boundary="===============9021034400188081457=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: [PATCH] atmodem: telit - re-attach gprs automatically
Date: Mon, 27 Mar 2017 18:18:11 +0100
Message-ID: <1490635091-28928-1-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9021034400188081457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lukasz Nowak <lnowak@tycoint.com>

Telit AT modem firmware (tested with UE910-EUR) generates
+CGREG: 0\r\n\r\n+CGEV: NW DETACH
after a context is de-activated and ppp connection closed.
Then, after a random amount of time (observed from a few seconds
to a few hours), an unsolicited +CGREG: 1 arrives.
Attempt to fix the problem, by sending AT+CGATT=3D1 once.
This does not re-activate the context, but if a network connection
is still correct, will generate an immediate +CGREG: 1.
---
 drivers/atmodem/gprs.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 7ea9f00..ba8646c 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -50,6 +50,7 @@ struct gprs_data {
 	GAtChat *chat;
 	unsigned int vendor;
 	unsigned int last_auto_context_id;
+	gboolean network_detach_retry;
 };
 =

 static void at_cgatt_cb(gboolean ok, GAtResult *result, gpointer user_data)
@@ -194,6 +195,28 @@ static void cgreg_notify(GAtResult *result, gpointer u=
ser_data)
 				NULL, NULL, NULL, gd->vendor) =3D=3D FALSE)
 		return;
 =

+	DBG("status=3D%d vendor=3D%d retry=3D%d", status, gd->vendor, gd->network=
_detach_retry);
+
+	/*
+	 * Telit AT modem firmware (tested with UE910-EUR) generates
+	 * +CGREG: 0\r\n\r\n+CGEV: NW DETACH
+	 * after a context is de-activated and ppp connection closed.
+	 * Then, after a random amount of time (observed from a few seconds
+	 * to a few hours), an unsolicited +CGREG: 1 arrives.
+	 * Attempt to fix the problem, by sending AT+CGATT=3D1 once.
+	 * This does not re-activate the context, but if a network connection
+	 * is still correct, will generate an immediate +CGREG: 1.
+	 */
+	if (gd->vendor =3D=3D OFONO_VENDOR_TELIT &&
+		!status && !gd->network_detach_retry) {
+		DBG("Trying to re-attach gprs network");
+		gd->network_detach_retry =3D TRUE;
+		g_at_chat_send(gd->chat, "AT+CGATT=3D1", none_prefix,
+				NULL, NULL, NULL);
+		return;
+	}
+	gd->network_detach_retry =3D FALSE;
+
 	ofono_gprs_status_notify(gprs, status);
 }
 =

@@ -214,6 +237,10 @@ static void cgev_notify(GAtResult *result, gpointer us=
er_data)
 =

 	if (g_str_equal(event, "NW DETACH") ||
 			g_str_equal(event, "ME DETACH")) {
+
+		if (gd->vendor =3D=3D OFONO_VENDOR_TELIT &&
+				gd->network_detach_retry)
+			return;
 		ofono_gprs_detached_notify(gprs);
 		return;
 	} else if (g_str_has_prefix(event, "ME PDN ACT")) {
-- =

2.7.4


--===============9021034400188081457==--

