Content-Type: multipart/mixed; boundary="===============9089475836438698209=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Add STE modem support for GPRS PDP Contexts
Date: Wed, 27 Jan 2010 14:13:27 -0600
Message-ID: <201001271413.27892.denkenz@gmail.com>
In-Reply-To: <1264536807-10462-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9089475836438698209==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>
> =

> ---
>  Makefile.am                     |    3 +-
>  drivers/stemodem/gprs-context.c |  610
>  +++++++++++++++++++++++++++++++++++++++ drivers/stemodem/stemodem.c     =
| =

>    3 +
>  drivers/stemodem/stemodem.h     |    4 +
>  plugins/ste.c                   |    2 +-
>  5 files changed, 620 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/stemodem/gprs-context.c

I have applied the patch with some major style fixes afterward.  A couple o=
f =

comments:

I have changed AT*EIAAUW handling to be just like MBM modems.  See my commi=
t =

message for details, but basically you were leaking memory here.  If my =

changes for some reason have broken something, please send an updated patch=
.  =

I can't test it here for obvious reasons :)

> +static void ste_eppsd_up_cb(gboolean ok, GAtResult *result, gpointer
>  user_data) +{
> +	if (!caif_if_create(conn->interface, conn->channel_id)) {
> +		ofono_error("Failed to create caif interface %s.",
> +			conn->interface);
> +		CALLBACK_WITH_SUCCESS(cb, NULL, FALSE, rsp.ip_address,
> +				rsp.subnet_mask, rsp.default_gateway,
> +				dns, cbd->data);
> +	} else {
> +		CALLBACK_WITH_SUCCESS(cb, conn->interface,
> +				FALSE, rsp.ip_address, rsp.subnet_mask,
> +				rsp.default_gateway, dns, cbd->data);
> +	}
> +	return;

I really don't like returning SUCCESS with a null interface in case the =

interface creation failed.  Can we return an error here and generate a cont=
ext =

deactivation command?

Regards,
-Denis

--===============9089475836438698209==--

