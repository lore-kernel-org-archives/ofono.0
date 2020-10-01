Content-Type: multipart/mixed; boundary="===============6914996344452906191=="
MIME-Version: 1.0
From: poeschel@lemonage.de
Subject: [PATCH v2] quectel: Power on/off with a gpio pulse
Date: Thu, 01 Oct 2020 13:42:58 +0200
Message-ID: <20201001114258.2947309-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6914996344452906191==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lars Poeschel <poeschel@lemonage.de>

Current implementation uses a gpio level of 1 for powering on quectel
modems using a gpio and a level of 0 for powering off.
This is wrong. Quectel modems use pulses for either power on and power
off. They turn on by the first pulse and turn then off by the next
pulse. The pulse length varies between different modems.
For power on the longest I could in the quectel hardware is "more than
2 seconds" from Quectel M95 Hardware Design Manual.
For Quectel EC21 this is ">=3D 100 ms".
For Quectel MC60 this is "recommended to be 100 ms".
For Quectel UC15 this is "at least 0.1 s".
For power off the four modems in question vary between a minimum pulse
length of 600-700ms.
This implements a 2100ms pulse for power on and 750ms for power off.
---
 plugins/quectel.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 6456775d..61ac906e 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -234,10 +234,21 @@ static void close_ngsm(struct ofono_modem *modem)
 		ofono_warn("Failed to restore line discipline");
 }
 =

+static gboolean gpio_power_off_cb(gpointer user_data)
+{
+	struct ofono_modem *modem =3D (struct ofono_modem *)user_data;
+	struct quectel_data *data =3D ofono_modem_get_data(modem);
+	const uint32_t gpio_value =3D 0;
+
+	l_gpio_writer_set(data->gpio, 1, &gpio_value);
+	ofono_modem_set_powered(modem, FALSE);
+	return false;
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

@@ -258,8 +269,12 @@ static void close_serial(struct ofono_modem *modem)
 	else
 		close_ngsm(modem);
 =

-	l_gpio_writer_set(data->gpio, 1, &gpio_value);
-	ofono_modem_set_powered(modem, FALSE);
+	if (data->gpio) {
+		l_gpio_writer_set(data->gpio, 1, &gpio_value);
+		g_timeout_add(750, gpio_power_off_cb, modem);
+	} else
+		ofono_modem_set_powered(modem, FALSE);
+
 }
 =

 static void dbus_hw_reply_properties(struct dbus_hw *hw)
@@ -1096,6 +1111,15 @@ static void init_timeout_cb(struct l_timeout *timeou=
t, void *user_data)
 	l_timeout_modify_ms(timeout, 500);
 }
 =

+static gboolean gpio_power_on_cb(gpointer user_data)
+{
+	struct quectel_data *data =3D user_data;
+	const uint32_t gpio_value =3D 0;
+
+	l_gpio_writer_set(data->gpio, 1, &gpio_value);
+	return false;
+}
+
 static int open_serial(struct ofono_modem *modem)
 {
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
@@ -1139,6 +1163,9 @@ static int open_serial(struct ofono_modem *modem)
 		return -EIO;
 	}
 =

+	if (data->gpio)
+		g_timeout_add(2100, gpio_power_on_cb, data);
+
 	/*
 	 * there are three different power-up scenarios:
 	 *
-- =

2.28.0

--===============6914996344452906191==--

