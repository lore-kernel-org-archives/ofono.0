Content-Type: multipart/mixed; boundary="===============3548141598389119755=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2 2/6] gatppp: Add IPv6 CP hooks
Date: Tue, 15 Nov 2011 07:59:07 -0600
Message-ID: <4EC2702B.7030308@gmail.com>
In-Reply-To: <4EC3AF04.7030804@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3548141598389119755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

>>> +gboolean g_at_ppp_set_ipv6cp_info(GAtPPP *ppp, gboolean is_server,
>>> +                    const char *local, const char *peer);
>>
>> So for consistency sake I think we should introduce
>> g_at_ppp_set_ipv6_server_info(GAtPPP *ppp, const char *remote_prefix);
>>
>> For the local prefix, I'm leaning towards creating a new set of v6 and
>> dual-stack specific constructors:
>>
>> g_at_ppp_ipv6_new(const char *local_prefix);
>> g_at_ppp_ipv6_server_new(const char *local_prefix);
>> g_at_ppp_ipv4v6_new(const char *local_prefix);
>> g_at_ppp_ipv4v6_server_new(const char *local_ip, const char
>> *local_prefix);
>>
>> The key difference between constructors being whether to create ipcp,
>> ipv6cp or both.  We might need a _full version of the server
>> constructors as well.  I'm not entirely happy with this, so if you have
>> better ideas, I'd love to hear them.
> =

> That looks OK to me. Regarding alternatives, one would be:
> =

> enum ofono_ppp_proto {
>     OFONO_PPP_PROTO_IP     =3D 0x1,
>     OFONO_PPP_PROTO_IPV6   =3D 0x2,
>     OFONO_PPP_PROTO_IPV4V6 =3D 0x4,
> };
> =

> struct _GAtPPP {
>     [...]
>     guint8 proto;
> };
> =

> g_at_ppp_new(guint8 proto);
> =

> or/and
> =

> g_at_ppp_set_proto(GAtPPP *ppp, guint8 proto, ...);
> =

> The usage would be:
> =

> - IPv4 only:
> =

>     g_at_ppp_new(OFONO_GPRS_PROTO_IP);
> =

> - IPv6 only:
> =

>     g_at_ppp_new(OFONO_GPRS_PROTO_IPV6);
> =

> - IPv4v6, both optional, but at least one is mandatory:
> =

>     g_at_ppp_new(OFONO_GPRS_PROTO_IPV4V6);
> =

> - IPv4v6, both mandatory:
> =

>     g_at_ppp_new(OFONO_GPRS_PROTO_IPV4V6 |
>          OFONO_GPRS_PROTO_IP | OFONO_GPRS_PROTO_IPV6);
> =

> - IPv4v6, IPv4 mandatory:
> =

>     g_at_ppp_new(OFONO_GPRS_PROTO_IPV4V6 | OFONO_GPRS_PROTO_IP);
> =

> and so on.
> =

> For g_at_ppp_set_proto(GAtPPP *ppp, guint8 proto, ...) there might be
> optional parameters (one IPv4/IPv6 local address or both IPv4 and IPv6
> local addresses), depending on the need. And similarly for
> g_at_ppp_set_server_info().
> =


There are some interesting ideas here, but I want to keep the API
changes and the impact on existing code minimal for now.  This means not
touching the original API if possible.

Besides, we simply don't know if we need all this flexibility, so lets
just consider the ipv4 only, ipv6 only and both ipv4 and ipv6 being
required as use cases we want to address.

Regards,
-Denis

--===============3548141598389119755==--

