Content-Type: multipart/mixed; boundary="===============1146192177794123969=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH 03/11] gatppp: Add PPP server extension
Date: Mon, 21 Jun 2010 10:38:02 +0800
Message-ID: <33AB447FBD802F4E932063B962385B351F543DFF@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <201006181249.33397.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1146192177794123969==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Denis Kenzior wrote:
> Hi Zhenhua,
> =

>> 1. Add interface to set PPP server info by g_at_ppp_set_server_info.
>> 2. Pass local and peer address through IPCP handshaking.
>> ---
> =

> Its great that you're working on the PPP Server extensions.
> Can I get you to
> submit a patch taking ownership of this task?  See ofono/TODO 'PPP
> Server support'.
> =

>> +static void ipcp_generate_peer_config_options(struct ipcp_data
>> *ipcp) +{ +	guint16 len =3D 0;
>> +
>> +	FILL_IP(ipcp->req_options & REQ_OPTION_IPADDR,
>> +					IP_ADDRESS, &ipcp->peer_addr);
>> +	FILL_IP(ipcp->req_options & REQ_OPTION_DNS1,
>> +					PRIMARY_DNS_SERVER,
> &ipcp->dns1);
>> +	FILL_IP(ipcp->req_options & REQ_OPTION_DNS2,
>> +					SECONDARY_DNS_SERVER,
> &ipcp->dns2);
>> +	FILL_IP(ipcp->req_options & REQ_OPTION_NBNS1,
>> +					PRIMARY_NBNS_SERVER,
> &ipcp->nbns1);
>> +	FILL_IP(ipcp->req_options & REQ_OPTION_NBNS2,
>> +					SECONDARY_NBNS_SERVER,
> &ipcp->nbns2);
>> +
> =

> Using ipcp->req_options is the wrong thing here.  That is used
> for options
> sent in a Configure-Req.  Here you're filling in options to be
> sent in a
> Configure-Nak, Configure-Reject or a Configure-Ack.  You
> should simply be filling
> these in ipcp_rcr.  Feel free to modify the FILL_IP macro to take an
> additional destination parameter.

Okay. I will do that.

>> +	ipcp->options_len =3D len;
>> +}
>> +
>> +void ipcp_set_server_info(struct pppcp_data *pppcp, guint32
>> local_addr, +				guint32 peer_addr, +				guint32 dns1, guint32 dns2,
>> +				guint32 nbns1, guint32 nbns2)
>> +{
>> +	struct ipcp_data *ipcp =3D pppcp_get_data(pppcp);
>> +
>> +	ipcp->req_options =3D REQ_OPTION_IPADDR | REQ_OPTION_DNS1 |
>> +				REQ_OPTION_DNS2 | REQ_OPTION_NBNS1 |
>> +				REQ_OPTION_NBNS2;
>> +
>> +	ipcp->local_addr =3D local_addr;
>> +	ipcp->peer_addr =3D peer_addr;
>> +	ipcp->dns1 =3D dns1;
>> +	ipcp->dns2 =3D dns2;
>> +	ipcp->nbns1 =3D nbns1;
>> +	ipcp->nbns2 =3D nbns2;
>> +
>> +	ipcp_generate_config_options(ipcp);
> =

> Please note that this function is currently having no effect,
> you're missing a
> call to pppcp_set_local_options.  However, in the case of a server, we
> actually do not want to request DNS or NBNS, and we should
> only send our local
> address to the peer if it is non-zero.  Please note that all
> PPP modems we
> have encountered so far, do not send their local IP address in
> a Configure-
> Request.  Thus calling ipcp_set_server_info should end up
> generating an empty
> Configure-Request or with only the local IP address present.

It's confused me a little. Please correct me if I am wrong. I think PPP mod=
em should send their local IP address to peer in a Configure-Request. So cl=
ient could accept the peer address in ipcp_rcr.

In the case of a server, ipcp_set_server_info() should set local, peer, DNS=
 and NBNS info and call pppcp_set_local_options(). And server only send our=
 local address to peer in a Configure-Request.

>> +}
>> +
>>  static void ipcp_reset_config_options(struct ipcp_data *ipcp)  {
>>  	ipcp->req_options =3D REQ_OPTION_IPADDR | REQ_OPTION_DNS1 |
>>  				REQ_OPTION_DNS2 | REQ_OPTION_NBNS1 |
>>  				REQ_OPTION_NBNS2;
>> -	ipcp->ipaddr =3D 0;
>> +	ipcp->local_addr =3D 0;
> =

> In the case of a server, the local_address should not be reset.

It seems we need to add a flag in ipcp_data to indicate whether it's server=
 or not. Does it make sense?

>> +	ipcp->peer_addr =3D 0;
>>  	ipcp->dns1 =3D 0;
>>  	ipcp->dns2 =3D 0;
>>  	ipcp->nbns1 =3D 0;
>> @@ -274,11 +321,54 @@ static enum rcr_result ipcp_rcr(struct
>>  pppcp_data *pppcp, guint8 **new_options, guint16 *new_len)
>>  {
>>  	struct ppp_option_iter iter;
>> +	struct ipcp_data *ipcp =3D pppcp_get_data(pppcp);
>> +	guint32 peer_addr;
>> +	guint32 dns1;
>> +	guint32 dns2;
>> =

>>  	ppp_option_iter_init(&iter, packet);
>> =

>> -	if (ppp_option_iter_next(&iter) =3D=3D FALSE)
>> -		return RCR_ACCEPT;
> =

> Again, be careful here.  In the case of a client we should
> only accept the
> Server's IP-Address, nothing else.
> =

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
>> +		default:
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (peer_addr && dns1 && dns2) {
>> +		if (ipcp->peer_addr =3D=3D 0) {
>> +			/* RFC 1332 Section 3.3
>> +			 * Accept the value of IP address as
> peer IP address
>> +			 */
>> +			ipcp->peer_addr =3D peer_addr;
>> +
> =

> This part doesn't really make any sense, if peer is sending 0,
> he's asking us
> for an IP.

For client side, the peer server address is zero initially. So it need to a=
ccept the server address immediately.

>> +			return RCR_ACCEPT;
>> +		} else if (ipcp->peer_addr =3D=3D peer_addr)
>> +			return RCR_ACCEPT;
> =

> You need to ensure that not only the peer_addr matches, but
> also the dns /
> nbns addresses.  In our case we should be Configure-Rejecting
> the NBNS options
> and Configure-Naking DNS ones if they're set to zero or don't
> match what the
> peer is sending us.

Agree. Will update that part.

>> +	} else {
>> +		/* Peer requests us to send ip address in config options */ +		if
>> (ipcp->peer_addr) { +			struct ipcp_data *peer;
>> +
>> +			peer =3D g_memdup(ipcp, sizeof(struct ipcp_data));
>> +			ipcp_generate_peer_config_options(peer);
> =

> Yuck, please don't do this.  The main PPPCP layer will take
> care of freeing
> new_options, however you're now leaking the rest of the
> ipcp_data structure.

Ok. I will take care about it and resend the patch later.

>> +
>> +			*new_len =3D peer->options_len;
>> +			*new_options =3D peer->options;
>> +			return RCR_NAK;
>> +		}
>> +	}
>> =

>>  	/* Reject all options */
>>  	*new_len =3D packet->length - sizeof(*packet);
>> =

> =

> Regards,
> -Denis

Regards,
Zhenhua


--===============1146192177794123969==--

