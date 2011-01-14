Content-Type: multipart/mixed; boundary="===============3180338428852812790=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: Re: [RFC PATCH 4/4] Dummy example GPRS context provisioning driver
Date: Fri, 14 Jan 2011 08:53:03 +0200
Message-ID: <1294987983.29263.24.camel@jsaunama-desktop>
In-Reply-To: <4D2F2106.5010807@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3180338428852812790==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On Thu, 2011-01-13 at 09:57 -0600, Denis Kenzior wrote:
> > Some virtual operators are using the same MCC/MNC as their host, or some
> > operators have several different trade names, and these can have
> > different access settings (at least different UI visible name). =

> > SPN in SIM typically tells these cases apart. This is why I included
> > reading SPN to that example provisioning.
> =

> Do you have specific examples?  To my knowledge the MVNOs should be
> provisioning the SIM with a different MNC from the host but the network
> used (and thus the network's MCC/MNC) are their host's.

I was not sure if all MVNOs have their own MNC, but in any case some
operators use different trade names. Off the top of my hat I know our
local Finnish operators Elisa and Sonera use trade names like Kolumbus
and TeleFinland, and their name shown in UI needs to be correct.

> > All provisioning plugins might not care about SPN (e.g. the previously
> > discussed one using mobile-broadband-provider-info?), so I would suggest
> > not creating specific SIM API yet. Of cause it can be added later, if so
> > wished.
> =

> You might be able to get away with reading of EFspn just because it is
> cached nicely on disk.  But you will have to carefully consider your
> plugin design if you wish to do so to avoid any race conditions and be
> able to properly clean up.

You mean that if plugin gets removed/unregistered before SPN-reading
callback comes in? =

That is a good point, and I also have to check how to handle this in
GPRS atom, since calling provisioning is asynchronous, and GPRS might
get removed while provisioning is running... I might need some help
figuring out solution to that. =

Alternative is of cause to make provisioning synchronous, but that would
limit what plugin can do (like asking SPN with ofono_sim_read())

--Jukka
 =



--===============3180338428852812790==--

