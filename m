Content-Type: multipart/mixed; boundary="===============5468134792676556466=="
MIME-Version: 1.0
From: Santtu Lakkala <inz@inz.fi>
Subject: Re: [PATCH] [RFC] Do the PIN check in SIMManager
Date: Mon, 07 Sep 2009 12:53:16 +0300
Message-ID: <4AA4D80C.1090104@inz.fi>
In-Reply-To: <1252135553-32722-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5468134792676556466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrzej Zaborowski wrote:
> This adds checking whether PIN is required during SIM initialisation and
> delaying the sim ready notifications until after correct PIN is given.
> According to 31.102 the IMSI should be retrieved after the PIN check
> however on the SIMs I've tried it can be retrieved before authentication
> and I think it would make sense to provide the imsi to the clients so
> they know which card they're authenticating to if they're swapping cards.

> +		for (i =3D 0; i < len; i++)
> +			if (!g_str_has_suffix(pin_required,
> +						at_sim_name[i].name))
> +				pin_type =3D at_sim_name[i].type;

Should this be:
> +		for (i =3D 0; i < len; i++)
> +			if (g_str_has_suffix(pin_required,
> +						at_sim_name[i].name)) {
> +				pin_type =3D at_sim_name[i].type;
> +				break;
> +			}

With the original code, I always get PH-CORP PUK (or PH-CORP PIN, should
 the required code be PH-CORP PUK).

- --
Santtu Lakkala
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkqk2AwACgkQX9Rc0+po4p1YVQCgl//9VD6QQ+BmRBqtIn9/pRMH
ticAn0QT9CvLrtQp/6cVLT0dwg8xe5q4
=3DR/Q0
-----END PGP SIGNATURE-----

--===============5468134792676556466==--

