Content-Type: multipart/mixed; boundary="===============0625821299417846453=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] plugins: add a new driver for Quectel UC15 modules
Date: Tue, 24 Jun 2014 12:41:45 -0500
Message-ID: <53A9B859.9040007@gmail.com>
In-Reply-To: <1403604522-22645-4-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0625821299417846453==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philip,

<snip>

> +
> +static void verify_enable(gboolean ok, GAtResult *result, gpointer user_=
data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct quectel_data *data =3D ofono_modem_get_data(modem);
> +
> +	if (ok) {
> +		ofono_modem_set_powered(modem, TRUE);
> +		g_at_chat_send(data->modem, "AT&C0", NULL, NULL, NULL, NULL);
> +		g_at_chat_send(data->aux, "AT&C0", NULL, NULL, NULL, NULL);

Why do you do send AT&C0 here?  Can it be done earlier?

Any reason for checking that CFUN succeeded?  If so, then it might be a
good idea to document that in comments / commit description.

What if it failed?  Are you relying on the core timeout mechanisms?

> +	}
> +}
> +
> +static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_da=
ta)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct quectel_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("ok %d (tried %d times)", (int)ok, data->enable_tries);

This cast seems unnecessary

> +
> +	if (!ok) {
> +		if (data->enable_tries > MAX_RETRIES) {
> +			g_at_chat_unref(data->aux);
> +			data->aux =3D NULL;
> +			g_at_chat_unref(data->modem);
> +			data->modem =3D NULL;
> +			ofono_modem_set_powered(modem, FALSE);
> +			DBG("modem won't enable - giving up");
> +		}
> +		goto retry;

Is the timer still running in case MAX_RETRIES is reached?  In general
we prefer using single-shot timers and re-starting them if the command
fails.  Certain commands might take several seconds to return on some
hardware.

> +	}
> +
> +	g_at_chat_send(data->aux, "AT+CPIN?", NULL, verify_enable,
> +					modem, NULL);

Using prefixes is a good idea, otherwise any unsolicited notifications
will be missed.  git show 35feae07e50f89ea3c42566c765f501ec768bd44 for
an example of what might happen.

> +retry:
> +	data->enable_tries++;
> +}
> +
> +static gboolean quectel_start(gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct quectel_data *data =3D ofono_modem_get_data(modem);
> +
> +	if (ofono_modem_get_powered(modem) =3D=3D FALSE) {
> +		g_at_chat_send(data->aux, "AT+CFUN=3D1", NULL, cfun_enable,
> +					modem, NULL);
> +		return TRUE;
> +	}
> +
> +	data->enable_timer =3D 0;
> +
> +	return FALSE;
> +}
> +
> +static int quectel_enable(struct ofono_modem *modem)
> +{
> +	struct quectel_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	data->modem =3D open_device(modem, "Modem", "Modem: ");
> +	if (data->modem =3D=3D NULL)
> +		return -EINVAL;
> +
> +	data->aux =3D open_device(modem, "Aux", "Aux: ");
> +	if (data->aux =3D=3D NULL) {
> +		g_at_chat_unref(data->modem);
> +		data->modem =3D NULL;
> +		return -EIO;
> +	}
> +	g_at_chat_set_slave(data->modem, data->aux);
> +
> +	g_at_chat_send(data->modem, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NULL);
> +	g_at_chat_send(data->aux, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NULL);
> +
> +	/* Give the modem a bit more time to power up completely. */
> +	data->enable_tries =3D 0;
> +	data->enable_timer =3D g_timeout_add_seconds(RESET_DELAY,
> +					quectel_start, modem);

Is this delay always necessary?  enable() is called in other situations
besides a hot-plugging...

> +
> +	return -EINPROGRESS;
> +}
> +
> +static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_d=
ata)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct quectel_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("");
> +
> +	g_at_chat_unref(data->aux);
> +	data->aux =3D NULL;
> +
> +	if (ok)
> +		ofono_modem_set_powered(modem, FALSE);
> +}
> +
> +static int quectel_disable(struct ofono_modem *modem)
> +{
> +	struct quectel_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	/* Prevent a race with cfun_start() retries. */
> +	if (data->enable_timer)
> +		g_source_remove(data->enable_timer);
> +
> +	g_at_chat_cancel_all(data->modem);
> +	g_at_chat_unregister_all(data->modem);
> +
> +	g_at_chat_unref(data->modem);
> +	data->modem =3D NULL;
> +
> +	g_at_chat_cancel_all(data->aux);
> +	g_at_chat_unregister_all(data->aux);
> +
> +	g_at_chat_send(data->aux, "AT+CFUN=3D0", NULL,
> +					cfun_disable, modem, NULL);

What behavior does this modem exhibit when using CFUN=3D0?  Many devices
jump off the USB bus when this is sent.  Hence why most drivers use CFUN=3D=
4.

> +
> +	return -EINPROGRESS;
> +}
> +

Regards,
-Denis


--===============0625821299417846453==--

