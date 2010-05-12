Content-Type: multipart/mixed; boundary="===============0061578763932608683=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/1] Add telephony_str_to_error to decode error code
Date: Wed, 12 May 2010 14:02:17 -0500
Message-ID: <201005121402.18171.denkenz@gmail.com>
In-Reply-To: <1273651973-2461-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0061578763932608683==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> +static gboolean search_entry(const char *str, struct error_entry *e,
> +						int maxentries,
> +						enum ofono_error_type type,
> +						struct ofono_error *error)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < maxentries; i++) {
> +		if (!strcmp(e[i].str, str)) {
> +			error->type =3D type;
> +			error->error =3D e[i].error;
> +			return TRUE;
> +		}
> +	}
> +
> +	return FALSE;
> +}

This doesn't really make sense, the errors from the modem usually come in t=
he =

form of +CMS ERROR: 123 assuming we enabled +CMEE=3D1.  If we enabled +CMEE=
=3D2 =

then the numeric error code gets converted to a string.  The former is =

preferable as the string might be different from what oFono has.  What you'=
re =

matching here will always result in an unknown error.

Regards,
-Denis

--===============0061578763932608683==--

