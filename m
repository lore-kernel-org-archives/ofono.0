Content-Type: multipart/mixed; boundary="===============3571656770437808195=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] stkutil: display text attributes as html
Date: Thu, 01 Jul 2010 16:15:35 -0500
Message-ID: <4C2D0577.5070708@gmail.com>
In-Reply-To: <20100701135459.40411dad@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3571656770437808195==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 07/01/2010 03:54 PM, Kristen Carlson Accardi wrote:
> On Thu, 01 Jul 2010 13:54:16 -0500
> Denis Kenzior <denkenz@gmail.com> wrote:
> =

>> Hi Kristen,
>>
>> On 07/01/2010 01:29 PM, Kristen Carlson Accardi wrote:
>>> On Thu, 01 Jul 2010 11:30:07 -0500
>>> Denis Kenzior <denkenz@gmail.com> wrote:
>>>
>>>>
>>>>> +		start =3D attrs[i++];
>>>>> +		len =3D attrs[i++];
>>>>> +		code =3D attrs[i++];
>>>>
>>>> You might want to be extra paranoid here that attrs_len is a multiple =
of 4.
>>>
>>> attrs_len does not have to be a multiple of 4.  I will add a sanity
>>> check to attrs_len to make sure it is at least >=3D i + 3.
>>>
>>
>> Then this code is incorrect, as it handles len 3 attrs only at the end
>> of the array.  Also please note that SIM Toolkit Text Attributes are
>> always coded on 4 bytes (see 102.223 Section 8.72 for details).  You
>> might want to assume 4 byte alignment or invent a data structure for
>> these attributes.
> =

> I should have said that attrs_len does not always have to be a multiple
> of 4 -- it is allowed to only have 3 byte attrs as the last attribute,
> so the code is correct.  However, since not all attributes are
> required to be of len 4, we can't just assume attrs_len is a multiple
> of 4.
> =


How do you figure this?  From 23.040 Section 9.2.3.24.10.1.1	Text Formatting

"Octet 4

This Octet may be omitted by setting the IED length accordingly."

From 102.223 Section 8.72:

"The Text Formatting is a sequence of one or several Text Formatting
items, each coded on 4 bytes.
The Text Formatting scheme used is the same as the Text Formatting
defined in TS 123 040 [27]."

So you either have to support a mixed 3 & 4 byte fields or you assume
all fields are 4 bytes.

Regards,
-Denis

--===============3571656770437808195==--

