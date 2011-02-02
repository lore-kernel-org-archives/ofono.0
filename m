Content-Type: multipart/mixed; boundary="===============9054911901181907219=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Selecting multiple radio access technologies in oFono
Date: Wed, 02 Feb 2011 11:44:43 +0100
Message-ID: <1296643483.1520.319.camel@aeonflux>
In-Reply-To: <AANLkTi=4tkd9Oe2+jhJdRjShX0VPYG=YsXysu=hSHiRo@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9054911901181907219==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> >> > The current API has 'gsm', 'umts', 'lte' and 'any'. I think you are
> >> > suggesting something like 'all-but-lte', right?
> >> I think it would be nice if user could be able to select multiple
> >> preferred  bands, not just only one. The use case I came up with was
> >> this 'all-but-lte'.
> >
> > can we first be clear that we are talking about technology selection and
> > not band selection. They are different.
> >
> > Right now I have no idea on how the hardware will ever support this
> > properly.
> =

> FYI, as far as I know the STE will supports the following technology
> combinations:
> - GSM only (WCDMA/E-UTRAN off)
> - WCDMA only (GSM/E-UTRAN off)
> - GSM +WCDMA (E-UTRAN off)
> - E-UTRAN only (GSM/WCDMA off)
> - E-UTRAN+GSM (WCDMA off)
> - E-UTRAN+WCDMA (GSM off)
> =

> *If* we want to expose this kind of granularity on the oFono API,
> we should probably go with Remi's proposal with a boolean for each
> technology.

right now I prefer to keep it simple.

We also have to think about the CDMA+LTE combination and CDMA+GSM combo
chips. There is still a bit a uncertainty how these are going to look
like. And more important how we have to expose them.

> > RAT selection is already so different that I prefer to keep it
> > like this. It is simple. We can cross the LTE bridge once this becomes a
> > real problem.
> =

> If you want to keep it simple it's fine with me. But personally I
> agree with Paavo
> it could be useful to be able to set the radio in "all-but-lte" mode...

Couldn't this be achieved by actual band selection if you really really
wanted this? Do we actually have different LTE band at all. I am still
not all that familiar with the low-level radio technology behind LTE.

Regards

Marcel



--===============9054911901181907219==--

