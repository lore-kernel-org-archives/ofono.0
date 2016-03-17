Content-Type: multipart/mixed; boundary="===============7639554184250151056=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 6/7] plugins/ublox: read network mode
Date: Thu, 17 Mar 2016 13:38:32 +0100
Message-ID: <1458218313-26966-7-git-send-email-dragos@endocode.com>
In-Reply-To: <1458218313-26966-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7639554184250151056==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Dongsu Park <dongsu@endocode.com>

Read network mode into modem string. This will let the gprs-context
drive know what to do.
---
 plugins/ublox.c | 47 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index 092ba64..d3361a3 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -42,6 +42,7 @@
 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
 =

+static const char *ubmconf_prefix[] =3D { "+UBMCONF:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

 enum supported_models {
@@ -51,11 +52,17 @@ enum supported_models {
 	TOBYL2_HIGH_THROUGHPUT_MODE 	=3D 1146,
 };
 =

+enum ublox_net_mode {
+	UBLOX_TOBYL2_NET_MODE_ROUTER =3D 1,
+	UBLOX_TOBYL2_NET_MODE_BRIDGE =3D 2,
+};
+
 struct ublox_data {
 	GAtChat *modem;
 	GAtChat *aux;
 	int model_id;
 	enum ofono_vendor vendor_family;
+	enum ublox_net_mode net_mode;
 };
 =

 static void ublox_debug(const char *str, void *user_data)
@@ -92,6 +99,39 @@ static void ublox_remove(struct ofono_modem *modem)
 	g_free(data);
 }
 =

+static void read_ubmconf_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct ofono_modem *modem =3D (struct ofono_modem *) user_data;
+	struct ublox_data *data =3D ofono_modem_get_data(modem);
+	int mode =3D 0;
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	while (!g_at_result_iter_next(&iter, "+UBMCONF:"))
+		;	/* skip every other line that is not UBMCONF */
+
+	g_at_result_iter_next_number(&iter, &mode);
+
+	data->net_mode =3D mode;
+	DBG("mode=3D%d", mode);
+	if (mode =3D=3D 1)
+		ofono_modem_set_string(modem, "NetworkMode", "routed");
+	else if (mode =3D=3D 2)
+		ofono_modem_set_string(modem, "NetworkMode", "bridged");
+}
+
+static void read_net_mode(struct ofono_modem *modem)
+{
+	struct ublox_data *data =3D ofono_modem_get_data(modem);
+
+	if (!data->aux)
+		return;
+
+	g_at_chat_send(data->aux, "AT+UBMCONF?",
+			ubmconf_prefix, read_ubmconf_cb, modem, NULL);
+}
+
 static GAtChat *open_device(struct ofono_modem *modem,
 				const char *key, char *debug)
 {
@@ -141,11 +181,6 @@ static void cfun_enable(gboolean ok, GAtResult *result=
, gpointer user_data)
 		return;
 	}
 =

-	if (data->model_id =3D=3D TOBYL2_HIGH_THROUGHPUT_MODE)
-		/* use bridged mode until routed mode support is added */
-		g_at_chat_send(data->aux, "AT+UBMCONF=3D2", none_prefix,
-						NULL, NULL, NULL);
-
 	ofono_modem_set_powered(modem, TRUE);
 }
 =

@@ -205,6 +240,8 @@ static int ublox_enable(struct ofono_modem *modem)
 	g_at_chat_send(data->aux, "ATE0 +CMEE=3D1", none_prefix,
 					NULL, NULL, NULL);
 =

+	read_net_mode(modem);
+
 	g_at_chat_send(data->aux, "AT+CFUN=3D4", none_prefix,
 					cfun_enable, modem, NULL);
 =

-- =

2.5.0


--===============7639554184250151056==--

