Content-Type: multipart/mixed; boundary="===============5335883231927819001=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: Compiling: error: cast increases required alignment of target
 type [-Werror=cast-align]
Date: Fri, 21 Jun 2019 11:52:12 +0200
Message-ID: <aacda8dd-61a9-2bc6-cf6e-13fee5e32b76@geanix.com>
In-Reply-To: <5fcbd5d1-a539-16f0-3666-7381400fe1fd@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5335883231927819001==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 08/02/2019 21.15, Denis Kenzior wrote:
> Hi,
> =

> On 02/04/2019 04:28 PM, Pi=C4=8Dugins Arsenijs wrote:
>> =C2=A0=C2=A0 CC =C2=A0 =C2=A0 =C2=A0 drivers/mbimmodem/mbim-message.o
>> drivers/mbimmodem/mbim-message.c: In function =E2=80=98_iter_copy_string=
=E2=80=99:
>> drivers/mbimmodem/mbim-message.c:199:18: error: cast increases =

>> required alignment of target type [-Werror=3Dcast-align]
>> =C2=A0=C2=A0 =C2=A0uint16_t *le =3D (uint16_t *) buf;
>> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^
> =

> Does the attached patch fix this?

It fixes it for me. Please apply.

// Martin

--===============5335883231927819001==--

