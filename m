Content-Type: multipart/mixed; boundary="===============4288825741914851899=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] stkutil: display text attributes as html
Date: Thu, 01 Jul 2010 17:50:30 -0500
Message-ID: <4C2D1BB6.60700@gmail.com>
In-Reply-To: <AANLkTinrzAGtJW4Xg4U6rFdG6L6bbykaNDN0DZrGLG6y@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4288825741914851899==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>>> It would have a different signature because as far as I understand a
>>> separate array of attributes is sent in each segment (the start/len
>>> fields can't address more than 256 characters anyway).  So that
>>> function can be a wrapper around this function.
>>>
>>
>> It depends actually.  I'd like to avoid writing a separate EMS
>> concatenator, and re-use sms_decode_text.  This means that if possible,
>> I'd like this function to work on arbitrary length strings.  The text
>> attributes can be massaged pretty easily without knowing what's inside
>> the SMS message.
> =

> My point is that it won't work on a message longer than 256 bytes
> anyway, because you would need to either change how the attribute
> start byte is coded, or supplement each attribute with information
> about which segment it relates to.

I know, see my comment above about 'text attributes can be massaged..'

My thinking is that doing it inside this function is faster / easier in
the common case than writing a custom EMS message decoder.

Regards,
-Denis

--===============4288825741914851899==--

