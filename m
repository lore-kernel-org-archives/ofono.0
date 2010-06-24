Content-Type: multipart/mixed; boundary="===============0353738655378263831=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH 2/6] gatppp: Add PPP server extension
Date: Thu, 24 Jun 2010 14:23:52 +0800
Message-ID: <33AB447FBD802F4E932063B962385B351F5C3CDF@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <201006231819.38520.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0353738655378263831==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Denis Kenzior wrote:
> Hi Zhenhua,
> =

>> 1. Add interface to set PPP server info by g_at_ppp_set_server_info.
>> 2. Pass local and peer address through IPCP handshaking.
> =

> Ok getting pretty close now :)
> =

>> +static void ipcp_reset_server_config_options(struct ipcp_data
>> *ipcp) +{ +	ipcp->req_options =3D REQ_OPTION_IPADDR;
> =

> Might want to only request IP Addr if local_addr is not zero.
> Just like in
> set_server_info.

Ok. Local updated.
 =

>> +
>> +	ipcp_generate_config_options(ipcp);
>> +}
>> +
> =

> <snip>
> =

>> @@ -167,7 +211,7 @@ static void ipcp_rca(struct pppcp_data *pppcp,
>> =

>>  		switch (ppp_option_iter_get_type(&iter)) {
>>  		case IP_ADDRESS:
>> -			memcpy(&ipcp->ipaddr, data, 4);
>> +			memcpy(&ipcp->local_addr, data, 4);
>>  			break;
>>  		case PRIMARY_DNS_SERVER:
>>  			memcpy(&ipcp->dns1, data, 4);
> =

> You might not want to do anything here in the case of a server role.

Agree. So in case of a server role, we simply do nothing in ipcp_rca and ip=
cp_rcn_nak. Good catch.

>> @@ -204,7 +248,7 @@ static void ipcp_rcn_nak(struct pppcp_data
>>  			*pppcp,  		case IP_ADDRESS: g_print("Setting suggested ip
>>  			addr\n"); ipcp->req_options |=3D REQ_OPTION_IPADDR;
>> -			memcpy(&ipcp->ipaddr, data, 4);
>> +			memcpy(&ipcp->local_addr, data, 4);
>>  			break;
>>  		case PRIMARY_DNS_SERVER:
>>  			g_print("Setting suggested dns1\n");
> =

> Again, probably don't want to set the local_addr in the case
> of a server role.
> =

>> @@ -269,17 +313,102 @@ static void ipcp_rcn_rej(struct pppcp_data
>>  	*pppcp, pppcp_set_local_options(pppcp, ipcp->options,
>> ipcp->options_len);  } =

>> =

>> +static guint8 *ipcp_generate_peer_config_options(struct ipcp_data
>> *ipcp, +							guint16
> *new_len)
>> +{
>> +	guint8 *options;
>> +	guint16 len =3D 0;
>> +
>> +	options =3D g_try_new0(guint8, MAX_CONFIG_OPTION_SIZE); +	if
>> (!options) +		return NULL;
>> +
>> +	FILL_IP(options, TRUE, IP_ADDRESS, &ipcp->peer_addr);
>> +	FILL_IP(options, TRUE, PRIMARY_DNS_SERVER, &ipcp->dns1);
>> +	FILL_IP(options, TRUE, SECONDARY_DNS_SERVER, &ipcp->dns2);
>> +	FILL_IP(options, TRUE, PRIMARY_NBNS_SERVER, &ipcp->nbns1);
>> +	FILL_IP(options, TRUE, SECONDARY_NBNS_SERVER, &ipcp->nbns2); +
>> +	*new_len =3D MAX_CONFIG_OPTION_SIZE;
> =

> Don't use MAX_CONFIG_OPTION_SIZE, instead use len (which is
> filled properly by
> the FILL_IP macro)  Also, we shouldn't bother supporting NBNS,
> lets never
> suggest those options as a server or set them in set_server_info.

Fixed, so I have removed NBNS parameters for set_server_info() at all.

>> +
>> +	return options;
>> +}
>> +
>>  static enum rcr_result ipcp_rcr(struct pppcp_data *pppcp,
>>  					const struct
> pppcp_packet *packet,
>>  					guint8 **new_options,
> guint16 *new_len)
>>  {
>>  	struct ppp_option_iter iter;
>> +	struct ipcp_data *ipcp =3D pppcp_get_data(pppcp);
>> +	guint32 peer_addr =3D 0;
>> +	guint32 dns1 =3D 0;
>> +	guint32 dns2 =3D 0;
>> +	guint32 nbns1 =3D 0;
>> +	guint32 nbns2 =3D 0;
>> =

>>  	ppp_option_iter_init(&iter, packet);
>> =

>> -	if (ppp_option_iter_next(&iter) =3D=3D FALSE)
>> +	while (ppp_option_iter_next(&iter) =3D=3D TRUE) {
>> +		const guint8 *data =3D ppp_option_iter_get_data(&iter); +
>> +		switch (ppp_option_iter_get_type(&iter)) {
>> +		case IP_ADDRESS:
>> +			memcpy(&peer_addr, data, 4);
>> +			break;
>> +		case PRIMARY_DNS_SERVER:
>> +			memcpy(&dns1, data, 4);
>> +			break;
>> +		case SECONDARY_DNS_SERVER:
>> +			memcpy(&dns2, data, 4);
>> +			break;
>> +		case PRIMARY_NBNS_SERVER:
>> +			memcpy(&nbns1, data, 4);
>> +			break;
>> +		case SECONDARY_NBNS_SERVER:
>> +			memcpy(&nbns2, data, 4);
>> +			break;
>> +		default:
>> +			break;
>> +		}
>> +	}
>> +
> =

> As mentioned above, if Primary / Secondary NBNS server is sent
> by the client,
> we need to Conf-Rej just those options to the client.  Any
> other unrecognized
> options should also be Conf-Rejected.  The order is important
> here, read the
> spec for details.  The IP Address, DNS1/DNS2 should not be
> Conf-Rejected. =


Looks like we need more Conf-Nak than Conf-Reject in ipcp_rcr. :-)

As PPP client, actually I think we don't need to send NBNS request at all. =
It's clear that pppd client only requests IP/DNS in Conf-Req. Secondly, if =
server sent us empty Conf-Req, the client should request server IP address =
in Conf-Nak response, instead of Conf-Rej all options. Once we get local_ad=
dr from server, we return Conf-Ack in ipcp_rcr and don't request server IP =
any more.

See attached pppd.log for details.

>> +	if (ipcp->is_server) {
>> +		guint8 *options;
>> +		guint16 len;
>> +
>> +		/* Reject if we have not assign client address yet */
>> +		if (ipcp->peer_addr =3D=3D 0 && ipcp->dns1 =3D=3D 0 && ipcp->dns2 =3D=
=3D 0)
>> +			goto reject;
> =

> Actually you should be NAKing here, not Rejecting.  Reject
> means you don't
> support this option at all.

Okay.

>> +
>> +		/* Acknowledge client options if it matches with server options
>> +		 */ +		if (ipcp->peer_addr =3D=3D peer_addr &&
>> +				ipcp->dns1 =3D=3D dns1 &&
> ipcp->dns2 =3D=3D dns2 &&
>> +				ipcp->nbns1 =3D=3D nbns1 &&
> ipcp->nbns2 =3D=3D nbns2)
>> +			return RCR_ACCEPT;
>> +
>> +		/* Send client IP/DNS/NBNS information in the config options */
>> +		options =3D ipcp_generate_peer_config_options(ipcp, &len); +		if
>> (!options) +			goto reject;
>> +
>> +		*new_len =3D len;
>> +		*new_options =3D options;
>> +
>> +		return RCR_NAK;
>> +	}
>> +
>> +	/* Client */
>> +	if (peer_addr && ipcp->peer_addr =3D=3D 0) {
>> +		/* RFC 1332 section 3.3
>> +		 * As client, accept the server IP as peer's address +		 */
>> +		ipcp->peer_addr =3D peer_addr;
>> +

As client, can we just accept peer_addr as long as it's no zero, and return=
 Conf-Ack? No matter what ipcp->peer_addr is.

>>  		return RCR_ACCEPT;
>> +	}
>> =

>> +reject:
>>  	/* Reject all options */
>>  	*new_len =3D ntohs(packet->length) - sizeof(*packet);
>>  	*new_options =3D g_memdup(packet->data, *new_len);
>> @@ -317,7 +446,7 @@ struct pppcp_data *ipcp_new(GAtPPP *ppp)  	}
>> =

>>  	pppcp_set_data(pppcp, ipcp);
>> -	ipcp_reset_config_options(ipcp);
>> +	ipcp_reset_client_config_options(ipcp);
>>  	pppcp_set_local_options(pppcp, ipcp->options, ipcp->options_len);
>> =

>>  	return pppcp;
>> =

> =

> Regards,
> -Denis



Regards,
Zhenhua


--===============0353738655378263831==--

