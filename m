Content-Type: multipart/mixed; boundary="===============9153249919898161344=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: [PATCH 0/3] EF-SPN API to sim-atom
Date: Tue, 01 Feb 2011 22:38:25 +0200
Message-ID: <1296592705.2619.78.camel@tucson>
In-Reply-To: <4D482342.6070205@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9153249919898161344==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, 2011-02-01 at 09:14 -0600, ext Denis Kenzior wrote:
> > does it really matter in the end? It gets read once and after that we
> > are caching it on disk anyway.
> > =

> =

> Of course it does, while SIM is initializing everything else is blocked.
>  Once we're in sim ready you can have n atoms initializing at the same
> time.  On good hardware with proper muxing that can shave tremendous
> amount of time off your startup cost.

I agree.

There is also this weird corner case when the SIM has no SPN available.
AFAIK, a failed read isn't cached, so bootstrapping that particular SIM
will incur a penalty every single time for information that isn't even
available, as opposed to the GPRS atom incurring it just once during its
lifetime.

That reminds me, I think there are SIMs out there that use the CPHS ONS
instead of SPN, and these can be used interchangeably.

Jukka, don't you actually also need the ONS?

Cheers,
Aki

> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono




--===============9153249919898161344==--

