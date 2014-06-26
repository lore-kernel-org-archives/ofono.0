Content-Type: multipart/mixed; boundary="===============6213091591307717591=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/6] plugins: new driver for u-blox SARA-U270 modems
Date: Thu, 26 Jun 2014 09:29:51 -0500
Message-ID: <53AC2E5F.4010100@gmail.com>
In-Reply-To: <1403629813-62204-4-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6213091591307717591==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philip,

> +static void ublox_remove(struct ofono_modem *modem)
> +{
> +	struct ublox_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	ofono_modem_set_data(modem, NULL);
> +	g_at_chat_unref(data->aux);

Any reason data->modem is not being unrefed? e.g in the case of hot-unplug?

> +	g_free(data);
> +}
> +
> +static GAtChat *open_device(struct ofono_modem *modem,
> +				const char *key, char *debug)
> +{
> +	const char *device;
> +	GAtSyntax *syntax;
> +	GIOChannel *channel;
> +	GAtChat *chat;
> +
> +	device =3D ofono_modem_get_string(modem, key);
> +	if (device =3D=3D NULL)
> +		return NULL;
> +
> +	DBG("%s %s", key, device);
> +
> +	channel =3D g_at_tty_open(device, NULL);
> +	if (channel =3D=3D NULL)
> +		return NULL;
> +
> +	syntax =3D g_at_syntax_new_gsm_permissive();
> +	chat =3D g_at_chat_new(channel, syntax);
> +	g_at_syntax_unref(syntax);
> +
> +	g_io_channel_unref(channel);
> +
> +	if (chat =3D=3D NULL)
> +		return NULL;
> +
> +	if (getenv("OFONO_AT_DEBUG"))
> +		g_at_chat_set_debug(chat, ublox_debug, debug);
> +
> +	return chat;
> +}
> +
> +

Please remove one whitespace.  Our coding style likes to use a single
empty line to separate functions.

> +static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_da=
ta)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct ublox_data * data =3D ofono_modem_get_data(modem);
> +
> +	DBG("ok %d", (int)ok);

No need to cast

> +
> +	if (!ok) {
> +		g_at_chat_unref(data->aux);
> +		data->aux =3D NULL;
> +		g_at_chat_unref(data->modem);
> +		data->modem =3D NULL;
> +	}
> +
> +	ofono_modem_set_powered(modem, TRUE);
> +
> +	g_at_chat_send(data->modem, "AT&C0", NULL, NULL, NULL, NULL);
> +	g_at_chat_send(data->aux, "AT&C0", NULL, NULL, NULL, NULL);

Might want to use prefixes here

> +}
> +
> +static int ublox_enable(struct ofono_modem *modem)
> +{
> +	struct ublox_data *data =3D ofono_modem_get_data(modem);
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
> +	g_at_chat_send(data->aux, "AT+CFUN=3D1", NULL, cfun_enable,
> +					modem, NULL);

Prefix should probably be used.  Also, should this be CFUN=3D4 and not 1?
 enable() callback should be putting the modem in the SIM powered, RX/TX
off mode (e.g. Offline).

> +
> +	return -EINPROGRESS;
> +}
> +
> +static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_d=
ata)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct ublox_data *data =3D ofono_modem_get_data(modem);
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
> +static int ublox_disable(struct ofono_modem *modem)
> +{
> +	struct ublox_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	g_at_chat_cancel_all(data->modem);
> +	g_at_chat_unregister_all(data->modem);
> +	g_at_chat_unref(data->modem);
> +	data->modem =3D NULL;
> +
> +	g_at_chat_cancel_all(data->aux);
> +	g_at_chat_unregister_all(data->aux);
> +
> +	g_at_chat_send(data->aux, "AT+CFUN=3D0", NULL,
> +					cfun_disable, modem, NULL);

This modem doesn't jump off the bus on CFUN=3D0, right?

> +
> +	return -EINPROGRESS;
> +}
> +

<snip>

Regards,
-Denis


--===============6213091591307717591==--

