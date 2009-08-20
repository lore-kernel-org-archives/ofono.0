Content-Type: multipart/mixed; boundary="===============5839141929010416236=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Build Breakage
Date: Thu, 20 Aug 2009 09:58:37 -0500
Message-ID: <200908200958.38111.denkenz@gmail.com>
In-Reply-To: <a32762a20908200126p108f591dq16f282593d9245e9@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5839141929010416236==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> But it seems the build is broken in git, but for a different reason:
>
> atmodem/atmodem.c:40:35: error: ofono/message-waiting.h: No such file
> or directory
> atmodem/atmodem.c:42:23: error: ofono/sim.h: No such file or directory
> atmodem/atmodem.c:43:23: error: ofono/sms.h: No such file or directory
> atmodem/atmodem.c:46:29: error: ofono/voicecall.h: No such file or

I already complained about this to Marcel. Any time a header is added a mak=
e =

clean is required. There were lots of new headers added.

> directory atmodem/atmodem.c: In function =E2=80=98create_cb=E2=80=99:
> atmodem/atmodem.c:381: warning: assignment makes pointer from integer
> without a cast

This probably happens because the message-waiting header isn't found :)

>
> Perhaps a --disable-at switch? I kid, I kid... ;-)
>

I've actually already said this should be the case :)  If one is building f=
or =

a Nokia device, atmodem plugin is wasted space.

Regards,
-Denis

--===============5839141929010416236==--

