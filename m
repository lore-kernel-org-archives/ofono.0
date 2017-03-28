Content-Type: multipart/mixed; boundary="===============7004476472268085997=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: [PATCH v2] atmodem: telit - re-attach gprs automatically
Date: Tue, 28 Mar 2017 12:42:41 +0100
Message-ID: <1490701361-14182-1-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7004476472268085997==
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
 drivers/atmodem/gprs.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 7ea9f00..3a6364e 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -50,6 +50,8 @@ struct gprs_data {
 	GAtChat *chat;
 	unsigned int vendor;
 	unsigned int last_auto_context_id;
+	gboolean telit_try_reattach;
+	int attached;
 };
 =

 static void at_cgatt_cb(gboolean ok, GAtResult *result, gpointer user_data)
@@ -73,8 +75,10 @@ static void at_gprs_set_attached(struct ofono_gprs *gprs=
, int attached,
 	snprintf(buf, sizeof(buf), "AT+CGATT=3D%i", attached ? 1 : 0);
 =

 	if (g_at_chat_send(gd->chat, buf, none_prefix,
-				at_cgatt_cb, cbd, g_free) > 0)
+				at_cgatt_cb, cbd, g_free) > 0) {
+		gd->attached =3D attached;
 		return;
+	}
 =

 	g_free(cbd);
 =

@@ -194,6 +198,28 @@ static void cgreg_notify(GAtResult *result, gpointer u=
ser_data)
 				NULL, NULL, NULL, gd->vendor) =3D=3D FALSE)
 		return;
 =

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
+	if (gd->vendor =3D=3D OFONO_VENDOR_TELIT) {
+		if (gd->attached && !status && !gd->telit_try_reattach) {
+			DBG("Trying to re-attach gprs network");
+			gd->telit_try_reattach =3D TRUE;
+			g_at_chat_send(gd->chat, "AT+CGATT=3D1", none_prefix,
+					NULL, NULL, NULL);
+			return;
+		}
+
+		gd->telit_try_reattach =3D FALSE;
+	}
+
 	ofono_gprs_status_notify(gprs, status);
 }
 =

@@ -214,6 +240,10 @@ static void cgev_notify(GAtResult *result, gpointer us=
er_data)
 =

 	if (g_str_equal(event, "NW DETACH") ||
 			g_str_equal(event, "ME DETACH")) {
+		if (gd->vendor =3D=3D OFONO_VENDOR_TELIT &&
+				gd->telit_try_reattach)
+			return;
+
 		ofono_gprs_detached_notify(gprs);
 		return;
 	} else if (g_str_has_prefix(event, "ME PDN ACT")) {
-- =

2.7.4


--===============7004476472268085997==--

