Content-Type: multipart/mixed; boundary="===============8739905576940139462=="
MIME-Version: 1.0
From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: [PATCH 2/2] atmodem: Probe device for previous APN.
Date: Wed, 05 Dec 2012 21:54:56 -0500
Message-ID: <20121206025456.GC4235@alittletooquiet.net>
In-Reply-To: <1354749146.1815.11.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8739905576940139462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

Thanks for your message.

On Thu, Dec 06, 2012 at 12:12:26AM +0100, Marcel Holtmann wrote:
> Hi Forest,
> =

> > If the device has retained parameters for a previously defined IP
> > context, is is probed via AT+CGDCONT?.
> =

> this is really not a good idea. The AT+CGDCONT? settings are on a per
> device basis. That is not how oFono actually works. It operates on a per
> SIM card basis. And since you do not know to what SIM card these
> previous settings apply to, the only sensible thing to do is to ignore
> them.

Okay, I was not aware of this.  But surely the common case (i.e. the only o=
ne
I've personally seen) is to have a single SIM card per device, and under th=
ose
limited circumstances it is safe to assume that the settings are valid for =
that
SIM.  Would it be reasonable to implement such a fallback for this more lim=
ited
case?

> You do know that oFono does keep its settings per SIM card persistent.
> So no matter what device you enter that SIM card into, the settings will
> be available the next time you try to connect. So it is a one time
> configuration option.

Yes, I do know this.  But it's just not a great fit for our use case.

We're using ConnMan and oFono to manage networking for computing appliances
(e.g. interactive kiosks and digital signs).  These are typically deployed =
in
fleets of anywhere from 10 to 10,000 units.  Clearly we do not want to manu=
ally
configure an APN for each machine. ;)

Ideally, we try to use a single configuration for the entire fleet to keep =
the
fleet easy to manage.  But for a variety of business and technical reasons,
multiple service providers may be used within a given fleet.  So we can't s=
imply
provision a single APN for the entire fleet.  What we really want is to be =
able
to plug a modem into the machine and it will Just Work.

So we'd like to choose the right APN based solely on information from the m=
odem.
I've observed that modems tend to arrive with an IP context pre-configured
(including the correct APN).  I assume the service provider sets this as pa=
rt of
some internal provisioning process.  Perhaps it is not safe to assume that =
this
will be the case with the majority of devices and/or providers.  On the oth=
er
hand, if it is, it seems sensible to make use of that data.

The alternative to pulling the data from the device is to provide a mechani=
sm
for specifying the APN policy for a particular fleet.  (At least in theory =
the
APN selection policy can vary from one fleet to the next.)  I assume this w=
ould
be implemented as a custom provisioning plugin that either hard-codes the p=
olicy
for the fleet, or provides a configuration mechanism that is flexible enoug=
h to
accommodate the needs of most fleets (probably using a provider -> APN mapp=
ing,
assuming we can guess the provider e.g. using the mobile-broadband-provider=
-info
database).

So this is probably a little heavier on the configuration side, but at leas=
t the
policy configuration would be the same over the entire fleet.  I think we c=
ould
live with that.  But of course it would be much easier if we didn't have to
bother. ;)

Thoughts?

Thanks,
Forest
-- =

Forest Bond
http://www.alittletooquiet.net
http://www.rapidrollout.com

--===============8739905576940139462==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuNC4xMCAoR05V
L0xpbnV4KQoKaUVZRUFSRUNBQVlGQWxEQUNRQUFDZ2tRUk80ZlFRZHY1QXlUK1FDZUlzSHVoNXlp
YXp2QldDME1qdGZBNFA2NApnYmNBb0l0S2xIU0UyczJrTXllUkF0elZCclNpcStLMAo9OFYxQwot
LS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============8739905576940139462==--

