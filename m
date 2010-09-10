Content-Type: multipart/mixed; boundary="===============4906152858005020919=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 2/7] phonesim changes for setting TE character set
Date: Fri, 10 Sep 2010 13:29:40 -0700
Message-ID: <1284150580-15255-1-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <4C8A65E0.7040105@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4906152858005020919==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/phonesim.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index d3caa20..24b68bf 100644
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
+
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


--===============4906152858005020919==--

