Content-Type: multipart/mixed; boundary="===============3859434832838154645=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCHv3 6/9] quectel: support gpio to power on/off the modem
Date: Wed, 10 Jul 2019 23:51:45 +0200
Message-ID: <20190710215148.78083-7-martin@geanix.com>
In-Reply-To: <20190710215148.78083-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3859434832838154645==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds support for configuring a gpio in udev to control the modem
power.

To enable gpio control, specify OFONO_QUECTEL_GPIO_CHIP and
OFONO_QUECTEL_GPIO_OFFSET in the udev environment, for example:

KERNEL=3D=3D"ttymxc0", ENV{OFONO_DRIVER}=3D"quectel", \
        ENV{OFONO_QUECTEL_GPIO_CHIP}=3D"gpiochip2", \
        ENV{OFONO_QUECTEL_GPIO_OFFSET}=3D"26"
---

Changes since v2:
 * fix memleak in quectel_probe_gpio()
 * expand comment to g_at_chat_set_wakeup_command()

 plugins/quectel.c | 84 +++++++++++++++++++++++++++++++++++++++++++----
 plugins/udevng.c  | 10 +++++-
 2 files changed, 87 insertions(+), 7 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 8914cf45..0533164d 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -75,6 +75,7 @@ struct quectel_data {
 	struct l_timeout *mux_ready_timer;
 	int mux_ready_count;
 	int initial_ldisc;
+	struct l_gpio_writer *gpio;
 };
 =

 static void quectel_debug(const char *str, void *user_data)
@@ -84,6 +85,43 @@ static void quectel_debug(const char *str, void *user_da=
ta)
 	ofono_info("%s%s", prefix, str);
 }
 =

+static int quectel_probe_gpio(struct ofono_modem *modem)
+{
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	struct l_gpio_chip *gpiochip;
+	uint32_t offset;
+	const char *chip_name, *offset_str;
+	uint32_t value =3D 0;
+
+	DBG("%p", modem);
+
+	chip_name =3D ofono_modem_get_string(modem, "GpioChip");
+	if (!chip_name)
+		return 0;
+
+	offset_str =3D ofono_modem_get_string(modem, "GpioOffset");
+	if (!offset_str)
+		return -EINVAL;
+
+	offset =3D strtoul(offset_str, NULL, 0);
+	if (!offset)
+		return -EINVAL;
+
+	gpiochip =3D l_gpio_chip_new(chip_name);
+	if (!gpiochip)
+		return -ENODEV;
+
+	data->gpio =3D l_gpio_writer_new(gpiochip, "ofono", 1, &offset,
+						&value);
+
+	l_gpio_chip_free(gpiochip);
+
+	if (!data->gpio)
+		return -EIO;
+
+	return 0;
+}
+
 static int quectel_probe(struct ofono_modem *modem)
 {
 	struct quectel_data *data;
@@ -94,7 +132,7 @@ static int quectel_probe(struct ofono_modem *modem)
 =

 	ofono_modem_set_data(modem, data);
 =

-	return 0;
+	return quectel_probe_gpio(modem);
 }
 =

 static void quectel_remove(struct ofono_modem *modem)
@@ -107,6 +145,7 @@ static void quectel_remove(struct ofono_modem *modem)
 		g_at_chat_unregister(data->aux, data->cpin_ready);
 =

 	ofono_modem_set_data(modem, NULL);
+	l_gpio_writer_free(data->gpio);
 	g_at_chat_unref(data->aux);
 	g_at_chat_unref(data->modem);
 	g_at_chat_unref(data->uart);
@@ -140,6 +179,7 @@ static void close_mux_cb(struct l_timeout *timeout, voi=
d *user_data)
 	data->uart =3D NULL;
 =

 	l_timeout_remove(timeout);
+	l_gpio_writer_set(data->gpio, 1, &gpio_value);
 	ofono_modem_set_powered(modem, false);
 }
 =

@@ -393,9 +433,22 @@ static void cmux_cb(gboolean ok, GAtResult *result, gp=
ointer user_data)
 	}
 }
 =

+static void ate_cb(int ok, GAtResult *result, void *user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	g_at_chat_set_wakeup_command(data->uart, NULL, 0, 0);
+	g_at_chat_send(data->uart, "AT+CMUX=3D0,0,5,127,10,3,30,10,2", NULL,
+			cmux_cb, modem, NULL);
+}
+
 static int open_serial(struct ofono_modem *modem)
 {
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	const uint32_t gpio_value =3D 1;
 	const char *rts_cts;
 =

 	DBG("%p", modem);
@@ -416,12 +469,31 @@ static int open_serial(struct ofono_modem *modem)
 	if (data->uart =3D=3D NULL)
 		return -EINVAL;
 =

-	g_at_chat_send(data->uart, "ATE0", none_prefix, NULL, NULL,
-			NULL);
+	if (data->gpio && !l_gpio_writer_set(data->gpio, 1, &gpio_value)) {
+		close_serial(modem);
+		return -EIO;
+	}
 =

-	/* setup multiplexing */
-	g_at_chat_send(data->uart, "AT+CMUX=3D0,0,5,127,10,3,30,10,2", NULL,
-			cmux_cb, modem, NULL);
+	/*
+	 * there are three different power-up scenarios:
+	 *
+	 *  1) the gpio has just been toggled on, so the modem is not ready
+	 *     until it prints RDY
+	 *
+	 *  2) the modem has been on for a while and ready to respond to
+	 *     commands, so there will be no RDY notification
+	 *
+	 *  3) either of the previous to scenarious is the case, but the modem
+	 *     UART is not configured to a fixed bitrate. In this case it needs
+	 *     a few 'AT' bytes to detect the host UART bitrate, but the RDY is
+	 *     lost.
+	 *
+	 * the wakeup command feature is (mis)used to support all three
+	 * scenarious by sending AT commands until the modem responds with OK,
+	 * at which point the modem is ready.
+	 */
+	g_at_chat_set_wakeup_command(data->uart, "AT\r", 500, 10000);
+	g_at_chat_send(data->uart, "ATE0", none_prefix, ate_cb, modem, NULL);
 =

 	return -EINPROGRESS;
 }
diff --git a/plugins/udevng.c b/plugins/udevng.c
index 567196bc..d754d126 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -883,8 +883,16 @@ static gboolean setup_quectel_serial(struct modem_info=
 *modem)
 	const char *value;
 =

 	info =3D modem->serial;
-	value =3D udev_device_get_property_value(info->dev, "OFONO_QUECTEL_RTSCTS=
");
 =

+	value =3D udev_device_get_property_value(info->dev, "OFONO_QUECTEL_GPIO_C=
HIP");
+	if (value)
+		ofono_modem_set_string(modem->modem, "GpioChip", value);
+
+	value =3D udev_device_get_property_value(info->dev, "OFONO_QUECTEL_GPIO_O=
FFSET");
+	if (value)
+		ofono_modem_set_string(modem->modem, "GpioOffset", value);
+
+	value =3D udev_device_get_property_value(info->dev, "OFONO_QUECTEL_RTSCTS=
");
 	ofono_modem_set_string(modem->modem, "RtsCts", value ? value : "off");
 	ofono_modem_set_string(modem->modem, "Device", info->devnode);
 =

-- =

2.22.0


--===============3859434832838154645==--

