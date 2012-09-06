Content-Type: multipart/mixed; boundary="===============6098285469628420015=="
MIME-Version: 1.0
From: christopher.vogl@hale.at
Subject: [PATCH 2/2] netreg: Add telit version for ciev notification
Date: Thu, 06 Sep 2012 11:25:27 +0200
Message-ID: <1346923528-32138-1-git-send-email-christopher.vogl@hale.at>
In-Reply-To: <50292A75.3040005@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6098285469628420015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Christopher Vogl <christopher.vogl@hale.at>

---
 drivers/atmodem/network-registration.c |   44 ++++++++++++++++++++++++++++=
++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index 7160679..509a47a 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -759,6 +759,37 @@ static void ciev_notify(GAtResult *result, gpointer us=
er_data)
 	ofono_netreg_strength_notify(netreg, strength);
 }
 =

+static void telit_ciev_notify(GAtResult *result, gpointer user_data)
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
@@ -1618,6 +1649,19 @@ static void cind_support_cb(gboolean ok, GAtResult *=
result, gpointer user_data)
 				at_cmer_query_cb, netreg, NULL);
 	g_at_chat_register(nd->chat, "+CIEV:",
 				ciev_notify, FALSE, netreg, NULL);
+
+	/*
+	 * Telit uses strings instead of numbers to identify indicators
+	 * in a +CIEV URC.
+	 * Handle them in a separate function to keep the code clean.
+	 */
+	if (nd->vendor =3D=3D OFONO_VENDOR_TELIT)
+		g_at_chat_register(nd->chat, "+CIEV:",
+				telit_ciev_notify, FALSE, netreg, NULL);
+	else
+		g_at_chat_register(nd->chat, "+CIEV:",
+				ciev_notify, FALSE, netreg, NULL);
+
 	g_at_chat_register(nd->chat, "+CREG:",
 				creg_notify, FALSE, netreg, NULL);
 =

-- =

1.7.7.6


--===============6098285469628420015==--

