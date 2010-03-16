Content-Type: multipart/mixed; boundary="===============0327793658198570578=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] Handle the conversion failure when parsing item
Date: Tue, 16 Mar 2010 14:27:54 -0600
Message-ID: <201003161527.55137.denkenz@gmail.com>
In-Reply-To: <1268764590.2700.20.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0327793658198570578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> > +	if (utf8 =3D=3D NULL)
> > +		return FALSE;
> > +
> > +	item->text =3D utf8;
> =

> Why bother with utf8 variable? Just do
> =

> 	if (item->text =3D=3D NULL)
> 		return FALSE;
> =


I actually find this acceptable because 'item' is a return structure, so we =

should avoid modifying it in case of an error.

Regards,
-Denis

--===============0327793658198570578==--

