Content-Type: multipart/mixed; boundary="===============1973874848249111379=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Patch on unsupported AT command
Date: Mon, 23 Nov 2009 17:08:27 +0100
Message-ID: <1258992507.2967.2.camel@violet>
In-Reply-To: <200911230454.36858.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1973874848249111379==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > This is first of all violating the coding style with the indentation on
> > the second line of the if, but it is also way too complicated.
> =

> There is actually a reason for this. =

> =

> >
> > 	if (info->len =3D=3D -1 && !strcmp(line, info->terminator)
> > 		return TRUE;
> =

> This part checks for static terminators, like "OK" or "BUSY" or ERROR.  W=
e do =

> whole string comparison here.
> =

> >
> > 	if (info->len > 0 && !strncmp(line, info->terminator, ...))
> > 		return TRUE;
> =

> This part checks for variable terminators.  E.g. +CMS ERROR: XXX.  These =
are =

> well defined by the standard so we only do a prefix comparison for these.

and your point is? I was just going by the pure algorithmic of the if
statement to make it actually readable without getting a headache ;)

Regards

Marcel




--===============1973874848249111379==--

