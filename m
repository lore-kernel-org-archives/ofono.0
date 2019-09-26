Content-Type: multipart/mixed; boundary="===============7544889619989325877=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 4/4] quectel: use own cmux implementation over kernel line
 discipline
Date: Thu, 26 Sep 2019 21:27:25 +0200
Message-ID: <20190926192725.227285-4-martin@geanix.com>
In-Reply-To: <20190926192725.227285-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7544889619989325877==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The in-kernel implementation of gsm0710 causes deadlocks in the
kernel[1], so switch back to the user-space implementation in ofono.

[1] https://lore.kernel.org/lkml/4b2455c0-25ba-0187-6df6-c63b4ccc6a6e(a)gea=
nix.com/
---
 plugins/quectel.c | 250 ++++++++++++++++++++++++----------------------
 1 file changed, 130 insertions(+), 120 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 4c94d305..4d33c008 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -28,14 +28,10 @@
 #include <stdbool.h>
 #include <unistd.h>
 =

-#include <sys/stat.h>
-#include <sys/ioctl.h>
-#include <sys/socket.h>
-#include <linux/tty.h>
-#include <linux/gsmmux.h>
 #include <ell/ell.h>
 #include <gatchat.h>
 #include <gattty.h>
+#include <gatmux.h>
 =

 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono.h>
@@ -92,7 +88,9 @@ struct quectel_data {
 	unsigned int sim_watch;
 =

 	/* used by quectel uart driver */
+	GIOChannel *device;
 	GAtChat *uart;
+	GAtMux *mux;
 	int mux_ready_count;
 	int initial_ldisc;
 	struct l_gpio_writer *gpio;
@@ -188,6 +186,11 @@ static void quectel_remove(struct ofono_modem *modem)
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

@@ -195,27 +198,12 @@ static void close_mux_cb(struct l_timeout *timeout, v=
oid *user_data)
 {
 	struct ofono_modem *modem =3D user_data;
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
-	GIOChannel *device;
 	uint32_t gpio_value =3D 0;
-	ssize_t write_count;
-	int fd;
 =

 	DBG("%p", modem);
 =

-	device =3D g_at_chat_get_channel(data->uart);
-	fd =3D g_io_channel_unix_get_fd(device);
-
-	/* restore initial tty line discipline */
-	if (ioctl(fd, TIOCSETD, &data->initial_ldisc) < 0)
-		ofono_warn("Failed to restore line discipline");
-
-	/* terminate gsm 0710 multiplexing on the modem side */
-	write_count =3D write(fd, gsm0710_terminate, sizeof(gsm0710_terminate));
-	if (write_count !=3D sizeof(gsm0710_terminate))
-		ofono_warn("Failed to terminate gsm multiplexing");
-
-	g_at_chat_unref(data->uart);
-	data->uart =3D NULL;
+	g_at_mux_unref(data->mux);
+	data->mux =3D NULL;
 =

 	l_timeout_remove(timeout);
 	l_gpio_writer_set(data->gpio, 1, &gpio_value);
@@ -225,6 +213,7 @@ static void close_mux_cb(struct l_timeout *timeout, voi=
d *user_data)
 static void close_serial(struct ofono_modem *modem)
 {
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	uint32_t gpio_value =3D 0;
 =

 	DBG("%p", modem);
 =

@@ -234,19 +223,27 @@ static void close_serial(struct ofono_modem *modem)
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
-	else
-		ofono_modem_set_powered(modem, false);
+	if (data->device) {
+		g_at_chat_unref(data->uart);
+		data->uart =3D NULL;
+
+		g_io_channel_unref(data->device);
+		data->device =3D NULL;
+
+		/*
+		 * shutting down and freeing the cmux object in a single
+		 * iteration of the main-loop causes use-after-free errors in
+		 * gatmux.c, so shutdown the mux here, and free it after a
+		 * timeout.
+		 */
+		g_at_mux_shutdown(data->mux);
+		l_timeout_create_ms(50, close_mux_cb, modem, NULL);
+
+		return;
+	}
+
+	l_gpio_writer_set(data->gpio, 1, &gpio_value);
+	ofono_modem_set_powered(modem, FALSE);
 }
 =

 static void dbus_hw_reply_properties(struct dbus_hw *hw)
@@ -524,7 +521,6 @@ static void dbus_hw_enable(struct ofono_modem *modem)
 static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
-	struct quectel_data *data =3D ofono_modem_get_data(modem);
 =

 	DBG("%p ok %d", modem, ok);
 =

@@ -614,6 +610,19 @@ static void cgmm_cb(int ok, GAtResult *result, void *u=
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
@@ -633,114 +642,80 @@ static int open_ttys(struct ofono_modem *modem)
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

-static void mux_ready_cb(struct l_timeout *timeout, void *user_data)
+static GAtChat *create_chat(struct ofono_modem *modem, char *debug)
 {
-	struct ofono_modem *modem =3D user_data;
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
-	struct stat st;
-	int ret;
+	GIOChannel *channel;
+	GAtSyntax *syntax;
+	GAtChat *chat;
 =

 	DBG("%p", modem);
 =

-	/* check if the last (and thus all) virtual gsm tty's are created */
-	ret =3D stat(ofono_modem_get_string(modem, "Modem"), &st);
-	if (ret < 0) {
-		if (data->mux_ready_count++ < 5) {
-			/* not ready yet; try again in 100 ms*/
-			l_timeout_modify_ms(timeout, 100);
-			return;
-		}
+	channel =3D g_at_mux_create_channel(data->mux);
+	if (channel =3D=3D NULL)
+		return NULL;
 =

-		/* not ready after 500 ms; bail out */
-		close_serial(modem);
-		return;
-	}
+	syntax =3D g_at_syntax_new_gsmv1();
+	chat =3D g_at_chat_new(channel, syntax);
+	g_at_syntax_unref(syntax);
+	g_io_channel_unref(channel);
 =

-	/* virtual gsm tty's are ready */
-	l_timeout_remove(timeout);
+	if (chat =3D=3D NULL)
+		return NULL;
 =

-	if (open_ttys(modem) !=3D -EINPROGRESS)
-		close_serial(modem);
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(chat, quectel_debug, debug);
 =

-	g_at_chat_set_slave(data->uart, data->modem);
+	return chat;
 }
 =

 static void cmux_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
-	struct gsm_config gsm_config;
-	GIOChannel *device;
-	int ldisc =3D N_GSM0710;
-	int fd;
 =

 	DBG("%p", modem);
 =

-	device =3D g_at_chat_get_channel(data->uart);
-	fd =3D g_io_channel_unix_get_fd(device);
+	g_at_chat_unref(data->uart);
+	data->uart =3D NULL;
 =

-	/* get initial line discipline to restore after use */
-	if (ioctl(fd, TIOCGETD, &data->initial_ldisc) < 0) {
-		ofono_error("Failed to get current line discipline: %s",
-				strerror(errno));
+	if (!ok) {
 		close_serial(modem);
 		return;
 	}
 =

-	/* enable gsm 0710 multiplexing line discipline */
-	if (ioctl(fd, TIOCSETD, &ldisc) < 0) {
-		ofono_error("Failed to set multiplexer line discipline: %s",
-				strerror(errno));
+	data->mux =3D g_at_mux_new_gsm0710_basic(data->device, 127);
+	if (data->mux =3D=3D NULL) {
+		ofono_error("failed to create gsm0710 mux");
 		close_serial(modem);
 		return;
 	}
 =

-	/* get n_gsm configuration */
-	if (ioctl(fd, GSMIOC_GETCONF, &gsm_config) < 0) {
-		ofono_error("Failed to get gsm config: %s", strerror(errno));
-		close_serial(modem);
-		return;
-	}
+	if (getenv("OFONO_MUX_DEBUG"))
+		g_at_mux_set_debug(data->mux, quectel_debug, "Mux: ");
+
+	g_at_mux_start(data->mux);
 =

-	gsm_config.initiator =3D 1;     /* cpu side is initiating multiplexing */
-	gsm_config.encapsulation =3D 0; /* basic transparency encoding */
-	gsm_config.mru =3D 127;         /* 127 bytes rx mtu */
-	gsm_config.mtu =3D 127;         /* 127 bytes tx mtu */
-	gsm_config.t1 =3D 10;           /* 100 ms ack timer */
-	gsm_config.n2 =3D 3;            /* 3 retries */
-	gsm_config.t2 =3D 30;           /* 300 ms response timer */
-	gsm_config.t3 =3D 10;           /* 100 ms wake up response timer */
-	gsm_config.i =3D 1;             /* subset */
-
-	/* set the new configuration */
-	if (ioctl(fd, GSMIOC_SETCONF, &gsm_config) < 0) {
-		ofono_error("Failed to set gsm config: %s", strerror(errno));
+	data->modem =3D create_chat(modem, "Modem: ");
+	if (!data->modem) {
+		ofono_error("failed to create modem channel");
 		close_serial(modem);
 		return;
 	}
 =

-	/*
-	 * the kernel does not yet support mapping the underlying serial device
-	 * to its virtual gsm ttys, so hard-code gsmtty1 gsmtty2 for now
-	 */
-	ofono_modem_set_string(modem, "Modem", "/dev/gsmtty1");
-	ofono_modem_set_string(modem, "Aux", "/dev/gsmtty2");
-
-	/* wait for gsmtty devices to appear */
-	if (!l_timeout_create_ms(100, mux_ready_cb, modem, NULL)) {
+	data->aux =3D create_chat(modem, "Aux: ");
+	if (!data->aux) {
+		ofono_error("failed to create aux channel");
 		close_serial(modem);
 		return;
 	}
+
+	setup_aux(modem);
 }
 =

 static void ate_cb(int ok, GAtResult *result, void *user_data)
@@ -771,8 +746,8 @@ static void init_cmd_cb(gboolean ok, GAtResult *result,=
 void *user_data)
 		g_at_chat_send(data->uart, "AT+IFC=3D2,2; E0", none_prefix,
 				ate_cb, modem, NULL);
 	else
-		g_at_chat_send(data->uart, "ATE0", none_prefix, ate_cb, modem,
-				NULL);
+		g_at_chat_send(data->uart, "AT+IFC=3D0,0; E0", none_prefix,
+				ate_cb, modem, NULL);
 =

 	l_timeout_remove(data->init_timeout);
 	data->init_timeout =3D NULL;
@@ -798,26 +773,58 @@ static void init_timeout_cb(struct l_timeout *timeout=
, void *user_data)
 static int open_serial(struct ofono_modem *modem)
 {
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	GHashTable *options;
+	GAtSyntax *syntax;
 	const uint32_t gpio_value =3D 1;
 	const char *rts_cts;
+	const char *device;
+	ssize_t written;
+	int fd;
 =

 	DBG("%p", modem);
 =

+	device =3D ofono_modem_get_string(modem, "Device");
 	rts_cts =3D ofono_modem_get_string(modem, "RtsCts");
 =

-	data->uart =3D at_util_open_device(modem, "Device", quectel_debug,
-						"UART: ",
-						"Baud", "115200",
-						"Parity", "none",
-						"StopBits", "1",
-						"DataBits", "8",
-						"XonXoff", "off",
-						"Local", "on",
-						"Read", "on",
-						"RtsCts", rts_cts,
-						NULL);
-	if (data->uart =3D=3D NULL)
-		return -EINVAL;
+	options =3D g_hash_table_new(g_str_hash, g_str_equal);
+	if (options =3D=3D NULL)
+		return -ENOMEM;
+
+	g_hash_table_insert(options, "Baud", "115200");
+	g_hash_table_insert(options, "Parity", "none");
+	g_hash_table_insert(options, "StopBits", "1");
+	g_hash_table_insert(options, "DataBits", "8");
+	g_hash_table_insert(options, "XonXoff", "off");
+	g_hash_table_insert(options, "Local", "on");
+	g_hash_table_insert(options, "Read", "on");
+	g_hash_table_insert(options, "RtsCts", (char *)rts_cts);
+
+	data->device =3D g_at_tty_open(device, options);
+	g_hash_table_destroy(options);
+
+	if (data->device =3D=3D NULL)
+		return -EIO;
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
+	syntax =3D g_at_syntax_new_gsm_permissive();
+	data->uart =3D g_at_chat_new(data->device, syntax);
+	g_at_syntax_unref(syntax);
+
+	if (data->uart =3D=3D NULL) {
+		close_serial(modem);
+		return -EIO;
+	}
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(data->uart, quectel_debug, "UART: ");
 =

 	if (data->gpio && !l_gpio_writer_set(data->gpio, 1, &gpio_value)) {
 		close_serial(modem);
@@ -878,6 +885,9 @@ static int quectel_disable(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

+	if (data->aux =3D=3D NULL)
+		return 0;
+
 	g_at_chat_cancel_all(data->modem);
 	g_at_chat_unregister_all(data->modem);
 =

-- =

2.23.0


--===============7544889619989325877==--

