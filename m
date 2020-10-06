Content-Type: multipart/mixed; boundary="===============0081520695009574808=="
MIME-Version: 1.0
From: poeschel@lemonage.de
Subject: [PATCH v3] quectel: Power on/off with a gpio pulse
Date: Tue, 06 Oct 2020 12:10:22 +0200
Message-ID: <20201006101022.3494920-1-poeschel@lemonage.de>
In-Reply-To: <20201005151055.te5kn5rrscrvrxzu@lem-wkst-02.lemonage>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0081520695009574808==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lars Poeschel <poeschel@lemonage.de>

Current implementation uses a gpio level of 1 for powering on quectel
modems using a gpio and a level of 0 for powering off.
Normally quectel modems are powered on or off by a gpio pulse on their
PWR_KEY pin. They turn on by the first pulse and turn then off by the
next pulse. The pulse length varies between different modems.
For power on the longest I could in the quectel hardware is "more than
2 seconds" from Quectel M95 Hardware Design Manual.
For Quectel EC21 this is ">=3D 100 ms".
For Quectel MC60 this is "recommended to be 100 ms".
For Quectel UC15 this is "at least 0.1 s".
For power off the four modems in question vary between a minimum pulse
length of 600-700ms.
This implements a 2100ms pulse for power on and 750ms for power off.

If you have some special circuitry that powers your modem by gpio level
and you need the old behaviour, you can switch to gpio level powering
by setting environment variable OFONO_QUECTEL_GPIO_LEVEL. The gpio goes
to high level for the modem to power on and to low level if it should
power off.

---
Changes in v3:
- switched to l_timeout_create_ms instead of g_timeout for the gpio
  pulse
- try to keep track of the gpio_timeout object
- combined patch with the level patch
---
 plugins/quectel.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 plugins/udevng.c  |  5 +++++
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 6456775d..aa519563 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -104,6 +104,7 @@ struct quectel_data {
 	int initial_ldisc;
 	struct l_gpio_writer *gpio;
 	struct l_timeout *init_timeout;
+	struct l_timeout *gpio_timeout;
 	size_t init_count;
 	guint init_cmd;
 };
@@ -191,6 +192,7 @@ static void quectel_remove(struct ofono_modem *modem)
 =

 	ofono_modem_set_data(modem, NULL);
 	l_timeout_remove(data->init_timeout);
+	l_timeout_remove(data->gpio_timeout);
 	l_gpio_writer_free(data->gpio);
 	at_util_sim_state_query_free(data->sim_state_query);
 	g_at_chat_unref(data->aux);
@@ -234,10 +236,22 @@ static void close_ngsm(struct ofono_modem *modem)
 		ofono_warn("Failed to restore line discipline");
 }
 =

+static void gpio_power_off_cb(struct l_timeout *timeout, void *user_data)
+{
+	struct ofono_modem *modem =3D (struct ofono_modem *)user_data;
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	const uint32_t gpio_value =3D 0;
+
+	l_timeout_remove(timeout);
+	data->gpio_timeout =3D NULL;
+	l_gpio_writer_set(data->gpio, 1, &gpio_value);
+	ofono_modem_set_powered(modem, FALSE);
+}
+
 static void close_serial(struct ofono_modem *modem)
 {
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
-	uint32_t gpio_value =3D 0;
+	uint32_t gpio_value =3D 1;
 =

 	DBG("%p", modem);
 =

@@ -258,7 +272,20 @@ static void close_serial(struct ofono_modem *modem)
 	else
 		close_ngsm(modem);
 =

-	l_gpio_writer_set(data->gpio, 1, &gpio_value);
+	if (data->gpio) {
+		if (ofono_modem_get_boolean(modem, "GpioLevel")) {
+			gpio_value =3D 0;
+			l_gpio_writer_set(data->gpio, 1, &gpio_value);
+		} else {
+			l_gpio_writer_set(data->gpio, 1, &gpio_value);
+			l_timeout_remove(data->gpio_timeout);
+			data->gpio_timeout =3D l_timeout_create_ms(750,
+							gpio_power_off_cb,
+							modem, NULL);
+			return;
+		}
+	}
+
 	ofono_modem_set_powered(modem, FALSE);
 }
 =

@@ -1096,6 +1123,16 @@ static void init_timeout_cb(struct l_timeout *timeou=
t, void *user_data)
 	l_timeout_modify_ms(timeout, 500);
 }
 =

+static void gpio_power_on_cb(struct l_timeout *timeout, void *user_data)
+{
+	struct quectel_data *data =3D user_data;
+	const uint32_t gpio_value =3D 0;
+
+	l_timeout_remove(timeout);
+	data->gpio_timeout =3D NULL;
+	l_gpio_writer_set(data->gpio, 1, &gpio_value);
+}
+
 static int open_serial(struct ofono_modem *modem)
 {
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
@@ -1139,6 +1176,10 @@ static int open_serial(struct ofono_modem *modem)
 		return -EIO;
 	}
 =

+	if (data->gpio && !ofono_modem_get_boolean(modem, "GpioLevel"))
+		data->gpio_timeout =3D l_timeout_create_ms(2100, gpio_power_on_cb,
+							 data, NULL);
+
 	/*
 	 * there are three different power-up scenarios:
 	 *
diff --git a/plugins/udevng.c b/plugins/udevng.c
index db13073e..8b1943aa 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -921,6 +921,11 @@ static gboolean setup_quectel_serial(struct modem_info=
 *modem)
 	if (value)
 		ofono_modem_set_string(modem->modem, "GpioOffset", value);
 =

+	value =3D udev_device_get_property_value(info->dev,
+						"OFONO_QUECTEL_GPIO_LEVEL");
+	if (value)
+		ofono_modem_set_boolean(modem->modem, "GpioLevel", TRUE);
+
 	value =3D udev_device_get_property_value(info->dev,
 						"OFONO_QUECTEL_MUX");
 	if (value)
-- =

2.28.0

--===============0081520695009574808==--

