Content-Type: multipart/mixed; boundary="===============9218390203195385021=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH] TODO: Add vCard export to SM/ME stores
Date: Wed, 09 Feb 2011 14:57:26 +0200
Message-ID: <AANLkTi=uBh=3q4n822sODLzbrSApPU-zCgDamFx3RRv4@mail.gmail.com>
In-Reply-To: <1290494233.13641.3.camel@aeonflux.mpl.access-company.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9218390203195385021==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

2010/11/23 Marcel Holtmann <marcel@holtmann.org>:
>> So the aa{sv} parameter/return value would be of format:
>> {
>> =C2=A0 'name' =C2=A0 =C2=A0: string,
>> =C2=A0 'group' =C2=A0 : string, =C2=A0 // optional, for eg. organization
>> =C2=A0 'hidden' =C2=A0: integer, =C2=A0// boolean value: defaults to 0
>> =C2=A0 'numbers' : array of dict {
>> =C2=A0 =C2=A0 'number' =C2=A0 : string,
>> =C2=A0 =C2=A0 'category' : integer
>> =C2=A0 },
>> =C2=A0 'emails' : array of dict {
>> =C2=A0 =C2=A0 'address' =C2=A0: string,
>> =C2=A0 =C2=A0 'category' : integer
>> =C2=A0 },
>> =C2=A0 'voip_uris' : array of dict {
>> =C2=A0 =C2=A0 'uri' =C2=A0 =C2=A0 =C2=A0: string,
>> =C2=A0 =C2=A0 'category' : integer
>> =C2=A0 },
>> }
>>
>> category : enum { // like existing "enum phonebook_number_type"
>> =C2=A0 HOME, MOBILE, FAX, WORK, OTHER
>> }
>
> this feels a bit too complicated for me. I actually don't want to
> over-design this feature, but it does have to be consistent with our
> other key names.

I agree, how about a strict subset of the spec, like a dict of name -> numb=
er?

> To be honest, the more and more I think about this, the more my
> conclusion is to not support phonebook export. It is a bad idea. It is
> highly complex and it is not a feature that will be used anyway.

I tend to agree. However, people seem to really want to have this
export(), so we need to arrive at some reasonable conclusion here.

Cheers,
Aki

--===============9218390203195385021==--

