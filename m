Content-Type: multipart/mixed; boundary="===============5240876575977790017=="
MIME-Version: 1.0
From: Gabriel Lucas <gabriel.lucas@smile.fr>
Subject: [PATCH 2/6] gemalto: support ALS3 in gemalto's plugin
Date: Mon, 19 Mar 2018 16:15:46 +0100
Message-ID: <1521472546-9197-1-git-send-email-gabriel.lucas@smile.fr>
In-Reply-To: <da322612-43b7-b3c8-9113-1c552c2f3015@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5240876575977790017==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Force serial port opening options
Wait for modem to be ready to start
initializing it
Handle LTE
---
 plugins/gemalto.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++++--=
----
 1 file changed, 95 insertions(+), 12 deletions(-)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index 3739d7b..6979683 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -53,6 +53,10 @@
 =

 #define HARDWARE_MONITOR_INTERFACE OFONO_SERVICE ".cinterion.HardwareMonit=
or"
 =

+/* Supported gemalto's modem */
+#define GEMALTO_MODEL_PHS8P 	"0053"
+#define GEMALTO_MODEL_ALS3 	"0061"
+
 static const char *none_prefix[] =3D { NULL };
 static const char *sctm_prefix[] =3D { "^SCTM:", NULL };
 static const char *sbv_prefix[] =3D { "^SBV:", NULL };
@@ -70,6 +74,8 @@ struct gemalto_data {
 	gboolean have_sim;
 	struct at_util_sim_state_query *sim_state_query;
 	struct gemalto_hardware_monitor *hm;
+	guint modem_ready_id;
+	guint trial_cmd_id;
 };
 =

 static int gemalto_probe(struct ofono_modem *modem)
@@ -107,10 +113,26 @@ static GAtChat *open_device(const char *device)
 	GAtSyntax *syntax;
 	GIOChannel *channel;
 	GAtChat *chat;
+	GHashTable *options;
+
+	options =3D g_hash_table_new(g_str_hash, g_str_equal);
+	if (options =3D=3D NULL)
+		return NULL;
+
+	g_hash_table_insert(options, "Baud", "115200");
+	g_hash_table_insert(options, "StopBits", "1");
+	g_hash_table_insert(options, "DataBits", "8");
+	g_hash_table_insert(options, "Parity", "none");
+	g_hash_table_insert(options, "XonXoff", "off");
+	g_hash_table_insert(options, "RtsCts", "on");
+	g_hash_table_insert(options, "Local", "on");
+	g_hash_table_insert(options, "Read", "on");
 =

 	DBG("Opening device %s", device);
 =

-	channel =3D g_at_tty_open(device, NULL);
+	channel =3D g_at_tty_open(device, options);
+	g_hash_table_destroy(options);
+
 	if (channel =3D=3D NULL)
 		return NULL;
 =

@@ -300,29 +322,24 @@ static int gemalto_hardware_monitor_enable(struct ofo=
no_modem *modem)
 	return 0;
 }
 =

-static int gemalto_enable(struct ofono_modem *modem)
+static void gemalto_initialize(struct ofono_modem *modem)
 {
 	struct gemalto_data *data =3D ofono_modem_get_data(modem);
-	const char *app, *mdm;
+	const char *mdm;
 =

-	DBG("%p", modem);
+	DBG("");
 =

-	app =3D ofono_modem_get_string(modem, "Application");
 	mdm =3D ofono_modem_get_string(modem, "Modem");
 =

-	if (app =3D=3D NULL || mdm =3D=3D NULL)
-		return -EINVAL;
+	if (mdm =3D=3D NULL)
+		return;
 =

 	/* Open devices */
-	data->app =3D open_device(app);
-	if (data->app =3D=3D NULL)
-		return -EINVAL;
-
 	data->mdm =3D open_device(mdm);
 	if (data->mdm =3D=3D NULL) {
 		g_at_chat_unref(data->app);
 		data->app =3D NULL;
-		return -EINVAL;
+		return;
 	}
 =

 	if (getenv("OFONO_AT_DEBUG")) {
@@ -340,6 +357,67 @@ static int gemalto_enable(struct ofono_modem *modem)
 			cfun_enable, modem, NULL);
 =

 	gemalto_hardware_monitor_enable(modem);
+}
+
+static void gemalto_modem_ready(GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+	const char *app =3D ofono_modem_get_string(modem, "Application");
+
+	DBG("");
+
+	/* =

+	 * As the modem wasn't ready to handle AT commands when we opened
+	 * it, we have to close and reopen the device app.
+	 */
+	data->modem_ready_id =3D 0;
+	data->trial_cmd_id =3D 0;
+
+	g_at_chat_unref(data->app);
+
+	data->app =3D open_device(app);
+	if (data->app =3D=3D NULL) {
+		ofono_modem_set_powered(modem, FALSE);
+	} else {
+		gemalto_initialize(modem);
+	}
+}
+
+static void gemalto_at_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+
+	g_at_chat_unregister(data->app, data->modem_ready_id);
+	data->modem_ready_id =3D 0;
+
+	gemalto_initialize(modem);
+}
+
+static int gemalto_enable(struct ofono_modem *modem)
+{
+	struct gemalto_data *data =3D ofono_modem_get_data(modem);
+	const char *app, *mdm;
+
+	DBG("%p", modem);
+
+	app =3D ofono_modem_get_string(modem, "Application");
+	mdm =3D ofono_modem_get_string(modem, "Modem");
+
+	if (app =3D=3D NULL || mdm =3D=3D NULL)
+		return -EINVAL;
+
+	/* Open devices */
+	data->app =3D open_device(app);
+	if (data->app =3D=3D NULL)
+		return -EINVAL;
+
+	/* Try the AT command. If it doesn't work, wait for ^SYSSTART */
+	data->modem_ready_id =3D g_at_chat_register(data->app, "^SYSSTART",
+				gemalto_modem_ready, FALSE, modem, NULL);
+	data->trial_cmd_id =3D g_at_chat_send(data->app, "ATE0 AT",
+				none_prefix, gemalto_at_cb, modem, NULL);
 =

 	return -EINPROGRESS;
 }
@@ -432,6 +510,7 @@ static void gemalto_post_sim(struct ofono_modem *modem)
 	struct gemalto_data *data =3D ofono_modem_get_data(modem);
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
+	const char *model =3D ofono_modem_get_string(modem, "Model");
 =

 	DBG("%p", modem);
 =

@@ -444,6 +523,10 @@ static void gemalto_post_sim(struct ofono_modem *modem)
 =

 	if (gprs && gc)
 		ofono_gprs_add_context(gprs, gc);
+
+	if (!g_strcmp0(model, GEMALTO_MODEL_ALS3))
+		ofono_lte_create(modem, OFONO_VENDOR_CINTERION,
+						"atmodem", data->app);
 }
 =

 static void gemalto_post_online(struct ofono_modem *modem)
-- =

1.9.1


--===============5240876575977790017==--

