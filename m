Content-Type: multipart/mixed; boundary="===============1784803902210191133=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: netlink.c:97: error: cast increases required alignment of target
 type
Date: Wed, 16 Sep 2009 17:00:07 +0300
Message-ID: <a32762a20909160700o2c059252h5beb82083a8a627c@mail.gmail.com>
In-Reply-To: <84y6og3vi4.fsf@sauna.l.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1784803902210191133==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2009/9/15 Timo Juhani Lindfors <timo.lindfors@iki.fi>:
>> =C2=A0 CC =C2=A0 =C2=A0 gdbus/watch.o
>> =C2=A0 CC =C2=A0 =C2=A0 gisi/netlink.o
>> cc1: warnings being treated as errors
>> gisi/netlink.c: In function 'g_pn_nl_process':
>> gisi/netlink.c:97: error: cast increases required alignment of target ty=
pe
>> gisi/netlink.c:129: error: cast increases required alignment of target t=
ype
>> gisi/netlink.c:130: error: cast increases required alignment of target t=
ype

This was discussed some weeks ago, and that warning is bogus in this
case, but there wasn't a clean workaround for it.

> on armel (openmoko gta02) debian unstable system with gcc 4:4.3.3-9
> apparently since in mainstainer mode -Wcast-align complains about

First of all, you probably should configure --disable-isimodem, which
excludes gisi as well, since the openmoko surely doesn't have a Nokia
modem in it. ;)

Also, distributors really should build without maintainer mode, which
makes the problem go away. It does suck for us, though, when building
in scratchbox armel target.

Cheers,
Aki

--===============1784803902210191133==--

