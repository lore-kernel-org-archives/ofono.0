Content-Type: multipart/mixed; boundary="===============5795467410182878926=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCHv3 5/9] quectel: add basic support for serial connected modems
Date: Wed, 10 Jul 2019 23:51:44 +0200
Message-ID: <20190710215148.78083-6-martin@geanix.com>
In-Reply-To: <20190710215148.78083-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5795467410182878926==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Setup GSM 07.10 multiplexing using the kernel n_gsm line discpline
driver, and use the virtual tty devices as Aux and Modem channels.

The driver supports rts/cts on the underlying serial device. This is
enabled with OFONO_QUECTED_RTSCTS udev environment, e.g.:

KERNEL=3D=3D"ttymxc0", ENV{OFONO_DRIVER}=3D"quectel", \
        ENV{OFONO_QUECTEL_RTSCTS}=3D"on"
---

Changes since v1:
 * work around kernel dead-lock in n_gsm tty line discipline
 * clearify explanatory comment in cfun_query()
 * add error handling to cfun_query()
 * move hard-coding of gsm tty paths from udevng to quectel

 plugins/quectel.c | 275 ++++++++++++++++++++++++++++++++++++++++------
 plugins/udevng.c  |  24 +++-
 2 files changed, 267 insertions(+), 32 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 6e93f45a..8914cf45 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -25,7 +25,13 @@
 =

 #include <errno.h>
 #include <stdlib.h>
+#include <stdbool.h>
+#include <unistd.h>
 =

+#include <sys/stat.h>
+#include <sys/ioctl.h>
+#include <linux/tty.h>
+#include <linux/gsmmux.h>
 #include <ell/ell.h>
 #include <gatchat.h>
 #include <gattty.h>
@@ -47,11 +53,28 @@ static const char *cfun_prefix[] =3D { "+CFUN:", NULL };
 static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

+static const uint8_t gsm0710_terminate[] =3D {
+	0xf9, /* open flag */
+	0x03, /* channel 0 */
+	0xef, /* UIH frame */
+	0x05, /* 2 data bytes */
+	0xc3, /* terminate 1 */
+	0x01, /* terminate 2 */
+	0xf2, /* crc */
+	0xf9, /* close flag */
+};
+
 struct quectel_data {
 	GAtChat *modem;
 	GAtChat *aux;
 	guint cpin_ready;
-	gboolean have_sim;
+	bool have_sim;
+
+	/* used by quectel uart driver */
+	GAtChat *uart;
+	struct l_timeout *mux_ready_timer;
+	int mux_ready_count;
+	int initial_ldisc;
 };
 =

 static void quectel_debug(const char *str, void *user_data)
@@ -86,9 +109,67 @@ static void quectel_remove(struct ofono_modem *modem)
 	ofono_modem_set_data(modem, NULL);
 	g_at_chat_unref(data->aux);
 	g_at_chat_unref(data->modem);
+	g_at_chat_unref(data->uart);
 	l_free(data);
 }
 =

+static void close_mux_cb(struct l_timeout *timeout, void *user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	GIOChannel *device;
+	uint32_t gpio_value =3D 0;
+	ssize_t write_count;
+	int fd;
+
+	DBG("%p", modem);
+
+	device =3D g_at_chat_get_channel(data->uart);
+	fd =3D g_io_channel_unix_get_fd(device);
+
+	/* restore initial tty line discipline */
+	if (ioctl(fd, TIOCSETD, &data->initial_ldisc) < 0)
+		ofono_warn("Failed to restore line discipline");
+
+	/* terminate gsm 0710 multiplexing on the modem side */
+	write_count =3D write(fd, gsm0710_terminate, sizeof(gsm0710_terminate));
+	if (write_count !=3D sizeof(gsm0710_terminate))
+		ofono_warn("Failed to terminate gsm multiplexing");
+
+	g_at_chat_unref(data->uart);
+	data->uart =3D NULL;
+
+	l_timeout_remove(timeout);
+	ofono_modem_set_powered(modem, false);
+}
+
+static void close_serial(struct ofono_modem *modem)
+{
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	g_at_chat_unref(data->aux);
+	data->aux =3D NULL;
+
+	g_at_chat_unref(data->modem);
+	data->modem =3D NULL;
+
+	/*
+	 * if gsm0710 multiplexing is used, the aux and modem file descriptors
+	 * must be closed before closing the underlying serial device to avoid
+	 * an old kernel dead-lock:
+	 * https://lists.ofono.org/pipermail/ofono/2011-March/009405.html
+	 *
+	 * setup a timer to iterate the mainloop once to let gatchat close the
+	 * virtual file descriptors unreferenced above
+	 */
+	if (data->uart)
+		l_timeout_create_ms(1, close_mux_cb, modem, NULL);
+	else
+		ofono_modem_set_powered(modem, false);
+}
+
 static void cpin_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -106,7 +187,7 @@ static void cpin_notify(GAtResult *result, gpointer use=
r_data)
 	g_at_result_iter_next_unquoted_string(&iter, &sim_inserted);
 =

 	if (g_strcmp0(sim_inserted, "NOT INSERTED") !=3D 0)
-		data->have_sim =3D TRUE;
+		data->have_sim =3D true;
 =

 	ofono_modem_set_powered(modem, TRUE);
 =

@@ -133,11 +214,7 @@ static void cfun_enable(gboolean ok, GAtResult *result=
, gpointer user_data)
 	DBG("%p ok %d", modem, ok);
 =

 	if (!ok) {
-		g_at_chat_unref(data->aux);
-		data->aux =3D NULL;
-		g_at_chat_unref(data->modem);
-		data->modem =3D NULL;
-		ofono_modem_set_powered(modem, FALSE);
+		close_serial(modem);
 		return;
 	}
 =

@@ -152,19 +229,23 @@ static void cfun_query(gboolean ok, GAtResult *result=
, gpointer user_data)
 	struct ofono_modem *modem =3D user_data;
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
 	GAtResultIter iter;
-	int status;
+	int cfun;
 =

 	DBG("%p ok %d", modem, ok);
 =

-	if (!ok)
+	if (!ok) {
+		close_serial(modem);
 		return;
+	}
 =

 	g_at_result_iter_init(&iter, result);
 =

-	if (g_at_result_iter_next(&iter, "+CFUN:") =3D=3D FALSE)
+	if (g_at_result_iter_next(&iter, "+CFUN:") =3D=3D FALSE) {
+		close_serial(modem);
 		return;
+	}
 =

-	g_at_result_iter_next_number(&iter, &status);
+	g_at_result_iter_next_number(&iter, &cfun);
 =

 	/*
 	 * The modem firmware powers up in CFUN=3D1 but will respond to AT+CFUN=
=3D4
@@ -172,20 +253,18 @@ static void cfun_query(gboolean ok, GAtResult *result=
, gpointer user_data)
 	 * passes.  Empirical evidence suggests that the firmware will report an
 	 * unsolicited +CPIN: notification when it is ready to be useful.
 	 *
-	 * Work around this feature by only transitioning to CFUN=3D4 after we've
-	 * received an unsolicited +CPIN: notification.
+	 * Work around this feature by only transitioning to CFUN=3D4 if the
+	 * modem is not in CFUN=3D1 or untill after we've received an unsolicited
+	 * +CPIN: notification.
 	 */
-
-	if (status !=3D 1) {
+	if (cfun !=3D 1)
 		g_at_chat_send(data->aux, "AT+CFUN=3D4", none_prefix, cfun_enable,
 				modem, NULL);
-		return;
-	}
-
-	cfun_enable(TRUE, NULL, modem);
+	else
+		cfun_enable(TRUE, NULL, modem);
 }
 =

-static int quectel_enable(struct ofono_modem *modem)
+static int open_ttys(struct ofono_modem *modem)
 {
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
 =

@@ -216,18 +295,155 @@ static int quectel_enable(struct ofono_modem *modem)
 	return -EINPROGRESS;
 }
 =

-static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+static void mux_ready_cb(struct l_timeout *timeout, void *user_data)
 {
 	struct ofono_modem *modem =3D user_data;
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	struct stat st;
+	int i, ret;
 =

 	DBG("%p", modem);
 =

-	g_at_chat_unref(data->aux);
-	data->aux =3D NULL;
+	/* check if the last (and thus all) virtual gsm tty's are created */
+	ret =3D stat(ofono_modem_get_string(modem, "Modem"), &st);
+	if (ret < 0) {
+		if (data->mux_ready_count++ < 5) {
+			/* not ready yet; try again in 100 ms*/
+			l_timeout_modify_ms(timeout, 100);
+			return;
+		}
+
+		/* not ready after 500 ms; bail out */
+		close_serial(modem);
+		return;
+	}
 =

-	if (ok)
-		ofono_modem_set_powered(modem, FALSE);
+	/* virtual gsm tty's are ready */
+	l_timeout_remove(timeout);
+
+	if (open_ttys(modem) !=3D -EINPROGRESS)
+		close_serial(modem);
+
+	g_at_chat_set_slave(data->uart, data->modem);
+}
+
+static void cmux_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	struct gsm_config gsm_config;
+	GIOChannel *device;
+	int ldisc =3D N_GSM0710;
+	int fd;
+
+	DBG("%p", modem);
+
+	device =3D g_at_chat_get_channel(data->uart);
+	fd =3D g_io_channel_unix_get_fd(device);
+
+	/* get initial line discipline to restore after use */
+	if (ioctl(fd, TIOCGETD, &data->initial_ldisc) < 0) {
+		ofono_error("Failed to get current line discipline: %s", strerror(errno)=
);
+		close_serial(modem);
+		return;
+	}
+
+	/* enable gsm 0710 multiplexing line discipline */
+	if (ioctl(fd, TIOCSETD, &ldisc) < 0) {
+		ofono_error("Failed to set multiplexer line discipline: %s", strerror(er=
rno));
+		close_serial(modem);
+		return;
+	}
+
+	/* get n_gsm configuration */
+	if (ioctl(fd, GSMIOC_GETCONF, &gsm_config) < 0) {
+		ofono_error("Failed to get gsm config: %s", strerror(errno));
+		close_serial(modem);
+		return;
+	}
+
+	gsm_config.initiator =3D 1;     /* cpu side is initiating multiplexing */
+	gsm_config.encapsulation =3D 0; /* basic transparency encoding */
+	gsm_config.mru =3D 127;         /* 127 bytes rx mtu */
+	gsm_config.mtu =3D 127;         /* 127 bytes tx mtu */
+	gsm_config.t1 =3D 10;           /* 100 ms ack timer */
+	gsm_config.n2 =3D 3;            /* 3 retries */
+	gsm_config.t2 =3D 30;           /* 300 ms response timer */
+	gsm_config.t3 =3D 10;           /* 100 ms wake up response timer */
+	gsm_config.i =3D 1;             /* subset */
+
+	/* set the new configuration */
+	if (ioctl(fd, GSMIOC_SETCONF, &gsm_config) < 0) {
+		ofono_error("Failed to set gsm config: %s", strerror(errno));
+		close_serial(modem);
+		return;
+	}
+
+	/*
+	 * the kernel does not yet support mapping the underlying serial device
+	 * to its virtual gsm ttys, so hard-code gsmtty1 gsmtty2 for now
+	 */
+	ofono_modem_set_string(modem, "Aux", "/dev/gsmtty1");
+	ofono_modem_set_string(modem, "Modem", "/dev/gsmtty2");
+
+	/* wait for gsmtty devices to appear */
+	if (!l_timeout_create_ms(100, mux_ready_cb, modem, NULL)) {
+		close_serial(modem);
+		return;
+	}
+}
+
+static int open_serial(struct ofono_modem *modem)
+{
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	const char *rts_cts;
+
+	DBG("%p", modem);
+
+	rts_cts =3D ofono_modem_get_string(modem, "RtsCts");
+
+	data->uart =3D at_util_open_device(modem, "Device", quectel_debug,
+						"UART: ",
+						"Baud", "115200",
+						"Parity", "none",
+						"StopBits", "1",
+						"DataBits", "8",
+						"XonXoff", "off",
+						"Local", "on",
+						"Read", "on",
+						"RtsCts", rts_cts,
+						NULL);
+	if (data->uart =3D=3D NULL)
+		return -EINVAL;
+
+	g_at_chat_send(data->uart, "ATE0", none_prefix, NULL, NULL,
+			NULL);
+
+	/* setup multiplexing */
+	g_at_chat_send(data->uart, "AT+CMUX=3D0,0,5,127,10,3,30,10,2", NULL,
+			cmux_cb, modem, NULL);
+
+	return -EINPROGRESS;
+}
+
+static int quectel_enable(struct ofono_modem *modem)
+{
+	DBG("%p", modem);
+
+	if (ofono_modem_get_string(modem, "Device"))
+		return open_serial(modem);
+	else
+		return open_ttys(modem);
+}
+
+static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	close_serial(modem);
 }
 =

 static int quectel_disable(struct ofono_modem *modem)
@@ -239,14 +455,11 @@ static int quectel_disable(struct ofono_modem *modem)
 	g_at_chat_cancel_all(data->modem);
 	g_at_chat_unregister_all(data->modem);
 =

-	g_at_chat_unref(data->modem);
-	data->modem =3D NULL;
-
 	g_at_chat_cancel_all(data->aux);
 	g_at_chat_unregister_all(data->aux);
 =

-	g_at_chat_send(data->aux, "AT+CFUN=3D0", cfun_prefix,
-					cfun_disable, modem, NULL);
+	g_at_chat_send(data->aux, "AT+CFUN=3D0", cfun_prefix, cfun_disable, modem,
+			NULL);
 =

 	return -EINPROGRESS;
 }
@@ -292,7 +505,7 @@ static void quectel_pre_sim(struct ofono_modem *modem)
 	sim =3D ofono_sim_create(modem, OFONO_VENDOR_QUECTEL, "atmodem",
 				data->aux);
 =

-	if (sim && data->have_sim =3D=3D TRUE)
+	if (sim && data->have_sim =3D=3D true)
 		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 4b420dc0..567196bc 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -837,7 +837,7 @@ static gboolean setup_samsung(struct modem_info *modem)
 	return TRUE;
 }
 =

-static gboolean setup_quectel(struct modem_info *modem)
+static gboolean setup_quectel_usb(struct modem_info *modem)
 {
 	const char *aux =3D NULL, *mdm =3D NULL;
 	GSList *list;
@@ -877,6 +877,28 @@ static gboolean setup_quectel(struct modem_info *modem)
 	return TRUE;
 }
 =

+static gboolean setup_quectel_serial(struct modem_info *modem)
+{
+	struct serial_device_info* info;
+	const char *value;
+
+	info =3D modem->serial;
+	value =3D udev_device_get_property_value(info->dev, "OFONO_QUECTEL_RTSCTS=
");
+
+	ofono_modem_set_string(modem->modem, "RtsCts", value ? value : "off");
+	ofono_modem_set_string(modem->modem, "Device", info->devnode);
+
+	return TRUE;
+}
+
+static gboolean setup_quectel(struct modem_info *modem)
+{
+	if (modem->serial)
+		return setup_quectel_serial(modem);
+	else
+		return setup_quectel_usb(modem);
+}
+
 static gboolean setup_quectelqmi(struct modem_info *modem)
 {
 	const char *qmi =3D NULL, *net =3D NULL, *gps =3D NULL, *aux =3D NULL;
-- =

2.22.0


--===============5795467410182878926==--

