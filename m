Content-Type: multipart/mixed; boundary="===============8023509900309499122=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [PATCH 02/12] gprs: driver interface changes for IPv6
Date: Tue, 08 Feb 2011 08:55:30 +0000
Message-ID: <CB0EE8641411214CBAFF8AEBB26ABCEC2991E7@008-AM1MPN1-001.mgdnok.nokia.com>
In-Reply-To: <4D501E8E.4020100@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8023509900309499122==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis, =


> >>> +enum ofono_gprs_addrconf {
> >>> +	OFONO_GPRS_ADDRCONF_NONE,
> >>> +	OFONO_GPRS_ADDRCONF_STATIC,
> >>> +	OFONO_GPRS_ADDRCONF_DHCP,
> >>> +};
> >>> +
> >>
> >> What exactly is the _NONE addrconf for?  And why don't we use =

> >> a gboolean
> >> here like before?
> > =

> > Neither "static" nor "DHCP" makes sense for IPv6. If we =

> have an IPv6 only context, the "Method" property will not =

> show up at all.
> =

> What about combined V4 V6 contexts? What method do you use =

> there, since
> NONE doesn't exactly fit?

The driver will call the ofono_gprs_context_set_ip_addrconf() method to set=
 either STATIC or DHCP configuration method for IPv4. NONE is just a deault=
 intializer, so the "Method" property doesn't show up in the "Settings" dic=
t, unless actually set by the driver.

> I'd rather see this be ignored for IPv6
> contexts or that we separate the IPv4 and IPv6 configuration into two =

> separate batches.

That's the idea. If we find that IPv6 needs some additional support, the pl=
an is to add a new ofono_gprs_context_set_ipv6_addrconf() method, which set=
s the the address configuration method for IPv6. That would be associated w=
ith a new "IPv6Method" property in the settings dict. At the moment I don't=
 know if we need this, until the driver writers start implemeting IPv6 supp=
ort for their modems.

Regards,

	MikaL

--===============8023509900309499122==--

