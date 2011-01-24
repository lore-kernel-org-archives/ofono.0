Content-Type: multipart/mixed; boundary="===============5904008683162946999=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v5] ifx: Adding modem selftest for Infineon modem
Date: Mon, 24 Jan 2011 18:47:37 +0100
Message-ID: <1295891257.1520.6.camel@aeonflux>
In-Reply-To: <1295891096-8258-1-git-send-email-robertino.benis@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5904008683162946999==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Robertino,

> Infineon modem selftest, during ifx_enable().
> Two steps trigger, with timeout. In case one
> fails, modem will not power up.

<snip>
 =

> +	flags =3D g_io_channel_get_flags(data->device) | G_IO_FLAG_NONBLOCK;
> +	g_io_channel_set_flags(data->device, flags, NULL);
> +
> +	g_io_channel_set_encoding(data->device, NULL, NULL);
> +	g_io_channel_set_buffered(data->device, FALSE);
> +

have you actually tested this patch. Your re-base of the patch is wrong
again. It will not work like this.

Regards

Marcel



--===============5904008683162946999==--

