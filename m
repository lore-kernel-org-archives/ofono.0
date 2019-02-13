Content-Type: multipart/mixed; boundary="===============4922277464423778785=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] xmm7modem: change to assign datapath for activated PDP
Date: Wed, 13 Feb 2019 08:49:59 -0600
Message-ID: <b6fe8129-e54d-0dd1-f35c-c52d40a3690e@gmail.com>
In-Reply-To: <1549972331-2259-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4922277464423778785==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 02/12/2019 05:52 AM, Antara Borwankar wrote:
> Changed the handling of +CGCONTRDP AT command reply in ifxmodem
> modem driver for XMM7MODEM vendor for routing data over the
> selected path.
> ---
>   drivers/ifxmodem/gprs-context.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> =

> diff --git a/drivers/ifxmodem/gprs-context.c b/drivers/ifxmodem/gprs-cont=
ext.c
> index 7f3628b..70d10af 100644
> --- a/drivers/ifxmodem/gprs-context.c
> +++ b/drivers/ifxmodem/gprs-context.c
> @@ -269,8 +269,10 @@ static void cgcontrdp_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
>   =

>   	const char *laddrnetmask =3D NULL;
>   	const char *gw =3D NULL;
> -	const char *interface;
>   	const char *dns[3];
> +	const char *ctrlpath;
> +	const char *datapath;
> +	char buf[64];

Is this buffer large enough to hold the required AT commands?  It seems =

like it might easily overflow?

>   =

>   	DBG("ok %d", ok);
>   =

> @@ -327,9 +329,9 @@ static void cgcontrdp_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
>   	DBG("DNS2: %s\n", gcd->dns2);
>   	DBG("Gateway: %s\n", gcd->gateway);
>   =

> -	interface =3D ofono_modem_get_string(modem, "NetworkInterface");
> +	ctrlpath =3D ofono_modem_get_string(modem, "CtrlPath");
> +	datapath =3D ofono_modem_get_string(modem, "DataPath");
>   =

> -	ofono_gprs_context_set_interface(gc, interface);
>   	ofono_gprs_context_set_ipv4_address(gc, gcd->address, TRUE);
>   =

>   	if (gcd->netmask[0])
> @@ -340,6 +342,12 @@ static void cgcontrdp_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
>   =

>   	ofono_gprs_context_set_ipv4_dns_servers(gc, dns);
>   =

> +	sprintf(buf, "AT+XDATACHANNEL=3D1,1,\"%s\",\"%s%u\",2,%u", ctrlpath,
> +				datapath, gcd->active_context, gcd->active_context);

e.g. here

Also, as I mentioned previously, mapping interfaces based on =

active_context id is not a good idea.  Can we use =

ofono_gprs_context->interface for this directly somehow?

> +	g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
> +	sprintf(buf, "AT+CGDATA=3D\"M-RAW_IP\",%u", gcd->active_context);
> +	g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
> +
>   	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);

To be pedantic, since you're issuing 2 other commands, you should call =

this only once those succeed.

>   }
>   =

> =


Regards,
-Denis

--===============4922277464423778785==--

