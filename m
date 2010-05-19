Content-Type: multipart/mixed; boundary="===============6760574712348953755=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 1/2] huawei: detect SecondaryDevice which is used for
 events
Date: Wed, 19 May 2010 08:40:59 -0500
Message-ID: <201005190840.59307.denkenz@gmail.com>
In-Reply-To: <20100519140652.3163.18467.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6760574712348953755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Please keep the commit header to less than 50 lines.

> +	device =3D ofono_modem_get_string(modem, "SecondaryDevice");
> +	if (!device)
> +		return -EINVAL;

Two tabs is enough here.

> +
> +	channel =3D g_at_tty_open(device, NULL);
> +	if (!channel)
> +		return -EIO;
> +
> +	syntax =3D g_at_syntax_new_gsm_permissive();
> +	data->event =3D g_at_chat_new(channel, syntax);
> +	g_at_syntax_unref(syntax);
> +	g_io_channel_unref(channel);
> +
> +	if (!data->event)
> +		return -EIO;
> +
> +	g_at_chat_add_terminator(data->event, "COMMAND NOT SUPPORT", -1,
> +				 FALSE);

Don't mix spaces and tabs for indentation

> +
> +	if (getenv("OFONO_AT_DEBUG"))
> +		g_at_chat_set_debug(data->event, huawei_event_debug, NULL);
> +
> +

Why the extra space?

Also, this entire sequence leaks the data->chat in case the 2nd port could =
not =

be opened.  See plugins/mbm.c for an example on how to do this better.

Regards,
-Denis

--===============6760574712348953755==--

