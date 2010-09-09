Content-Type: multipart/mixed; boundary="===============3172300130902438998=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 02/13] atgen changes for setting TE character set
Date: Thu, 09 Sep 2010 12:00:33 -0700
Message-ID: <1284058833-15483-1-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <4C88F433.6070106@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3172300130902438998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/atgen.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/plugins/atgen.c b/plugins/atgen.c
index 1ce2467..1b898b7 100644
--- a/plugins/atgen.c
+++ b/plugins/atgen.c
@@ -25,6 +25,8 @@
 =

 #include <errno.h>
 #include <stdlib.h>
+#include <string.h>
+#include <stdio.h>
 =

 #include <glib.h>
 #include <gatchat.h>
@@ -55,6 +57,9 @@
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
 =

+static const char *none_prefix[] =3D { NULL };
+static const char *cscs_prefix[] =3D { "+CSCS:", NULL };
+
 static const char *tty_opts[] =3D {
 	"Baud",
 	"Read",
@@ -67,6 +72,48 @@ static const char *tty_opts[] =3D {
 	NULL,
 };
 =

+static const char *best_charset(int supported)
+{
+	const char *charset =3D "Invalid";
+
+	if (supported & AT_UTIL_CHARSET_GSM)
+		charset =3D "GSM";
+
+	if (supported & AT_UTIL_CHARSET_UTF8)
+		charset =3D "UTF-8";
+
+	return charset;
+}
+
+static void list_charsets_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	GAtChat *chat =3D ofono_modem_get_data(modem);
+	const char *charset;
+	int supported =3D 0;
+	char buf[32];
+
+	if (!ok)
+		return;
+
+	if (!at_util_parse_cscs_supported(result, &supported))
+		return;
+
+	charset =3D best_charset(supported);
+	snprintf(buf, sizeof(buf), "AT+CSCS=3D\"%s\"", charset);
+
+	g_at_chat_send(chat, buf, none_prefix, NULL, NULL, NULL);
+}
+
+static void list_charsets(struct ofono_modem *modem)
+{
+	GAtChat *chat =3D ofono_modem_get_data(modem);
+
+	g_at_chat_send(chat, "AT+CSCS=3D?", cscs_prefix,
+			list_charsets_cb, modem, NULL);
+}
+
 static int atgen_probe(struct ofono_modem *modem)
 {
 	return 0;
@@ -207,6 +254,8 @@ static void atgen_pre_sim(struct ofono_modem *modem)
 =

 	if (sim)
 		ofono_sim_inserted_notify(sim, TRUE);
+
+	list_charsets(modem);
 }
 =

 static void atgen_post_sim(struct ofono_modem *modem)
-- =

1.7.0.4


--===============3172300130902438998==--

