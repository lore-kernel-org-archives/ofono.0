Content-Type: multipart/mixed; boundary="===============7713667662006027009=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [PATCH 1/9] stkutil: display text attributes as html
Date: Thu, 15 Jul 2010 22:17:58 +0200
Message-ID: <AANLkTikNE6jXa6Qhu33llLQGsUMnAGQPnchN_nBflHpB@mail.gmail.com>
In-Reply-To: <20100709145826.17b28eae@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7713667662006027009==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 9 July 2010 23:58, Kristen Carlson Accardi <kristen@linux.intel.com> w=
rote:
> On Thu, 08 Jul 2010 17:49:56 -0500
> Denis Kenzior <denkenz@gmail.com> wrote:
>
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* if the alignment is the s=
ame as either the default
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* or the last alignment use=
d, don't set any alignment
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* value.
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (start =3D=3D 0)
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 align=
 =3D STK_DEFAULT_TEXT_ALIGNMENT;
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else {
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 align=
 =3D (formats[start - 1] & 0xFF) &
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 STK_TEXT_FORMAT_ALIGN_=
MASK;
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (a=
lign =3D=3D STK_TEXT_FORMAT_NO_ALIGN)
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 align =3D STK_DEFAULT_TEXT_ALIGNMENT;
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> > +
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((code & STK_TEXT_FORMAT_ALIGN=
_MASK) =3D=3D align)
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 code =
|=3D STK_TEXT_FORMAT_NO_ALIGN;
>> > +
>>
>> So I think the above code is actually incorrect. =C2=A0The spec talks ab=
out
>> Language dependent (default) alignment being equal to
>> STK_DEFAULT_TEXT_ALIGNMENT. =C2=A0So if the SIM sends us a Left aligned
>> attribute, it really means Left aligned.
>>
>> Maybe something like this is enough?
>>
>> if (start =3D=3D 0)
>> =C2=A0 =C2=A0 =C2=A0 align =3D STK_TEXT_FORMAT_NO_ALIGN;
>> else
>> =C2=A0 =C2=A0 =C2=A0 align =3D formats[start - 1] & STK_TEXT_FORMAT_ALIG=
N_MASK;
>
> I agree with you that this does not match the spec. =C2=A0I did this
> deliberately, because I had a problem deciding how to deal with
> the test case which you requested I include, which was defined
> in test_sms.c (header_test). =C2=A0I included the test case below
> for your reference.
>
> static struct html_attr_test html_attr_data_1 =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.text =3D "EMS messages can contain italic, bo=
ld, large, small and "
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"colored text",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.text_attr =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.len =3D 20,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.attributes =3D { =
0x19, 0x06, 0x20, 0x00, 0x21, 0x04, 0x10, 0x00,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x27, 0x05, 0x04, 0x00, 0x2E, 0x05, 0=
x08, 0x00,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x38, 0x07, 0x00, 0x2B },
> =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.html =3D "EMS messages can contain <span styl=
e=3D\"font-style: "
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"italic;\">italic<=
/span>, <span style=3D\"font-weight: bold;\">"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"bold</span>, <spa=
n style=3D\"font-size: big;\">large</span>, "
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"<span style=3D\"f=
ont-size: small;\">small</span> and "
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"<span style=3D\"c=
olor: #FFFF00;background-color: #C11B17;\">"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"colored</span> te=
xt",
> };
>
> So, you have your first formatting at start position 0x19, with
> format code 0x20, and color not set (0x00). =C2=A0Since previously
> you had no formatting from the beginning to byte 0x19, and this
> formatting specifies an alignment value of 0, if we interpret
> this the way you suggest we will now insert a <div > tag with
> left alignment specified at character 0x19, which would cause
> a break in the text. =C2=A0So, we can chose to interpret left
> alignment as really meaning left alignment, which would be
> correct according to the spec, but if this test case is truly
> representative of what SIMs might send us, then we are going to
> have some weird looking strings resulting.

One idea to handle this was for the text_to_html function to take a
language parameter (for now it could just hardcode English) and decide
the default alignment based on it.  Then default alignment (bits 0:3
=3D=3D 3) would be treated same as left (or right).

This assumes the test is correct afterall, because it's not clear from 23 0=
40.

Best regards

--===============7713667662006027009==--

