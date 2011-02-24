Content-Type: multipart/mixed; boundary="===============1812119764252669532=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 3/6] mbmmodem: add location-reporting driver
 implementation
Date: Wed, 23 Feb 2011 18:57:23 -0600
Message-ID: <4D65ACF3.9040508@gmail.com>
In-Reply-To: <1298399715-9617-4-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1812119764252669532==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

> +static int mbm_create_data_chat(struct ofono_location_reporting *lr)
> +{
> +	struct gps_data *gd =3D ofono_location_reporting_get_data(lr);
> +	struct ofono_modem *modem;
> +	const char *gps_dev;
> +	GAtSyntax *syntax;
> +	GIOChannel *channel;
> +	int fd;
> +
> +	modem =3D ofono_location_reporting_get_modem(lr);
> +	gps_dev =3D ofono_modem_get_string(modem, "GPSDevice");
> +
> +	channel =3D g_at_tty_open(gps_dev, NULL);
> +	if (channel =3D=3D NULL)
> +		return -1;
> +
> +	syntax =3D g_at_syntax_new_gsm_permissive();
> +	gd->data_chat =3D g_at_chat_new(channel, syntax);
> +	fd =3D g_io_channel_unix_get_fd(channel);
> +
> +	g_at_syntax_unref(syntax);
> +	g_io_channel_unref(channel);
> +
> +	if (gd->data_chat =3D=3D NULL)
> +		return -1;
> +
> +	return fd;
> +}
> +

Why do you bother creating a GAtChat for the NMEA port?  It seems that a
GIOChannel or a simple fd would be enough.

Also, what happens if the channel is hupped by the modem?  Shouldn't we
have a watch in the core for that and set Enabled accordingly?

Regards,
-Denis

--===============1812119764252669532==--

