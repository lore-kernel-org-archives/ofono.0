Content-Type: multipart/mixed; boundary="===============2587935762486481927=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Fix: simplify isimodem call-barring driver.
Date: Tue, 23 Mar 2010 16:53:13 -0500
Message-ID: <201003231653.14125.denkenz@gmail.com>
In-Reply-To: <1269366372-19526-1-git-send-email-ppessi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2587935762486481927==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> From: Pekka Pessi <Pekka.Pessi@nokia.com>
> =

> Add support for lock codes AG and AC (MMI codes 333 and 353. respectively=
).

First of all, please keep your commit messages less than 72 characters long =

and headings less than 50 characters long.

Secondly, please keep your patches whitespace clean, there are several case=
s =

of spaces being used instead of tabs for indentation.

> ---
>  drivers/isimodem/call-barring.c |  153
>  ++++++++++++--------------------------- drivers/isimodem/ss.h           =
| =

>   28 ++++----
>  2 files changed, 63 insertions(+), 118 deletions(-)
> =

> diff --git a/drivers/isimodem/call-barring.c
>  b/drivers/isimodem/call-barring.c index 6487ae8..b0246fa 100644
> --- a/drivers/isimodem/call-barring.c
> +++ b/drivers/isimodem/call-barring.c
> @@ -48,6 +48,28 @@ struct barr_data {
>  	GIsiClient *client;
>  };

> =

> +	DBG("lock code %s (%u) old password %s new password %s\n",
> +	    lock, ss_code, old_passwd, new_passwd);

Here is an instance of whitespace error.

> -	if (g_isi_request_make(bd->client, msg, sizeof(msg), SS_TIMEOUT,
> +	if (cbd &&
> +	    g_isi_request_make(bd->client, msg, sizeof(msg), SS_TIMEOUT,
>  				set_passwd_resp_cb, cbd))
>  		return;

Here's another one..

>  enum ss_codes {
> -	SS_GSM_ALL_FORWARDINGS =3D 0x02,
> -	SS_GSM_ALL_COND_FORWARDINGS =3D 0x04,
> -	SS_GSM_FORW_UNCONDITIONAL =3D 0x15,
> -	SS_GSM_BARR_ALL_OUT =3D 0x21,
> -	SS_GSM_BARR_ALL_IN =3D 0x23,
> -	SS_GSM_CALL_WAITING =3D 0x2B,
> -	SS_GSM_FORW_NO_REPLY =3D 0x3D,
> -	SS_GSM_FORW_NO_REACH =3D 0x3E,
> -	SS_GSM_FORW_BUSY =3D 0x43,
> -	SS_GSM_ALL_BARRINGS =3D 0x014A,
> -	SS_GSM_BARR_OUT_INTER =3D 0x014B,
> -	SS_GSM_BARR_OUT_INTER_EXC_HOME =3D 0x014C,
> -	SS_GSM_BARR_ALL_IN_ROAM =3D 0x015F
> +	SS_GSM_ALL_FORWARDINGS =3D 002,
> +	SS_GSM_ALL_COND_FORWARDINGS =3D 004,

Are you sure this isn't octal syntax?  It still works, but you might simply =

use 2 and 4  here.

> +	SS_GSM_FORW_UNCONDITIONAL =3D 21,
> +	SS_GSM_BARR_ALL_OUT =3D 33,
> +	SS_GSM_OUTGOING_BARR_SERV =3D 333,
> +	SS_GSM_INCOMING_BARR_SERV =3D 353,
> +	SS_GSM_BARR_ALL_IN =3D 35,
> +	SS_GSM_CALL_WAITING =3D 43,
> +	SS_GSM_FORW_NO_REPLY =3D 61,
> +	SS_GSM_FORW_NO_REACH =3D 62,
> +	SS_GSM_FORW_BUSY =3D 67,
> +	SS_GSM_ALL_BARRINGS =3D 330,
> +	SS_GSM_BARR_OUT_INTER =3D 331,
> +	SS_GSM_BARR_OUT_INTER_EXC_HOME =3D 332,
> +	SS_GSM_BARR_ALL_IN_ROAM =3D 351,
>  };

From now on we'll require all enum values to be tab aligned so they're a bi=
t =

easier to read.  See src/stkutil.h for reference.

Regards,
-Denis

--===============2587935762486481927==--

