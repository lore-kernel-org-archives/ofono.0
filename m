Content-Type: multipart/mixed; boundary="===============4367643249521847323=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH v2 09/18] isimodem: clip colp clir colr wgmodem2.5
Date: Thu, 03 Mar 2011 17:45:14 +0200
Message-ID: <AANLkTik78T=3xAR8ZkGHnkAtDwYtq6+dKGdSHn4yhmrb@mail.gmail.com>
In-Reply-To: <b85bed728917dbe817cc739f9423881e9fbe78ff.1298460572.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4367643249521847323==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2011/2/23 Andreas Westin <andreas.westin@stericsson.com>:
> From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>
>
> ---
> =C2=A0drivers/isimodem/call-settings.c | =C2=A0711 ++++++++++++++++++++++=
+++++++++++++++-
> =C2=A0drivers/isimodem/call.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =
=C2=A09 +
> =C2=A0drivers/isimodem/debug.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=
=A04 +
> =C2=A0drivers/isimodem/ss.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
=C2=A0 22 ++
> =C2=A04 files changed, 728 insertions(+), 18 deletions(-)

I pushed CLIP, COLP and COLR query support based on this patch, plus
refactored the call waiting code some.

The CLIR query and set functionality included was sufficiently
convoluted that I had to leave it out for the time being.

Frankly, I am not sure that even oFono core is working properly here,
if the CLIR status can only be modified locally. That said, my
supplementary-service-foo is admittedly lacking, so if someone can
make sense of CLIR here, I would appreciate comments and/or patches.

Cheers,
Aki

--===============4367643249521847323==--

