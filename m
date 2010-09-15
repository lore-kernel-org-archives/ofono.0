Content-Type: multipart/mixed; boundary="===============6513736477151085974=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] Internal and Driver API changes for Send USSD
Date: Wed, 15 Sep 2010 12:13:14 -0500
Message-ID: <4C90FEAA.3010907@gmail.com>
In-Reply-To: <1284499394-19842-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6513736477151085974==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 09/14/2010 04:23 PM, Jeevaka Badrappan wrote:
> ---
>  drivers/atmodem/ussd.c  |  115 ++++++++++++++++++++++++++++-------------=
------
>  drivers/isimodem/ussd.c |   42 +++--------------
>  include/ussd.h          |    8 ++-
>  src/ussd.c              |   39 +++++++++++++---
>  4 files changed, 115 insertions(+), 89 deletions(-)
> =


This patch has been applied, but refactored heavily afterward.

> +	struct ussd_data *data =3D ofono_ussd_get_data(ussd);
>  	GAtResultIter iter;
>  	int status;
>  	int dcs;
> -	const char *content;
> -	char *converted =3D NULL;
> -	gboolean udhi;
> +	const char *content =3D NULL;
>  	enum sms_charset charset;
> -	gboolean compressed;
> -	gboolean iso639;
> +	unsigned char msg[160];
> +	const unsigned char *msg_ptr =3D NULL;
> +	unsigned char *converted =3D NULL;
> +	long written;
> +	long msg_len =3D 0;

Please avoid initializing variables unless absolutely necessary.  This
actually hid some serious issues in the code which I had to fix.  In the
future I will not be so nice and simply reject such patches.

> +	switch (charset) {
> +	case SMS_CHARSET_7BIT:
> +		if (data->charset =3D=3D AT_UTIL_CHARSET_GSM)
> +			msg_ptr =3D pack_7bit_own_buf((const guint8 *) content,
> +					strlen(content), 0, TRUE, &msg_len, 0, msg);
> +		else if (data->charset =3D=3D AT_UTIL_CHARSET_UTF8)
> +			ussd_encode(content, &msg_len, msg);
> +		else if (data->charset =3D=3D AT_UTIL_CHARSET_UCS2) {
> +			msg_ptr =3D decode_hex_own_buf(content, -1, &msg_len, 0, msg);

Please watch out for buffer overflows and make sure to run valgrind and
test all your code.  msg in this case was too small to contain the
decoded UCS2 information (up to 182 * 2 characters)

> +		snprintf(buf, sizeof(buf), "AT+CUSD=3D1,\"%.*s\",%d",
> +				(int) written, unpacked_buf, dcs);
> +	} else {
> +		converted =3D encode_hex_own_buf(pdu, len, 0, coded_buf);

Same thing here, you were overflowing the coded_buf

> +		if (!converted)
> +			goto error;
> +
> +		snprintf(buf, sizeof(buf), "AT+CUSD=3D1,\"%.*s\",%d",
> +				strlen(converted), converted, dcs);

and overflowing buf as well

Regards,
-Denis

--===============6513736477151085974==--

