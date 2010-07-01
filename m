Content-Type: multipart/mixed; boundary="===============3465404692032053126=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] stkutil: display text attributes as html
Date: Thu, 01 Jul 2010 18:08:47 -0500
Message-ID: <4C2D1FFF.8050308@gmail.com>
In-Reply-To: <20100701155656.6cbabca3@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3465404692032053126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

>>>> Then this code is incorrect, as it handles len 3 attrs only at the end
>>>> of the array.  Also please note that SIM Toolkit Text Attributes are
>>>> always coded on 4 bytes (see 102.223 Section 8.72 for details).  You
>>>> might want to assume 4 byte alignment or invent a data structure for
>>>> these attributes.
>>>
>>> I should have said that attrs_len does not always have to be a multiple
>>> of 4 -- it is allowed to only have 3 byte attrs as the last attribute,
>>> so the code is correct.  However, since not all attributes are
>>> required to be of len 4, we can't just assume attrs_len is a multiple
>>> of 4.
>>>
>>
>> How do you figure this?  From 23.040 Section 9.2.3.24.10.1.1	Text Format=
ting
>>
>> "Octet 4
>>
>> This Octet may be omitted by setting the IED length accordingly."
> =

> This isn't the clearest language, so my interpretation of this is
> you may omit one byte if you set the length properly.  Clearly
> the spec tell you that the byte is optional, so I think it would
> be wrong to assume that all are 4 bytes.  Also, since obviously
> we can't support mixed 3 and 4 byte fields since we'd have no
> way to know if the next byte was the start of the next attribute,
> it's got to be at the end of the array.

Actually it is not.  Each Text attribute is put into an SMS header, with
the header having an IEI (Information Element Identifier), Length and
Data.  See SMS_IEI_TEXT_FORMAT in smsutil.h

Hence, when an EMS PDU is parsed, you know whether this is a 3 byte or a
4 byte element.

Regards,
-Denis

--===============3465404692032053126==--

