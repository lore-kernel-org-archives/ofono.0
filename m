Content-Type: multipart/mixed; boundary="===============4592452686035565586=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/7] src: Introduced enum called_number_type
Date: Mon, 24 Jan 2011 16:19:09 -0600
Message-ID: <4D3DFADD.1090905@gmail.com>
In-Reply-To: <1295777796-19978-2-git-send-email-george@matveev.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4592452686035565586==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi George,

> +/* 24.008 Section 10.5.4.7 Called party BCD number */
> +enum called_number_type {
> +	CALLED_NUMBER_TYPE_UNKNOWN =3D 0,
> +	CALLED_NUMBER_TYPE_INTERNATIONAL =3D 1,
> +	CALLED_NUMBER_TYPE_NATIONAL =3D 2,
> +	CALLED_NUMBER_TYPE_NETWORK_SPECIFIC =3D 3,
> +	CALLED_NUMBER_TYPE_DEDICATED_ACCESS =3D 4,
> +	CALLED_NUMBER_TYPE_RESERVED =3D 7
> +};
> +

This isn't going to work.  Your patches basically break all voice call
drivers that we have.  I refer you to stemodem ecav_notify function or
the calypsomodem cpi parser.  The number type is not handled properly there.

27.007 uses three main ton/npi combinations:

unknown / unknown (128)
unknown / isdn (129)
international / isdn (145)

If you want to be pedantic, then define an enum something like this:

enum number_type {
	NUMBER_TYPE_UNKNOWN,
	NUMBER_TYPE_UNKNOWN_ISDN,
	NUMBER_TYPE_INTERNATIONAL_ISDN,
};

And just handle these three appropriately.

Alternatively decompose the value into the appropriate bit-fields and
compare the bit-field values.  E.g. bits 1..4 -> npi.  Bits 5..7 -> ton
and define enums for them appropriately.  This will still be a messier
solution than assigning the values 128/129 (in fact 27.007 recommends
assigning these values anyway).

Regards,
-Denis

--===============4592452686035565586==--

