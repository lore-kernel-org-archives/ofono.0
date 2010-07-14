Content-Type: multipart/mixed; boundary="===============2440367497395476589=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] mbm: poll SIM status when initializing
Date: Wed, 14 Jul 2010 19:28:32 +0300
Message-ID: <1279124912-13663-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2440367497395476589==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 plugins/mbm.c |   39 +++++++++++++++++++++++++++++++++++----
 1 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/plugins/mbm.c b/plugins/mbm.c
index 864b0df..9e63005 100644
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
@@ -54,6 +55,8 @@ static const char *none_prefix[] =3D { NULL };
 struct mbm_data {
 	GAtChat *modem_port;
 	GAtChat *data_port;
+	guint sim_poll;
+	guint sim_polled;
 	gboolean have_sim;
 };
 =

@@ -82,6 +85,10 @@ static void mbm_remove(struct ofono_modem *modem)
 =

 	g_at_chat_unref(data->data_port);
 	g_at_chat_unref(data->modem_port);
+
+	if (data->sim_poll > 0)
+		g_source_remove(data->sim_poll);
+
 	g_free(data);
 }
 =

@@ -92,6 +99,8 @@ static void mbm_debug(const char *str, void *user_data)
 	ofono_info("%s %s", prefix, str);
 }
 =

+static gboolean init_simpin_check(gpointer user_data);
+
 static void simpin_check(gboolean ok, GAtResult *result, gpointer user_dat=
a)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -99,17 +108,40 @@ static void simpin_check(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 =

 	DBG("");
 =

-	/* Modem returns error if there is no SIM in slot */
+	/* Modem returns +CME ERROR: 10 if SIM is not ready. */
+	if (!ok && result->final_or_pdu &&
+		!strcmp(result->final_or_pdu, "+CME ERROR: 10") &&
+		data->sim_polled++ < 5) {
+		data->sim_poll =3D
+			g_timeout_add_seconds(1, init_simpin_check, modem);
+		return;
+	}
+
+	data->sim_polled =3D 0;
+
+	/* Modem returns ERROR if there is no SIM in slot. */
 	data->have_sim =3D ok;
 =

 	ofono_modem_set_powered(modem, TRUE);
 }
 =

-static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
+static gboolean init_simpin_check(gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
 	struct mbm_data *data =3D ofono_modem_get_data(modem);
 =

+	data->sim_poll =3D 0;
+
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
@@ -117,8 +149,7 @@ static void cfun_enable(gboolean ok, GAtResult *result,=
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


--===============2440367497395476589==--

