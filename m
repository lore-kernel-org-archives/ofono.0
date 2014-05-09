Content-Type: multipart/mixed; boundary="===============5974050510746375975=="
MIME-Version: 1.0
From: Patrik Flykt <Patrik.Flykt@linux.intel.com>
Subject: Re: Network preference gsm is only working when allowing roaming?
Date: Fri, 09 May 2014 09:31:18 +0300
Message-ID: <1399617078.4638.172.camel@pflykt-mobl1>
In-Reply-To: <CAFtUo_bRBz8BmOz2ONKf3brcKRZe5V1qHdPwB2MzBQXA8YF1Xw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5974050510746375975==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


	Hi,

On Thu, 2014-05-08 at 16:51 +0200, Niclas Karlsson wrote:

>     [ org.ofono.NetworkRegistration ]
>         Status =3D roaming
>         Strength =3D 100
>         Name =3D  - Telenor SE
>         LocationAreaCode =3D 34301
>         Mode =3D auto
>         MobileCountryCode =3D 240
>         CellId =3D 40251
>         MobileNetworkCode =3D 24

This, and...

>     [ org.ofono.SimManager ]
>         Retries =3D [pin =3D 3] [puk =3D 10]
>         SubscriberIdentity =3D 24*************1
>         FixedDialing =3D 0
>         SubscriberNumbers =3D
>         BarredDialing =3D 0
>         LockedPins =3D
>         MobileNetworkCode =3D 08
>         MobileCountryCode =3D 240
>         Present =3D 1
>         PinRequired =3D none

...this combined looks like your SIM says MobileNetworkCode 08 while the
network attached to is 24. So ofono thinks your are roaming now. Is an
update needed to some database? Is this in ofono or in some other sw?

Let's ask ofono ml for an answer.

Cheers,

	Patrik



--===============5974050510746375975==--

