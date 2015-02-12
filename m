Content-Type: multipart/mixed; boundary="===============7870370897852491164=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] unit: SMS-DELIVER decoding/encoding test for long
 alphanum address
Date: Thu, 12 Feb 2015 13:04:37 -0600
Message-ID: <54DCF945.8070105@gmail.com>
In-Reply-To: <1423753800-17543-3-git-send-email-tommi.kenakkala@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7870370897852491164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tommi,

On 02/12/2015 09:10 AM, Tommi Kenakkala wrote:
> ---
>   unit/test-sms.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++=
----
>   1 file changed, 48 insertions(+), 4 deletions(-)
>
> diff --git a/unit/test-sms.c b/unit/test-sms.c
> index 7b644df..5b4a37f 100644
> --- a/unit/test-sms.c
> +++ b/unit/test-sms.c
> @@ -38,6 +38,12 @@ static const char *simple_deliver =3D "07911326040000F=
0"
>   		"040B911346610089F60000208062917314480CC8F71D14969741F977FD07";
>   static const char *alnum_sender =3D "0791447758100650"
>   		"040DD0F334FC1CA6970100008080312170224008D4F29CDE0EA7D9";
> +static const char *unicode_deliver =3D "04819999990414D0FBFD7EBFDFEFF77B=
FE1E001"
> +		"9512090801361807E00DC00FC00C400E400D600F600C500E500D800F800C"
> +		"600E600C700E700C900E900CA00EA00DF003100320033003400350036003"
> +		"7003800390030002000540068006900730020006D0065007300730061006"
> +		"7006500200069007300200036003300200075006E00690063006F0064006"
> +		"5002000630068006100720073002E";
>   static const char *simple_submit =3D "0011000B916407281553F80000AA"
>   		"0AE8329BFD4697D9EC37";
>
> @@ -298,13 +304,16 @@ static void test_deliver_encode(void)
>   	int encoded_pdu_len;
>   	int encoded_tpdu_len;
>   	char *encoded_pdu;
> +	unsigned int smsc_len;
>
> +	/* test simple_deliver */
>   	decoded_pdu =3D decode_hex(simple_deliver, -1, &pdu_len, 0);
>
>   	g_assert(decoded_pdu);
>   	g_assert(pdu_len =3D=3D (long)strlen(simple_deliver) / 2);
>
> -	ret =3D sms_decode(decoded_pdu, pdu_len, FALSE, 30, &sms);
> +	smsc_len =3D decoded_pdu[0] + 1;
> +	ret =3D sms_decode(decoded_pdu, pdu_len, FALSE, pdu_len - smsc_len, &sm=
s);
>

This seems extraneous to this patch.  Probably belongs in a separate patch.

>   	g_free(decoded_pdu);
>
> @@ -322,7 +331,7 @@ static void test_deliver_encode(void)
>   	}
>
>   	g_assert(ret);
> -	g_assert(encoded_tpdu_len =3D=3D 30);
> +	g_assert(encoded_tpdu_len =3D=3D pdu_len - smsc_len);

as above.

>   	g_assert(encoded_pdu_len =3D=3D pdu_len);
>
>   	encoded_pdu =3D encode_hex(pdu, encoded_pdu_len, 0);
> @@ -331,12 +340,14 @@ static void test_deliver_encode(void)
>
>   	g_free(encoded_pdu);
>
> +	/* test alnum_sender */
>   	decoded_pdu =3D decode_hex(alnum_sender, -1, &pdu_len, 0);
>
>   	g_assert(decoded_pdu);
>   	g_assert(pdu_len =3D=3D (long)strlen(alnum_sender) / 2);
>
> -	ret =3D sms_decode(decoded_pdu, pdu_len, FALSE, 27, &sms);
> +	smsc_len =3D decoded_pdu[0] + 1;
> +	ret =3D sms_decode(decoded_pdu, pdu_len, FALSE, pdu_len - smsc_len, &sm=
s);

as above

>
>   	g_free(decoded_pdu);
>
> @@ -354,7 +365,7 @@ static void test_deliver_encode(void)
>   	}
>
>   	g_assert(ret);
> -	g_assert(encoded_tpdu_len =3D=3D 27);
> +	g_assert(encoded_tpdu_len =3D=3D pdu_len - smsc_len);

as above

>   	g_assert(encoded_pdu_len =3D=3D pdu_len);
>
>   	encoded_pdu =3D encode_hex(pdu, encoded_pdu_len, 0);
> @@ -362,6 +373,39 @@ static void test_deliver_encode(void)
>   	g_assert(strcmp(alnum_sender, encoded_pdu) =3D=3D 0);
>
>   	g_free(encoded_pdu);
> +
> +	/* test unicode_deliver*/
> +	decoded_pdu =3D decode_hex(unicode_deliver, -1, &pdu_len, 0);
> +	g_assert(decoded_pdu);
> +	g_assert(pdu_len =3D=3D (long)strlen(unicode_deliver) / 2);
> +
> +	smsc_len =3D decoded_pdu[0] + 1;
> +	ret =3D sms_decode(decoded_pdu, pdu_len, FALSE, pdu_len - smsc_len, &sm=
s);
> +
> +	g_free(decoded_pdu);
> +
> +	g_assert(ret);
> +	g_assert(sms.type =3D=3D SMS_TYPE_DELIVER);
> +
> +	ret =3D sms_encode(&sms, &encoded_pdu_len, &encoded_tpdu_len, pdu);
> +
> +	if (g_test_verbose()) {
> +		int i;
> +
> +		for (i =3D 0; i < encoded_pdu_len; i++)
> +			g_print("%02X", pdu[i]);
> +		g_print("\n");
> +	}
> +
> +	g_assert(ret);
> +	g_assert(encoded_tpdu_len =3D=3D pdu_len - smsc_len);
> +	g_assert(encoded_pdu_len =3D=3D pdu_len);
> +
> +	encoded_pdu =3D encode_hex(pdu, encoded_pdu_len, 0);
> +
> +	g_assert(strcmp(unicode_deliver, encoded_pdu) =3D=3D 0);
> +
> +	g_free(encoded_pdu);
>   }
>
>   static void test_simple_submit(void)
>

Regards,
-Denis

--===============7870370897852491164==--

