Content-Type: multipart/mixed; boundary="===============6507098812658738694=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] mbim: add optional copy of TEMP_FAILURE_RETRY macro (fix
 musl compile)
Date: Mon, 28 Jan 2019 13:34:37 +0100
Message-ID: <99537250-8354-4976-95A4-5EF7362DBBED@holtmann.org>
In-Reply-To: <20190128093221.68639-1-nicolas.serafini@sensefly.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6507098812658738694==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

> TEMP_FAILURE_RETRY is not available on musl.
> =

> Signed-off-by: Nicolas Serafini <nicolas.serafini@sensefly.com>
> ---
> drivers/mbimmodem/mbim.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
> =

> diff --git a/drivers/mbimmodem/mbim.c b/drivers/mbimmodem/mbim.c
> index 54b18acf..4b040528 100644
> --- a/drivers/mbimmodem/mbim.c
> +++ b/drivers/mbimmodem/mbim.c
> @@ -37,6 +37,16 @@
> #include "mbim-message.h"
> #include "mbim-private.h"
> =

> +/* taken from glibc unistd.h for musl support */
> +#ifndef TEMP_FAILURE_RETRY
> +#define TEMP_FAILURE_RETRY(expression)             \
> +  (__extension__                                   \
> +    ({ long int __result;                          \
> +       do __result =3D (long int) (expression);      \
> +       while (__result =3D=3D -1L && errno =3D=3D EINTR);  \
> +       __result; }))
> +#endif
> +

or you use the notation that is used in src/storage.h and maybe even move i=
t to a more common place. The TFR macro is used in various places.

Regards

Marcel


--===============6507098812658738694==--

