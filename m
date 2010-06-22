Content-Type: multipart/mixed; boundary="===============0390593588584666245=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH 1/5] gatppp: Add PPP server extension
Date: Tue, 22 Jun 2010 14:24:05 +0800
Message-ID: <33AB447FBD802F4E932063B962385B351F5444CD@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <201006212336.52715.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0390593588584666245==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Denis Kenzior wrote:
> Hi Zhenhua,
> =

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
>> -		return RCR_ACCEPT;
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
>> +	if (peer_addr) {
>> +		if (ipcp->peer_addr =3D=3D 0) {
>> +			/* RFC 1332 section 3.3
>> +			 * As client, accept the server IP as peer's address +			 */
>> +			ipcp->peer_addr =3D peer_addr;
>> +
>> +			return RCR_ACCEPT;
> =

> I'm still confused about this part.  As client we should
> accept server's IP
> address as long as its non-zero.  Otherwise Conf-Rej the option.

Right, initially, client know nothing about server, so client->peer_addr is=
 zero. Once client get a non-zero IP from configure option, we fill this IP=
 as peer's IP address.

Looks like this IP is exposed as gateway to Connman. Maybe I could change i=
t like:
	if (ipcp->is_server =3D=3D FALSE && ipcp->peer_addr =3D=3D 0)

>> +		} else if (ipcp->peer_addr =3D=3D peer_addr && ipcp->dns1 =3D=3D dns1
>> +				&& ipcp->nbns1 =3D=3D nbns1 &&
> ipcp->nbns2 =3D=3D nbns2)
>> +			/* As server, verify the client's info
> and then send
>> +			 * acknowledgement back
>> +			 */
>> +			return RCR_ACCEPT;
>> +	} else {
>> +		/* Client requests server to send IP/DNS/NBNS information in the
>> +		 * config options +		 */
>> +		if (ipcp->peer_addr) {
>> +			guint8 *options;
>> +			guint16 len;
>> +
>> +			options =3D
> ipcp_generate_peer_config_options(ipcp, &len);
>> +			if (!options)
>> +				goto reject;
>> +
>> +			*new_len =3D len;
>> +			*new_options =3D options;
>> +			return RCR_NAK;
>> +		}
> =

> Here we want to ensure that we nak the client's options for as
> long as the
> options don't match.  Even ipcp->peer_addr is 0 (e.g. we're allocating
> client's address via DHCP or something)

In theory, it's true. But I don't see a PPP modem without client's address =
here. Even in drivers/atmodem/gprs-context.c, we assume the PPP interface h=
as a static IP instead of dynamic one.

Anyway, I will modify this part.

> Overall I think this code path is a little too complicated.
> Can you see
> whether you can clean it up a bit?

Okay, I will try to elimiate some conditional branchs here.
 =

> Regards,
> -Denis



Regards,
Zhenhua


--===============0390593588584666245==--

