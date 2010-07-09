Content-Type: multipart/mixed; boundary="===============3563861163693190486=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH 1/9] stkutil: display text attributes as html
Date: Fri, 09 Jul 2010 14:58:26 -0700
Message-ID: <20100709145826.17b28eae@kcaccard-MOBL3>
In-Reply-To: <4C365614.3000105@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3563861163693190486==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 08 Jul 2010 17:49:56 -0500
Denis Kenzior <denkenz@gmail.com> wrote:

> > +		/*
> > +		 * if the alignment is the same as either the default
> > +		 * or the last alignment used, don't set any alignment
> > +		 * value.
> > +		 */
> > +		if (start =3D=3D 0)
> > +			align =3D STK_DEFAULT_TEXT_ALIGNMENT;
> > +		else {
> > +			align =3D (formats[start - 1] & 0xFF) &
> > +					STK_TEXT_FORMAT_ALIGN_MASK;
> > +			if (align =3D=3D STK_TEXT_FORMAT_NO_ALIGN)
> > +				align =3D STK_DEFAULT_TEXT_ALIGNMENT;
> > +		}
> > +
> > +		if ((code & STK_TEXT_FORMAT_ALIGN_MASK) =3D=3D align)
> > +			code |=3D STK_TEXT_FORMAT_NO_ALIGN;
> > +  =

> =

> So I think the above code is actually incorrect.  The spec talks about
> Language dependent (default) alignment being equal to
> STK_DEFAULT_TEXT_ALIGNMENT.  So if the SIM sends us a Left aligned
> attribute, it really means Left aligned.
> =

> Maybe something like this is enough?
> =

> if (start =3D=3D 0)
> 	align =3D STK_TEXT_FORMAT_NO_ALIGN;
> else
> 	align =3D formats[start - 1] & STK_TEXT_FORMAT_ALIGN_MASK;

I agree with you that this does not match the spec.  I did this
deliberately, because I had a problem deciding how to deal with =

the test case which you requested I include, which was defined =

in test_sms.c (header_test).  I included the test case below
for your reference.

static struct html_attr_test html_attr_data_1 =3D {
        .text =3D "EMS messages can contain italic, bold, large, small and "
                "colored text",
        .text_attr =3D {
                .len =3D 20,
                .attributes =3D { 0x19, 0x06, 0x20, 0x00, 0x21, 0x04, 0x10,=
 0x00,
                                0x27, 0x05, 0x04, 0x00, 0x2E, 0x05, 0x08, 0=
x00,
                                0x38, 0x07, 0x00, 0x2B },
        },
        .html =3D "EMS messages can contain <span style=3D\"font-style: "
                "italic;\">italic</span>, <span style=3D\"font-weight: bold=
;\">"
                "bold</span>, <span style=3D\"font-size: big;\">large</span=
>, "
                "<span style=3D\"font-size: small;\">small</span> and "
                "<span style=3D\"color: #FFFF00;background-color: #C11B17;\=
">"
                "colored</span> text",
};

So, you have your first formatting at start position 0x19, with
format code 0x20, and color not set (0x00).  Since previously
you had no formatting from the beginning to byte 0x19, and this
formatting specifies an alignment value of 0, if we interpret
this the way you suggest we will now insert a <div > tag with
left alignment specified at character 0x19, which would cause
a break in the text.  So, we can chose to interpret left
alignment as really meaning left alignment, which would be
correct according to the spec, but if this test case is truly
representative of what SIMs might send us, then we are going to
have some weird looking strings resulting.

How would you suggest handling this?

--===============3563861163693190486==--

