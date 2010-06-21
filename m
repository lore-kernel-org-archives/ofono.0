Content-Type: multipart/mixed; boundary="===============4836363657567119752=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 2/2] test-stkutil: add html formatted text tests
Date: Tue, 22 Jun 2010 00:59:30 +0200
Message-ID: <AANLkTikq2ZJCU6uwcVsfBhoFmjde-WxJtYqpUN8HiM4d@mail.gmail.com>
In-Reply-To: <1277125602-3996-3-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4836363657567119752==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 21 June 2010 15:06, Kristen Carlson Accardi <kristen@linux.intel.com> =
wrote:
> diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
> index c586a7b..21fd02d 100644
> --- a/unit/test-stkutil.c
> +++ b/unit/test-stkutil.c
> @@ -28,6 +28,9 @@
> =C2=A0#include <stdlib.h>
> =C2=A0#include <string.h>
> =C2=A0#include <stdint.h>
> +#include <fcntl.h>
> +
> +#include <sys/stat.h>
>
> =C2=A0#include <glib.h>
> =C2=A0#include <glib/gprintf.h>
> @@ -508,6 +511,7 @@ struct display_text_test {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct stk_duration duration;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct stk_text_attribute text_attr;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct stk_frame_id frame_id;
> + =C2=A0 =C2=A0 =C2=A0 const char *test_name;
> =C2=A0};
>
> =C2=A0unsigned char display_text_111[] =3D { 0xD0, 0x1A, 0x81, 0x03, 0x01=
, 0x21, 0x80,
> @@ -603,6 +607,69 @@ unsigned char display_text_711[] =3D { 0xD0, 0x19, 0=
x81, 0x03, 0x01, 0x21, 0x80,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x63, 0x6=
F, 0x6E, 0x64, 0x84, 0x02,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x01, 0x0=
A };
>
> +unsigned char display_text_811[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, 0x2=
1, 0x80,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x82, 0x02, =
0x81, 0x02, 0x8D, 0x11,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04, 0x54, =
0x65, 0x78, 0x74, 0x20,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x41, 0x74, =
0x74, 0x72, 0x69, 0x62,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x75, 0x74, =
0x65, 0x20, 0x31, 0xD0,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04, 0x00, =
0x10, 0x00, 0xB4 };
> +
> +unsigned char display_text_821[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, 0x2=
1, 0x80,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x82, 0x02, =
0x81, 0x02, 0x8D, 0x11,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04, 0x54, =
0x65, 0x78, 0x74, 0x20,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x41, 0x74, =
0x74, 0x72, 0x69, 0x62,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x75, 0x74, =
0x65, 0x20, 0x31, 0xD0,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04, 0x00, =
0x10, 0x01, 0xB4 };
> +
> +unsigned char display_text_831[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, 0x2=
1, 0x80,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x82, 0x02, =
0x81, 0x02, 0x8D, 0x11,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04, 0x54, =
0x65, 0x78, 0x74, 0x20,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x41, 0x74, =
0x74, 0x72, 0x69, 0x62,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x75, 0x74, =
0x65, 0x20, 0x31, 0xD0,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04, 0x00, =
0x10, 0x02, 0xB4 };
> +
> +unsigned char display_text_841[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, 0x2=
1, 0x80,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x82, 0x02, =
0x81, 0x02, 0x8D, 0x11,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04, 0x54, =
0x65, 0x78, 0x74, 0x20,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x41, 0x74, =
0x74, 0x72, 0x69, 0x62,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x75, 0x74, =
0x65, 0x20, 0x31, 0xD0,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04, 0x00, =
0x10, 0x04, 0xB4 };
> +
> +unsigned char display_text_851[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, 0x2=
1, 0x80,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x82, 0x02, =
0x81, 0x02, 0x8D, 0x11,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04, 0x54, =
0x65, 0x78, 0x74, 0x20,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x41, 0x74, =
0x74, 0x72, 0x69, 0x62,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x75, 0x74, =
0x65, 0x20, 0x31, 0xD0,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04, 0x00, =
0x10, 0x08, 0xB4 };
> +
> +unsigned char display_text_861[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, 0x2=
1, 0x80,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x82, 0x02, =
0x81, 0x02, 0x8D, 0x11,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04, 0x54, =
0x65, 0x78, 0x74, 0x20,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x41, 0x74, =
0x74, 0x72, 0x69, 0x62,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x75, 0x74, =
0x65, 0x20, 0x31, 0xD0,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04, 0x00, =
0x10, 0x10, 0xB4 };
> +
> +unsigned char display_text_871[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, 0x2=
1, 0x80,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x82, 0x02, =
0x81, 0x02, 0x8D, 0x11,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04, 0x54, =
0x65, 0x78, 0x74, 0x20,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x41, 0x74, =
0x74, 0x72, 0x69, 0x62,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x75, 0x74, =
0x65, 0x20, 0x31, 0xD0,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04, 0x00, =
0x10, 0x20, 0xB4 };
> +
> +unsigned char display_text_881[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, 0x2=
1, 0x80,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x82, 0x02, =
0x81, 0x02, 0x8D, 0x11,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04, 0x54, =
0x65, 0x78, 0x74, 0x20,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x41, 0x74, =
0x74, 0x72, 0x69, 0x62,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x75, 0x74, =
0x65, 0x20, 0x31, 0xD0,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04, 0x00, =
0x10, 0x40, 0xB4 };
> +
> +unsigned char display_text_891[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, 0x2=
1, 0x80,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x82, 0x02, =
0x81, 0x02, 0x8D, 0x11,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04, 0x54, =
0x65, 0x78, 0x74, 0x20,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x41, 0x74, =
0x74, 0x72, 0x69, 0x62,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x75, 0x74, =
0x65, 0x20, 0x31, 0xD0,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04, 0x00, =
0x10, 0x80, 0xB4 };
> +
> =C2=A0unsigned char display_text_911[] =3D { 0xD0, 0x10, 0x81, 0x03, 0x01=
, 0x21, 0x80,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x82, 0x0=
2, 0x81, 0x02, 0x8D, 0x05,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x08, 0x4=
F, 0x60, 0x59, 0x7D };
> @@ -708,6 +775,114 @@ static struct display_text_test display_text_data_7=
11 =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0};
>
> +static struct display_text_test display_text_data_811 =3D {
> + =C2=A0 =C2=A0 =C2=A0 .pdu =3D display_text_811,
> + =C2=A0 =C2=A0 =C2=A0 .pdu_len =3D sizeof(display_text_811),
> + =C2=A0 =C2=A0 =C2=A0 .qualifier =3D 0x80,
> + =C2=A0 =C2=A0 =C2=A0 .text =3D "Text Attribute 1",
> + =C2=A0 =C2=A0 =C2=A0 .text_attr =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .len =3D 4,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .attributes =3D { 0x00=
, 0x10, 0x00, 0xB4 },
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 .test_name =3D "811.html",
> +};
> +
> +static struct display_text_test display_text_data_821 =3D {
> + =C2=A0 =C2=A0 =C2=A0 .pdu =3D display_text_821,
> + =C2=A0 =C2=A0 =C2=A0 .pdu_len =3D sizeof(display_text_821),
> + =C2=A0 =C2=A0 =C2=A0 .qualifier =3D 0x80,
> + =C2=A0 =C2=A0 =C2=A0 .text =3D "Text Attribute 1",
> + =C2=A0 =C2=A0 =C2=A0 .text_attr =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .len =3D 4,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .attributes =3D { 0x00=
, 0x10, 0x01, 0xB4 },
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 .test_name =3D "821.html",
> +};
> +
> +static struct display_text_test display_text_data_831 =3D {
> + =C2=A0 =C2=A0 =C2=A0 .pdu =3D display_text_831,
> + =C2=A0 =C2=A0 =C2=A0 .pdu_len =3D sizeof(display_text_831),
> + =C2=A0 =C2=A0 =C2=A0 .qualifier =3D 0x80,
> + =C2=A0 =C2=A0 =C2=A0 .text =3D "Text Attribute 1",
> + =C2=A0 =C2=A0 =C2=A0 .text_attr =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .len =3D 4,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .attributes =3D { 0x00=
, 0x10, 0x02, 0xB4 },
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 .test_name =3D "831.html",
> +};
> +
> +static struct display_text_test display_text_data_841 =3D {
> + =C2=A0 =C2=A0 =C2=A0 .pdu =3D display_text_841,
> + =C2=A0 =C2=A0 =C2=A0 .pdu_len =3D sizeof(display_text_841),
> + =C2=A0 =C2=A0 =C2=A0 .qualifier =3D 0x80,
> + =C2=A0 =C2=A0 =C2=A0 .text =3D "Text Attribute 1",
> + =C2=A0 =C2=A0 =C2=A0 .text_attr =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .len =3D 4,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .attributes =3D { 0x00=
, 0x10, 0x04, 0xB4 },
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 .test_name =3D "841.html",
> +};
> +
> +static struct display_text_test display_text_data_851 =3D {
> + =C2=A0 =C2=A0 =C2=A0 .pdu =3D display_text_851,
> + =C2=A0 =C2=A0 =C2=A0 .pdu_len =3D sizeof(display_text_851),
> + =C2=A0 =C2=A0 =C2=A0 .qualifier =3D 0x80,
> + =C2=A0 =C2=A0 =C2=A0 .text =3D "Text Attribute 1",
> + =C2=A0 =C2=A0 =C2=A0 .text_attr =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .len =3D 4,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .attributes =3D { 0x00=
, 0x10, 0x08, 0xB4 },
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 .test_name =3D "851.html",
> +};
> +
> +static struct display_text_test display_text_data_861 =3D {
> + =C2=A0 =C2=A0 =C2=A0 .pdu =3D display_text_861,
> + =C2=A0 =C2=A0 =C2=A0 .pdu_len =3D sizeof(display_text_861),
> + =C2=A0 =C2=A0 =C2=A0 .qualifier =3D 0x80,
> + =C2=A0 =C2=A0 =C2=A0 .text =3D "Text Attribute 1",
> + =C2=A0 =C2=A0 =C2=A0 .text_attr =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .len =3D 4,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .attributes =3D { 0x00=
, 0x10, 0x10, 0xB4 },
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 .test_name =3D "861.html",
> +};
> +
> +static struct display_text_test display_text_data_871 =3D {
> + =C2=A0 =C2=A0 =C2=A0 .pdu =3D display_text_871,
> + =C2=A0 =C2=A0 =C2=A0 .pdu_len =3D sizeof(display_text_871),
> + =C2=A0 =C2=A0 =C2=A0 .qualifier =3D 0x80,
> + =C2=A0 =C2=A0 =C2=A0 .text =3D "Text Attribute 1",
> + =C2=A0 =C2=A0 =C2=A0 .text_attr =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .len =3D 4,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .attributes =3D { 0x00=
, 0x10, 0x20, 0xB4 },
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 .test_name =3D "871.html",
> +};
> +
> +static struct display_text_test display_text_data_881 =3D {
> + =C2=A0 =C2=A0 =C2=A0 .pdu =3D display_text_881,
> + =C2=A0 =C2=A0 =C2=A0 .pdu_len =3D sizeof(display_text_881),
> + =C2=A0 =C2=A0 =C2=A0 .qualifier =3D 0x80,
> + =C2=A0 =C2=A0 =C2=A0 .text =3D "Text Attribute 1",
> + =C2=A0 =C2=A0 =C2=A0 .text_attr =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .len =3D 4,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .attributes =3D { 0x00=
, 0x10, 0x40, 0xB4 },
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 .test_name =3D "881.html",
> +};
> +
> +static struct display_text_test display_text_data_891 =3D {
> + =C2=A0 =C2=A0 =C2=A0 .pdu =3D display_text_891,
> + =C2=A0 =C2=A0 =C2=A0 .pdu_len =3D sizeof(display_text_891),
> + =C2=A0 =C2=A0 =C2=A0 .qualifier =3D 0x80,
> + =C2=A0 =C2=A0 =C2=A0 .text =3D "Text Attribute 1",
> + =C2=A0 =C2=A0 =C2=A0 .text_attr =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .len =3D 4,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .attributes =3D { 0x00=
, 0x10, 0x80, 0xB4 },
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 .test_name =3D "891.html",
> +};
> +
> =C2=A0static struct display_text_test display_text_data_911 =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.pdu =3D display_text_911,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.pdu_len =3D sizeof(display_text_911),
> @@ -722,6 +897,58 @@ static struct display_text_test display_text_data_10=
11 =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.text =3D "80=E3=83=AB"
> =C2=A0};
>
> +static void do_html_test(char *text, int text_len, const unsigned char *=
attrs,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int attrs_len, const char *filename)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int fd;
> + =C2=A0 =C2=A0 =C2=A0 char html_header[] =3D "<html><body>";
> + =C2=A0 =C2=A0 =C2=A0 char html_close[] =3D "</body></html>";
> + =C2=A0 =C2=A0 =C2=A0 char *html;
> + =C2=A0 =C2=A0 =C2=A0 ssize_t bytes_written;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (filename =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* open output file */
> + =C2=A0 =C2=A0 =C2=A0 fd =3D open(filename, O_WRONLY | O_CREAT, S_IRUSR =
| S_IWUSR |
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 S_IRGRP | S_IROTH);
> + =C2=A0 =C2=A0 =C2=A0 if (fd < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_print("unable to ope=
n %s\n", filename);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 bytes_written =3D write(fd, html_header, strlen(ht=
ml_header));
> + =C2=A0 =C2=A0 =C2=A0 html =3D stk_text_to_html(text, text_len, attrs, a=
ttrs_len);
> + =C2=A0 =C2=A0 =C2=A0 bytes_written =3D write(fd, html, strlen(html));
> + =C2=A0 =C2=A0 =C2=A0 bytes_written =3D write(fd, html_close, strlen(htm=
l_close));
> + =C2=A0 =C2=A0 =C2=A0 close(fd);
> + =C2=A0 =C2=A0 =C2=A0 g_free(html);
> +}
> +
> +static void test_html1(gconstpointer data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 char html_test[] =3D "EMS messages can contain ita=
lic, bold,"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 " large, small and colored text";
> + =C2=A0 =C2=A0 =C2=A0 const unsigned char attrs[] =3D { 0x19, 0x06, 0x20=
, 0x00,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x21, 0x04, =
0x10, 0x00,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x27, 0x05, =
0x04, 0x00,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x2E, 0x05, =
0x08, 0x00,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x38, 0x07, =
0x00, 0x2B };
> + =C2=A0 =C2=A0 =C2=A0 const char filename[] =3D "html1.html";
> +
> + =C2=A0 =C2=A0 =C2=A0 do_html_test(html_test, strlen(html_test), attrs, =
20, filename);
> +}
> +
> +static void test_html2(gconstpointer data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 char html_test[] =3D "Blue green green green";
> + =C2=A0 =C2=A0 =C2=A0 const unsigned char attrs[] =3D { 0x00, 0x00, 0x00=
, 0x94,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00, 0x04, =
0x00, 0x96 };
> + =C2=A0 =C2=A0 =C2=A0 const char filename[] =3D "html2.html";
> +
> + =C2=A0 =C2=A0 =C2=A0 do_html_test(html_test, strlen(html_test), attrs, =
8, filename);
> +}
> +
> =C2=A0/* Defined in TS 102.384 Section 27.22.4.1 */
> =C2=A0static void test_display_text(gconstpointer data)
> =C2=A0{
> @@ -747,6 +974,14 @@ static void test_display_text(gconstpointer data)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0check_duration(&command->display_text.duration=
, &test->duration);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0check_text_attr(&command->display_text.text_at=
tr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&test->text_attr);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (command->display_text.text_attr.len > 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_html_test(command->=
display_text.text,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strlen(command->display_text.text),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command->display_text.text_attr.attribut=
es,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command->display_text.text_attr.len,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test->test_name);
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0check_frame_id(&command->display_text.frame_id=
, &test->frame_id);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0stk_command_free(command);
> @@ -21913,6 +22148,28 @@ int main(int argc, char **argv)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&display_text_data_611, test_display_=
text);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0g_test_add_data_func("/teststk/Display Text 7.=
1.1",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&display_text_data_711, test_display_=
text);
> + =C2=A0 =C2=A0 =C2=A0 g_test_add_data_func("/teststk/HTML test 1",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, test_html1);
> + =C2=A0 =C2=A0 =C2=A0 g_test_add_data_func("/teststk/HTML test 2",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, test_html2);
> + =C2=A0 =C2=A0 =C2=A0 g_test_add_data_func("/teststk/Display Text 8.1.1",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &display_text_data_811, test_display_tex=
t);
> + =C2=A0 =C2=A0 =C2=A0 g_test_add_data_func("/teststk/Display Text 8.2.1",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &display_text_data_821, test_display_tex=
t);
> + =C2=A0 =C2=A0 =C2=A0 g_test_add_data_func("/teststk/Display Text 8.3.1",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &display_text_data_831, test_display_tex=
t);
> + =C2=A0 =C2=A0 =C2=A0 g_test_add_data_func("/teststk/Display Text 8.4.1",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &display_text_data_841, test_display_tex=
t);
> + =C2=A0 =C2=A0 =C2=A0 g_test_add_data_func("/teststk/Display Text 8.5.1",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &display_text_data_851, test_display_tex=
t);
> + =C2=A0 =C2=A0 =C2=A0 g_test_add_data_func("/teststk/Display Text 8.6.1",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &display_text_data_861, test_display_tex=
t);
> + =C2=A0 =C2=A0 =C2=A0 g_test_add_data_func("/teststk/Display Text 8.7.1",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &display_text_data_871, test_display_tex=
t);
> + =C2=A0 =C2=A0 =C2=A0 g_test_add_data_func("/teststk/Display Text 8.8.1",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &display_text_data_881, test_display_tex=
t);
> + =C2=A0 =C2=A0 =C2=A0 g_test_add_data_func("/teststk/Display Text 8.9.1",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &display_text_data_891, test_display_tex=
t);

The unit tests can probably do whatever they want, but in my opinion
they should fail if anything is wrong with the tested function, while
this code never calls g_assert.  You should probably include the
expected html with each test and do strcmp (I agree this is not ideal
because there are many valid results, but it'll at least force someone
who sends a patch to run and update the tests).

Regards

--===============4836363657567119752==--

