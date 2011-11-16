Content-Type: multipart/mixed; boundary="===============0351476116974810192=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCHv2 2/6] gatppp: Add IPv6 CP hooks
Date: Wed, 16 Nov 2011 14:39:32 +0200
Message-ID: <4EC3AF04.7030804@intel.com>
In-Reply-To: <4EC1D415.3040204@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0351476116974810192==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 11/15/2011 04:53 AM, Denis Kenzior wrote:
>> +	case IPV6CP_PROTO:
>> +		if (ppp->ipv6cp)
>> +			pppcp_process_packet(ppp->ipv6cp, packet, len - offset);
>> +		break;
>
> Are you sure you don't want to send a protocol reject here?

Sure, will make it so, thanks for the idea.

>> +
>> +	if (ppp->ipv6cp)
>> +		pppcp_signal_close(ppp->ipv6cp);
>
> This also looks fine, but please add a newline here

OK.

>> +gboolean g_at_ppp_set_ipv6cp_info(GAtPPP *ppp, gboolean is_server,
>> +					const char *local, const char *peer);
>
> So for consistency sake I think we should introduce
> g_at_ppp_set_ipv6_server_info(GAtPPP *ppp, const char *remote_prefix);
>
> For the local prefix, I'm leaning towards creating a new set of v6 and
> dual-stack specific constructors:
>
> g_at_ppp_ipv6_new(const char *local_prefix);
> g_at_ppp_ipv6_server_new(const char *local_prefix);
> g_at_ppp_ipv4v6_new(const char *local_prefix);
> g_at_ppp_ipv4v6_server_new(const char *local_ip, const char *local_prefix=
);
>
> The key difference between constructors being whether to create ipcp,
> ipv6cp or both.  We might need a _full version of the server
> constructors as well.  I'm not entirely happy with this, so if you have
> better ideas, I'd love to hear them.

That looks OK to me. Regarding alternatives, one would be:

enum ofono_ppp_proto {
	OFONO_PPP_PROTO_IP     =3D 0x1,
	OFONO_PPP_PROTO_IPV6   =3D 0x2,
	OFONO_PPP_PROTO_IPV4V6 =3D 0x4,
};

struct _GAtPPP {
	[...]
	guint8 proto;
};

g_at_ppp_new(guint8 proto);

or/and

g_at_ppp_set_proto(GAtPPP *ppp, guint8 proto, ...);

The usage would be:

- IPv4 only:

	g_at_ppp_new(OFONO_GPRS_PROTO_IP);

- IPv6 only:

	g_at_ppp_new(OFONO_GPRS_PROTO_IPV6);

- IPv4v6, both optional, but at least one is mandatory:

	g_at_ppp_new(OFONO_GPRS_PROTO_IPV4V6);

- IPv4v6, both mandatory:

	g_at_ppp_new(OFONO_GPRS_PROTO_IPV4V6 |
	 	OFONO_GPRS_PROTO_IP | OFONO_GPRS_PROTO_IPV6);

- IPv4v6, IPv4 mandatory:

	g_at_ppp_new(OFONO_GPRS_PROTO_IPV4V6 | OFONO_GPRS_PROTO_IP);

and so on.

For g_at_ppp_set_proto(GAtPPP *ppp, guint8 proto, ...) there might be optio=
nal =

parameters (one IPv4/IPv6 local address or both IPv4 and IPv6 local address=
es), =

depending on the need. And similarly for g_at_ppp_set_server_info().

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki


--===============0351476116974810192==--

