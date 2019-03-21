Content-Type: multipart/mixed; boundary="===============4822693987893522665=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] xmm7modem: handling of IPv6 address for activated context
Date: Wed, 20 Mar 2019 20:28:36 -0500
Message-ID: <410132eb-c2c3-38aa-e9fa-aba0514085f5@gmail.com>
In-Reply-To: <1553073329-32420-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4822693987893522665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 03/20/2019 04:15 AM, Antara Borwankar wrote:
> Handled IPv6 address after activating PDP context
> ---
>   drivers/ifxmodem/gprs-context.c | 33 +++++++++++++++++++++++----------
>   1 file changed, 23 insertions(+), 10 deletions(-)
> =

> diff --git a/drivers/ifxmodem/gprs-context.c b/drivers/ifxmodem/gprs-cont=
ext.c
> index 6042004..55d72a6 100644
> --- a/drivers/ifxmodem/gprs-context.c
> +++ b/drivers/ifxmodem/gprs-context.c
> @@ -352,10 +352,12 @@ static void cgcontrdp_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
>   =

>   	DBG("DNS: %s, %s\n", gcd->dns1, gcd->dns2);
>   =

> -	if (!laddrnetmask || at_util_get_ipv4_address_and_netmask(laddrnetmask,
> -					gcd->address, gcd->netmask) < 0) {
> -		failed_setup(gc, NULL, TRUE);
> -		return;
> +	if(gcd->proto =3D=3D OFONO_GPRS_PROTO_IP) {

There really should be a space after 'if' here.

> +		if (!laddrnetmask || at_util_get_ipv4_address_and_netmask(laddrnetmask,
> +						gcd->address, gcd->netmask) < 0) {
> +			failed_setup(gc, NULL, TRUE);
> +			return;
> +		}
>   	}
>   =

>   	if (gw)
> @@ -373,15 +375,26 @@ static void cgcontrdp_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
>   	interface =3D ofono_gprs_context_get_interface(gc);
>   	datapath =3D get_datapath(modem, interface);
>   =

> -	ofono_gprs_context_set_ipv4_address(gc, gcd->address, TRUE);
> +	if(gcd->proto =3D=3D OFONO_GPRS_PROTO_IP) {

And here

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
> +	if(gcd->proto =3D=3D OFONO_GPRS_PROTO_IPV6) {
> +		ofono_gprs_context_set_ipv6_address(gc, gcd->address);

So I'm not sure I understand what is happening here.  gcd->address is =

only set when gcd->proto is OFONO_GPRS_PROTO_IP.  E.g. when it is =

extracted by at_util_get_ipv4_address_and_netmask.  How are you =

obtaining it for IPV6?

> +
> +		if (gcd->gateway[0])
> +			ofono_gprs_context_set_ipv6_gateway(gc, gcd->gateway);
> +
> +		ofono_gprs_context_set_ipv6_dns_servers(gc, dns);
> +	}
>   =

>   	snprintf(buf, sizeof(buf), "AT+XDATACHANNEL=3D1,1,\"%s\",\"%s\",2,%u",
>   			ctrlpath, datapath, gcd->active_context);
> =


Regards,
-Denis

--===============4822693987893522665==--

