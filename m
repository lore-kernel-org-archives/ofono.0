Content-Type: multipart/mixed; boundary="===============4287055073421104829=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH 1/3] stkutil: display text attributes as html
Date: Thu, 01 Jul 2010 15:56:56 -0700
Message-ID: <20100701155656.6cbabca3@kcaccard-MOBL3>
In-Reply-To: <4C2D0577.5070708@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4287055073421104829==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 01 Jul 2010 16:15:35 -0500
Denis Kenzior <denkenz@gmail.com> wrote:

> On 07/01/2010 03:54 PM, Kristen Carlson Accardi wrote:
> > On Thu, 01 Jul 2010 13:54:16 -0500
> > Denis Kenzior <denkenz@gmail.com> wrote:
> > =

> >> Hi Kristen,
> >>
> >> On 07/01/2010 01:29 PM, Kristen Carlson Accardi wrote:
> >>> On Thu, 01 Jul 2010 11:30:07 -0500
> >>> Denis Kenzior <denkenz@gmail.com> wrote:
> >>>
> >>>>
> >>>>> +		start =3D attrs[i++];
> >>>>> +		len =3D attrs[i++];
> >>>>> +		code =3D attrs[i++];
> >>>>
> >>>> You might want to be extra paranoid here that attrs_len is a multipl=
e of 4.
> >>>
> >>> attrs_len does not have to be a multiple of 4.  I will add a sanity
> >>> check to attrs_len to make sure it is at least >=3D i + 3.
> >>>
> >>
> >> Then this code is incorrect, as it handles len 3 attrs only at the end
> >> of the array.  Also please note that SIM Toolkit Text Attributes are
> >> always coded on 4 bytes (see 102.223 Section 8.72 for details).  You
> >> might want to assume 4 byte alignment or invent a data structure for
> >> these attributes.
> > =

> > I should have said that attrs_len does not always have to be a multiple
> > of 4 -- it is allowed to only have 3 byte attrs as the last attribute,
> > so the code is correct.  However, since not all attributes are
> > required to be of len 4, we can't just assume attrs_len is a multiple
> > of 4.
> > =

> =

> How do you figure this?  From 23.040 Section 9.2.3.24.10.1.1	Text Formatt=
ing
> =

> "Octet 4
> =

> This Octet may be omitted by setting the IED length accordingly."

This isn't the clearest language, so my interpretation of this is
you may omit one byte if you set the length properly.  Clearly
the spec tell you that the byte is optional, so I think it would
be wrong to assume that all are 4 bytes.  Also, since obviously
we can't support mixed 3 and 4 byte fields since we'd have no
way to know if the next byte was the start of the next attribute,
it's got to be at the end of the array.

> =

> From 102.223 Section 8.72:
> =

> "The Text Formatting is a sequence of one or several Text Formatting
> items, each coded on 4 bytes.
> The Text Formatting scheme used is the same as the Text Formatting
> defined in TS 123 040 [27]."
> =

> So you either have to support a mixed 3 & 4 byte fields or you assume
> all fields are 4 bytes.
> =

> Regards,
> -Denis


--===============4287055073421104829==--

