Content-Type: multipart/mixed; boundary="===============6149938128962328551=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: About ppp_receive()
Date: Tue, 24 Aug 2010 21:56:34 -0500
Message-ID: <4C748662.2080605@gmail.com>
In-Reply-To: <4C747D3B.1000407@neusoft.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6149938128962328551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Steven,

>>> But some carriers, like China Telecom or Sprint Network etc, will
>>> support the full configuration
>>> options(Magic-Number,Protocol-Field-Compression,Address-and-Control-Fie=
ld-Compression),
>>>
>>> So if PFC option is used ,our code will got wrong with ppp_receive().
>>

We explicitly do not advertise capability to receive PFC or ACFC
packets.  If the remote peer PPP stack is compliant it should not be
sending such packets in the first place.

Are you saying you're working with a PPP stack that is not compliant and
not honoring our request not to send ACFC or PFC packets?

> =

> anyway, if we want to implement a full PPP stack, we have a long way to g=
o.
> =


That's the point, we actually do not want to implement a full PPP stack.
 Only enough to talk to the relatively unsophisticated PPP stacks
running inside the modem firmware.  Remember, PPP is simply used host to
modem.  It is not used over the air.

Regards,
-Denis

--===============6149938128962328551==--

