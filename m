Content-Type: multipart/mixed; boundary="===============8132370070063879880=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: Build Breakage
Date: Thu, 20 Aug 2009 11:26:14 +0300
Message-ID: <a32762a20908200126p108f591dq16f282593d9245e9@mail.gmail.com>
In-Reply-To: <200908191959.39030.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8132370070063879880==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2009/8/20 Denis Kenzior <denkenz@gmail.com>:
> SOCK_NONBLOCK and SOCK_CLOEXEC are only available on kernel >=3D 2.6.28 &=
 glibc
>>=3D 2.9. =C2=A0I know this is hardly bleeding edge, but oFono should cont=
inue
> working with older systems. =C2=A0Perhaps a --disable-isi configure optio=
n is
> _really_ in order?

I think I've seen enough of these issues. I agree this is not nice, so
I'll push a patch for a --disable-isi configure switch, along with
R=C3=A9mi's patch that fixes the actual build issue.

But it seems the build is broken in git, but for a different reason:

atmodem/atmodem.c:40:35: error: ofono/message-waiting.h: No such file
or directory
atmodem/atmodem.c:42:23: error: ofono/sim.h: No such file or directory
atmodem/atmodem.c:43:23: error: ofono/sms.h: No such file or directory
atmodem/atmodem.c:46:29: error: ofono/voicecall.h: No such file or directory
atmodem/atmodem.c: In function =E2=80=98create_cb=E2=80=99:
atmodem/atmodem.c:381: warning: assignment makes pointer from integer
without a cast

Perhaps a --disable-at switch? I kid, I kid... ;-)

Cheers,
Aki

--===============8132370070063879880==--

