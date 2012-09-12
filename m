Content-Type: multipart/mixed; boundary="===============5876822963011747600=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] netreg: Add telit version for ciev notification
Date: Tue, 11 Sep 2012 23:24:19 -0500
Message-ID: <50500E73.1090202@gmail.com>
In-Reply-To: <1346924958-32644-1-git-send-email-christopher.vogl@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5876822963011747600==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

On 09/06/2012 04:49 AM, christopher.vogl(a)hale.at wrote:
> From: Christopher Vogl<christopher.vogl@hale.at>
>
> ---
>   drivers/atmodem/network-registration.c |   44 +++++++++++++++++++++++++=
+++++++
>   1 files changed, 44 insertions(+), 0 deletions(-)
>

Patch has been applied, however:

> @@ -1618,6 +1649,19 @@ static void cind_support_cb(gboolean ok, GAtResult=
 *result, gpointer user_data)
>   				at_cmer_query_cb, netreg, NULL);
>   	g_at_chat_register(nd->chat, "+CIEV:",
>   				ciev_notify, FALSE, netreg, NULL);
> +
> +	/*
> +	 * Telit uses strings instead of numbers to identify indicators
> +	 * in a +CIEV URC.
> +	 * Handle them in a separate function to keep the code clean.
> +	 */
> +	if (nd->vendor =3D=3D OFONO_VENDOR_TELIT)
> +		g_at_chat_register(nd->chat, "+CIEV:",
> +				telit_ciev_notify, FALSE, netreg, NULL);
> +	else
> +		g_at_chat_register(nd->chat, "+CIEV:",
> +				ciev_notify, FALSE, netreg, NULL);
> +

You ended up registering for +CIEV twice, so I took that out in commit =

bb0f308223816e53de0a5a6a2cdb6eb1f11856c8.

>   	g_at_chat_register(nd->chat, "+CREG:",
>   				creg_notify, FALSE, netreg, NULL);
>

Also, I made failing to initialize +CMER fatal in commit =

b274e74102c7a4b96c06dba895cf0cb444fa54c3.  Can you please double-check =

that it is working as intended, I only performed basic sanity checking =

on my end.

Regards,
-Denis

--===============5876822963011747600==--

