Content-Type: multipart/mixed; boundary="===============6231009660933566716=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 0/4] Add support for CPHS customer service profile
Date: Wed, 26 Jan 2011 12:34:22 +0200
Message-ID: <AANLkTikjEDQNLxFR3=fCBk_OYd0Eic64a_JcFHVUDGmU@mail.gmail.com>
In-Reply-To: <1296037726.1520.110.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6231009660933566716==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

2011/1/26 Marcel Holtmann <marcel@holtmann.org>:
>> > one open question here is still if we also have to disallow scanning
>> > when this is set?
>> >
>> > So we might wanna update the Scan() and Register() method with the
>> > proper error codes and put a note in there for mode =3D "auto-only".
>>
>> Good point, it's also missing from the Scan() implementation. I meant
>> to add it for but forgot. I'll send a v2 shortly.
>>
>> The other open item was whether to create a new error code for this or
>> reuse the existing access denied error (my preference).
>
> good question. I can see the benefit of having a proper error code, but
> I have no preference here right now.

I really would prefer to use the existing one, which I think came with
the lockdown property. It fits the bill here as well, and since access
denied won't ever occur for these methods for any other reason, the
code will look exactly the same on the client side.

Cheers,
Aki

--===============6231009660933566716==--

