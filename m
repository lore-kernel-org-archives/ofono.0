Content-Type: multipart/mixed; boundary="===============0537297686606251736=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] plugins: add a new driver for Quectel UC15 modems
Date: Tue, 08 Jul 2014 08:49:14 -0500
Message-ID: <53BBF6DA.9070600@gmail.com>
In-Reply-To: <1404726887-35547-2-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0537297686606251736==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philip,

On 07/07/2014 04:54 AM, Philip Paeps wrote:
> ---
>  Makefile.am       |    3 +
>  plugins/quectel.c |  379 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 382 insertions(+)
> =


I went ahead and applied the patch, with one small fix afterwards:

<snip>

> +static void cfun_query(gboolean ok, GAtResult *result, gpointer user_dat=
a)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct quectel_data *data =3D ofono_modem_get_data(modem);
> +	GAtResultIter iter;
> +	int status;
> +
> +	DBG("ok %d", ok);
> +
> +	if (!ok)
> +		return;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (g_at_result_iter_next(&iter, "+CFUN:") =3D=3D FALSE)
> +		return;
> +
> +	g_at_result_iter_next_number(&iter, &status);
> +
> +	/*
> +	 * The modem firmware powers up in CFUN=3D1 but will respond to AT+CFUN=
=3D4
> +	 * with ERROR until some amount of time (which varies with temperature)
> +	 * passes.  Empirical evidence suggests that the firmware will report an
> +	 * unsolicited +CPIN: notification when it is ready to be useful.
> +	 *
> +	 * Work around this feature by only transitioning to CFUN=3D4 after we'=
ve
> +	 * received an unsolicited +CPIN: notification.
> +	 */
> +
> +	if (status !=3D 1) {
> +		g_at_chat_send(data->aux, "AT+CFUN=3D4", none_prefix,
> +					cfun_enable, modem, NULL);

This part doesn't match the comment above.  Feel free to send a follow
on patch to fix it.

> +		return;
> +	}
> +
> +	cfun_enable(TRUE, NULL, modem);
> +}
> +

<snip>

> +	ofono_devinfo_create(modem, OFONO_VENDOR_QUECTEL, "atmodem",
> +					data->aux);

<snip>

> +	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_QUECTEL, "atmodem",
> +					data->aux);
> +	gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_QUECTEL, "atmodem",
> +					data->modem);
> +

<snip>

> +	ofono_netreg_create(modem, OFONO_VENDOR_QUECTEL, "atmodem",
> +					data->aux);

I changed these to 0 instead of OFONO_VENDOR_QUECTEL since no vendor
specific behavior is being used in these atom drivers.

Regards,
-Denis


--===============0537297686606251736==--

