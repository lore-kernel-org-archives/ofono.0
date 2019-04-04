Content-Type: multipart/mixed; boundary="===============7460812014049813427=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] xmm7modem: handling of IPv6 address for activated context
Date: Thu, 04 Apr 2019 11:42:27 -0500
Message-ID: <f152b013-ac5b-fa69-761c-1d6e39c85ea6@gmail.com>
In-Reply-To: <1554281174-27190-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7460812014049813427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 04/03/2019 03:46 AM, Antara Borwankar wrote:
> Handled IPv6 address after activating PDP context
> ---
>   drivers/ifxmodem/gprs-context.c | 38 ++++++++++++++++++++++++++++------=
----
>   1 file changed, 28 insertions(+), 10 deletions(-)
> =

> diff --git a/drivers/ifxmodem/gprs-context.c b/drivers/ifxmodem/gprs-cont=
ext.c
> index 6042004..2c5456b 100644
> --- a/drivers/ifxmodem/gprs-context.c
> +++ b/drivers/ifxmodem/gprs-context.c
> @@ -352,10 +352,17 @@ static void cgcontrdp_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
>   =

>   	DBG("DNS: %s, %s\n", gcd->dns1, gcd->dns2);
>   =

> -	if (!laddrnetmask || at_util_get_ipv4_address_and_netmask(laddrnetmask,
> -					gcd->address, gcd->netmask) < 0) {
> -		failed_setup(gc, NULL, TRUE);
> -		return;
> +	if (gcd->proto =3D=3D OFONO_GPRS_PROTO_IP) {
> +		if (!laddrnetmask || at_util_get_ipv4_address_and_netmask(laddrnetmask,
> +						gcd->address, gcd->netmask) < 0) {
> +			failed_setup(gc, NULL, TRUE);
> +			return;
> +		}
> +	}
> +
> +	if (gcd->proto =3D=3D OFONO_GPRS_PROTO_IPV6) {
> +		if (laddrnetmask)
> +			strncpy(gcd->address, laddrnetmask, sizeof(gcd->address));

So what +CGPIAF setting is being assumed here?  If =

IPv6_AddressFormat=3D=3D0, then aren't you also copying parts of the netmas=
k =

into gcd->address?  FYI, the core doesn't validate the ipv6 address from =

the driver and broadcasts it directly over D-Bus.

>   	}
>   =

>   	if (gw)
> @@ -373,15 +380,26 @@ static void cgcontrdp_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
>   	interface =3D ofono_gprs_context_get_interface(gc);
>   	datapath =3D get_datapath(modem, interface);
>   =

> -	ofono_gprs_context_set_ipv4_address(gc, gcd->address, TRUE);
> +	if (gcd->proto =3D=3D OFONO_GPRS_PROTO_IP) {
> +		ofono_gprs_context_set_ipv4_address(gc, gcd->address, TRUE);
>   =

> -	if (gcd->netmask[0])
> -		ofono_gprs_context_set_ipv4_netmask(gc, gcd->netmask);
> +		if (gcd->netmask[0])
> +			ofono_gprs_context_set_ipv4_netmask(gc, gcd->netmask);
>   =

> -	if (gcd->gateway[0])
> -		ofono_gprs_context_set_ipv4_gateway(gc, gcd->gateway);
> +		if (gcd->gateway[0])
> +			ofono_gprs_context_set_ipv4_gateway(gc, gcd->gateway);
>   =

> -	ofono_gprs_context_set_ipv4_dns_servers(gc, dns);
> +		ofono_gprs_context_set_ipv4_dns_servers(gc, dns);
> +	}
> +
> +	if (gcd->proto =3D=3D OFONO_GPRS_PROTO_IPV6) {
> +		ofono_gprs_context_set_ipv6_address(gc, gcd->address);
> +

What about the prefix length?

> +		if (gcd->gateway[0])
> +			ofono_gprs_context_set_ipv6_gateway(gc, gcd->gateway);
> +
> +		ofono_gprs_context_set_ipv6_dns_servers(gc, dns);
> +	}

Also, I think we're ending up with too many if statements.  They should =

be combined and the DBG statements moved into the relevant if block.

>   =

>   	snprintf(buf, sizeof(buf), "AT+XDATACHANNEL=3D1,1,\"%s\",\"%s\",2,%u",
>   			ctrlpath, datapath, gcd->active_context);
>

Regards,
-Denis

--===============7460812014049813427==--

