Content-Type: multipart/mixed; boundary="===============1498305027163178317=="
MIME-Version: 1.0
From: Lars Poeschel <poeschel@lemonage.de>
Subject: Re: [PATCH 2/2] quectel: Power on/off with a gpio pulse
Date: Wed, 30 Sep 2020 10:50:55 +0200
Message-ID: <20200930085055.jt3d2yhkhcwehlau@lem-wkst-02.lemonage>
In-Reply-To: <cc4fb8d7-b93e-3f46-2d14-078bc7967d4f@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1498305027163178317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, Sep 29, 2020 at 09:22:26AM -0500, Denis Kenzior wrote:
> > @@ -237,7 +248,7 @@ static void close_ngsm(struct ofono_modem *modem)
> >   static void close_serial(struct ofono_modem *modem)
> >   {
> >   	struct quectel_data *data =3D ofono_modem_get_data(modem);
> > -	uint32_t gpio_value =3D 0;
> > +	uint32_t gpio_value =3D 1;
> >   	DBG("%p", modem);
> > @@ -258,7 +269,13 @@ static void close_serial(struct ofono_modem *modem)
> >   	else
> >   		close_ngsm(modem);
> > -	l_gpio_writer_set(data->gpio, 1, &gpio_value);
> > +	if (data->gpio) {
> > +		l_gpio_writer_set(data->gpio, 1, &gpio_value);
> > +		usleep(750000);
> =

> usleep blocks the entire process, which is kinda bad if you have multiple
> modems / clients.  My normal rule of thumb is to NAK anything that can bl=
ock
> for longer than 50-100ms...
> =

> Can this be done using g_timeout instead?

This was indeed not the first solution I tried. But I used the l_timeout_
thing that is used all over in quectel.c. I could not get this to work
in a way I was satisfied with. When I send a SIGTERM to the ofono
process close_serial is called but the timeout_callback never fires
and thus the modem does not power off. This is why I then tried usleep
and this works reliably.
Just to be sure I tried with g_timeout and this is the same like
l_timeout. The callback is not called.
Do you have another idea ?

Patch with g_timeout is below for reference

Regards,
Lars

-- >8 --
Subject: [PATCH] quectel: Power on/off with a gpio pulse

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
 plugins/quectel.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 6456775d..9ddb15e8 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -103,6 +103,7 @@ struct quectel_data {
 	int mux_ready_count;
 	int initial_ldisc;
 	struct l_gpio_writer *gpio;
+	struct l_timeout *gpio_timeout;
 	struct l_timeout *init_timeout;
 	size_t init_count;
 	guint init_cmd;
@@ -133,6 +134,16 @@ static void quectel_debug(const char *str, void *user_=
data)
 	ofono_info("%s%s", prefix, str);
 }

+static void gpio_timeout_cb(struct l_timeout *timeout, void *user_data)
+{
+	const uint32_t gpio_value =3D 0;
+	struct quectel_data *data =3D user_data;
+
+	l_gpio_writer_set(data->gpio, 1, &gpio_value);
+	l_timeout_remove(data->gpio_timeout);
+	data->gpio_timeout =3D NULL;
+}
+
 static int quectel_probe_gpio(struct ofono_modem *modem)
 {
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
@@ -234,10 +245,20 @@ static void close_ngsm(struct ofono_modem *modem)
 		ofono_warn("Failed to restore line discipline");
 }

+static gboolean gpio_cb(gpointer user_data)
+{
+	struct l_gpio_writer *gpio =3D (struct l_gpio_writer *)user_data;
+	uint32_t gpio_value =3D 0;
+	DBG("%s", __func__);
+
+	l_gpio_writer_set(gpio, 1, &gpio_value);
+	return false;
+}
+
 static void close_serial(struct ofono_modem *modem)
 {
 	struct quectel_data *data =3D ofono_modem_get_data(modem);
-	uint32_t gpio_value =3D 0;
+	uint32_t gpio_value =3D 1;

 	DBG("%p", modem);

@@ -258,7 +279,11 @@ static void close_serial(struct ofono_modem *modem)
 	else
 		close_ngsm(modem);

-	l_gpio_writer_set(data->gpio, 1, &gpio_value);
+	if (data->gpio) {
+		l_gpio_writer_set(data->gpio, 1, &gpio_value);
+		g_timeout_add(750, gpio_cb, data->gpio);
+	}
+
 	ofono_modem_set_powered(modem, FALSE);
 }

@@ -1139,6 +1164,10 @@ static int open_serial(struct ofono_modem *modem)
 		return -EIO;
 	}

+	if (data->gpio)
+		data->gpio_timeout =3D l_timeout_create_ms(2100, gpio_timeout_cb,
+				data, NULL);
+
 	/*
 	 * there are three different power-up scenarios:
 	 *
--
2.28.0

--===============1498305027163178317==--

