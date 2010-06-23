Content-Type: multipart/mixed; boundary="===============6433129686122117857=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/6] gatppp: Add PPP server extension
Date: Wed, 23 Jun 2010 18:19:38 -0500
Message-ID: <201006231819.38520.denkenz@gmail.com>
In-Reply-To: <1277286402-22312-3-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6433129686122117857==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> 1. Add interface to set PPP server info by g_at_ppp_set_server_info.
> 2. Pass local and peer address through IPCP handshaking.

Ok getting pretty close now :)

> +static void ipcp_reset_server_config_options(struct ipcp_data *ipcp)
> +{
> +	ipcp->req_options =3D REQ_OPTION_IPADDR;

Might want to only request IP Addr if local_addr is not zero.  Just like in =

set_server_info.

> +
> +	ipcp_generate_config_options(ipcp);
> +}
> +

<snip>

> @@ -167,7 +211,7 @@ static void ipcp_rca(struct pppcp_data *pppcp,
> =

>  		switch (ppp_option_iter_get_type(&iter)) {
>  		case IP_ADDRESS:
> -			memcpy(&ipcp->ipaddr, data, 4);
> +			memcpy(&ipcp->local_addr, data, 4);
>  			break;
>  		case PRIMARY_DNS_SERVER:
>  			memcpy(&ipcp->dns1, data, 4);

You might not want to do anything here in the case of a server role.

> @@ -204,7 +248,7 @@ static void ipcp_rcn_nak(struct pppcp_data *pppcp,
>  		case IP_ADDRESS:
>  			g_print("Setting suggested ip addr\n");
>  			ipcp->req_options |=3D REQ_OPTION_IPADDR;
> -			memcpy(&ipcp->ipaddr, data, 4);
> +			memcpy(&ipcp->local_addr, data, 4);
>  			break;
>  		case PRIMARY_DNS_SERVER:
>  			g_print("Setting suggested dns1\n");

Again, probably don't want to set the local_addr in the case of a server ro=
le.

> @@ -269,17 +313,102 @@ static void ipcp_rcn_rej(struct pppcp_data *pppcp,
>  	pppcp_set_local_options(pppcp, ipcp->options, ipcp->options_len);
>  }
> =

> +static guint8 *ipcp_generate_peer_config_options(struct ipcp_data *ipcp,
> +							guint16 *new_len)
> +{
> +	guint8 *options;
> +	guint16 len =3D 0;
> +
> +	options =3D g_try_new0(guint8, MAX_CONFIG_OPTION_SIZE);
> +	if (!options)
> +		return NULL;
> +
> +	FILL_IP(options, TRUE, IP_ADDRESS, &ipcp->peer_addr);
> +	FILL_IP(options, TRUE, PRIMARY_DNS_SERVER, &ipcp->dns1);
> +	FILL_IP(options, TRUE, SECONDARY_DNS_SERVER, &ipcp->dns2);
> +	FILL_IP(options, TRUE, PRIMARY_NBNS_SERVER, &ipcp->nbns1);
> +	FILL_IP(options, TRUE, SECONDARY_NBNS_SERVER, &ipcp->nbns2);
> +
> +	*new_len =3D MAX_CONFIG_OPTION_SIZE;

Don't use MAX_CONFIG_OPTION_SIZE, instead use len (which is filled properly=
 by =

the FILL_IP macro)  Also, we shouldn't bother supporting NBNS, lets never =

suggest those options as a server or set them in set_server_info.

> +
> +	return options;
> +}
> +
>  static enum rcr_result ipcp_rcr(struct pppcp_data *pppcp,
>  					const struct pppcp_packet *packet,
>  					guint8 **new_options, guint16 *new_len)
>  {
>  	struct ppp_option_iter iter;
> +	struct ipcp_data *ipcp =3D pppcp_get_data(pppcp);
> +	guint32 peer_addr =3D 0;
> +	guint32 dns1 =3D 0;
> +	guint32 dns2 =3D 0;
> +	guint32 nbns1 =3D 0;
> +	guint32 nbns2 =3D 0;
> =

>  	ppp_option_iter_init(&iter, packet);
> =

> -	if (ppp_option_iter_next(&iter) =3D=3D FALSE)
> +	while (ppp_option_iter_next(&iter) =3D=3D TRUE) {
> +		const guint8 *data =3D ppp_option_iter_get_data(&iter);
> +
> +		switch (ppp_option_iter_get_type(&iter)) {
> +		case IP_ADDRESS:
> +			memcpy(&peer_addr, data, 4);
> +			break;
> +		case PRIMARY_DNS_SERVER:
> +			memcpy(&dns1, data, 4);
> +			break;
> +		case SECONDARY_DNS_SERVER:
> +			memcpy(&dns2, data, 4);
> +			break;
> +		case PRIMARY_NBNS_SERVER:
> +			memcpy(&nbns1, data, 4);
> +			break;
> +		case SECONDARY_NBNS_SERVER:
> +			memcpy(&nbns2, data, 4);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +

As mentioned above, if Primary / Secondary NBNS server is sent by the clien=
t, =

we need to Conf-Rej just those options to the client.  Any other unrecogniz=
ed =

options should also be Conf-Rejected.  The order is important here, read th=
e =

spec for details.  The IP Address, DNS1/DNS2 should not be Conf-Rejected.

> +	if (ipcp->is_server) {
> +		guint8 *options;
> +		guint16 len;
> +
> +		/* Reject if we have not assign client address yet */
> +		if (ipcp->peer_addr =3D=3D 0 && ipcp->dns1 =3D=3D 0 && ipcp->dns2 =3D=
=3D 0)
> +			goto reject;

Actually you should be NAKing here, not Rejecting.  Reject means you don't =

support this option at all.

> +
> +		/* Acknowledge client options if it matches with server options
> +		 */
> +		if (ipcp->peer_addr =3D=3D peer_addr &&
> +				ipcp->dns1 =3D=3D dns1 && ipcp->dns2 =3D=3D dns2 &&
> +				ipcp->nbns1 =3D=3D nbns1 && ipcp->nbns2 =3D=3D nbns2)
> +			return RCR_ACCEPT;
> +
> +		/* Send client IP/DNS/NBNS information in the config options */
> +		options =3D ipcp_generate_peer_config_options(ipcp, &len);
> +		if (!options)
> +			goto reject;
> +
> +		*new_len =3D len;
> +		*new_options =3D options;
> +
> +		return RCR_NAK;
> +	}
> +
> +	/* Client */
> +	if (peer_addr && ipcp->peer_addr =3D=3D 0) {
> +		/* RFC 1332 section 3.3
> +		 * As client, accept the server IP as peer's address
> +		 */
> +		ipcp->peer_addr =3D peer_addr;
> +
>  		return RCR_ACCEPT;
> +	}
> =

> +reject:
>  	/* Reject all options */
>  	*new_len =3D ntohs(packet->length) - sizeof(*packet);
>  	*new_options =3D g_memdup(packet->data, *new_len);
> @@ -317,7 +446,7 @@ struct pppcp_data *ipcp_new(GAtPPP *ppp)
>  	}
> =

>  	pppcp_set_data(pppcp, ipcp);
> -	ipcp_reset_config_options(ipcp);
> +	ipcp_reset_client_config_options(ipcp);
>  	pppcp_set_local_options(pppcp, ipcp->options, ipcp->options_len);
> =

>  	return pppcp;
> =


Regards,
-Denis

--===============6433129686122117857==--

