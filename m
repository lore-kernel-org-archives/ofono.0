Content-Type: multipart/mixed; boundary="===============6537941166904063747=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] mbm: poll SIM status when initializing
Date: Wed, 14 Jul 2010 11:00:17 -0500
Message-ID: <4C3DDF11.4070505@gmail.com>
In-Reply-To: <1279122224-5274-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6537941166904063747==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> @@ -99,17 +102,35 @@ static void simpin_check(gboolean ok, GAtResult *res=
ult, gpointer user_data)
>  =

>  	DBG("");
>  =

> -	/* Modem returns error if there is no SIM in slot */
> +	/* Modem returns +CME ERROR: 10 if SIM is not ready. */
> +	if (!ok && result->final_or_pdu &&
> +		!strcmp(result->final_or_pdu, "+CME ERROR: 10")) {
> +		g_timeout_add_seconds(1, init_simpin_check, modem);
> +		return;
> +	}
> +
> +	/* Modem returns ERROR if there is no SIM in slot. */

What if the modem has no SIM present at all?  You might want to set a
retry threshold so that we don't poll the modem into oblivion.

Regards,
-Denis

--===============6537941166904063747==--

