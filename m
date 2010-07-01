Content-Type: multipart/mixed; boundary="===============7250040266172266180=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH 1/3] stkutil: display text attributes as html
Date: Thu, 01 Jul 2010 13:54:59 -0700
Message-ID: <20100701135459.40411dad@kcaccard-MOBL3>
In-Reply-To: <4C2CE458.2080806@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7250040266172266180==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 01 Jul 2010 13:54:16 -0500
Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Kristen,
> =

> On 07/01/2010 01:29 PM, Kristen Carlson Accardi wrote:
> > On Thu, 01 Jul 2010 11:30:07 -0500
> > Denis Kenzior <denkenz@gmail.com> wrote:
> > =

> >>
> >>> +		start =3D attrs[i++];
> >>> +		len =3D attrs[i++];
> >>> +		code =3D attrs[i++];
> >>
> >> You might want to be extra paranoid here that attrs_len is a multiple =
of 4.
> > =

> > attrs_len does not have to be a multiple of 4.  I will add a sanity
> > check to attrs_len to make sure it is at least >=3D i + 3.
> > =

> =

> Then this code is incorrect, as it handles len 3 attrs only at the end
> of the array.  Also please note that SIM Toolkit Text Attributes are
> always coded on 4 bytes (see 102.223 Section 8.72 for details).  You
> might want to assume 4 byte alignment or invent a data structure for
> these attributes.

I should have said that attrs_len does not always have to be a multiple
of 4 -- it is allowed to only have 3 byte attrs as the last attribute,
so the code is correct.  However, since not all attributes are
required to be of len 4, we can't just assume attrs_len is a multiple
of 4.

> =

> >>
> >>> +
> >>> +		if (i < attrs_len)
> >>> +			color =3D attrs[i++];
> >>> +		else
> >>> +			color =3D 0;
> >>> +
> >>> +		if (len =3D=3D 0)
> >>> +			end =3D text_len;
> >>> +		else
> >>> +			end =3D start + len;
> >>> +
> >>> +		/* sanity check values */
> >>> +		if (start > end || end > text_len)
> >>> +			continue;
> >>> +
> >>> +		/*
> >>> +		 * if the alignment is the same as either the default
> >>> +		 * or the last alignment used, don't set any alignment
> >>> +		 * value.
> >>> +		 */
> >>> +		if (start =3D=3D 0)
> >>> +			align =3D STK_DEFAULT_TEXT_ALIGNMENT;
> >>
> >> Are attributes which do not contain start =3D 0 valid?  If so, you mig=
ht
> >> take extra care here.
> > =

> > Yes start can be nonzero, but I don't understand what you are asking he=
re.
> > If start is not equal to zero, we have already made sure it is not
> > greater than the end.
> =

> I'm not seeing how align gets initialized properly if start !=3D 0.

I snipped that part off of my reply, sorry.  Here is the code as I
originally sent it:
 		/*
                 * if the alignment is the same as either the default
                 * or the last alignment used, don't set any alignment
                 * value.
                 */
                if (start =3D=3D 0)
                        align =3D STK_DEFAULT_TEXT_ALIGNMENT;
                else {
                        align =3D (formats[start -1] & 0xFF) &
                                        STK_TEXT_FORMAT_ALIGN_MASK;
                        if (align =3D=3D STK_TEXT_FORMAT_NO_ALIGN)
                                align =3D STK_DEFAULT_TEXT_ALIGNMENT;
                }

so if start !=3D zero, align is set to the previous alignment value.
(formats[start - 1]).

Thanks,
Kristen

--===============7250040266172266180==--

