Content-Type: multipart/mixed; boundary="===============5574281546866716372=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCHv2 5/6] gatppp: Add IPv6 CP connect, disconnect callbacks
Date: Thu, 17 Nov 2011 10:10:21 +0200
Message-ID: <4EC4C16D.20507@intel.com>
In-Reply-To: <4EC26C81.7010104@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5574281546866716372==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 11/15/2011 03:43 PM, Denis Kenzior wrote:
> That sounds fine, basically we need a single TUN interface to handle
> both IPv6 and IPv4 packets.  We can probably get by with simply checking
> the state of each NCP inside ppp_drop_packet on the rx side.
>
> On the tx side we most likely need to peek inside the IP packet to
> figure out and set the protocol accordingly.

OK, will make it so. Thanks for the idea!

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki

--===============5574281546866716372==--

