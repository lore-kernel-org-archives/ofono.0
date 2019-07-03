Content-Type: multipart/mixed; boundary="===============7343105823219211438=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 10/10] quectel: support gpio to power on/off the modem
Date: Wed, 03 Jul 2019 20:09:55 +0200
Message-ID: <20190703180955.18246-11-martin@geanix.com>
In-Reply-To: <20190703180955.18246-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7343105823219211438==
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
 plugins/quectel.c | 86 +++++++++++++++++++++++++++++++++++++++++++----
 plugins/udevng.c  | 10 +++++-
 2 files changed, 89 insertions(+), 7 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 649e8550..29e66da2 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -75,6 +75,8 @@ struct quectel_data {
 	struct l_timeout *mux_ready_timer;
 	int mux_ready_count;
 	int initial_ldisc;
+	struct l_gpio_writer *gpio;
+	size_t rdy_listener;
 };
 =

 static void quectel_debug(const char *str, void *user_data)
@@ -84,6 +86,41 @@ static void quectel_debug(const char *str, void *user_da=
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
+	chip_name =3D ofono_modem_get_string(modem, "GpioChip");
+	if (!chip_name)
+		return 0;
+
+	offset_str =3D ofono_modem_get_string(modem, "GpioOffset");
+	if (!offset_str)
+		return -EINVAL;
+
+	gpiochip =3D l_gpio_chip_new(chip_name);
+	if (!gpiochip)
+		return -ENODEV;
+
+	offset =3D strtoul(offset_str, NULL, 0);
+	if (!offset)
+		return -EINVAL;
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
@@ -94,7 +131,7 @@ static int quectel_probe(struct ofono_modem *modem)
 =

 	ofono_modem_set_data(modem, data);
 =

-	return 0;
+	return quectel_probe_gpio(modem);
 }
 =

 static void quectel_remove(struct ofono_modem *modem)
@@ -107,6 +144,7 @@ static void quectel_remove(struct ofono_modem *modem)
 		g_at_chat_unregister(data->aux, data->cpin_ready);
 =

 	ofono_modem_set_data(modem, NULL);
+	l_gpio_writer_free(data->gpio);
 	g_at_chat_unref(data->aux);
 	g_at_chat_unref(data->modem);
 	g_at_chat_unref(data->uart);
@@ -244,6 +282,7 @@ static void close_serial(struct ofono_modem *modem)
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
 	GIOChannel *device;
 	ssize_t write_count;
+	uint32_t gpio_value =3D 0;
 	int fd;
 =

 	DBG("%p", modem);
@@ -263,6 +302,7 @@ static void close_serial(struct ofono_modem *modem)
 	g_at_chat_unref(data->uart);
 	data->uart =3D NULL;
 =

+	l_gpio_writer_set(data->gpio, 1, &gpio_value);
 	ofono_modem_set_powered(modem, false);
 }
 =

@@ -355,6 +395,42 @@ static void cmux_cb(int ok, GAtResult *result, void *u=
ser_data)
 	}
 }
 =

+static void setup_cmux(struct ofono_modem *modem)
+{
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+
+	g_at_chat_send(data->uart, "ATE0", none_prefix, NULL, NULL, NULL);
+
+	/* setup multiplexing */
+	g_at_chat_send(data->uart, "AT+CMUX=3D0,0,5,127,10,3,30,10,2", NULL,
+			cmux_cb, modem, NULL);
+}
+
+static void rdy_notify(GAtResult *result, void *user_data)
+{
+	setup_cmux(user_data);
+}
+
+static int gpio_enable(struct ofono_modem *modem)
+{
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	uint32_t gpio_value =3D 1;
+
+	/*
+	 * activating the enable gpio below, the modem is not ready until it
+	 * responds with "RDY", so set up a listener for this
+	 */
+	data->rdy_listener =3D g_at_chat_register(data->uart, "RDY", rdy_notify,
+						false, modem, NULL);
+
+	if (!l_gpio_writer_set(data->gpio, 1, &gpio_value)) {
+		close_serial(modem);
+		return -EIO;
+	}
+
+	return -EINPROGRESS;
+}
+
 static int open_serial(struct ofono_modem *modem)
 {
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
@@ -378,12 +454,10 @@ static int open_serial(struct ofono_modem *modem)
 	if (data->uart =3D=3D NULL)
 		return -EINVAL;
 =

-	g_at_chat_send(data->uart, "ATE0", none_prefix, NULL, NULL,
-			NULL);
+	if (data->gpio)
+		return gpio_enable(modem);
 =

-	/* setup multiplexing */
-	g_at_chat_send(data->uart, "AT+CMUX=3D0,0,5,127,10,3,30,10,2", NULL,
-			cmux_cb, modem, NULL);
+	setup_cmux(modem);
 =

 	return -EINPROGRESS;
 }
diff --git a/plugins/udevng.c b/plugins/udevng.c
index ec19995d..dcc276e1 100644
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


--===============7343105823219211438==--

