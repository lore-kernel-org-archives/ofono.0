Content-Type: multipart/mixed; boundary="===============8061933162088939729=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 03/13] phonesim changes for setting TE character set
Date: Thu, 09 Sep 2010 12:01:44 -0700
Message-ID: <1284058904-15526-1-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1284035516-21359-4-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8061933162088939729==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/phonesim.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index d3caa20..288baf6 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -64,6 +64,7 @@
 #include <drivers/atmodem/atutil.h>
 =

 static const char *none_prefix[] =3D { NULL };
+static const char *cscs_prefix[] =3D { "+CSCS:", NULL };
 =

 struct phonesim_data {
 	GAtMux *mux;
@@ -72,6 +73,48 @@ struct phonesim_data {
 	gboolean use_mux;
 };
 =

+static const char *best_charset(int supported)
+{
+	const char *charset =3D "Invalid";
+
+	if (supported & AT_UTIL_CHARSET_UCS2)
+		charset =3D "UCS2";
+
+	if (supported & AT_UTIL_CHARSET_GSM)
+		charset =3D "GSM";
+
+	return charset;
+}
+
+static void list_charsets_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct phonesim_data *data =3D ofono_modem_get_data(modem);
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
+	g_at_chat_send(data->chat, buf, none_prefix, NULL, NULL, NULL);
+}
+
+static void list_charsets(struct ofono_modem *modem)
+{
+	struct phonesim_data *data =3D ofono_modem_get_data(modem);
+	=

+	g_at_chat_send(data->chat, "AT+CSCS=3D?", cscs_prefix,
+			list_charsets_cb, modem, NULL);
+}
+
 static int phonesim_probe(struct ofono_modem *modem)
 {
 	struct phonesim_data *data;
@@ -321,6 +364,8 @@ static void phonesim_pre_sim(struct ofono_modem *modem)
 =

 	if (sim)
 		ofono_sim_inserted_notify(sim, TRUE);
+
+	list_charsets(modem);
 }
 =

 static void phonesim_post_sim(struct ofono_modem *modem)
-- =

1.7.0.4


--===============8061933162088939729==--

