Content-Type: multipart/mixed; boundary="===============6917058443890868479=="
MIME-Version: 1.0
From: Lasse Kunnasluoto <lasse.kunnasluoto@tieto.com>
Subject: Re: SAT support in oFono
Date: Mon, 24 Jan 2011 09:15:11 +0200
Message-ID: <1295853311.26199.41.camel@lkunnasl-desktop>
In-Reply-To: <4D39B0A2.8060204@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6917058443890868479==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 2011-01-21 at 18:13 +0200, Denis Kenzior wrote:
> Hi Lasse,
> =

> On 01/21/2011 02:44 AM, Lasse.Kunnasluoto(a)tieto.com wrote:
> > Hi
> > =

> > I am checking what is the level of SAT/STK support in ofono and have a =
couple of questions. The current implementation contains support for basic =
STK commands, like menus, inputs, calls, sms and so on. In TODO, there is o=
nly REFRESH command on the list.
> > =

> > Is there plans or ideas to extend the support in oFono Core with more c=
omplex STK features like (3GPP TS 31.111):
> > - Call control by USIM
> > - MO SMS Control by USIM
> =

> Let us set aside the the merits of the use cases for these features for
> the moment ;)  Implementing Call control by USIM is fairly
> straightforward to do in the core.  However, no modem manufacturer
> currently allows us to have full control over this feature.  It is
> implemented in the firmware and every vendor does this differently.  So
> for now support of this feature is in the realm of the modem driver.
> =

okay, so assuming this is how it is going stay. Even modem handles
these, ofono should deliver possible AlphaId SIM may give in a response
to call control envelope. I did not see if this is implemented. Or is it
dropped since it is not tested in GCF..

> > - BIP (Bearer independent protocol), including commands like OPEN CHANN=
EL, CLOSE CHANNEL, SEND/RECEIVE DATA
BIP is on many operators' wish list of supported SAT features. Even it
is optional in 3GPP, some market areas will probably require BIP. I
don't have an example to give right now.
> =

> Please feel free to add a new TODO item adding these features and send
> us patches :)
> =

> > - Extend support in PROVIDE LOCAL INFO
> =

> What support are you looking for?  Most of the information that is asked
> by provide local info is implemented in the modem firmware.  We have
> only included support for items which are not covered by the firmware.
> =

If aiming GCF approval support should contain: IMEI, location info,
network measurements&BCCH channel list, timing advance, access
technology, IMEISV, Inter-frequency UTRAN measurements. As you said
these are often handled by modem, but isn't possible that modem can be
configured in a way it leaves the full control of SAT to the host?
Although certain AT command based modems would require proprietary
commands to fetch all the needed information. So in that sense it is
more logical for modem to handle these commands what requires low level
interfaces.

> > - EVENT DOWNLOAD / SET UP EVENT LIST
> > =

> =

> Again, which ones are you looking for?  oFono explicitly ignores the
> following two events as these make no sense in the smartphone context:
> =

> - Idle Screen Available
> - User Activity
> =

It looks like  Idle Screen Available and User Activity & User Activity
are mandatory features in 3GPP TS 31.124, chapter 3.4 Applicability
table. Rest of the sub-features are listed there. =


BR,
-Lasse

> Regards,
> -Denis



--===============6917058443890868479==--

