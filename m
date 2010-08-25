Content-Type: multipart/mixed; boundary="===============4018868166537070164=="
MIME-Version: 1.0
From: Steven <liu-dj@neusoft.com>
Subject: Re: About ppp_receive()
Date: Wed, 25 Aug 2010 11:22:59 +0800
Message-ID: <4C748C93.1000401@neusoft.com>
In-Reply-To: <4C748662.2080605@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4018868166537070164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis Kenzior wrote:
> Hi Steven,
> =

>>>> But some carriers, like China Telecom or Sprint Network etc, will
>>>> support the full configuration
>>>> options(Magic-Number,Protocol-Field-Compression,Address-and-Control-Fi=
eld-Compression),
>>>>
>>>> So if PFC option is used ,our code will got wrong with ppp_receive().
> =

> We explicitly do not advertise capability to receive PFC or ACFC
> packets.  If the remote peer PPP stack is compliant it should not be
> sending such packets in the first place.

Yes,We do not advertise capability to receive PFC or ACFC, just like i =

have said

 >>>In our current source code, because we only negotiate two
 >>> configuration options - REQ_OPTION_MRU and REQ_OPTION_ACCM. so it's
 >>> okey for our PPP stack.

> =

> Are you saying you're working with a PPP stack that is not compliant and
> not honoring our request not to send ACFC or PFC packets?
> =


NO, just as the above have said ,we only negotiate two options, it's ok =

for our PPP stack and it runs correctly.

>> anyway, if we want to implement a full PPP stack, we have a long way to =
go.
>>
> =

> That's the point, we actually do not want to implement a full PPP stack.
>  Only enough to talk to the relatively unsophisticated PPP stacks
> running inside the modem firmware.  Remember, PPP is simply used host to
> modem.  It is not used over the air.

yes, i got it.

B.R

Steven
---------------------------------------------------------------------------=
------------------------
Confidentiality Notice: The information contained in this e-mail and any ac=
companying attachment(s) =

is intended only for the use of the intended recipient and may be confident=
ial and/or privileged of =

Neusoft Corporation, its subsidiaries and/or its affiliates. If any reader =
of this communication is =

not the intended recipient, unauthorized use, forwarding, printing,  storin=
g, disclosure or copying =

is strictly prohibited, and may be unlawful.If you have received this commu=
nication in error,please =

immediately notify the sender by return e-mail, and delete the original mes=
sage and all copies from =

your system. Thank you. =

---------------------------------------------------------------------------=
------------------------


--===============4018868166537070164==--

