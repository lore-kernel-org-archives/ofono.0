Content-Type: multipart/mixed; boundary="===============1641300864940175705=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/4] Handle the conversion failure when parsing item
Date: Tue, 16 Mar 2010 21:40:43 -0700
Message-ID: <1268800843.2700.36.camel@localhost.localdomain>
In-Reply-To: <201003161527.55137.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1641300864940175705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > > +	if (utf8 =3D=3D NULL)
> > > +		return FALSE;
> > > +
> > > +	item->text =3D utf8;
> > =

> > Why bother with utf8 variable? Just do
> > =

> > 	if (item->text =3D=3D NULL)
> > 		return FALSE;
> > =

> =

> I actually find this acceptable because 'item' is a return structure, so =
we =

> should avoid modifying it in case of an error.

in general it makes no difference since the assigned pointer will be the
same as the previous one. However this is a minor nitpick and nothing
major. So I am fine either way.

Regards

Marcel



--===============1641300864940175705==--

