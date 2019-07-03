Content-Type: multipart/mixed; boundary="===============7960222865653011743=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 09/10] quectel: add basic support for serial connected modems
Date: Wed, 03 Jul 2019 20:09:54 +0200
Message-ID: <20190703180955.18246-10-martin@geanix.com>
In-Reply-To: <20190703180955.18246-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7960222865653011743==
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
 plugins/quectel.c | 187 +++++++++++++++++++++++++++++++++++++++++++++-
 plugins/udevng.c  |  34 ++++++++-
 2 files changed, 217 insertions(+), 4 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 1727ef40..649e8550 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -26,7 +26,12 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <stdbool.h>
+#include <unistd.h>
 =

+#include <sys/stat.h>
+#include <sys/ioctl.h>
+#include <linux/tty.h>
+#include <linux/gsmmux.h>
 #include <ell/ell.h>
 #include <gatchat.h>
 #include <gattty.h>
@@ -48,11 +53,28 @@ static const char *cfun_prefix[] =3D { "+CFUN:", NULL };
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
 	size_t cpin_ready;
 	bool have_sim;
+
+	/* used by quectel uart driver */
+	GAtChat *uart;
+	struct l_timeout *mux_ready_timer;
+	int mux_ready_count;
+	int initial_ldisc;
 };
 =

 static void quectel_debug(const char *str, void *user_data)
@@ -87,6 +109,7 @@ static void quectel_remove(struct ofono_modem *modem)
 	ofono_modem_set_data(modem, NULL);
 	g_at_chat_unref(data->aux);
 	g_at_chat_unref(data->modem);
+	g_at_chat_unref(data->uart);
 	l_free(data);
 }
 =

@@ -186,7 +209,7 @@ static void cfun_query(int ok, GAtResult *result, void =
*user_data)
 	cfun_enable(true, NULL, modem);
 }
 =

-static int quectel_enable(struct ofono_modem *modem)
+static int open_ttys(struct ofono_modem *modem)
 {
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
 =

@@ -216,6 +239,165 @@ static int quectel_enable(struct ofono_modem *modem)
 	return -EINPROGRESS;
 }
 =

+static void close_serial(struct ofono_modem *modem)
+{
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	GIOChannel *device;
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
+	ofono_modem_set_powered(modem, false);
+}
+
+static void mux_ready_cb(struct l_timeout *timeout, void *user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	struct stat st;
+	int i, ret;
+
+	DBG("%p", modem);
+
+	/* check if all virtual gsm tty's are created */
+	ret =3D stat(ofono_modem_get_string(modem, "Modem"), &st);
+	if (ret < 0 && data->mux_ready_count++ < 5) {
+		/* not ready yet; try again in 100 ms*/
+		l_timeout_modify_ms(timeout, 100);
+		return;
+	} else if (ret < 0) {
+		/* not ready after 500 ms; bail out */
+		close_serial(modem);
+		return;
+	}
+
+	/* virtual gsm tty's are ready */
+	l_timeout_remove(timeout);
+
+	if (open_ttys(modem) !=3D -EINPROGRESS)
+		close_serial(modem);
+
+	g_at_chat_set_slave(data->uart, data->modem);
+}
+
+static void cmux_cb(int ok, GAtResult *result, void *user_data)
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
 static void cfun_disable(int ok, GAtResult *result, void *user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -226,8 +408,7 @@ static void cfun_disable(int ok, GAtResult *result, voi=
d *user_data)
 	g_at_chat_unref(data->aux);
 	data->aux =3D NULL;
 =

-	if (ok)
-		ofono_modem_set_powered(modem, false);
+	close_serial(modem);
 }
 =

 static int quectel_disable(struct ofono_modem *modem)
diff --git a/plugins/udevng.c b/plugins/udevng.c
index 4b420dc0..ec19995d 100644
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
@@ -877,6 +877,38 @@ static gboolean setup_quectel(struct modem_info *modem)
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
+	/*
+	 * there's no way to link virtual gsm tty devices to the underlying
+	 * tty device or vice/versa, so there's no way around hard-coding
+	 * the devices here. A second cmux setup would start from /dev/gsmtty65,
+	 * but there's also no way check for existing mux devices in a race free
+	 * manner
+	 */
+	ofono_modem_set_string(modem->modem, "Aux", "/dev/gsmtty1");
+	ofono_modem_set_string(modem->modem, "Modem", "/dev/gsmtty2");
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


--===============7960222865653011743==--

