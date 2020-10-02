Content-Type: multipart/mixed; boundary="===============3565035862382236988=="
MIME-Version: 1.0
From: poeschel@lemonage.de
Subject: [PATCH] quectel: Possibility to switch power by gpio level
Date: Fri, 02 Oct 2020 14:49:10 +0200
Message-ID: <20201002124910.3074242-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3565035862382236988==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lars Poeschel <poeschel@lemonage.de>

This does apply on top of my previous patch:
[PATCH v2] quectel: Power on/off with a gpio pulse

-- >8 --
Subject: [PATCH] quectel: Possibility to switch power by gpio level

Normally quectel modems are powered on or off by a gpio pulse on their
PWR_KEY pin.
If you have some special circuitry that powers your modem by gpio level
then this here is for you. You can switch to level behaviour by setting
environment variable OFONO_QUECTEL_GPIO_LEVEL. The gpio goes to high
level for the modem to power on and to low level if it should power off.
---
 plugins/quectel.c | 17 ++++++++++++-----
 plugins/udevng.c  |  5 +++++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 6ab1d6fd..d4a49555 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -271,10 +271,17 @@ static void close_serial(struct ofono_modem *modem)
 		close_ngsm(modem);
 =

 	if (data->gpio) {
-		l_gpio_writer_set(data->gpio, 1, &gpio_value);
-		g_timeout_add(750, gpio_power_off_cb, modem);
-	} else
-		ofono_modem_set_powered(modem, FALSE);
+		if (ofono_modem_get_boolean(modem, "GpioLevel")) {
+			gpio_value =3D 0;
+			l_gpio_writer_set(data->gpio, 1, &gpio_value);
+		} else {
+			l_gpio_writer_set(data->gpio, 1, &gpio_value);
+			g_timeout_add(750, gpio_power_off_cb, modem);
+			return;
+		}
+	}
+
+	ofono_modem_set_powered(modem, FALSE);
 =

 }
 =

@@ -1164,7 +1171,7 @@ static int open_serial(struct ofono_modem *modem)
 		return -EIO;
 	}
 =

-	if (data->gpio)
+	if (data->gpio && !ofono_modem_get_boolean(modem, "GpioLevel"))
 		g_timeout_add(2100, gpio_power_on_cb, data);
 =

 	/*
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

--===============3565035862382236988==--

