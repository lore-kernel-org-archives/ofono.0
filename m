Content-Type: multipart/mixed; boundary="===============4583421919172863589=="
MIME-Version: 1.0
From: Alex J Lennon <ajlennon@dynamicdevices.co.uk>
Subject: [PATCH 1/2] cinterion: Add cinterion vendor support
Date: Thu, 30 Apr 2015 20:08:16 +0100
Message-ID: <1430420897-31084-1-git-send-email-ajlennon@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4583421919172863589==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implement OFONO_VENDOR_CINTERION specific support to register
textual +CIEV indications for signal strength using vendor
specific AT^SIND command
---
 drivers/atmodem/network-registration.c | 64 ++++++++++++++++++++++++++++++=
++--
 drivers/atmodem/vendor.h               |  1 +
 2 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index a438726..c3507cc 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -838,6 +838,39 @@ static void telit_ciev_notify(GAtResult *result, gpoin=
ter user_data)
 	ofono_netreg_strength_notify(netreg, strength);
 }
 =

+static void cinterion_ciev_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	const char *signal_identifier =3D "rssi";
+	const char *ind_str;
+	int strength;
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CIEV:"))
+		return;
+
+	if (!g_at_result_iter_next_unquoted_string(&iter, &ind_str))
+		return;
+
+	if (!g_str_equal(signal_identifier, ind_str))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &strength))
+		return;
+
+	DBG("rssi %d", strength);
+
+	if (strength =3D=3D nd->signal_invalid)
+		strength =3D -1;
+	else
+		strength =3D (strength * 100) / (nd->signal_max - nd->signal_min);
+
+	ofono_netreg_strength_notify(netreg, strength);
+}
+
 static void ctzv_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
@@ -1494,13 +1527,17 @@ static void at_cmer_set_cb(gboolean ok, GAtResult *=
result, gpointer user_data)
 	}
 =

 	/*
-	 * Telit uses strings instead of numbers to identify indicators
-	 * in a +CIEV URC.
-	 * Handle them in a separate function to keep the code clean.
+	 * Telit/Cinterion uses strings instead of numbers to identify
+	 * indicators in a +CIEV URC.
+	 * Handle them in separate functions to keep the code clean.
 	 */
 	if (nd->vendor =3D=3D OFONO_VENDOR_TELIT)
 		g_at_chat_register(nd->chat, "+CIEV:",
 				telit_ciev_notify, FALSE, netreg, NULL);
+	else if (nd->vendor =3D=3D OFONO_VENDOR_CINTERION)
+	{
+	  /* +CIEV handling has been registered in at_creg_set_cb() */
+	}
 	else
 		g_at_chat_register(nd->chat, "+CIEV:",
 				ciev_notify, FALSE, netreg, NULL);
@@ -1915,6 +1952,27 @@ static void at_creg_set_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 		g_at_chat_send(nd->chat, "AT*TLTS=3D1", none_prefix,
 						NULL, NULL, NULL);
 		break;
+	case OFONO_VENDOR_CINTERION:
+		/*
+		 * We can't set rssi bounds from Cinterion responses
+		 * so set them up to specified values here
+		 *
+		 * Cinterion rssi signal strength specified as:
+		 * 0      <=3D -112dBm
+		 * 1 - 4  signal strengh in 15 dB steps
+		 * 5      >=3D -51 dBm
+		 * 99     not known or undetectable
+		 */
+		nd->signal_min =3D 0;
+		nd->signal_max =3D 5;
+		nd->signal_invalid =3D 99;
+
+		/* Register for specific signal strength reports */
+		g_at_chat_send(nd->chat, "AT^SIND=3D\"rssi\",1", none_prefix,
+				NULL, NULL, NULL);
+		g_at_chat_register(nd->chat, "+CIEV:",
+				cinterion_ciev_notify, FALSE, netreg, NULL);
+		break;
 	case OFONO_VENDOR_NOKIA:
 	case OFONO_VENDOR_SAMSUNG:
 		/* Signal strength reporting via CIND is not supported */
diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
index c132e45..52071c8 100644
--- a/drivers/atmodem/vendor.h
+++ b/drivers/atmodem/vendor.h
@@ -45,4 +45,5 @@ enum ofono_vendor {
 	OFONO_VENDOR_ALCATEL,
 	OFONO_VENDOR_QUECTEL,
 	OFONO_VENDOR_UBLOX,
+	OFONO_VENDOR_CINTERION,
 };
-- =

1.9.1


--===============4583421919172863589==--

