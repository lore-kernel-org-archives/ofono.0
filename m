Content-Type: multipart/mixed; boundary="===============8754655667905336300=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [PATCH 6/8] plugins: add gps atom to mbm
Date: Thu, 16 Dec 2010 17:30:21 -0300
Message-ID: <1292531423-22316-7-git-send-email-rafael.zurita@profusion.mobi>
In-Reply-To: <1292531423-22316-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8754655667905336300==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/mbm.c |   30 ++++++++++++++++++++++++++++--
 1 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/plugins/mbm.c b/plugins/mbm.c
index 62e3ae1..60681df 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -45,6 +45,7 @@
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
 #include <ofono/log.h>
+#include <ofono/gps.h>
 =

 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
@@ -61,11 +62,13 @@ enum mbm_variant {
 struct mbm_data {
 	GAtChat *modem_port;
 	GAtChat *data_port;
+	GAtChat *gps_port;
 	guint cpin_poll_source;
 	guint cpin_poll_count;
 	gboolean have_sim;
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
+	struct ofono_gps *gps;
 	guint reopen_source;
 	enum mbm_variant variant;
 };
@@ -93,6 +96,7 @@ static void mbm_remove(struct ofono_modem *modem)
 =

 	ofono_modem_set_data(modem, NULL);
 =

+	g_at_chat_unref(data->gps_port);
 	g_at_chat_unref(data->data_port);
 	g_at_chat_unref(data->modem_port);
 =

@@ -354,15 +358,17 @@ static int mbm_enable(struct ofono_modem *modem)
 	struct mbm_data *data =3D ofono_modem_get_data(modem);
 	const char *modem_dev;
 	const char *data_dev;
+	const char *gps_dev;
 =

 	DBG("%p", modem);
 =

 	modem_dev =3D ofono_modem_get_string(modem, "ModemDevice");
 	data_dev =3D ofono_modem_get_string(modem, "DataDevice");
+	gps_dev =3D ofono_modem_get_string(modem, "GPSDevice");
 =

-	DBG("%s, %s", modem_dev, data_dev);
+	DBG("%s, %s, %s", modem_dev, data_dev, gps_dev);
 =

-	if (modem_dev =3D=3D NULL || data_dev =3D=3D NULL)
+	if (modem_dev =3D=3D NULL || data_dev =3D=3D NULL || gps_dev =3D=3D NULL)
 		return -EINVAL;
 =

 	data->modem_port =3D create_port(modem_dev);
@@ -383,6 +389,20 @@ static int mbm_enable(struct ofono_modem *modem)
 	if (getenv("OFONO_AT_DEBUG"))
 		g_at_chat_set_debug(data->data_port, mbm_debug, "Data: ");
 =

+	data->gps_port =3D create_port(gps_dev);
+	if (data->gps_port =3D=3D NULL) {
+		g_at_chat_unref(data->data_port);
+		data->data_port =3D NULL;
+
+		g_at_chat_unref(data->modem_port);
+		data->modem_port =3D NULL;
+
+		return -EIO;
+	}
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(data->gps_port, mbm_debug, "GPS: ");
+
 	g_at_chat_set_disconnect_function(data->data_port,
 						mbm_disconnect, modem);
 =

@@ -415,6 +435,9 @@ static void cfun_disable(gboolean ok, GAtResult *result=
, gpointer user_data)
 	g_at_chat_unref(data->data_port);
 	data->data_port =3D NULL;
 =

+	g_at_chat_unref(data->gps_port);
+	data->gps_port =3D NULL;
+
 	if (ok)
 		ofono_modem_set_powered(modem, FALSE);
 }
@@ -541,6 +564,9 @@ static void mbm_post_online(struct ofono_modem *modem)
 					OFONO_GPRS_CONTEXT_TYPE_MMS);
 		ofono_gprs_add_context(data->gprs, data->gc);
 	}
+
+	data->gps =3D ofono_gps_create(modem, 0,
+					"mbmmodem", data->gps_port);
 }
 =

 static struct ofono_modem_driver mbm_driver =3D {
-- =

1.7.2.3


--===============8754655667905336300==--

