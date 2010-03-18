Content-Type: multipart/mixed; boundary="===============7399625528515468671=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 7/7] Fix: isimodem handling of call barring services.
Date: Thu, 18 Mar 2010 11:51:29 -0500
Message-ID: <201003181151.29899.denkenz@gmail.com>
In-Reply-To: <1268923471-29059-7-git-send-email-ppessi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7399625528515468671==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> From: Pekka Pessi <Pekka.Pessi@nokia.com>
> =

> =

> Signed-off-by: Pekka Pessi <Pekka.Pessi@nokia.com>
> ---
>  drivers/isimodem/call-barring.c |   64
>  ++++++++++++++++++++------------------ drivers/isimodem/ss.h           |=
  =

>  28 +++++++++--------
>  2 files changed, 49 insertions(+), 43 deletions(-)
> @@ -105,7 +104,9 @@ static void isi_set(struct ofono_call_barring *barr,
>  const char *lock, DBG("lock code %s enable %d class %d password %s\n",
>  		lock, enable, cls, passwd);
> =

> -	if (!cbd || !passwd || strlen(passwd) > 4 || cls !=3D 7)
> +	if (!cbd || !lock)
> +		goto error;
> +	if (!passwd || strlen(passwd) !=3D 4 || strspn(passwd, "0123456789") !=
=3D 4)
>  		goto error;

I suggest not doing this checking in the driver code, if the core is sendin=
g =

you something you don't expect, let us fix the core.

> =

>  	if (strcmp(lock, "AO") =3D=3D 0)
> @@ -120,23 +121,23 @@ static void isi_set(struct ofono_call_barring *barr,
>  const char *lock, ss_code =3D SS_GSM_BARR_ALL_IN_ROAM;
>  	else if (strcmp(lock, "AB") =3D=3D 0)
>  		ss_code =3D SS_GSM_ALL_BARRINGS;
> +	else if (enable)
> +		/* Only Deactivate supports AG (333) and AC (353) */
> +		goto error;

Same here, to my knowledge the core never actually allows this.

> -	if (!cbd || strlen(old_passwd) > 4 || strlen(new_passwd) > 4)
> +	if (!cbd)
> +		goto error;
> +	if (strlen(old_passwd) !=3D 4 || strspn(old_passwd, "0123456789") !=3D =
4)
> +		goto error;
> +	if (strlen(new_passwd) !=3D 4 || strspn(new_passwd, "0123456789") !=3D =
4)
>  		goto error;

Again, let us fix the core so you guys don't have to do this checking.

Regards,
-Denis

--===============7399625528515468671==--

