Content-Type: multipart/mixed; boundary="===============9110182098938105102=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ubloxmodem: fix maybe-unitialized error
Date: Fri, 21 Jun 2019 15:27:43 -0500
Message-ID: <c646e52f-2bfa-b164-7cd4-494365db24b6@gmail.com>
In-Reply-To: <95409985-43ec-8ed4-a04f-a208ab7efc69@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9110182098938105102==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 06/21/2019 03:21 PM, Martin Hundeb=C3=B8ll wrote:
> Hi Denis,
> =

> On 21/06/2019 19.54, Denis Kenzior wrote:
>> What compiler are you using?=C2=A0 gcc really needs to make up its mind =

>> whether it warns about enums or doesn't.=C2=A0 The behavior between =

>> versions is nuts.
> =

> % arm-oe-linux-gnueabi-gcc --version
> arm-oe-linux-gnueabi-gcc (GCC) 8.2.0
> =

> So I need this fix when building for my embedded platform using a =

> compiler from the Yocto SDK. Thanks for applying.
> =

> My up-to-date host compiler has no complaints regarding enums :)
> =

> But with gcc-9.1 I get a few of these now:
> =

> ../git/gisi/modem.c: In function =E2=80=98modem_subs_update=E2=80=99:
> ../git/gisi/modem.c:383:3: error: converting a packed =E2=80=98struct =

> sockaddr_pn=E2=80=99 pointer (alignment 1) to a =E2=80=98const struct soc=
kaddr=E2=80=99 pointer =

> (alignment 2) may result in an unaligned pointer value =

> [-Werror=3Daddress-of-packed-member]
>  =C2=A0 383 |=C2=A0=C2=A0 sizeof(commgr));
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 ^~~~~~
> In file included from ../git/gisi/message.h:32,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from ../git/gisi/modem.c:36:
> ../git/gisi/phonet.h:49:8: note: defined here
>  =C2=A0=C2=A0 49 | struct sockaddr_pn {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ^~~~~~~~~~~
> =


Yeah we've seen this one as well.  The problem is that there's not a =

whole lot we can do but #pragma this out as it is a structure that is =

part of the uapi.

> =

> It's not a problem though, since I don't enable gisi in my build - now =

> you know :)

As do I honestly.  That driver has not been maintained in some time. =

I'm considering removing it from the tree entirely.

Regards,
-Denis

--===============9110182098938105102==--

