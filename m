Content-Type: multipart/mixed; boundary="===============4915231130957502166=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] quectel: Power on/off with a gpio pulse
Date: Tue, 29 Sep 2020 09:22:26 -0500
Message-ID: <cc4fb8d7-b93e-3f46-2d14-078bc7967d4f@gmail.com>
In-Reply-To: <20200924103806.2518502-2-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4915231130957502166==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lars,

On 9/24/20 5:38 AM, poeschel(a)lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> =

> Current implementation uses a gpio level of 1 for powering on quectel
> modems using a gpio and a level of 0 for powering off.
> This is wrong. Quectel modems use pulses for either power on and power
> off. They turn on by the first pulse and turn then off by the next
> pulse. The pulse length varies between different modems.
> For power on the longest I could in the quectel hardware is "more than
> 2 seconds" from Quectel M95 Hardware Design Manual.
> For Quectel EC21 this is ">=3D 100 ms".
> For Quectel MC60 this is "recommended to be 100 ms".
> For Quectel UC15 this is "at least 0.1 s".
> For power off the four modems in question vary between a minimum pulse
> length of 600-700ms.
> This implements a 2100ms pulse for power on and 750ms for power off.
> ---
>   plugins/quectel.c | 25 +++++++++++++++++++++++--
>   1 file changed, 23 insertions(+), 2 deletions(-)
> =

> diff --git a/plugins/quectel.c b/plugins/quectel.c
> index 6456775d..1d8da528 100644
> --- a/plugins/quectel.c
> +++ b/plugins/quectel.c
> @@ -103,6 +103,7 @@ struct quectel_data {
>   	int mux_ready_count;
>   	int initial_ldisc;
>   	struct l_gpio_writer *gpio;
> +	struct l_timeout *gpio_timeout;
>   	struct l_timeout *init_timeout;
>   	size_t init_count;
>   	guint init_cmd;
> @@ -133,6 +134,16 @@ static void quectel_debug(const char *str, void *use=
r_data)
>   	ofono_info("%s%s", prefix, str);
>   }
>   =

> +static void gpio_timeout_cb(struct l_timeout *timeout, void *user_data)
> +{
> +	const uint32_t gpio_value =3D 0;
> +	struct quectel_data *data =3D user_data;
> +
> +	l_gpio_writer_set(data->gpio, 1, &gpio_value);
> +	l_timeout_remove(data->gpio_timeout);
> +	data->gpio_timeout =3D NULL;
> +}
> +
>   static int quectel_probe_gpio(struct ofono_modem *modem)
>   {
>   	struct quectel_data *data =3D ofono_modem_get_data(modem);
> @@ -237,7 +248,7 @@ static void close_ngsm(struct ofono_modem *modem)
>   static void close_serial(struct ofono_modem *modem)
>   {
>   	struct quectel_data *data =3D ofono_modem_get_data(modem);
> -	uint32_t gpio_value =3D 0;
> +	uint32_t gpio_value =3D 1;
>   =

>   	DBG("%p", modem);
>   =

> @@ -258,7 +269,13 @@ static void close_serial(struct ofono_modem *modem)
>   	else
>   		close_ngsm(modem);
>   =

> -	l_gpio_writer_set(data->gpio, 1, &gpio_value);
> +	if (data->gpio) {
> +		l_gpio_writer_set(data->gpio, 1, &gpio_value);
> +		usleep(750000);

usleep blocks the entire process, which is kinda bad if you have multiple m=
odems =

/ clients.  My normal rule of thumb is to NAK anything that can block for l=
onger =

than 50-100ms...

Can this be done using g_timeout instead?

> +		gpio_value =3D 0;
> +		l_gpio_writer_set(data->gpio, 1, &gpio_value);
> +	}
> +
>   	ofono_modem_set_powered(modem, FALSE);
>   }
>   =

> @@ -1139,6 +1156,10 @@ static int open_serial(struct ofono_modem *modem)
>   		return -EIO;
>   	}
>   =

> +	if (data->gpio)
> +		data->gpio_timeout =3D l_timeout_create_ms(2100, gpio_timeout_cb,
> +				data, NULL);
> +
>   	/*
>   	 * there are three different power-up scenarios:
>   	 *
> =


Regards,
-Denis
--===============4915231130957502166==--

