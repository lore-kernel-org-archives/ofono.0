Content-Type: multipart/mixed; boundary="===============0603875605904278350=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] mbm: poll SIM status when initializing
Date: Wed, 14 Jul 2010 18:43:44 +0300
Message-ID: <1279122224-5274-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0603875605904278350==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 plugins/mbm.c |   28 ++++++++++++++++++++++++----
 1 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/plugins/mbm.c b/plugins/mbm.c
index 864b0df..5058b7c 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -26,6 +26,7 @@
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
+#include <string.h>
 =

 #include <glib.h>
 #include <gatchat.h>
@@ -92,6 +93,8 @@ static void mbm_debug(const char *str, void *user_data)
 	ofono_info("%s %s", prefix, str);
 }
 =

+static gboolean init_simpin_check(gpointer user_data);
+
 static void simpin_check(gboolean ok, GAtResult *result, gpointer user_dat=
a)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -99,17 +102,35 @@ static void simpin_check(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 =

 	DBG("");
 =

-	/* Modem returns error if there is no SIM in slot */
+	/* Modem returns +CME ERROR: 10 if SIM is not ready. */
+	if (!ok && result->final_or_pdu &&
+		!strcmp(result->final_or_pdu, "+CME ERROR: 10")) {
+		g_timeout_add_seconds(1, init_simpin_check, modem);
+		return;
+	}
+
+	/* Modem returns ERROR if there is no SIM in slot. */
 	data->have_sim =3D ok;
 =

 	ofono_modem_set_powered(modem, TRUE);
 }
 =

-static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
+
+static gboolean init_simpin_check(gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
 	struct mbm_data *data =3D ofono_modem_get_data(modem);
 =

+	g_at_chat_send(data->modem_port, "AT+CPIN?", cpin_prefix,
+			simpin_check, modem, NULL);
+
+	return FALSE;
+}
+
+static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+
 	DBG("");
 =

 	if (!ok) {
@@ -117,8 +138,7 @@ static void cfun_enable(gboolean ok, GAtResult *result,=
 gpointer user_data)
 		return;
 	}
 =

-	g_at_chat_send(data->modem_port, "AT+CPIN?", cpin_prefix,
-			simpin_check, modem, NULL);
+	init_simpin_check(modem);
 }
 =

 static void cfun_query(gboolean ok, GAtResult *result, gpointer user_data)
-- =

1.7.0.4


--===============0603875605904278350==--

