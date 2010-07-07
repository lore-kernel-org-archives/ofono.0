Content-Type: multipart/mixed; boundary="===============2709101595260456442=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [SMS D-Bus 07/23] introduce DECLARE_SMS_ADDR_STR()
Date: Wed, 07 Jul 2010 17:54:11 -0500
Message-ID: <4C350593.8000302@gmail.com>
In-Reply-To: <9ef38420df1d42245dd852123b5cd885cc770481.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2709101595260456442==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

> +enum { SMS_ADDR_STR_SIZE =3D 25 };
> +#define DECLARE_SMS_ADDR_STR(a) char a[SMS_ADDR_STR_SIZE]
> +
>  gboolean sms_decode_address_field(const unsigned char *pdu, int len,
>  					int *offset, gboolean sc,
>  					struct sms_address *out);

Sounds fine to me, but can we get rid of the enum declaration? simply
char a[25] seems to be enough.  Might want to add a comment explaining
why it is 25.  Namely that sms address is encoded into 12 bytes, stored
in hex format and space for a null.

Regards,
-Denis

--===============2709101595260456442==--

