Content-Type: multipart/mixed; boundary="===============4707489023256357651=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] smsutil: <CR> is not necessarily a padding character in
 CBS message
Date: Fri, 27 Jul 2012 01:02:55 -0500
Message-ID: <50122F0F.4@gmail.com>
In-Reply-To: <1343401711-31526-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4707489023256357651==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 07/27/2012 10:08 AM, Philippe Nunes wrote:
> ---
>   src/smsutil.c |   37 ++++++++++++++++++++++++++++++-------
>   1 file changed, 30 insertions(+), 7 deletions(-)
>

The patch looks 'correct', but a few points below:

> diff --git a/src/smsutil.c b/src/smsutil.c
> index a541964..59eb7b1 100644
> --- a/src/smsutil.c
> +++ b/src/smsutil.c
> @@ -4090,7 +4090,7 @@ char *cbs_decode_text(GSList *cbs_list, char *iso63=
9_lang)
>   			unsigned char unpacked[CBS_MAX_GSM_CHARS];
>   			long written;
>   			int max_chars;
> -			int i;
> +			int i, j;
>
>   			max_chars =3D
>   				sms_text_capacity_gsm(CBS_MAX_GSM_CHARS, taken);
> @@ -4102,12 +4102,24 @@ char *cbs_decode_text(GSList *cbs_list, char *iso=
639_lang)
>   			i =3D iso639 ? 3 : 0;
>
>   			/*
> -			 * CR is a padding character, which means we can
> -			 * safely discard everything afterwards
> +			 * CR can be used as a padding character, which means
> +			 * we can safely discard everything afterwards
>   			 */
> +
>   			for (; i<  written; i++, bufsize++) {
> -				if (unpacked[i] =3D=3D '\r')
> -					break;
> +				if (unpacked[i] =3D=3D '\r') {
> +					/*
> +					 * check if this is a padding character or
> +					 * if it is a wanted<CR>
> +					 */
> +					for (j=3Di+1; j<  written; j++)

Why are you breaking the coding style here?  Specifically item M3.

> +						if (unpacked[j] !=3D '\r')
> +							break;
> +
> +					if (j =3D=3D written)
> +						break;
> +				}
> +
>
>   				buf[bufsize] =3D unpacked[i];
>   			}
> @@ -4135,8 +4147,19 @@ char *cbs_decode_text(GSList *cbs_list, char *iso6=
39_lang)
>   			}
>
>   			while (i<  max_offset) {
> -				if (ud[i] =3D=3D 0x00&&  ud[i+1] =3D=3D '\r')
> -					break;
> +				if (ud[i] =3D=3D 0x00&&  ud[i+1] =3D=3D '\r') {
> +					int j =3D i+2;
> +
> +					while (j<  max_offset) {
> +						if (ud[j] !=3D 0x00 || ud[j+1] !=3D '\r')
> +							break;
> +
> +						j +=3D 2;
> +					}
> +
> +					if (j =3D=3D max_offset)
> +						break;
> +				}

Two points here.

First of all, you're again breaking the coding style item M3.  I know =

the existing code is also in violation, but then the first patch in this =

series should be fixing that violation, and then adding the new code on =

top.  I'm not advocating that you fix all of smsutil.c, but at least fix =

up the local area you will be touching first.

Secondly, mildly nitpicking, but why are you using a 'for' loop in the =

first chunk and now a while loop here?  At the very least you can make =

the code shorter and be more consistent.

>
>   				buf[bufsize] =3D ud[i];
>   				buf[bufsize + 1] =3D ud[i+1];

I'd really prefer that patches like this one that fix bugs in the =

{sms,stk}util.c are accompanied by changes / additions to the respective =

unit test files.  Especially in this case, as I assume that you have a =

set of test data that this is failing on.

That way I can immediately reference the test data, sanity check it and =

run the unit test to verify that the code and your changes are working =

as expected.  Furthermore, any regressions are more easily caught in the =

future.

Regards,
-Denis

--===============4707489023256357651==--

