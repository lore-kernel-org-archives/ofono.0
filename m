Content-Type: multipart/mixed; boundary="===============0338415935771470353=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3] quectel: Power on/off with a gpio pulse
Date: Tue, 06 Oct 2020 15:43:32 -0500
Message-ID: <efbe040e-78e2-60a2-9910-4e9c79375384@gmail.com>
In-Reply-To: <20201006101022.3494920-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0338415935771470353==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lars,

On 10/6/20 5:10 AM, poeschel(a)lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> =

> Current implementation uses a gpio level of 1 for powering on quectel
> modems using a gpio and a level of 0 for powering off.
> Normally quectel modems are powered on or off by a gpio pulse on their
> PWR_KEY pin. They turn on by the first pulse and turn then off by the
> next pulse. The pulse length varies between different modems.
> For power on the longest I could in the quectel hardware is "more than
> 2 seconds" from Quectel M95 Hardware Design Manual.
> For Quectel EC21 this is ">=3D 100 ms".
> For Quectel MC60 this is "recommended to be 100 ms".
> For Quectel UC15 this is "at least 0.1 s".
> For power off the four modems in question vary between a minimum pulse
> length of 600-700ms.
> This implements a 2100ms pulse for power on and 750ms for power off.
> =

> If you have some special circuitry that powers your modem by gpio level
> and you need the old behaviour, you can switch to gpio level powering
> by setting environment variable OFONO_QUECTEL_GPIO_LEVEL. The gpio goes
> to high level for the modem to power on and to low level if it should
> power off.
> =

> ---
> Changes in v3:
> - switched to l_timeout_create_ms instead of g_timeout for the gpio
>    pulse
> - try to keep track of the gpio_timeout object
> - combined patch with the level patch
> ---
>   plugins/quectel.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
>   plugins/udevng.c  |  5 +++++
>   2 files changed, 48 insertions(+), 2 deletions(-)
> =


Applied with a minor tweak:

> +static void gpio_power_off_cb(struct l_timeout *timeout, void *user_data)
> +{
> +	struct ofono_modem *modem =3D (struct ofono_modem *)user_data;

This cast was not needed

> +	struct quectel_data *data =3D ofono_modem_get_data(modem);
> +	const uint32_t gpio_value =3D 0;
> +
> +	l_timeout_remove(timeout);
> +	data->gpio_timeout =3D NULL;
> +	l_gpio_writer_set(data->gpio, 1, &gpio_value);
> +	ofono_modem_set_powered(modem, FALSE);
> +}
> +

Regards,
-Denis
--===============0338415935771470353==--

