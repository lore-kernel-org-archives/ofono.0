Content-Type: multipart/mixed; boundary="===============1576336029631362359=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: Patch on unsupported AT command
Date: Mon, 23 Nov 2009 07:21:04 +0100
Message-ID: <1258957264.2993.12.camel@violet>
In-Reply-To: <38D9F46DFF92C54980D2F2C1E8EE313001B4CCBCF2@pdsmsx503.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1576336029631362359==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

looks good so far, but ...

> +static gboolean check_terminator(struct terminator_info *info, char
> *line)
> +{
> +       if ((info->len =3D=3D -1 && !strcmp(line, info->terminator)) ||
> +               (info->len > 0 && !strncmp(line, info->terminator,
> info->len)))
> +               return TRUE;
> +       else
> +               return FALSE;
> +}
> + =


This is first of all violating the coding style with the indentation on
the second line of the if, but it is also way too complicated.

	if (info->len =3D=3D -1 && !strcmp(line, info->terminator)
		return TRUE;

	if (info->len > 0 && !strncmp(line, info->terminator, ...))
		return TRUE;

	return FALSE;

Maybe it is too early in the morning to do code review, but this should
be doing the same, but be a lot simpler to read ;)

Regards

Marcel



--===============1576336029631362359==--

