Content-Type: multipart/mixed; boundary="===============5966920915692472007=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCHv3 2/2] quectel: support own cmux implementation over kernel
 line discipline
Date: Mon, 07 Oct 2019 23:39:59 +0200
Message-ID: <20191007213959.20110-2-martin@geanix.com>
In-Reply-To: <20191007213959.20110-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5966920915692472007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The in-kernel implementation of gsm0710 causes deadlocks in the
kernel[1], so switch the default back to the user-space implementation
in ofono.

The change also removes the timeout-callback used to defer disabling the
n_gsm line discipline, as that is no longer needed[2]

To enable use of the kernel line discipline, add an udev env entry with
OFONO_QUECTEL_MUX=3D"n_gsm".

[1] https://lore.kernel.org/lkml/4b2455c0-25ba-0187-6df6-c63b4ccc6a6e(a)gea=
nix.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D7030082a7415d18e3befdf1f9ec05b3d5de98de4
---

Changes since v2:
 * keep kernel line discipline support
 * remove unrelated check in quectel_disable()
 * remove unrelated setting of AT+IFC=3D0,0
 * revert to using at_util_open_device()

 plugins/quectel.c | 202 ++++++++++++++++++++++++++++++++++++----------
 plugins/udevng.c  |   5 ++
 2 files changed, 166 insertions(+), 41 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index f19065b2..8b2c0133 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -36,6 +36,7 @@
 #include <ell/ell.h>
 #include <gatchat.h>
 #include <gattty.h>
+#include <gatmux.h>
 =

 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono.h>
@@ -95,7 +96,9 @@ struct quectel_data {
 	bool sim_ready;
 =

 	/* used by quectel uart driver */
+	GIOChannel *device;
 	GAtChat *uart;
+	GAtMux *mux;
 	int mux_ready_count;
 	int initial_ldisc;
 	struct l_gpio_writer *gpio;
@@ -192,43 +195,48 @@ static void quectel_remove(struct ofono_modem *modem)
 	g_at_chat_unref(data->aux);
 	g_at_chat_unref(data->modem);
 	g_at_chat_unref(data->uart);
+	g_at_mux_unref(data->mux);
+
+	if (data->device)
+		g_io_channel_unref(data->device);
+
 	l_free(data);
 }
 =

-static void close_mux_cb(struct l_timeout *timeout, void *user_data)
+static void close_mux(struct ofono_modem *modem)
+{
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	g_io_channel_unref(data->device);
+	data->device =3D NULL;
+
+	g_at_mux_unref(data->mux);
+	data->mux =3D NULL;
+}
+
+static void close_ngsm(struct ofono_modem *modem)
 {
-	struct ofono_modem *modem =3D user_data;
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
-	GIOChannel *device;
-	uint32_t gpio_value =3D 0;
-	ssize_t write_count;
 	int fd;
 =

 	DBG("%p", modem);
 =

-	device =3D g_at_chat_get_channel(data->uart);
-	fd =3D g_io_channel_unix_get_fd(device);
+	if (!data->device)
+		return;
+
+	fd =3D g_io_channel_unix_get_fd(data->device);
 =

 	/* restore initial tty line discipline */
 	if (ioctl(fd, TIOCSETD, &data->initial_ldisc) < 0)
 		ofono_warn("Failed to restore line discipline");
-
-	/* terminate gsm 0710 multiplexing on the modem side */
-	write_count =3D write(fd, gsm0710_terminate, sizeof(gsm0710_terminate));
-	if (write_count !=3D sizeof(gsm0710_terminate))
-		ofono_warn("Failed to terminate gsm multiplexing");
-
-	g_at_chat_unref(data->uart);
-	data->uart =3D NULL;
-
-	l_timeout_remove(timeout);
-	l_gpio_writer_set(data->gpio, 1, &gpio_value);
-	ofono_modem_set_powered(modem, FALSE);
 }
 =

 static void close_serial(struct ofono_modem *modem)
 {
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	uint32_t gpio_value =3D 0;
 =

 	DBG("%p", modem);
 =

@@ -241,19 +249,16 @@ static void close_serial(struct ofono_modem *modem)
 	g_at_chat_unref(data->modem);
 	data->modem =3D NULL;
 =

-	/*
-	 * if gsm0710 multiplexing is used, the aux and modem file descriptors
-	 * must be closed before closing the underlying serial device to avoid
-	 * an old kernel dead-lock:
-	 * https://lists.ofono.org/pipermail/ofono/2011-March/009405.html
-	 *
-	 * setup a timer to iterate the mainloop once to let gatchat close the
-	 * virtual file descriptors unreferenced above
-	 */
-	if (data->uart)
-		l_timeout_create_ms(1, close_mux_cb, modem, NULL);
+	g_at_chat_unref(data->uart);
+	data->uart =3D NULL;
+
+	if (data->mux)
+		close_mux(modem);
 	else
-		ofono_modem_set_powered(modem, false);
+		close_ngsm(modem);
+
+	l_gpio_writer_set(data->gpio, 1, &gpio_value);
+	ofono_modem_set_powered(modem, FALSE);
 }
 =

 static void dbus_hw_reply_properties(struct dbus_hw *hw)
@@ -793,6 +798,19 @@ static void cgmm_cb(int ok, GAtResult *result, void *u=
ser_data)
 			NULL);
 }
 =

+static void setup_aux(struct ofono_modem *modem)
+{
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	g_at_chat_set_slave(data->modem, data->aux);
+	g_at_chat_send(data->aux, "ATE0; &C0; +CMEE=3D1; +QIURC=3D0", none_prefix,
+			NULL, NULL, NULL);
+	g_at_chat_send(data->aux, "AT+CGMM", cgmm_prefix, cgmm_cb, modem,
+			NULL);
+}
+
 static int open_ttys(struct ofono_modem *modem)
 {
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
@@ -812,16 +830,73 @@ static int open_ttys(struct ofono_modem *modem)
 		return -EIO;
 	}
 =

-	g_at_chat_set_slave(data->modem, data->aux);
-
-	g_at_chat_send(data->aux, "ATE0; &C0; +CMEE=3D1; +QIURC=3D0", none_prefix,
-			NULL, NULL, NULL);
-	g_at_chat_send(data->aux, "AT+CGMM", cgmm_prefix, cgmm_cb, modem,
-			NULL);
+	setup_aux(modem);
 =

 	return -EINPROGRESS;
 }
 =

+static GAtChat *create_chat(struct ofono_modem *modem, char *debug)
+{
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	GIOChannel *channel;
+	GAtSyntax *syntax;
+	GAtChat *chat;
+
+	DBG("%p", modem);
+
+	channel =3D g_at_mux_create_channel(data->mux);
+	if (channel =3D=3D NULL)
+		return NULL;
+
+	syntax =3D g_at_syntax_new_gsmv1();
+	chat =3D g_at_chat_new(channel, syntax);
+	g_at_syntax_unref(syntax);
+	g_io_channel_unref(channel);
+
+	if (chat =3D=3D NULL)
+		return NULL;
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(chat, quectel_debug, debug);
+
+	return chat;
+}
+
+static void cmux_gatmux(struct ofono_modem *modem)
+{
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	data->mux =3D g_at_mux_new_gsm0710_basic(data->device, 127);
+	if (data->mux =3D=3D NULL) {
+		ofono_error("failed to create gsm0710 mux");
+		close_serial(modem);
+		return;
+	}
+
+	if (getenv("OFONO_MUX_DEBUG"))
+		g_at_mux_set_debug(data->mux, quectel_debug, "Mux: ");
+
+	g_at_mux_start(data->mux);
+
+	data->modem =3D create_chat(modem, "Modem: ");
+	if (!data->modem) {
+		ofono_error("failed to create modem channel");
+		close_serial(modem);
+		return;
+	}
+
+	data->aux =3D create_chat(modem, "Aux: ");
+	if (!data->aux) {
+		ofono_error("failed to create aux channel");
+		close_serial(modem);
+		return;
+	}
+
+	setup_aux(modem);
+}
+
 static void mux_ready_cb(struct l_timeout *timeout, void *user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -854,9 +929,8 @@ static void mux_ready_cb(struct l_timeout *timeout, voi=
d *user_data)
 	g_at_chat_set_slave(data->uart, data->modem);
 }
 =

-static void cmux_cb(gboolean ok, GAtResult *result, gpointer user_data)
+static void cmux_ngsm(struct ofono_modem *modem)
 {
-	struct ofono_modem *modem =3D user_data;
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
 	struct gsm_config gsm_config;
 	GIOChannel *device;
@@ -865,8 +939,7 @@ static void cmux_cb(gboolean ok, GAtResult *result, gpo=
inter user_data)
 =

 	DBG("%p", modem);
 =

-	device =3D g_at_chat_get_channel(data->uart);
-	fd =3D g_io_channel_unix_get_fd(device);
+	fd =3D g_io_channel_unix_get_fd(data->device);
 =

 	/* get initial line discipline to restore after use */
 	if (ioctl(fd, TIOCGETD, &data->initial_ldisc) < 0) {
@@ -922,6 +995,39 @@ static void cmux_cb(gboolean ok, GAtResult *result, gp=
ointer user_data)
 	}
 }
 =

+static void cmux_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	const char *mux =3D ofono_modem_get_string(modem, "Mux");
+
+	DBG("%p", modem);
+
+	g_at_chat_unref(data->uart);
+	data->uart =3D NULL;
+
+	if (!ok) {
+		close_serial(modem);
+		return;
+	}
+
+	if (!mux)
+		mux =3D "internal";
+
+	if (strcmp(mux, "n_gsm") =3D=3D 0) {
+		cmux_ngsm(modem);
+		return;
+	}
+
+	if (strcmp(mux, "internal") =3D=3D 0) {
+		cmux_gatmux(modem);
+		return;
+	}
+
+	ofono_error("unsupported mux setting: '%s'", mux);
+	close_serial(modem);
+}
+
 static void ate_cb(int ok, GAtResult *result, void *user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -979,6 +1085,8 @@ static int open_serial(struct ofono_modem *modem)
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
 	const uint32_t gpio_value =3D 1;
 	const char *rts_cts;
+	ssize_t written;
+	int fd;
 =

 	DBG("%p", modem);
 =

@@ -998,6 +1106,18 @@ static int open_serial(struct ofono_modem *modem)
 	if (data->uart =3D=3D NULL)
 		return -EINVAL;
 =

+	data->device =3D g_at_chat_get_channel(data->uart);
+	g_io_channel_ref(data->device);
+
+	/*
+	 * terminate gsm 0710 multiplexing on the modem side to make sure it
+	 * responds to plain AT commands
+	 * */
+	fd =3D g_io_channel_unix_get_fd(data->device);
+	written =3D write(fd, gsm0710_terminate, sizeof(gsm0710_terminate));
+	if (written !=3D sizeof(gsm0710_terminate))
+		ofono_warn("Failed to terminate gsm multiplexing");
+
 	if (data->gpio && !l_gpio_writer_set(data->gpio, 1, &gpio_value)) {
 		close_serial(modem);
 		return -EIO;
diff --git a/plugins/udevng.c b/plugins/udevng.c
index 40ed2b02..4a38621b 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -893,6 +893,11 @@ static gboolean setup_quectel_serial(struct modem_info=
 *modem)
 	if (value)
 		ofono_modem_set_string(modem->modem, "GpioOffset", value);
 =

+	value =3D udev_device_get_property_value(info->dev,
+						"OFONO_QUECTEL_MUX");
+	if (value)
+		ofono_modem_set_string(modem->modem, "Mux", value);
+
 	value =3D udev_device_get_property_value(info->dev,
 						"OFONO_QUECTEL_RTSCTS");
 	ofono_modem_set_string(modem->modem, "RtsCts", value ? value : "off");
-- =

2.23.0

--===============5966920915692472007==--

