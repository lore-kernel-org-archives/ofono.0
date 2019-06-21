Content-Type: multipart/mixed; boundary="===============1456950408141272058=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [PATCH] ubloxmodem: fix maybe-unitialized error
Date: Fri, 21 Jun 2019 22:21:56 +0200
Message-ID: <95409985-43ec-8ed4-a04f-a208ab7efc69@geanix.com>
In-Reply-To: <586bc825-a21a-31a3-6e3a-e8d87c0ff409@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1456950408141272058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 21/06/2019 19.54, Denis Kenzior wrote:
> What compiler are you using?=C2=A0 gcc really needs to make up its mind =

> whether it warns about enums or doesn't.=C2=A0 The behavior between versi=
ons =

> is nuts.

% arm-oe-linux-gnueabi-gcc --version
arm-oe-linux-gnueabi-gcc (GCC) 8.2.0

So I need this fix when building for my embedded platform using a =

compiler from the Yocto SDK. Thanks for applying.

My up-to-date host compiler has no complaints regarding enums :)

But with gcc-9.1 I get a few of these now:

../git/gisi/modem.c: In function =E2=80=98modem_subs_update=E2=80=99:
../git/gisi/modem.c:383:3: error: converting a packed =E2=80=98struct =

sockaddr_pn=E2=80=99 pointer (alignment 1) to a =E2=80=98const struct socka=
ddr=E2=80=99 pointer =

(alignment 2) may result in an unaligned pointer value =

[-Werror=3Daddress-of-packed-member]
   383 |   sizeof(commgr));
       |   ^~~~~~
In file included from ../git/gisi/message.h:32,
                  from ../git/gisi/modem.c:36:
../git/gisi/phonet.h:49:8: note: defined here
    49 | struct sockaddr_pn {
       |        ^~~~~~~~~~~


It's not a problem though, since I don't enable gisi in my build - now =

you know :)

// Martin

--===============1456950408141272058==--

