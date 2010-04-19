Content-Type: multipart/mixed; boundary="===============6603203582341593764=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Added Wavecom modem plugin.
Date: Mon, 19 Apr 2010 16:29:37 -0500
Message-ID: <201004191629.37572.denkenz@gmail.com>
In-Reply-To: <1271705668-23970-1-git-send-email-matgnt@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6603203582341593764==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matthias,

> The Wavecom WMP100 assumes CPIN to be the final response, therefore some
>  special handling is neccessary (see
>  6d28f82dc1ccb3de3a028a88eafb96fb001c7e61). Now the vendor id
>  OFONO_VENDOR_WAVECOM is passed with all "*create" functions.

You should also set your authorship information correctly.  E.g. first + la=
st =

name.

> +	options =3D g_hash_table_new_full(g_str_hash, g_str_equal,
> +					g_free, g_free);
> +	if (!options)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; tty_opts[i]; i++) {
> +		value =3D ofono_modem_get_string(modem, tty_opts[i]);
> +
> +		if (value =3D=3D NULL)
> +			continue;
> +
> +		g_hash_table_insert(options, g_strdup(tty_opts[i]),
> +					g_strdup(value));
> +	}
> +
> +	channel =3D g_at_tty_open(device, options);

I suggest hardcoding these options (see calypso.c) unless you really want t=
o =

change them from modem.conf for some reason.

> +	value =3D ofono_modem_get_string(modem, "GsmSyntax");
> +	if (value) {
> +		if (g_str_equal(value, "V1"))
> +			syntax =3D g_at_syntax_new_gsmv1();
> +		else if (g_str_equal(value, "Permissive"))
> +			syntax =3D g_at_syntax_new_gsm_permissive();
> +		else
> +			return -EINVAL;
> +	} else {
> +		syntax =3D g_at_syntax_new_gsmv1();
> +	}

Same here, you should know whether the wavecom is 27.007 compliant or not.

> +	ofono_devinfo_create(modem, OFONO_VENDOR_WAVECOM, "atmodem", chat);
> +	ofono_sim_create(modem, OFONO_VENDOR_WAVECOM, "atmodem", chat);
> +	ofono_voicecall_create(modem, OFONO_VENDOR_WAVECOM, "atmodem", chat);

You really don't want to do that, only pass it to the place where it is =

relevant (e.g. the SIM atom.) That way we know what quirks the modem actual=
ly =

has instead of looking at all drivers just to find it has completely stock =

behavior.

Regards,
-Denis

--===============6603203582341593764==--

