Content-Type: multipart/mixed; boundary="===============7096767800120998816=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 2/3] telit: allow plugin to be compiled without BT support
Date: Thu, 04 Apr 2013 10:20:51 +0200
Message-ID: <1365063652-24286-3-git-send-email-jonas@southpole.se>
In-Reply-To: <1365063652-24286-1-git-send-email-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7096767800120998816==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The HE910, for example, does not have Bluetooth, so it may be
desirable to compile the plugin even when Bluetooth is disabled
in the Ofono configuration.
---
 Makefile.am     |  9 ++++++---
 configure.ac    |  3 +++
 plugins/telit.c | 18 ++++++++++++++++++
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 0d2ba9f..368836b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -407,13 +407,16 @@ builtin_sources +=3D plugins/samsung.c
 builtin_modules +=3D sim900
 builtin_sources +=3D plugins/sim900.c
 =

+builtin_modules +=3D telit
+builtin_sources +=3D plugins/telit.c
+if BLUETOOTH
+builtin_sources +=3D plugins/bluetooth.h
+endif
+
 if BLUETOOTH
 builtin_modules +=3D bluetooth
 builtin_sources +=3D plugins/bluetooth.c plugins/bluetooth.h
 =

-builtin_modules +=3D telit
-builtin_sources +=3D plugins/telit.c plugins/bluetooth.h
-
 builtin_modules +=3D sap
 builtin_sources +=3D plugins/sap.c plugins/bluetooth.h
 =

diff --git a/configure.ac b/configure.ac
index 450352b..ddd24a4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -182,6 +182,9 @@ fi
 AC_SUBST(BLUEZ_CFLAGS)
 AC_SUBST(BLUEZ_LIBS)
 AM_CONDITIONAL(BLUETOOTH, test "${enable_bluetooth}" !=3D "no")
+if (test "${enable_bluetooth}" !=3D "no"); then
+	AC_DEFINE(NEED_BLUETOOTH, 1, [Define if bluetooth support is required])
+fi
 =

 AC_ARG_WITH([provisiondb], AC_HELP_STRING([--with-provisiondb=3DFILE],
 	[location of provision database]), [path_provisiondb=3D${withval}])
diff --git a/plugins/telit.c b/plugins/telit.c
index 79bc421..f661ab9 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -58,10 +58,14 @@
 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
 =

+#ifdef NEED_BLUETOOTH
 #include "bluetooth.h"
+#endif
 =

 static const char *none_prefix[] =3D { NULL };
+#ifdef NEED_BLUETOOTH
 static const char *rsen_prefix[]=3D { "#RSEN:", NULL };
+#endif
 =

 struct telit_data {
 	GAtChat *chat;		/* AT chat */
@@ -83,6 +87,7 @@ static void telit_debug(const char *str, void *user_data)
 	ofono_info("%s%s", prefix, str);
 }
 =

+#ifdef NEED_BLUETOOTH
 static void sap_close_io(struct ofono_modem *modem)
 {
 	struct telit_data *data =3D ofono_modem_get_data(modem);
@@ -178,6 +183,7 @@ static gboolean hw_event_cb(GIOChannel *hw_io, GIOCondi=
tion condition,
 =

 	return FALSE;
 }
+#endif
 =

 static GAtChat *open_device(struct ofono_modem *modem,
 				const char *key, char *debug)
@@ -285,7 +291,9 @@ static void cfun_enable_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 		g_at_chat_unref(data->chat);
 		data->chat =3D NULL;
 		ofono_modem_set_powered(m, FALSE);
+#ifdef NEED_BLUETOOTH
 		sap_close_io(modem);
+#endif
 		return;
 	}
 =

@@ -355,6 +363,7 @@ static int telit_enable(struct ofono_modem *modem)
 	return -EINPROGRESS;
 }
 =

+#ifdef NEED_BLUETOOTH
 static void telit_rsen_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -393,6 +402,7 @@ static void rsen_enable_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 		return;
 	}
 }
+#endif
 =

 static void cfun_disable_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
 {
@@ -433,6 +443,7 @@ static int telit_disable(struct ofono_modem *modem)
 	return -EINPROGRESS;
 }
 =

+#ifdef NEED_BLUETOOTH
 static void rsen_disable_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -542,6 +553,7 @@ static int telit_sap_disable(struct ofono_modem *modem)
 =

 	return -EINPROGRESS;
 }
+#endif
 =

 static void telit_pre_sim(struct ofono_modem *modem)
 {
@@ -622,6 +634,7 @@ static void telit_post_online(struct ofono_modem *modem)
 		ofono_message_waiting_register(mw);
 }
 =

+#ifdef NEED_BLUETOOTH
 static struct bluetooth_sap_driver sap_driver =3D {
 	.name =3D "telit",
 	.enable =3D telit_sap_enable,
@@ -631,6 +644,7 @@ static struct bluetooth_sap_driver sap_driver =3D {
 	.post_online =3D telit_post_online,
 	.disable =3D telit_sap_disable,
 };
+#endif
 =

 static int telit_probe(struct ofono_modem *modem)
 {
@@ -644,7 +658,9 @@ static int telit_probe(struct ofono_modem *modem)
 =

 	ofono_modem_set_data(modem, data);
 =

+#ifdef NEED_BLUETOOTH
 	bluetooth_sap_client_register(&sap_driver, modem);
+#endif
 =

 	return 0;
 }
@@ -655,7 +671,9 @@ static void telit_remove(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

+#ifdef NEED_BLUETOOTH
 	bluetooth_sap_client_unregister(modem);
+#endif
 =

 	ofono_modem_set_data(modem, NULL);
 =

-- =

1.8.1.2


--===============7096767800120998816==--

