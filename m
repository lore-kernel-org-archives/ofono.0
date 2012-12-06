Content-Type: multipart/mixed; boundary="===============3980862036865479599=="
MIME-Version: 1.0
From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: [PATCH 2/2] atmodem: Probe device for previous APN.
Date: Thu, 06 Dec 2012 10:37:53 -0500
Message-ID: <20121206153753.GE4235@alittletooquiet.net>
In-Reply-To: <1354794329.1815.22.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3980862036865479599==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 06, 2012 at 12:45:29PM +0100, Marcel Holtmann wrote:
> > >>> If the device has retained parameters for a previously defined IP
> > >>> context, is is probed via AT+CGDCONT?.
> > >>
> > >> this is really not a good idea. The AT+CGDCONT? settings are on a per
> > >> device basis. That is not how oFono actually works. It operates on a=
 per
> > >> SIM card basis. And since you do not know to what SIM card these
> > >> previous settings apply to, the only sensible thing to do is to igno=
re
> > >> them.
> > >
> > > Okay, I was not aware of this.  But surely the common case (i.e. the =
only one
> > > I've personally seen) is to have a single SIM card per device, and un=
der those
> > > limited circumstances it is safe to assume that the settings are vali=
d for that
> > > SIM.  Would it be reasonable to implement such a fallback for this mo=
re limited
> > > case?
> > >
> > =

> > I admit your approach did make me chuckle for being so unorthodox :) =

> > However, I think your perception is slightly wrong, there are people wh=
o =

> > switch sim cards like crazy (e.g. frequent travelers) so this form of =

> > provisioning is not really a good idea in those cases.
> =

> even if you switch your SIM card only once, it is a bad idea to start
> out with a wrong context. Some operators do not include actually domain
> names and a flatrate in one could mean pay as you go in another and
> drain your bank account. Most operators should have their backends for
> different billings fixed, but you never know. It is really the only
> sensible way to bind the APN settings to your SIM card.
> =

> Why the SIM card does not come with the APN settings stored is another
> story. You need to blame the operators for that.

Fair enough.  I suppose all this SIM card switching is more common outside =
of
the US.

> > > The alternative to pulling the data from the device is to provide a m=
echanism
> > > for specifying the APN policy for a particular fleet.  (At least in t=
heory the
> > > APN selection policy can vary from one fleet to the next.)  I assume =
this would
> > > be implemented as a custom provisioning plugin that either hard-codes=
 the policy
> > > for the fleet, or provides a configuration mechanism that is flexible=
 enough to
> > > accommodate the needs of most fleets (probably using a provider ->  A=
PN mapping,
> > > assuming we can guess the provider e.g. using the mobile-broadband-pr=
ovider-info
> > > database).
> > =

> > I'm getting lost, why is the default mobile-broadband-provider-info =

> > plugin not good enough?  And why don't you simply create your own =

> > database based on the providers you are targeting?  To me it seems like =

> > you need X entries for all X providers you have.  Unless the settings =

> > vary within a given provider somehow?
> =

> The default mobile-broadband-provider-info database has too many
> duplicate choices and in that case oFono can not auto-provision your SIM
> card, but a specific smaller version of that database just target to
> your fleet would make oFono auto-provision the settings and you get
> exactly what you wanted in the first place. No extra code to be written.

I think this approach makes sense (provided we never need to use different =
APNs
for the same provider within a given fleet).

> It is really a database problem that oFono backs out with the
> auto-provision in most cases. That database is just overloaded. And in
> case of oFono provision you also get the SPN information of your
> provider if they provided it. I would trust the combination of MCC, MNC
> and SPN more than anything stored via AT+CGDCONT.
> =

> In addition you can write your own provisioning plugin in case you do
> not like the XML format from mobile-broadband-provider-info.

If we do end up needing this, it will be so we can make the APN selection p=
olicy
dynamically configurable at runtime via an API (i.e. instead of via a
configuration file).  But hopefully we won't need that. ;)

Thanks for your help.

Regards,
Forest
-- =

Forest Bond
http://www.alittletooquiet.net
http://www.rapidrollout.com

--===============3980862036865479599==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuNC4xMCAoR05V
L0xpbnV4KQoKaUVZRUFSRUNBQVlGQWxEQXU5RUFDZ2tRUk80ZlFRZHY1QXlRbFFDZUlYeDlPNzBr
UjNMeXhGekNkajRndm1BUgpiblFBb05ndklXazdkY0lTVU14MjNWV2FtRnJoSnljcwo9eEY4ZQot
LS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============3980862036865479599==--

