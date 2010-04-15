Content-Type: multipart/mixed; boundary="===============2657867810309947407=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 7/8] Add AT driver for STK atom.
Date: Thu, 15 Apr 2010 16:48:10 -0500
Message-ID: <201004151648.11027.denkenz@gmail.com>
In-Reply-To: <1270795800-7273-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2657867810309947407==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> ---
>  Makefile.am               |    1 +
>  drivers/atmodem/atmodem.c |    2 +
>  drivers/atmodem/atmodem.h |    3 +
>  drivers/atmodem/stk.c     |  258
>  +++++++++++++++++++++++++++++++++++++++++++++ plugins/atgen.c           =
| =

>    2 +
>  plugins/phonesim.c        |    3 +
>  6 files changed, 269 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/atmodem/stk.c

I did apply the patch, however I have a question:

The terminal response goes something like this:

> +
> +	len =3D sprintf(buf, "AT+CSIM=3D%i,A0140000%02hhX",
> +			10 + length * 2, length);
> +
> +	for (; length; length--)
> +		len +=3D sprintf(buf + len, "%02hhX", *value++);
> +

In the new stk envelope code it goes something like this:

> =

> +	len =3D sprintf(buf, "AT+CSIM=3D%i,A0C20000%02hhX",
> +			12 + length * 2, length);
> +
> +	for (; length; length--)
> +		len +=3D sprintf(buf + len, "%02hhX", *command++);
> +
> +	len +=3D sprintf(buf + len, "FF");

What is the point of this last 'FF'?  The code removed from the sim atom =

driver doesn't have it either...

Regards,
-Denis

--===============2657867810309947407==--

