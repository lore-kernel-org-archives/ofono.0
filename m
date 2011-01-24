Content-Type: multipart/mixed; boundary="===============3055477683151294563=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: SAT support in oFono
Date: Mon, 24 Jan 2011 16:10:55 +0100
Message-ID: <1295881855.2676.33.camel@aeonflux>
In-Reply-To: <1295880225.26199.82.camel@lkunnasl-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3055477683151294563==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lasse,

> > > > > I am checking what is the level of SAT/STK support in ofono and h=
ave a couple of questions. The current implementation contains support for =
basic STK commands, like menus, inputs, calls, sms and so on. In TODO, ther=
e is only REFRESH command on the list.
> > > > > =

> > > > > Is there plans or ideas to extend the support in oFono Core with =
more complex STK features like (3GPP TS 31.111):
> > > > > - Call control by USIM
> > > > > - MO SMS Control by USIM
> > > > =

> > > > Let us set aside the the merits of the use cases for these features=
 for
> > > > the moment ;)  Implementing Call control by USIM is fairly
> > > > straightforward to do in the core.  However, no modem manufacturer
> > > > currently allows us to have full control over this feature.  It is
> > > > implemented in the firmware and every vendor does this differently.=
  So
> > > > for now support of this feature is in the realm of the modem driver.
> > > > =

> > > okay, so assuming this is how it is going stay. Even modem handles
> > > these, ofono should deliver possible AlphaId SIM may give in a respon=
se
> > > to call control envelope. I did not see if this is implemented. Or is=
 it
> > > dropped since it is not tested in GCF..
> > =

> > show us modem hardware where this is needed. At some point we just had
> > to be realistic here in what can be tested with real hardware. And thus
> > is really required to be supported and what makes sense in a smartphone
> > environment.
> > =

> Understand. Sorry, cannot give an example of such HW. But if we would
> follow the 31.111 literally the alpha id should be displayed to user. =


I have not tested this by myself, but judging from the code we do inform
the STK agent even about commands handled by the modem. You checked up
on the agent callback "DisplayActionInformation", do you?

> > > > > - BIP (Bearer independent protocol), including commands like OPEN=
 CHANNEL, CLOSE CHANNEL, SEND/RECEIVE DATA
> > > BIP is on many operators' wish list of supported SAT features. Even it
> > > is optional in 3GPP, some market areas will probably require BIP. I
> > > don't have an example to give right now.
> > =

> > I think the important phrase is "wish list". So far nobody could really
> > showed me the exact use case for BIP. I am actually really interested in
> > understanding what the operators wanna use it for. I prefer to have hard
> > facts here and not just "wish list" and "probably". If this is not a
> > requirement for certification and the operator is not actually using
> > such a feature at all, then why bother. Feel free to convince me
> > otherwise here.
> Main use case is that operator can update the SAT applet on the SIM
> remotely. Operators cannot really advertise or productize usage of BIP
> before enough terminals support it. SCWS introduces new ways of using
> SAT, you could build better UIs using a web browser to access SIM
> applets. This is the use case Jukka Saunamaki mentioned.

As mentioned SMS-PP-data-download is not good enough for what reason?

> > While we can certainly look into supporting BIP at some point, but from
> > where I am standing it is pretty clear; first get all mandatory STK
> > features sorted out, before trying to work on optional ones.
> > =

> What is the 3GPP release you are aiming in STK support? Release 99, 4, 5
> 6,7? As it defines what is mandatory to support and to be tested in GCF.

I think it will be 7 or later, but it does depend a little bit on what
hardware we will test it.

> > > > > - EVENT DOWNLOAD / SET UP EVENT LIST
> > > > > =

> > > > =

> > > > Again, which ones are you looking for?  oFono explicitly ignores the
> > > > following two events as these make no sense in the smartphone conte=
xt:
> > > > =

> > > > - Idle Screen Available
> > > > - User Activity
> > > > =

> > > It looks like  Idle Screen Available and User Activity & User Activity
> > > are mandatory features in 3GPP TS 31.124, chapter 3.4 Applicability
> > > table. Rest of the sub-features are listed there. =

> > =

> > Don't they depend on the STK profile that you are using?
> > =

> No. If a terminal claims to support USAT and be compliant with 3GPP e.g.
> Rel-7 or any other, certain features become mandatory, depending on
> certain conditions, like the HW capability, e.g. do you have a display,
> keypad etc. To check what is mandatory and what not in various 3GPP
> releases, you can check 3GPP TS 31.124, Table B.1. Conditions are in
> Table A.1.
> =

> 31.124 is for 3G. Equivalent for 2G is 51.010-4

I let the people that are currently working GCF pre-certification worry
about the details here. Feel free to provide any feedback that you might
have on this topic.

Regards

Marcel



--===============3055477683151294563==--

