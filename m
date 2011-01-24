Content-Type: multipart/mixed; boundary="===============0382891319201571157=="
MIME-Version: 1.0
From: Lasse Kunnasluoto <lasse.kunnasluoto@tieto.com>
Subject: Re: SAT support in oFono
Date: Mon, 24 Jan 2011 16:43:45 +0200
Message-ID: <1295880225.26199.82.camel@lkunnasl-desktop>
In-Reply-To: <1295866144.2676.15.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0382891319201571157==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Mon, 2011-01-24 at 12:49 +0200, Marcel Holtmann wrote:
> Hi Lasse,
> =

> > > > I am checking what is the level of SAT/STK support in ofono and hav=
e a couple of questions. The current implementation contains support for ba=
sic STK commands, like menus, inputs, calls, sms and so on. In TODO, there =
is only REFRESH command on the list.
> > > > =

> > > > Is there plans or ideas to extend the support in oFono Core with mo=
re complex STK features like (3GPP TS 31.111):
> > > > - Call control by USIM
> > > > - MO SMS Control by USIM
> > > =

> > > Let us set aside the the merits of the use cases for these features f=
or
> > > the moment ;)  Implementing Call control by USIM is fairly
> > > straightforward to do in the core.  However, no modem manufacturer
> > > currently allows us to have full control over this feature.  It is
> > > implemented in the firmware and every vendor does this differently.  =
So
> > > for now support of this feature is in the realm of the modem driver.
> > > =

> > okay, so assuming this is how it is going stay. Even modem handles
> > these, ofono should deliver possible AlphaId SIM may give in a response
> > to call control envelope. I did not see if this is implemented. Or is it
> > dropped since it is not tested in GCF..
> =

> show us modem hardware where this is needed. At some point we just had
> to be realistic here in what can be tested with real hardware. And thus
> is really required to be supported and what makes sense in a smartphone
> environment.
> =

Understand. Sorry, cannot give an example of such HW. But if we would
follow the 31.111 literally the alpha id should be displayed to user. =


> > > > - BIP (Bearer independent protocol), including commands like OPEN C=
HANNEL, CLOSE CHANNEL, SEND/RECEIVE DATA
> > BIP is on many operators' wish list of supported SAT features. Even it
> > is optional in 3GPP, some market areas will probably require BIP. I
> > don't have an example to give right now.
> =

> I think the important phrase is "wish list". So far nobody could really
> showed me the exact use case for BIP. I am actually really interested in
> understanding what the operators wanna use it for. I prefer to have hard
> facts here and not just "wish list" and "probably". If this is not a
> requirement for certification and the operator is not actually using
> such a feature at all, then why bother. Feel free to convince me
> otherwise here.
Main use case is that operator can update the SAT applet on the SIM
remotely. Operators cannot really advertise or productize usage of BIP
before enough terminals support it. SCWS introduces new ways of using
SAT, you could build better UIs using a web browser to access SIM
applets. This is the use case Jukka Saunamaki mentioned.

> =

> While we can certainly look into supporting BIP at some point, but from
> where I am standing it is pretty clear; first get all mandatory STK
> features sorted out, before trying to work on optional ones.
> =

What is the 3GPP release you are aiming in STK support? Release 99, 4, 5
6,7? As it defines what is mandatory to support and to be tested in GCF.

> > > > - Extend support in PROVIDE LOCAL INFO
> > > =

> > > What support are you looking for?  Most of the information that is as=
ked
> > > by provide local info is implemented in the modem firmware.  We have
> > > only included support for items which are not covered by the firmware.
> > > =

> > If aiming GCF approval support should contain: IMEI, location info,
> > network measurements&BCCH channel list, timing advance, access
> > technology, IMEISV, Inter-frequency UTRAN measurements. As you said
> > these are often handled by modem, but isn't possible that modem can be
> > configured in a way it leaves the full control of SAT to the host?
> > Although certain AT command based modems would require proprietary
> > commands to fetch all the needed information. So in that sense it is
> > more logical for modem to handle these commands what requires low level
> > interfaces.
> =

> What we have seen so far is that all of these are handled by the modem.
> If the modem has all information available, then why bother waking up
> the host CPU for this. It does make a lot of sense to keep the host CPU
> asleep if possible. I am pretty pragmatic here; if we have to support a
> modem that does not handle these, then we have to do it.
> =

> So if you have more information about other modem types, please let us
> know. And patches are always welcome.
> =

> > > > - EVENT DOWNLOAD / SET UP EVENT LIST
> > > > =

> > > =

> > > Again, which ones are you looking for?  oFono explicitly ignores the
> > > following two events as these make no sense in the smartphone context:
> > > =

> > > - Idle Screen Available
> > > - User Activity
> > > =

> > It looks like  Idle Screen Available and User Activity & User Activity
> > are mandatory features in 3GPP TS 31.124, chapter 3.4 Applicability
> > table. Rest of the sub-features are listed there. =

> =

> Don't they depend on the STK profile that you are using?
> =

No. If a terminal claims to support USAT and be compliant with 3GPP e.g.
Rel-7 or any other, certain features become mandatory, depending on
certain conditions, like the HW capability, e.g. do you have a display,
keypad etc. To check what is mandatory and what not in various 3GPP
releases, you can check 3GPP TS 31.124, Table B.1. Conditions are in
Table A.1.

31.124 is for 3G. Equivalent for 2G is 51.010-4

BR,
-Lasse

> Regards
> =

> Marcel
> =

> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono



--===============0382891319201571157==--

