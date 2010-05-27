Content-Type: multipart/mixed; boundary="===============0026671656583916019=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] Add: Online property to modem
Date: Thu, 27 May 2010 10:34:31 -0500
Message-ID: <201005271034.32141.denkenz@gmail.com>
In-Reply-To: <AANLkTik_bD5RSKdfM5_sVGPWCaG9eeFEGSpOj1YbJ0cF@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0026671656583916019==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> 2010/5/27 Denis Kenzior <denkenz@gmail.com>:
> > Hi Pekka,
> >
> >> 2010/5/27 Denis Kenzior <denkenz@gmail.com>:
> >> > Patch has been applied, however I did some refactoring afterward.
> >> >  Please test that I didn't break something.
> >>
> >> There is now a race condition in online/offline and sim hotswap. With
> >> imperfect hw a missing sim gets detected only when modem attempts to
> >> register to network and actually tries to read something from sim
> >> card. I have no idea if the missing sim can be reported before +cops
> >> command response is returned.
> >
> > Sorry, but how does such a modem even get to the sim ready state?  oFono
> > reads the IMSI before it even tries to send post_sim, and you certainly
> > can't read the IMSI without a sim card.
> =

> If you have a SIM card and then remove it, modem should go to pre_sim
> state (and the expectation is that it will go offline, too.)  However,
> unless explicitly told otherwise, isimodem goes to limited service
> mode.

Still having trouble seeing your concerns.  oFono core transitions the mode=
m =

to the pre_sim state.  If a modem requires special steps to be taken to be =
in =

sync with the core, then the driver has to take care of it.

> =

> >> However, at least isimodem needs explicitly told to go offline when
> >> sim gets removed.
> >
> > My thinking is that the modem drivers can take care of this.  The core
> > needs to be kept simple here and assume an 'ideal' implementation.
> >
> > I'm still having trouble understanding how we'll support emergency calls
> > with no SIM with this framework though.
> =

> The online/offline cuts in only if you have SIM card (and PIN is
> entered/disabled).
>

And we rely on the modem to activate rx/tx in the case of an emergency call=
? =

How does this work with Flight mode?

Regards,
-Denis=20

--===============0026671656583916019==--

