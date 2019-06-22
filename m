Content-Type: multipart/mixed; boundary="===============4745100758714102937=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Compiling: error: cast increases required alignment of target
 type [-Werror=cast-align]
Date: Sat, 22 Jun 2019 07:40:56 +0200
Message-ID: <051AF527-BA6E-43B1-AF73-63BBCCA17D0B@holtmann.org>
In-Reply-To: <d075be62-954d-fb03-f639-0bf53e985201@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4745100758714102937==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>>> On 02/04/2019 04:28 PM, Pi=C4=8Dugins Arsenijs wrote:
>>>>    CC       drivers/mbimmodem/mbim-message.o
>>>> drivers/mbimmodem/mbim-message.c: In function =E2=80=98_iter_copy_stri=
ng=E2=80=99:
>>>> drivers/mbimmodem/mbim-message.c:199:18: error: cast increases require=
d alignment of target type [-Werror=3Dcast-align]
>>>>     uint16_t *le =3D (uint16_t *) buf;
>>>>                    ^
>>> =

>>> Does the attached patch fix this?
>> It fixes it for me. Please apply.
>> // Martin
> =

> All right, applied.

I wonder if using l_get_u16 here to ensure that we always get the alignment=
 right isn=E2=80=99t better.

Regards

Marcel


--===============4745100758714102937==--

