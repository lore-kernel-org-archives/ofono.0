Content-Type: multipart/mixed; boundary="===============5463447003484315378=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH 2/6] gatppp: Add PPP server extension
Date: Thu, 24 Jun 2010 14:26:26 +0800
Message-ID: <33AB447FBD802F4E932063B962385B351F5C3CF3@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <33AB447FBD802F4E932063B962385B351F5C3CDF@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5463447003484315378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Zhang, Zhenhua wrote:
> Hi Denis,
> =

>> As mentioned above, if Primary / Secondary NBNS server is sent
>> by the client,
>> we need to Conf-Rej just those options to the client.  Any
>> other unrecognized
>> options should also be Conf-Rejected.  The order is important
>> here, read the
>> spec for details.  The IP Address, DNS1/DNS2 should not be
>> Conf-Rejected.
> =

> Looks like we need more Conf-Nak than Conf-Reject in ipcp_rcr. :-)
> =

> As PPP client, actually I think we don't need to send NBNS
> request at all. It's clear that pppd client only requests
> IP/DNS in Conf-Req. Secondly, if server sent us empty
> Conf-Req, the client should request server IP address in
> Conf-Nak response, instead of Conf-Rej all options. Once we
> get local_addr from server, we return Conf-Ack in ipcp_rcr and
> don't request server IP any more.
> =

> See attached pppd.log for details.

Ops, forgot the attachment. Attached again.
 =

>>> +	if (ipcp->is_server) {
>>> +		guint8 *options;
>>> +		guint16 len;
>>> +
>>> +		/* Reject if we have not assign client address yet */
>>> +		if (ipcp->peer_addr =3D=3D 0 && ipcp->dns1 =3D=3D 0 && ipcp->dns2 =
=3D=3D 0)
>>> +			goto reject;
>> =

>> Actually you should be NAKing here, not Rejecting.  Reject
>> means you don't
>> support this option at all.
> =

> Okay.
> =

>>> +
>>> +		/* Acknowledge client options if it matches with server options
>>> +		 */ +		if (ipcp->peer_addr =3D=3D peer_addr &&
>>> +				ipcp->dns1 =3D=3D dns1 &&
>> ipcp->dns2 =3D=3D dns2 &&
>>> +				ipcp->nbns1 =3D=3D nbns1 &&
>> ipcp->nbns2 =3D=3D nbns2)
>>> +			return RCR_ACCEPT;
>>> +
>>> +		/* Send client IP/DNS/NBNS information in the config options */
>>> +		options =3D
> ipcp_generate_peer_config_options(ipcp, &len); +		if
>>> (!options) +			goto reject;
>>> +
>>> +		*new_len =3D len;
>>> +		*new_options =3D options;
>>> +
>>> +		return RCR_NAK;
>>> +	}
>>> +
>>> +	/* Client */
>>> +	if (peer_addr && ipcp->peer_addr =3D=3D 0) {
>>> +		/* RFC 1332 section 3.3
>>> +		 * As client, accept the server IP as peer's address +		 */
>>> +		ipcp->peer_addr =3D peer_addr;
>>> +
> =

> As client, can we just accept peer_addr as long as it's no
> zero, and return Conf-Ack? No matter what ipcp->peer_addr is.
> =

>>>  		return RCR_ACCEPT;
>>> +	}
>>> =

>>> +reject:
>>>  	/* Reject all options */
>>>  	*new_len =3D ntohs(packet->length) - sizeof(*packet);
>>>  	*new_options =3D g_memdup(packet->data, *new_len);
>>> @@ -317,7 +446,7 @@ struct pppcp_data *ipcp_new(GAtPPP *ppp)  	}
>>> =

>>>  	pppcp_set_data(pppcp, ipcp);
>>> -	ipcp_reset_config_options(ipcp);
>>> +	ipcp_reset_client_config_options(ipcp);
>>>  	pppcp_set_local_options(pppcp, ipcp->options, ipcp->options_len);
>>> =

>>>  	return pppcp;
>>> =

>> =

>> Regards,
>> -Denis
> =

> =

> =

> Regards,
> Zhenhua
> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono



Regards,
Zhenhua


--===============5463447003484315378==
Content-Type: application/octet-stream
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pppd.log"

cHBwZFs4NzAxXTogc2VudCBbSVBDUCBDb25mUmVxIGlkPTB4MSA8Y29tcHJlc3MgVkogMGYgMDE+
IDxhZGRyIDAuMC4wLjA+IDxtcy1kbnMxIDAuMC4wLjA+IDxtcy1kbnMyIDAuMC4wLjA+XQpwcHBk
Wzg3MDFdOiByY3ZkIFtMQ1AgUHJvdFJlaiBpZD0weDEgODAgZmQgMDEgMDEgMDAgMGYgMWEgMDQg
NzggMDAgMTggMDQgNzggMDAgMTUgMDMgMmZdCnBwcGRbODcwMV06IFByb3RvY29sLVJlamVjdCBm
b3IgJ0NvbXByZXNzaW9uIENvbnRyb2wgUHJvdG9jb2wnICgweDgwZmQpIHJlY2VpdmVkCnBwcGRb
ODcwMV06IHJjdmQgW0lQQ1AgQ29uZlJlcSBpZD0weDFdCnBwcGRbODcwMV06IHNlbnQgW0lQQ1Ag
Q29uZk5hayBpZD0weDEgPGFkZHIgMC4wLjAuMD5dCnBwcGRbODcwMV06IHJjdmQgW0lQQ1AgQ29u
Zk5hayBpZD0weDEgPGFkZHIgMTAuODUuMTUuMTQyPiA8bXMtZG5zMSAyMTEuMTM2LjExMi41MD4g
PG1zLWRuczIgMjExLjEzNi4yMC4yMDM+XQpwcHBkWzg3MDFdOiBzZW50IFtJUENQIENvbmZSZXEg
aWQ9MHgyIDxjb21wcmVzcyBWSiAwZiAwMT4gPGFkZHIgMTAuODUuMTUuMTQyPiA8bXMtZG5zMSAy
MTEuMTM2LjExMi41MD4gPG1zLWRuczIgMjExLjEzNi4yMC4yMDM+XQpwcHBkWzg3MDFdOiByY3Zk
IFtJUENQIENvbmZSZXEgaWQ9MHgyXQpwcHBkWzg3MDFdOiBzZW50IFtJUENQIENvbmZBY2sgaWQ9
MHgyXQpwcHBkWzg3MDFdOiByY3ZkIFtJUENQIENvbmZBY2sgaWQ9MHgyIDxjb21wcmVzcyBWSiAw
ZiAwMT4gPGFkZHIgMTAuODUuMTUuMTQyPiA8bXMtZG5zMSAyMTEuMTM2LjExMi41MD4gPG1zLWRu
czIgMjExLjEzNi4yMC4yMDM+XQpwcHBkWzg3MDFdOiBDb3VsZCBub3QgZGV0ZXJtaW5lIHJlbW90
ZSBJUCBhZGRyZXNzOiBkZWZhdWx0aW5nIHRvIDEwLjY0LjY0LjY0CnBwcGRbODcwMV06IG5vdCBy
ZXBsYWNpbmcgZXhpc3RpbmcgZGVmYXVsdCByb3V0ZSB2aWEgMTAuMjM5LjIwLjEKcHBwZFs4NzAx
XTogQ2Fubm90IGRldGVybWluZSBldGhlcm5ldCBhZGRyZXNzIGZvciBwcm94eSBBUlAKcHBwZFs4
NzAxXTogbG9jYWwgIElQIGFkZHJlc3MgMTAuODUuMTUuMTQyCnBwcGRbODcwMV06IHJlbW90ZSBJ
UCBhZGRyZXNzIDEwLjY0LjY0LjY0CnBwcGRbODcwMV06IHByaW1hcnkgICBETlMgYWRkcmVzcyAy
MTEuMTM2LjExMi41MApwcHBkWzg3MDFdOiBzZWNvbmRhcnkgRE5TIGFkZHJlc3MgMjExLjEzNi4y
MC4yMDMKcHBwZFs4NzAxXTogU2NyaXB0IC9ldGMvcHBwL2lwLXVwIHN0YXJ0ZWQgKHBpZCA4NzEw
KQpwcHBkWzg3MDFdOiBTY3JpcHQgL2V0Yy9wcHAvaXAtdXAgZmluaXNoZWQgKHBpZCA4NzEwKSwg
c3RhdHVzID0gMHgwCgoKCg==

--===============5463447003484315378==--

