Content-Type: multipart/mixed; boundary="===============7699325198520655057=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Checking PIN length based on its type (PIN / PUK / NET).
Date: Fri, 19 Mar 2010 10:25:32 -0500
Message-ID: <201003191025.32736.denkenz@gmail.com>
In-Reply-To: <1269010831-21798-1-git-send-email-ppessi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7699325198520655057==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> -gboolean is_valid_pin(const char *pin)
> +gboolean is_valid_pin(const char *pin, enum pin_type type)
>  {
>  	unsigned int i;
> =

> @@ -588,14 +588,30 @@ gboolean is_valid_pin(const char *pin)
>  	if (pin =3D=3D NULL || pin[0] =3D=3D '\0')
>  		return FALSE;
> =

> -	for (i =3D 0; i < strlen(pin); i++)
> -		if (pin[i] < '0' || pin[i] > '9')
> -			return FALSE;
> -
> -	if (i > 8)
> +	i =3D strlen(pin);
> +	if (i !=3D strspn(pin, "012345679"))
>  		return FALSE;
> =

> -	return TRUE;
> +	switch (type)
> +	{
> +	case PIN_TYPE_PIN:
> +		/* 11.11 Section 9.3 ("CHV"): 4..8 IA-5 digits */
> +		if (4 <=3D i && i <=3D 8)
> +			return TRUE;

This looks wrong, 'break' is missing.

> +	case PIN_TYPE_PUK:
> +		/* 11.11 Section 9.3 ("UNBLOCK CHV"), 8 IA-5 digits */
> +		if (i =3D=3D 8)
> +			return TRUE;

Same here

> +	case PIN_TYPE_NET:
> +		/* 22.004 Section 5.2, 4 IA-5 digits */
> +		if (i =3D=3D 4)
> +			return TRUE;

And here

> +	case PIN_TYPE_NONE:
> +		if (i < 8)
> +			return TRUE;
> +	}

and here

> +
> +	return FALSE;
>  }

> =

> -gboolean is_valid_pin(const char *pin);
> +
> +
> +gboolean is_valid_pin(const char *pin, enum pin_type type);

Why the extra lines?

Regards,
-Denis

--===============7699325198520655057==--

