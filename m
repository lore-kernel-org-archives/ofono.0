Content-Type: multipart/mixed; boundary="===============6185888273579272173=="
MIME-Version: 1.0
From: Bernhard.Guillon@hale.at
Subject: [RFC PATCH 2/2] network-registration.c: implement CIND for Telit
 UC864-G
Date: Thu, 19 May 2011 12:40:24 +0200
Message-ID: <1305801624-3410-2-git-send-email-Bernhard.Guillon@hale.at>
In-Reply-To: <1305801624-3410-1-git-send-email-Bernhard.Guillon@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6185888273579272173==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Bernhard Guillon <Bernhard.Guillon@hale.at>

*UC864 has a incompatible CIND
*use specific constants for a KISS callback function
*add a Telit specific check for "not measurable" strength

Co-authored-by: Christopher Vogl <Christopher.Vogl@hale.at>
Signed-off-by: Bernhard Guillon <Bernhard.Guillon@hale.at>
---
 drivers/atmodem/network-registration.c |   38 ++++++++++++++++++++++++++++=
+--
 1 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index b3aa511..616faa2 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -48,6 +48,10 @@ static const char *cops_prefix[] =3D { "+COPS:", NULL };
 static const char *csq_prefix[] =3D { "+CSQ:", NULL };
 static const char *cind_prefix[] =3D { "+CIND:", NULL };
 static const char *option_tech_prefix[] =3D { "_OCTI:", "_OUWCTI:", NULL };
+static const int telit_signal_not_measurable =3D 99;
+static const int telit_signal_index =3D 9;
+static const int telit_signal_min =3D 0;
+static const int telit_signal_max =3D 5;
 =

 struct netreg_data {
 	GAtChat *chat;
@@ -666,7 +670,16 @@ static void ciev_notify(GAtResult *result, gpointer us=
er_data)
 	if (!g_at_result_iter_next_number(&iter, &strength))
 		return;
 =

-	strength =3D (strength * 100) / (nd->signal_max - nd->signal_min);
+	switch (nd->vendor) {
+		case OFONO_VENDOR_TELIT:
+			if (strength =3D=3D telit_signal_not_measurable)
+				strength =3D 0;
+			else
+				strength =3D (strength * 100) / (nd->signal_max - nd->signal_min);
+			break;
+		default:
+			strength =3D (strength * 100) / (nd->signal_max - nd->signal_min);
+	}
 	ofono_netreg_strength_notify(netreg, strength);
 }
 =

@@ -798,8 +811,16 @@ static void cind_cb(gboolean ok, GAtResult *result, gp=
ointer user_data)
 =

 	g_at_result_iter_next_number(&iter, &strength);
 =

-	strength =3D (strength * 100) / (nd->signal_max - nd->signal_min);
-
+	switch (nd->vendor) {
+		case OFONO_VENDOR_TELIT:
+			if (strength =3D=3D telit_signal_not_measurable)
+				strength =3D 0;
+			else
+				strength =3D (strength * 100) / (nd->signal_max - nd->signal_min);
+			break;
+		default:
+			strength =3D (strength * 100) / (nd->signal_max - nd->signal_min);
+	}
 	cb(&error, strength, cbd->data);
 }
 =

@@ -1302,6 +1323,17 @@ static void at_creg_set_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 	case OFONO_VENDOR_NOKIA:
 		/* Signal strength reporting via CIND is not supported */
 		break;
+	case OFONO_VENDOR_TELIT:
+		// FIXME: We use RSSI instead of signal.
+		// FIXME: Consider reading signal index from modem.
+		nd->signal_index =3D telit_signal_index;
+		nd->signal_min =3D telit_signal_min;
+		nd->signal_max =3D telit_signal_max;
+		g_at_chat_send(nd->chat, "AT+CIND=3D1", cind_prefix,
+								NULL, NULL, NULL);
+		g_at_chat_register(nd->chat, "+CIEV:",
+						ciev_notify, FALSE, netreg, NULL);
+		break;
 	default:
 		g_at_chat_send(nd->chat, "AT+CIND=3D?", cind_prefix,
 				cind_support_cb, netreg, NULL);
-- =

1.7.0.4



--
Scanned by MailScanner.


--===============6185888273579272173==--

