Content-Type: multipart/mixed; boundary="===============6599164376322891083=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v4] ifx: Adding modem selftest for Infineon modem
Date: Thu, 20 Jan 2011 05:25:41 +0100
Message-ID: <1295497541.3873.255.camel@aeonflux>
In-Reply-To: <1295462337-12110-1-git-send-email-robertino.benis@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6599164376322891083==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Robertino,

> This patch summarize changes that triggers Infineon
> modem selftest during ofono boot. Patch addresses
> issues raised by Marcel from the privious submissions.
> =

> Thank you,
> -- r.

so git works the way that it takes the subject of the email and the body
as commit messages. So you can not write private messages in the body of
an email addressed the people who review patches.

Check for yourself what happens if you store this email and use "git am"
and then "git log".

I would prefer that you use the email body to describe your patch in
detail and what happens here. If you wanna see examples then just use
"git log plugins/ifx.c" to see what we have done in the past.

Especially since you are adding two modem selftest commands without any
other explanation, it would be nice if you summarize the discussion from
the mailing list in one paragraph here.

> ---

Private comments have to be between "---" and the diffstat. Then git
will ignore them.

<snip>

>  static void setup_internal_mux(struct ofono_modem *modem)
>  {
>  	struct ifx_data *data =3D ofono_modem_get_data(modem);
> +	GIOFlags flags;
>  	int i;
>  =

>  	DBG("");
>  =

> +	flags =3D g_io_channel_get_flags(data->device) | G_IO_FLAG_NONBLOCK;
> +	g_io_channel_set_flags(data->device, flags, NULL);
> +
> +	g_io_channel_set_encoding(data->device, NULL, NULL);
> +	g_io_channel_set_buffered(data->device, FALSE);
> +

Please do me a favor and review the patch result for you submit it at
least once. This is important. If you just blindly rebase the patch,
then something like this happens. You sneak in fragments that are not
related to your patch, but come in via a different path.

If I would apply your patch then we are back to the bug fixing from
yesterday. I didn't bother with review of the rest of the patch.

Regards

Marcel



--===============6599164376322891083==--

