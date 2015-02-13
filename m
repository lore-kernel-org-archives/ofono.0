Content-Type: multipart/mixed; boundary="===============6662839749627167414=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] sms: SMS-DELIVER TP-OA Alphanum decoding and encoding
 fix
Date: Fri, 13 Feb 2015 09:13:14 -0600
Message-ID: <54DE148A.9090407@gmail.com>
In-Reply-To: <1423830226-32024-2-git-send-email-tommi.kenakkala@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6662839749627167414==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tommi,

On 02/13/2015 06:23 AM, Tommi Kenakkala wrote:
> TP-OA max length comparisons were incorrect because TP-OA's 7-bit
> coded octets transport eleven 8-bit chars which take 23 bytes in UTF-8.
> Increase address array accordingly and don't compare byte length to
> character limit, but to a proper limit.
> ---
>   src/smsutil.c |   12 +++++++++---
>   src/smsutil.h |    6 +++++-
>   2 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/src/smsutil.c b/src/smsutil.c
> index be60ee9..213e50e 100644
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
> +		/* TP-OA's 10 octets transport 11 8-bit chars */
> +		if (g_utf8_strlen(addr, strlen(addr)) > 11)
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
> +		 * TP-OA's 10 octets transport 11 8-bit chars,
> +		 * which take 23 bytes in unicode.
> +		 */
> +		if (strlen(utf8) > 23) {

22, not 23.

>   			g_free(utf8);
>   			return FALSE;
>   		}
> diff --git a/src/smsutil.h b/src/smsutil.h
> index b1001f8..d252810 100644
> --- a/src/smsutil.h
> +++ b/src/smsutil.h
> @@ -220,7 +220,11 @@ enum cbs_geo_scope {
>   struct sms_address {
>   	enum sms_number_type number_type;
>   	enum sms_numbering_plan numbering_plan;
> -	char address[21]; /* Max 20 in semi-octet, 11 in alnum */
> +	/*
> +	 * An alphanum TP-OA is 10 7-bit coded octets, which can carry
> +	 * 11 8-bit characters. Those converted to UTF-8 take 23 bytes.

22 bytes + null terminator.

> +	 */
> +	char address[23];
>   };
>
>   struct sms_scts {
>

Regards,
-Denis

--===============6662839749627167414==--

