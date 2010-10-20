Content-Type: multipart/mixed; boundary="===============1476401016151771869=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: A way of polling SIM status
Date: Wed, 20 Oct 2010 23:43:27 +0200
Message-ID: <1287611007.3316.160.camel@aeonflux>
In-Reply-To: <AANLkTi=hh06TUUFknSEtLTsv-YDQSHiFMQaJ4CT5=YXk@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1476401016151771869==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> >> Unfortunately some modems report CPIN: READY even though they're not
> >> ready.  The only reliable way to poll for this is to poll the IMSI, th=
en
> >> the phonebook and the sms store and report ready only once all of them
> >> can be manipulated.
> >
> > I seems to me that Caiwen is proposing SIM presence polling. Each and
> > every modem does it now separately. Unfortunately this seems to be
> > even trickier than PIN lock polling, at least MBM returns different
> > error codes depending on how far its own initialization has got.
> =

> My MBM seems to only detect the SIM if it is inserted during the modem
> enumeration (on USB or PCI).  If you there's no SIM during modem
> initialisation, or you extract the SIM, then inserting a new SIM is
> never detected, the modem will always return "SIM not inserted" until
> reset.

there is a MBM specific event for SIM insertion. Not sure if it works on
the F35xx, but it should be working on the F36xx and later.

Regards

Marcel



--===============1476401016151771869==--

