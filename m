Content-Type: multipart/mixed; boundary="===============3782311202048886159=="
MIME-Version: 1.0
From: Bernhard.Guillon@hale.at
Subject: [PATCH v2 2/3] network-registration.c: implement CIND forTelit UC864-G
Date: Wed, 25 May 2011 15:14:24 +0200
Message-ID: <1306329265-12066-2-git-send-email-Bernhard.Guillon@hale.at>
In-Reply-To: <1306329265-12066-1-git-send-email-Bernhard.Guillon@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3782311202048886159==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Bernhard Guillon <Bernhard.Guillon@hale.at>

*UC864 has an incompatible CIND
*add a Telit specific check for "not measurable" strength

Co-authored-by: Christopher Vogl <Christopher.Vogl@hale.at>
---
 drivers/atmodem/network-registration.c |   40 ++++++++++++++++++++++++++++=
+--
 1 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index b3aa511..984e85e 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -666,7 +666,20 @@ static void ciev_notify(GAtResult *result, gpointer us=
er_data)
 	if (!g_at_result_iter_next_number(&iter, &strength))
 		return;
 =

-	strength =3D (strength * 100) / (nd->signal_max - nd->signal_min);
+	switch (nd->vendor) {
+	case OFONO_VENDOR_TELIT:
+		/* Check for "signal not measurable" */
+		if (strength =3D=3D 99)
+			strength =3D 0;
+		else
+			strength =3D (strength * 100) / (nd->signal_max -
+						nd->signal_min);
+		break;
+	default:
+		strength =3D (strength * 100) / (nd->signal_max - nd->signal_min);
+		break;
+	}
+
 	ofono_netreg_strength_notify(netreg, strength);
 }
 =

@@ -798,8 +811,19 @@ static void cind_cb(gboolean ok, GAtResult *result, gp=
ointer user_data)
 =

 	g_at_result_iter_next_number(&iter, &strength);
 =

-	strength =3D (strength * 100) / (nd->signal_max - nd->signal_min);
-
+	switch (nd->vendor) {
+	case OFONO_VENDOR_TELIT:
+		/* Check for "signal not measurable" */
+		if (strength =3D=3D 99)
+			strength =3D 0;
+		else
+			strength =3D (strength * 100) / (nd->signal_max -
+						nd->signal_min);
+		break;
+	default:
+		strength =3D (strength * 100) / (nd->signal_max - nd->signal_min);
+		break;
+	}
 	cb(&error, strength, cbd->data);
 }
 =

@@ -1302,6 +1326,16 @@ static void at_creg_set_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 	case OFONO_VENDOR_NOKIA:
 		/* Signal strength reporting via CIND is not supported */
 		break;
+	case OFONO_VENDOR_TELIT:
+		/* Use RSSI instead of signal.*/
+		nd->signal_index =3D 9;
+		nd->signal_min =3D 0;
+		nd->signal_max =3D 5;
+		g_at_chat_send(nd->chat, "AT+CIND=3D1", cind_prefix,
+						NULL, NULL, NULL);
+		g_at_chat_register(nd->chat, "+CIEV:", ciev_notify,
+					FALSE, netreg, NULL);
+		break;
 	default:
 		g_at_chat_send(nd->chat, "AT+CIND=3D?", cind_prefix,
 				cind_support_cb, netreg, NULL);
-- =

1.7.0.4



--
Scanned by MailScanner.


--===============3782311202048886159==--

