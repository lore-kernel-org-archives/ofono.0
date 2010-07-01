Content-Type: multipart/mixed; boundary="===============1251315580020297505=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] stkutil: display text attributes as html
Date: Thu, 01 Jul 2010 13:54:16 -0500
Message-ID: <4C2CE458.2080806@gmail.com>
In-Reply-To: <20100701112903.0d4cd35f@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1251315580020297505==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

On 07/01/2010 01:29 PM, Kristen Carlson Accardi wrote:
> On Thu, 01 Jul 2010 11:30:07 -0500
> Denis Kenzior <denkenz@gmail.com> wrote:
> =

>>
>>> +		start =3D attrs[i++];
>>> +		len =3D attrs[i++];
>>> +		code =3D attrs[i++];
>>
>> You might want to be extra paranoid here that attrs_len is a multiple of=
 4.
> =

> attrs_len does not have to be a multiple of 4.  I will add a sanity
> check to attrs_len to make sure it is at least >=3D i + 3.
> =


Then this code is incorrect, as it handles len 3 attrs only at the end
of the array.  Also please note that SIM Toolkit Text Attributes are
always coded on 4 bytes (see 102.223 Section 8.72 for details).  You
might want to assume 4 byte alignment or invent a data structure for
these attributes.

>>
>>> +
>>> +		if (i < attrs_len)
>>> +			color =3D attrs[i++];
>>> +		else
>>> +			color =3D 0;
>>> +
>>> +		if (len =3D=3D 0)
>>> +			end =3D text_len;
>>> +		else
>>> +			end =3D start + len;
>>> +
>>> +		/* sanity check values */
>>> +		if (start > end || end > text_len)
>>> +			continue;
>>> +
>>> +		/*
>>> +		 * if the alignment is the same as either the default
>>> +		 * or the last alignment used, don't set any alignment
>>> +		 * value.
>>> +		 */
>>> +		if (start =3D=3D 0)
>>> +			align =3D STK_DEFAULT_TEXT_ALIGNMENT;
>>
>> Are attributes which do not contain start =3D 0 valid?  If so, you might
>> take extra care here.
> =

> Yes start can be nonzero, but I don't understand what you are asking here.
> If start is not equal to zero, we have already made sure it is not
> greater than the end.

I'm not seeing how align gets initialized properly if start !=3D 0.

Regards,
-Denis

--===============1251315580020297505==--

