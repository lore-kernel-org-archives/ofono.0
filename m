Content-Type: multipart/mixed; boundary="===============2532044878576901176=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: RE: GPRS support for Ofono
Date: Wed, 02 Sep 2009 11:41:17 -0700
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C9680035E2@orsmsx508.amr.corp.intel.com>
In-Reply-To: <200909021246.01315.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2532044878576901176==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> > > I know why you want this, but I'm still against the counter being an
> > > oFono driver API.  There needs to be a proper kernel interface that
> > > signals the application when an interface has gone away with the rx/tx
> > > details.  This way we handle this generically for all modems without
> > > relying on some intrinsic hardware capabilities.
> >
> > This still doesn't solve the case where the modem is accessed from a PC
> > client and forwards PPP data as that data will not go through any
> > network interface, e.g. BT DUN or USB tethering.
> =

> The cases you describe imply that oFono is not even in control of the gprs
> context.  How would we track/report the tx/rx statistics in that case?

It's probably difficult if the PC client is allowed to redefine GPRS contex=
ts, but otherwise oFono should at least be able to report the total tx/rx f=
or the context's it has defined. The BT DUN / USB bridge could call into oF=
ono and trigger a poll of all the stats to update them, e.g. when a BT DUN =
connection is disconnected.

> > The modem is really in the best position to provide the most reliable
> > information on data usage. You can still use statistics from the network
> > interfaces as a fall-back in case the modem can not provide this
> > information.
> =

> I don't disagree, but not every modem can track these statistics and this
> isn't described by 27.007.  I suggest the initial support should be
> enabled by the modem driver implementing a custom D-Bus interface and =

> expose these details however it wishes.

The modem driver has no desires of its own :-) It really comes down to what=
 the UI needs and I doubt that the UI wants to deal with this on a modem by=
 modem basis, but sure it's a possibility.

Cheers,
Waldo

--===============2532044878576901176==--

