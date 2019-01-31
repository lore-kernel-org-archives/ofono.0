Content-Type: multipart/mixed; boundary="===============5059738426975758642=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] xmm7modem: chnage to assign datapath for activated
 PDP context
Date: Thu, 31 Jan 2019 12:58:52 -0600
Message-ID: <df37aefb-0629-0790-ba3a-c390417b8ba8@gmail.com>
In-Reply-To: <1548915570-4856-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5059738426975758642==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 01/31/2019 12:19 AM, Antara Borwankar wrote:
> Changed the handling of CGCONTRDP AT command reply in ifxmodem
> modem driver for XMM7MODEM vendor for assigning network interface
> to context settings and routing data over the selected path.
> ---
>   drivers/ifxmodem/gprs-context.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> =

> diff --git a/drivers/ifxmodem/gprs-context.c b/drivers/ifxmodem/gprs-cont=
ext.c
> index 7f3628b..6cadb47 100644
> --- a/drivers/ifxmodem/gprs-context.c
> +++ b/drivers/ifxmodem/gprs-context.c
> @@ -271,6 +271,9 @@ static void cgcontrdp_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
>   	const char *gw =3D NULL;
>   	const char *interface;
>   	const char *dns[3];
> +	const char *ctrlpath;
> +	const char *datapath;
> +	char buf[64];
>   =

>   	DBG("ok %d", ok);
>   =

> @@ -328,8 +331,9 @@ static void cgcontrdp_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
>   	DBG("Gateway: %s\n", gcd->gateway);
>   =

>   	interface =3D ofono_modem_get_string(modem, "NetworkInterface");
> +	ctrlpath =3D ofono_modem_get_string(modem, "CtrlPath");
> +	datapath =3D ofono_modem_get_string(modem, "DataPath");
>   =

> -	ofono_gprs_context_set_interface(gc, interface);
>   	ofono_gprs_context_set_ipv4_address(gc, gcd->address, TRUE);
>   =

>   	if (gcd->netmask[0])
> @@ -340,6 +344,15 @@ static void cgcontrdp_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
>   =

>   	ofono_gprs_context_set_ipv4_dns_servers(gc, dns);
>   =

> +	sprintf(buf, "AT+XDATACHANNEL=3D1,1,\"%s\",\"%s%u\",2,%u", ctrlpath,
> +				datapath, gcd->active_context, gcd->active_context);
> +	g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
> +	sprintf(buf, "AT+CGDATA=3D\"M-RAW_IP\",%u", gcd->active_context);
> +	g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
> +
> +	sprintf(buf, "%s\b%u", interface, gcd->active_context);

I'd have to look up the standard, but isn't using backspace like this is =

a bit dangerous.  E.g. won't the results possibly vary depending on the =

terminal set?

If there are multiple interfaces, why aren't they detected by udevng?  I =

think you need to provide a more detailed explanation of what is =

actually happening here...

> +	ofono_gprs_context_set_interface(gc, buf);
> =

Regards,
-Denis

--===============5059738426975758642==--

