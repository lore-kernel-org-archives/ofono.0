Content-Type: multipart/mixed; boundary="===============7063144091658462492=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Patch on unsupported AT command
Date: Mon, 23 Nov 2009 04:54:36 -0600
Message-ID: <200911230454.36858.denkenz@gmail.com>
In-Reply-To: <1258957264.2993.12.camel@violet>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7063144091658462492==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> This is first of all violating the coding style with the indentation on
> the second line of the if, but it is also way too complicated.

There is actually a reason for this. =


>
> 	if (info->len =3D=3D -1 && !strcmp(line, info->terminator)
> 		return TRUE;

This part checks for static terminators, like "OK" or "BUSY" or ERROR.  We =
do =

whole string comparison here.

>
> 	if (info->len > 0 && !strncmp(line, info->terminator, ...))
> 		return TRUE;

This part checks for variable terminators.  E.g. +CMS ERROR: XXX.  These ar=
e =

well defined by the standard so we only do a prefix comparison for these.

Regards,
-Denis

--===============7063144091658462492==--

