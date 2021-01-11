Content-Type: multipart/mixed; boundary="===============8027483754740040642=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 1/2] gemalto: add netmon driver
Date: Mon, 11 Jan 2021 13:28:58 -0600
Message-ID: <2b75d01b-123c-65d4-cdbd-01131ed8de9e@gmail.com>
In-Reply-To: <20210110194405.1994055-2-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8027483754740040642==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On 1/10/21 1:44 PM, Sergey Matyukevich wrote:
> Implement network monitoring driver for gemalto modems that
> are able to provide serving cell information and basic
> measurements using AT+CQS and AT^SMONI commands.
> ---
>   Makefile.am                         |   3 +-
>   drivers/gemaltomodem/gemaltomodem.c |   2 +
>   drivers/gemaltomodem/gemaltomodem.h |   3 +
>   drivers/gemaltomodem/netmon.c       | 609 ++++++++++++++++++++++++++++
>   4 files changed, 616 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gemaltomodem/netmon.c
> =


<snip>

> +static int gemalto_netmon_probe(struct ofono_netmon *netmon,
> +					unsigned int vendor, void *user)
> +{
> +	GAtChat *chat =3D user;
> +	struct netmon_driver_data *nmd;
> +
> +	DBG("gemalto netmon probe");
> +
> +	nmd =3D g_try_new0(struct netmon_driver_data, 1);
> +	if (nmd =3D=3D NULL)
> +		return -ENOMEM;

Feel free to use g_new0.  We have given up using g_try_new0 since these err=
ors =

don't really occur on Linux.

> +
> +	nmd->chat =3D g_at_chat_clone(chat);
> +
> +	ofono_netmon_set_data(netmon, nmd);
> +
> +	g_idle_add(gemalto_delayed_register, netmon);
> +
> +	return 0;
> +}

Other than this, LGTM.

Regards,
-Denis
--===============8027483754740040642==--

