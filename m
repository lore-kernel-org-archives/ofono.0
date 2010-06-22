Content-Type: multipart/mixed; boundary="===============7609509339802290382=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] gatppp: Add PPP server extension
Date: Mon, 21 Jun 2010 23:36:52 -0500
Message-ID: <201006212336.52715.denkenz@gmail.com>
In-Reply-To: <1277113682-17510-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7609509339802290382==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

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
> -		return RCR_ACCEPT;
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
> +	if (peer_addr) {
> +		if (ipcp->peer_addr =3D=3D 0) {
> +			/* RFC 1332 section 3.3
> +			 * As client, accept the server IP as peer's address
> +			 */
> +			ipcp->peer_addr =3D peer_addr;
> +
> +			return RCR_ACCEPT;

I'm still confused about this part.  As client we should accept server's IP =

address as long as its non-zero.  Otherwise Conf-Rej the option.

> +		} else if (ipcp->peer_addr =3D=3D peer_addr && ipcp->dns1 =3D=3D dns1
> +				&& ipcp->nbns1 =3D=3D nbns1 && ipcp->nbns2 =3D=3D nbns2)
> +			/* As server, verify the client's info and then send
> +			 * acknowledgement back
> +			 */
> +			return RCR_ACCEPT;
> +	} else {
> +		/* Client requests server to send IP/DNS/NBNS information in the
> +		 * config options
> +		 */
> +		if (ipcp->peer_addr) {
> +			guint8 *options;
> +			guint16 len;
> +
> +			options =3D ipcp_generate_peer_config_options(ipcp, &len);
> +			if (!options)
> +				goto reject;
> +
> +			*new_len =3D len;
> +			*new_options =3D options;
> +			return RCR_NAK;
> +		}

Here we want to ensure that we nak the client's options for as long as the =

options don't match.  Even ipcp->peer_addr is 0 (e.g. we're allocating =

client's address via DHCP or something)

Overall I think this code path is a little too complicated.  Can you see =

whether you can clean it up a bit?

Regards,
-Denis

--===============7609509339802290382==--

