Content-Type: multipart/mixed; boundary="===============6474663400467642948=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 1/3] simutil: add validate_utf8_tlv
Date: Tue, 19 Jan 2021 10:04:54 -0600
Message-ID: <01bf6f8f-83fd-b1d4-bf3f-76d468eadecf@gmail.com>
In-Reply-To: <20210116192107.18568-2-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6474663400467642948==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On 1/16/21 1:21 PM, Sergey Matyukevich wrote:
> Add helper to validate if TLV value is a valid UTF8 string.
> Note that both null-terminated and non null-terminated UTF8
> strings are considered valid.
> ---
>   src/simutil.c | 14 ++++++++++++++
>   src/simutil.h |  1 +
>   2 files changed, 15 insertions(+)
> =


<snip>

> +gboolean validate_utf8_tlv(const unsigned char *tlv)
> +{
> +	int len =3D tlv[1];
> +
> +	if (len =3D=3D 0)
> +		return FALSE;
> +
> +	/* support both null-termiated and non null-terminated UTF8 TLV value */

I tweaked this comment to fix the typo here and make fit to 80 chars

> +	if (tlv[len + 1] =3D=3D '\0')
> +		len -=3D 1;
> +
> +	return g_utf8_validate_len((const char *)tlv + 2, len, NULL);
> +}
> +
>   static char *sim_network_name_parse(const unsigned char *buffer, int le=
ngth,
>   					gboolean *add_ci)
>   {

Applied, thanks.

Regards,
-Denis
--===============6474663400467642948==--

