Content-Type: multipart/mixed; boundary="===============3153396507187894581=="
MIME-Version: 1.0
From: Piotr Haber <gluedig@gmail.com>
Subject: [PATCH 1/2] plugins: rename he910 to xe910
Date: Thu, 26 Jan 2017 17:22:52 +0100
Message-ID: <20170126162253.25442-2-gluedig@gmail.com>
In-Reply-To: <20170126162253.25442-1-gluedig@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3153396507187894581==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In preparation for more generic support
of Telit xE910 family.
---
 Makefile.am                  |  4 +--
 plugins/udevng.c             |  6 ++--
 plugins/{he910.c =3D> xe910.c} | 70 ++++++++++++++++++++++----------------=
------
 3 files changed, 40 insertions(+), 40 deletions(-)
 rename plugins/{he910.c =3D> xe910.c} (83%)

diff --git a/Makefile.am b/Makefile.am
index f76971ec..6d134739 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -491,8 +491,8 @@ builtin_sources +=3D plugins/sim900.c
 builtin_modules +=3D connman
 builtin_sources +=3D plugins/connman.c
 =

-builtin_modules +=3D he910
-builtin_sources +=3D plugins/he910.c
+builtin_modules +=3D xe910
+builtin_sources +=3D plugins/xe910.c
 =

 builtin_modules +=3D quectel
 builtin_sources +=3D plugins/quectel.c
diff --git a/plugins/udevng.c b/plugins/udevng.c
index 50089129..2f1da62b 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -654,7 +654,7 @@ static gboolean setup_telit(struct modem_info *modem)
 	return TRUE;
 }
 =

-static gboolean setup_he910(struct modem_info *modem)
+static gboolean setup_xe910(struct modem_info *modem)
 {
 	const char *mdm =3D NULL, *aux =3D NULL, *gps =3D NULL;
 	GSList *list;
@@ -976,7 +976,7 @@ static struct {
 	{ "novatel",	setup_novatel	},
 	{ "nokia",	setup_nokia	},
 	{ "telit",	setup_telit	},
-	{ "he910",	setup_he910	},
+	{ "xe910",	setup_xe910	},
 	{ "simcom",	setup_simcom	},
 	{ "zte",	setup_zte	},
 	{ "icera",	setup_icera	},
@@ -1214,7 +1214,7 @@ static struct {
 	{ "simcom",	"option",	"05c6", "9000"	},
 	{ "telit",	"usbserial",	"1bc7"		},
 	{ "telit",	"option",	"1bc7"		},
-	{ "he910",	"cdc_acm",	"1bc7", "0021"	},
+	{ "xe910",	"cdc_acm",	"1bc7", "0021"	},
 	{ "nokia",	"option",	"0421", "060e"	},
 	{ "nokia",	"option",	"0421", "0623"	},
 	{ "samsung",	"option",	"04e8", "6889"	},
diff --git a/plugins/he910.c b/plugins/xe910.c
similarity index 83%
rename from plugins/he910.c
rename to plugins/xe910.c
index 69362b87..24fe1ade 100644
--- a/plugins/he910.c
+++ b/plugins/xe910.c
@@ -62,7 +62,7 @@
 static const char *none_prefix[] =3D { NULL };
 static const char *qss_prefix[] =3D { "#QSS:", NULL };
 =

-struct he910_data {
+struct xe910_data {
 	GAtChat *chat;		/* AT chat */
 	GAtChat *modem;		/* Data port */
 	struct ofono_sim *sim;
@@ -70,7 +70,7 @@ struct he910_data {
 	ofono_bool_t sms_phonebook_added;
 };
 =

-static void he910_debug(const char *str, void *user_data)
+static void xe910_debug(const char *str, void *user_data)
 {
 	const char *prefix =3D user_data;
 =

@@ -112,14 +112,14 @@ static GAtChat *open_device(struct ofono_modem *modem,
 		return NULL;
 =

 	if (getenv("OFONO_AT_DEBUG"))
-		g_at_chat_set_debug(chat, he910_debug, debug);
+		g_at_chat_set_debug(chat, xe910_debug, debug);
 =

 	return chat;
 }
 =

 static void switch_sim_state_status(struct ofono_modem *modem, int status)
 {
-	struct he910_data *data =3D ofono_modem_get_data(modem);
+	struct xe910_data *data =3D ofono_modem_get_data(modem);
 =

 	DBG("%p, SIM status: %d", modem, status);
 =

@@ -151,7 +151,7 @@ static void switch_sim_state_status(struct ofono_modem =
*modem, int status)
 	}
 }
 =

-static void he910_qss_notify(GAtResult *result, gpointer user_data)
+static void xe910_qss_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
 	int status;
@@ -197,7 +197,7 @@ static void qss_query_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 static void cfun_enable_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
 {
 	struct ofono_modem *modem =3D user_data;
-	struct he910_data *data =3D ofono_modem_get_data(modem);
+	struct xe910_data *data =3D ofono_modem_get_data(modem);
 =

 	DBG("%p", modem);
 =

@@ -232,7 +232,7 @@ static void cfun_enable_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 				NULL, NULL, NULL);
 =

 	/* Follow sim state */
-	g_at_chat_register(data->chat, "#QSS:", he910_qss_notify,
+	g_at_chat_register(data->chat, "#QSS:", xe910_qss_notify,
 				FALSE, modem, NULL);
 =

 	/* Enable sim state notification */
@@ -242,9 +242,9 @@ static void cfun_enable_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 			qss_query_cb, modem, NULL);
 }
 =

-static int he910_enable(struct ofono_modem *modem)
+static int xe910_enable(struct ofono_modem *modem)
 {
-	struct he910_data *data =3D ofono_modem_get_data(modem);
+	struct xe910_data *data =3D ofono_modem_get_data(modem);
 =

 	DBG("%p", modem);
 =

@@ -278,7 +278,7 @@ static int he910_enable(struct ofono_modem *modem)
 static void cfun_disable_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
 {
 	struct ofono_modem *modem =3D user_data;
-	struct he910_data *data =3D ofono_modem_get_data(modem);
+	struct xe910_data *data =3D ofono_modem_get_data(modem);
 =

 	DBG("%p", modem);
 =

@@ -289,9 +289,9 @@ static void cfun_disable_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 		ofono_modem_set_powered(modem, FALSE);
 }
 =

-static int he910_disable(struct ofono_modem *modem)
+static int xe910_disable(struct ofono_modem *modem)
 {
-	struct he910_data *data =3D ofono_modem_get_data(modem);
+	struct xe910_data *data =3D ofono_modem_get_data(modem);
 =

 	DBG("%p", modem);
 =

@@ -310,9 +310,9 @@ static int he910_disable(struct ofono_modem *modem)
 	return -EINPROGRESS;
 }
 =

-static void he910_pre_sim(struct ofono_modem *modem)
+static void xe910_pre_sim(struct ofono_modem *modem)
 {
-	struct he910_data *data =3D ofono_modem_get_data(modem);
+	struct xe910_data *data =3D ofono_modem_get_data(modem);
 =

 	DBG("%p", modem);
 =

@@ -322,9 +322,9 @@ static void he910_pre_sim(struct ofono_modem *modem)
 	ofono_location_reporting_create(modem, 0, "telitmodem", data->chat);
 }
 =

-static void he910_post_online(struct ofono_modem *modem)
+static void xe910_post_online(struct ofono_modem *modem)
 {
-	struct he910_data *data =3D ofono_modem_get_data(modem);
+	struct xe910_data *data =3D ofono_modem_get_data(modem);
 	struct ofono_message_waiting *mw;
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
@@ -351,13 +351,13 @@ static void he910_post_online(struct ofono_modem *mod=
em)
 		ofono_gprs_add_context(gprs, gc);
 }
 =

-static int he910_probe(struct ofono_modem *modem)
+static int xe910_probe(struct ofono_modem *modem)
 {
-	struct he910_data *data;
+	struct xe910_data *data;
 =

 	DBG("%p", modem);
 =

-	data =3D g_try_new0(struct he910_data, 1);
+	data =3D g_try_new0(struct xe910_data, 1);
 	if (data =3D=3D NULL)
 		return -ENOMEM;
 =

@@ -366,9 +366,9 @@ static int he910_probe(struct ofono_modem *modem)
 	return 0;
 }
 =

-static void he910_remove(struct ofono_modem *modem)
+static void xe910_remove(struct ofono_modem *modem)
 {
-	struct he910_data *data =3D ofono_modem_get_data(modem);
+	struct xe910_data *data =3D ofono_modem_get_data(modem);
 =

 	DBG("%p", modem);
 =

@@ -381,27 +381,27 @@ static void he910_remove(struct ofono_modem *modem)
 	g_free(data);
 }
 =

-static struct ofono_modem_driver he910_driver =3D {
-	.name		=3D "he910",
-	.probe		=3D he910_probe,
-	.remove		=3D he910_remove,
-	.enable		=3D he910_enable,
-	.disable	=3D he910_disable,
-	.pre_sim	=3D he910_pre_sim,
-	.post_online	=3D he910_post_online,
+static struct ofono_modem_driver xe910_driver =3D {
+	.name		=3D "xe910",
+	.probe		=3D xe910_probe,
+	.remove		=3D xe910_remove,
+	.enable		=3D xe910_enable,
+	.disable	=3D xe910_disable,
+	.pre_sim	=3D xe910_pre_sim,
+	.post_online	=3D xe910_post_online,
 };
 =

-static int he910_init(void)
+static int xe910_init(void)
 {
 	DBG("");
 =

-	return ofono_modem_driver_register(&he910_driver);
+	return ofono_modem_driver_register(&xe910_driver);
 }
 =

-static void he910_exit(void)
+static void xe910_exit(void)
 {
-	ofono_modem_driver_unregister(&he910_driver);
+	ofono_modem_driver_unregister(&xe910_driver);
 }
 =

-OFONO_PLUGIN_DEFINE(he910, "Telit HE910 driver", VERSION,
-		OFONO_PLUGIN_PRIORITY_DEFAULT, he910_init, he910_exit)
+OFONO_PLUGIN_DEFINE(xe910, "Telit HE910 driver", VERSION,
+		OFONO_PLUGIN_PRIORITY_DEFAULT, xe910_init, xe910_exit)
-- =

2.11.0


--===============3153396507187894581==--

