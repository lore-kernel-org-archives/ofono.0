Content-Type: multipart/mixed; boundary="===============1689407188615968701=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/9] stkutil: display text attributes as html
Date: Fri, 09 Jul 2010 17:13:57 -0500
Message-ID: <4C379F25.9090302@gmail.com>
In-Reply-To: <20100709145826.17b28eae@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1689407188615968701==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> I agree with you that this does not match the spec.  I did this
> deliberately, because I had a problem deciding how to deal with =

> the test case which you requested I include, which was defined =

> in test_sms.c (header_test).  I included the test case below
> for your reference.
> =

> static struct html_attr_test html_attr_data_1 =3D {
>         .text =3D "EMS messages can contain italic, bold, large, small an=
d "
>                 "colored text",
>         .text_attr =3D {
>                 .len =3D 20,
>                 .attributes =3D { 0x19, 0x06, 0x20, 0x00, 0x21, 0x04, 0x1=
0, 0x00,
>                                 0x27, 0x05, 0x04, 0x00, 0x2E, 0x05, 0x08,=
 0x00,
>                                 0x38, 0x07, 0x00, 0x2B },
>         },
>         .html =3D "EMS messages can contain <span style=3D\"font-style: "
>                 "italic;\">italic</span>, <span style=3D\"font-weight: bo=
ld;\">"
>                 "bold</span>, <span style=3D\"font-size: big;\">large</sp=
an>, "
>                 "<span style=3D\"font-size: small;\">small</span> and "
>                 "<span style=3D\"color: #FFFF00;background-color: #C11B17=
;\">"
>                 "colored</span> text",
> };
> =

> So, you have your first formatting at start position 0x19, with
> format code 0x20, and color not set (0x00).  Since previously
> you had no formatting from the beginning to byte 0x19, and this
> formatting specifies an alignment value of 0, if we interpret
> this the way you suggest we will now insert a <div > tag with
> left alignment specified at character 0x19, which would cause
> a break in the text.  So, we can chose to interpret left
> alignment as really meaning left alignment, which would be
> correct according to the spec, but if this test case is truly
> representative of what SIMs might send us, then we are going to
> have some weird looking strings resulting.
> =

> How would you suggest handling this?

The above test is pretty arbitrary, so I wouldn't worry too much about
it.  I think that the explicit left alignment is better and is in line
with tests from 102.384.

However, maybe generating some additional SMS messages with EMS text
attributes for testing might be a good idea.  See if anyone has an old
Sony Ericsson mobile around?

Regards,
-Denis

--===============1689407188615968701==--

