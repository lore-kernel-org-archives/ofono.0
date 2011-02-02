Content-Type: multipart/mixed; boundary="===============0308131280205325661=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: Selecting multiple radio access technologies in oFono
Date: Wed, 02 Feb 2011 11:31:00 +0100
Message-ID: <AANLkTi=4tkd9Oe2+jhJdRjShX0VPYG=YsXysu=hSHiRo@mail.gmail.com>
In-Reply-To: <1296639762.1520.314.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0308131280205325661==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel & Aki

>> > The current API has 'gsm', 'umts', 'lte' and 'any'. I think you are
>> > suggesting something like 'all-but-lte', right?
>> I think it would be nice if user could be able to select multiple
>> preferred =C2=A0bands, not just only one. The use case I came up with was
>> this 'all-but-lte'.
>
> can we first be clear that we are talking about technology selection and
> not band selection. They are different.
>
> Right now I have no idea on how the hardware will ever support this
> properly.

FYI, as far as I know the STE will supports the following technology
combinations:
- GSM only (WCDMA/E-UTRAN off)
- WCDMA only (GSM/E-UTRAN off)
- GSM +WCDMA (E-UTRAN off)
- E-UTRAN only (GSM/WCDMA off)
- E-UTRAN+GSM (WCDMA off)
- E-UTRAN+WCDMA (GSM off)

*If* we want to expose this kind of granularity on the oFono API,
we should probably go with Remi's proposal with a boolean for each
technology.

> RAT selection is already so different that I prefer to keep it
> like this. It is simple. We can cross the LTE bridge once this becomes a
> real problem.

If you want to keep it simple it's fine with me. But personally I
agree with Paavo
it could be useful to be able to set the radio in "all-but-lte" mode...

Regards,
Sjur

--===============0308131280205325661==--

