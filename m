Content-Type: multipart/mixed; boundary="===============5269053057905158824=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: Setting PDP mode
Date: Fri, 11 Mar 2011 15:27:05 +0000
Message-ID: <A782C372B9527D44AB20BF45FEEBB14F75A8B16C2A@irsmsx503.ger.corp.intel.com>
In-Reply-To: <1299745991.3163.3.camel@claudio-laptop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5269053057905158824==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Hi,
>
> It's possible to set the pdp mode through ofono ? I need to set the pdp
> mode to auto, ip and ppp,
>
> What are the dbus interface and properties to use ?

Hi,

You should have a look at doc/connman-api.txt.

In the org.ofono.ConnectionContext interface, there is a 'Protocol' propert=
ies.

But I am not so familiar with oFono yet, and it seems that only IP is suppo=
rted. IPv6 works seems in progress.

And from what I could have seen in the sources, oFono only 'discuss' with m=
odem making IP data call. For PPP, oFono use its own PPP stack.

So to conclude, I don't think that you can change the PDP mode, but I hope =
that someone with a biggest background, which should be very easy to found,=
 will give us some more detailed info.

Regards,

Bertrand.
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============5269053057905158824==--

