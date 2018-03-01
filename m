Content-Type: multipart/mixed; boundary="===============9151847471560948103=="
MIME-Version: 1.0
From: Reinhard Speyerer <rspmn@arcor.de>
Subject: Re: [PATCH 4/4] qmimodem: get LTE default bearer APN from modem
Date: Thu, 01 Mar 2018 23:30:16 +0100
Message-ID: <20180301223015.7bkg2wkzts4e3g7u@arcor.de>
In-Reply-To: <2b9f8392-6748-ea6d-9725-e5ffd8845d54@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9151847471560948103==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 01, 2018 at 04:43:22PM +0100, Jonas Bonn wrote:
> On 03/01/2018 04:27 PM, Denis Kenzior wrote:
> > Hi Jonas,
> > =

> > On 03/01/2018 09:20 AM, Jonas Bonn wrote:
> > > On 03/01/2018 04:02 PM, Denis Kenzior wrote:
> > > > Hi Jonas,
> > > > =

> > > > On 03/01/2018 04:48 AM, Jonas Bonn wrote:
> > > > > When an LTE modem registers with the network, a default bearer is
> > > > > automatically established.=C2=A0 The APN used for this bearer is =
taken from
> > > > > whatever default settings the modem has.
> > > > > =

> > > > > In order to properly set up the ofono context, we need to find ou=
t what
> > > > > APN the modem has used when negotiating this bearer.=C2=A0 Ideall=
y, we would
> > > > > want to query the 'current settings', but those aren't available =
until
> > > > > start_net has been called and that's done in the gprs-context ato=
m.=C2=A0 As
> > > > > such, we query the 'default settings' here under the assumption t=
hat
> > > > > that's what the modem will have used.
> > > > =

> > > > I don't recall exactly, but from what I remember the default
> > > > attach APN is not guaranteed to be honored by the operator.=C2=A0 So
> > > > the default attach settings used for the actual active context
> > > > might be different.=C2=A0 It might be better to query those instead.
> > > =

> > > So, this becomes quite messy:
> > > =

> > > Getting "current settings" does not succeed until after we have
> > > called start_net.=C2=A0 This is done in the gprs-context atom as part=
 of
> > > read_settings() for LTE and shares a bunch of code with
> > > activate_primary() that also calls start_net.
> > > =

> > > We can move the call of start_net to the gprs atom if we must, but
> > > we end up duplicating a whole bunch of code.=C2=A0 That's why I wante=
d to
> > > just grab the APN from the default settings in the GPRS atom, call
> > > cid_activated(), and then wait for read_settings() to be called
> > > before invoking start_net and then getting the rest of the settings.
> > > =

> > =

> > 3GPP extended +CGDCONT specifically for this case.=C2=A0 Does QMI have
> > anything similar?
> =

> Not that I am able to ascertain.  I'm hoping somebody here can tell me wh=
at
> that would be...
> =

> For +CGDCONT you effectively have an event saying that a 'transient' cont=
ext
> has been activated.  There's nothing in the QMI protocol that resembles
> this.  We jsut get "network registered" and then we need to understand th=
at
> there's an underlying bearer, call start_net (for whatever reason, despite
> the net effectively being started already), and then query the settings.
> The heuristic we have is (network_registered && tech=3D=3DLTE)... if there
> something better, I'd love to know!

Hi Jonas,

if you only need to know the APN and the IP version assigned by the network
for the default bearer you could try to use WDSGetLTEAttachParameters
(WDS msgid 0x0085) instead of using WDSStartNetworkInterface followed by
WDSGetCurrentSettings.

Regards,
Reinhard

--===============9151847471560948103==--

