Content-Type: multipart/mixed; boundary="===============7178234637909810883=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Compiling: error: cast increases required alignment of target
 type [-Werror=cast-align]
Date: Fri, 21 Jun 2019 12:48:36 -0500
Message-ID: <d075be62-954d-fb03-f639-0bf53e985201@gmail.com>
In-Reply-To: <aacda8dd-61a9-2bc6-cf6e-13fee5e32b76@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7178234637909810883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 06/21/2019 04:52 AM, Martin Hundeb=C3=B8ll wrote:
> Hi Denis,
> =

> On 08/02/2019 21.15, Denis Kenzior wrote:
>> Hi,
>>
>> On 02/04/2019 04:28 PM, Pi=C4=8Dugins Arsenijs wrote:
>>> =C2=A0=C2=A0 CC =C2=A0 =C2=A0 =C2=A0 drivers/mbimmodem/mbim-message.o
>>> drivers/mbimmodem/mbim-message.c: In function =E2=80=98_iter_copy_strin=
g=E2=80=99:
>>> drivers/mbimmodem/mbim-message.c:199:18: error: cast increases =

>>> required alignment of target type [-Werror=3Dcast-align]
>>> =C2=A0=C2=A0 =C2=A0uint16_t *le =3D (uint16_t *) buf;
>>> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^
>>
>> Does the attached patch fix this?
> =

> It fixes it for me. Please apply.
> =

> // Martin

All right, applied.

Regards,
-Denis

--===============7178234637909810883==--

