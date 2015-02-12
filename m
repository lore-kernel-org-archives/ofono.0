Content-Type: multipart/mixed; boundary="===============4891876301773966896=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] sms: SMS-DELIVER TP-OA Alphanum decoding and encoding
 fix
Date: Thu, 12 Feb 2015 12:59:18 -0600
Message-ID: <54DCF806.5060609@gmail.com>
In-Reply-To: <1423753800-17543-2-git-send-email-tommi.kenakkala@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4891876301773966896==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tommi,

On 02/12/2015 09:09 AM, Tommi Kenakkala wrote:
> Ofono ignores receved SMS if they have a long alphanum address with
> extended ascii characters:
> 1) sms_encode_address_field: TP-OA max length comparison before encoding
> is incorrect because TP-OA's 11 octets are 7-bit coded and thus transport
> twelve 8-bit chars. Change ofono to compare character count to character
> limit instead of octet limit.

How did you arrive at 11 octet figure? TP-OA is limited to 12 bytes.  So =

12 - TON - LEN =3D 10 bytes payload.

10 bytes with 7-bit packed characters -> 11 unpacked characters

All characters in the GSM default alphabet can be described by a maximum =

of 2 bytes in utf8.  Exception is the euro sign, which is an extended =

character, but requires 3 utf8 bytes to encode.  So a buffer of 11 * 2 + =

1 bytes should be sufficient to hold an alphanumeric address.

> 2) sms_decode_address_field: Decoding from 7-bit alphabet will output max.
> twelve 8-bit chars which converted to UTF-8 take 24 bytes.
> Increase oFono sms_address struct's array accordingly.
> ---
>   src/smsutil.c |   12 +++++++++---
>   src/smsutil.h |    6 +++++-
>   2 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/src/smsutil.c b/src/smsutil.c
> index be60ee9..b2ff349 100644
> --- a/src/smsutil.c
> +++ b/src/smsutil.c
> @@ -524,7 +524,8 @@ static gboolean encode_validity_period(const struct s=
ms_validity_period *vp,
>   gboolean sms_encode_address_field(const struct sms_address *in, gboolea=
n sc,
>   					unsigned char *pdu, int *offset)
>   {
> -	size_t len =3D strlen(in->address);
> +	const char *addr =3D (const char *)&in->address;
> +	size_t len =3D strlen(addr);
>   	unsigned char addr_len =3D 0;
>   	unsigned char p[10];
>
> @@ -546,7 +547,8 @@ gboolean sms_encode_address_field(const struct sms_ad=
dress *in, gboolean sc,
>   		unsigned char *gsm;
>   		unsigned char *r;
>
> -		if (len > 11)
> +		/* TP-OA's 11 octets may fit 12 7-bit packed characters */
> +		if (g_utf8_strlen(addr, strlen(addr)) > 12)

g_utf8_strlen() > 11 here

>   			return FALSE;
>
>   		gsm =3D convert_utf8_to_gsm(in->address, len, NULL, &written, 0);
> @@ -675,7 +677,11 @@ gboolean sms_decode_address_field(const unsigned cha=
r *pdu, int len,
>   		if (utf8 =3D=3D NULL)
>   			return FALSE;
>
> -		if (strlen(utf8) > 20) {
> +		/*
> +		 * TP-OA's 11 7-bit octets may contain 12 8-bit chars,
> +		 * which converted to unicode would take 24+1 bytes.
> +		 */
> +		if (strlen(utf8) > 24) {

and strlen(utf8) > 22 here...

>   			g_free(utf8);
>   			return FALSE;
>   		}
> diff --git a/src/smsutil.h b/src/smsutil.h
> index b1001f8..e8266c8 100644
> --- a/src/smsutil.h
> +++ b/src/smsutil.h
> @@ -220,7 +220,11 @@ enum cbs_geo_scope {
>   struct sms_address {
>   	enum sms_number_type number_type;
>   	enum sms_numbering_plan numbering_plan;
> -	char address[21]; /* Max 20 in semi-octet, 11 in alnum */
> +	/*
> +	 * An alphanum TP-OA is 11 7-bit octets. Those can contain max 12 8-bit
> +	 * characters taking 24 bytes when converted to UTF-8.
> +	 */
> +	char address[25];

And address should be 23, the comment is wrong

>   };
>
>   struct sms_scts {
>

Regards,
-Denis

--===============4891876301773966896==--

