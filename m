Content-Type: multipart/mixed; boundary="===============2699030363616335705=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 0/3] isimodem: Allow network registration automatically
Date: Mon, 29 Aug 2011 14:36:22 +0300
Message-ID: <CANzBvOTLUpSJs5XqgS9DS0tpzdwigeHEitOgYjD_seF428N8Gw@mail.gmail.com>
In-Reply-To: <6B9DA0A3415B234191A1ADFA6275C51CB241E5@008-AM1MPN1-041.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2699030363616335705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Iiro,

2011/8/3  <iiro.kaihlaniemi@nokia.com>:
> Network registration is disabled by default. Enable network registration =
and roaming =C2=A0when network is started.
>
> =C2=A0drivers/isimodem/debug.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| =C2=A0 =C2=A05 ++
> =C2=A0drivers/isimodem/network-registration.c | =C2=A0 85 +++++++++++++++=
++++++++++++++++
> =C2=A0drivers/isimodem/network.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 12 ++++-
> =C2=A03 files changed, 101 insertions(+), 1 deletions(-)

I just pushed a set of patches including these changes. Thanks!

Cheers,
Aki

--===============2699030363616335705==--

