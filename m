Content-Type: multipart/mixed; boundary="===============4972300613342428754=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/2] atmodem: Probe device for previous APN.
Date: Thu, 06 Dec 2012 12:45:29 +0100
Message-ID: <1354794329.1815.22.camel@aeonflux>
In-Reply-To: <50BD7F02.8050900@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4972300613342428754==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> >>> If the device has retained parameters for a previously defined IP
> >>> context, is is probed via AT+CGDCONT?.
> >>
> >> this is really not a good idea. The AT+CGDCONT? settings are on a per
> >> device basis. That is not how oFono actually works. It operates on a p=
er
> >> SIM card basis. And since you do not know to what SIM card these
> >> previous settings apply to, the only sensible thing to do is to ignore
> >> them.
> >
> > Okay, I was not aware of this.  But surely the common case (i.e. the on=
ly one
> > I've personally seen) is to have a single SIM card per device, and unde=
r those
> > limited circumstances it is safe to assume that the settings are valid =
for that
> > SIM.  Would it be reasonable to implement such a fallback for this more=
 limited
> > case?
> >
> =

> I admit your approach did make me chuckle for being so unorthodox :) =

> However, I think your perception is slightly wrong, there are people who =

> switch sim cards like crazy (e.g. frequent travelers) so this form of =

> provisioning is not really a good idea in those cases.

even if you switch your SIM card only once, it is a bad idea to start
out with a wrong context. Some operators do not include actually domain
names and a flatrate in one could mean pay as you go in another and
drain your bank account. Most operators should have their backends for
different billings fixed, but you never know. It is really the only
sensible way to bind the APN settings to your SIM card.

Why the SIM card does not come with the APN settings stored is another
story. You need to blame the operators for that.

> >> You do know that oFono does keep its settings per SIM card persistent.
> >> So no matter what device you enter that SIM card into, the settings wi=
ll
> >> be available the next time you try to connect. So it is a one time
> >> configuration option.
> >
> > Yes, I do know this.  But it's just not a great fit for our use case.
> >
> > We're using ConnMan and oFono to manage networking for computing applia=
nces
> > (e.g. interactive kiosks and digital signs).  These are typically deplo=
yed in
> > fleets of anywhere from 10 to 10,000 units.  Clearly we do not want to =
manually
> > configure an APN for each machine. ;)
> >
> > Ideally, we try to use a single configuration for the entire fleet to k=
eep the
> > fleet easy to manage.  But for a variety of business and technical reas=
ons,
> > multiple service providers may be used within a given fleet.  So we can=
't simply
> > provision a single APN for the entire fleet.  What we really want is to=
 be able
> > to plug a modem into the machine and it will Just Work.
> >
> > So we'd like to choose the right APN based solely on information from t=
he modem.
> > I've observed that modems tend to arrive with an IP context pre-configu=
red
> > (including the correct APN).  I assume the service provider sets this a=
s part of
> > some internal provisioning process.  Perhaps it is not safe to assume t=
hat this
> > will be the case with the majority of devices and/or providers.  On the=
 other
> > hand, if it is, it seems sensible to make use of that data.
> >
> > The alternative to pulling the data from the device is to provide a mec=
hanism
> > for specifying the APN policy for a particular fleet.  (At least in the=
ory the
> > APN selection policy can vary from one fleet to the next.)  I assume th=
is would
> > be implemented as a custom provisioning plugin that either hard-codes t=
he policy
> > for the fleet, or provides a configuration mechanism that is flexible e=
nough to
> > accommodate the needs of most fleets (probably using a provider ->  APN=
 mapping,
> > assuming we can guess the provider e.g. using the mobile-broadband-prov=
ider-info
> > database).
> =

> I'm getting lost, why is the default mobile-broadband-provider-info =

> plugin not good enough?  And why don't you simply create your own =

> database based on the providers you are targeting?  To me it seems like =

> you need X entries for all X providers you have.  Unless the settings =

> vary within a given provider somehow?

The default mobile-broadband-provider-info database has too many
duplicate choices and in that case oFono can not auto-provision your SIM
card, but a specific smaller version of that database just target to
your fleet would make oFono auto-provision the settings and you get
exactly what you wanted in the first place. No extra code to be written.

It is really a database problem that oFono backs out with the
auto-provision in most cases. That database is just overloaded. And in
case of oFono provision you also get the SPN information of your
provider if they provided it. I would trust the combination of MCC, MNC
and SPN more than anything stored via AT+CGDCONT.

In addition you can write your own provisioning plugin in case you do
not like the XML format from mobile-broadband-provider-info.

Regards

Marcel



--===============4972300613342428754==--

