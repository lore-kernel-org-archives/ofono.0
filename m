Content-Type: multipart/mixed; boundary="===============8422385723593973725=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH 1/3] stkutil: display text attributes as html
Date: Thu, 01 Jul 2010 11:29:03 -0700
Message-ID: <20100701112903.0d4cd35f@kcaccard-MOBL3>
In-Reply-To: <4C2CC28F.2000707@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8422385723593973725==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 01 Jul 2010 11:30:07 -0500
Denis Kenzior <denkenz@gmail.com> wrote:

> =

> > +		start =3D attrs[i++];
> > +		len =3D attrs[i++];
> > +		code =3D attrs[i++];
> =

> You might want to be extra paranoid here that attrs_len is a multiple of =
4.

attrs_len does not have to be a multiple of 4.  I will add a sanity
check to attrs_len to make sure it is at least >=3D i + 3.

> =

> > +
> > +		if (i < attrs_len)
> > +			color =3D attrs[i++];
> > +		else
> > +			color =3D 0;
> > +
> > +		if (len =3D=3D 0)
> > +			end =3D text_len;
> > +		else
> > +			end =3D start + len;
> > +
> > +		/* sanity check values */
> > +		if (start > end || end > text_len)
> > +			continue;
> > +
> > +		/*
> > +		 * if the alignment is the same as either the default
> > +		 * or the last alignment used, don't set any alignment
> > +		 * value.
> > +		 */
> > +		if (start =3D=3D 0)
> > +			align =3D STK_DEFAULT_TEXT_ALIGNMENT;
> =

> Are attributes which do not contain start =3D 0 valid?  If so, you might
> take extra care here.

Yes start can be nonzero, but I don't understand what you are asking here.
If start is not equal to zero, we have already made sure it is not
greater than the end.

Thanks,
Kristen

--===============8422385723593973725==--

