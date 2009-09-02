Content-Type: multipart/mixed; boundary="===============0231761514234518904=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: GPRS support for Ofono
Date: Wed, 02 Sep 2009 14:01:03 -0700
Message-ID: <1251925263.1266.124.camel@localhost.localdomain>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C9680035E2@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0231761514234518904==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Waldo,

> > > > I know why you want this, but I'm still against the counter being an
> > > > oFono driver API.  There needs to be a proper kernel interface that
> > > > signals the application when an interface has gone away with the rx=
/tx
> > > > details.  This way we handle this generically for all modems without
> > > > relying on some intrinsic hardware capabilities.
> > >
> > > This still doesn't solve the case where the modem is accessed from a =
PC
> > > client and forwards PPP data as that data will not go through any
> > > network interface, e.g. BT DUN or USB tethering.
> > =

> > The cases you describe imply that oFono is not even in control of the g=
prs
> > context.  How would we track/report the tx/rx statistics in that case?
> =

> It's probably difficult if the PC client is allowed to redefine GPRS cont=
exts, but otherwise oFono should at least be able to report the total tx/rx=
 for the context's it has defined. The BT DUN / USB bridge could call into =
oFono and trigger a poll of all the stats to update them, e.g. when a BT DU=
N connection is disconnected.

how should it do this if oFono is not in the mix. If you are using
Bluetooth DUN and point it to a virtual TTY, then you are out of look.
If using USB CDC ACM then same applies.

The real solution here is Bluetooth PAN and USB CDC Ether which do
properly interact with the networking stack.

> > > The modem is really in the best position to provide the most reliable
> > > information on data usage. You can still use statistics from the netw=
ork
> > > interfaces as a fall-back in case the modem can not provide this
> > > information.
> > =

> > I don't disagree, but not every modem can track these statistics and th=
is
> > isn't described by 27.007.  I suggest the initial support should be
> > enabled by the modem driver implementing a custom D-Bus interface and =

> > expose these details however it wishes.
> =

> The modem driver has no desires of its own :-) It really comes down to wh=
at the UI needs and I doubt that the UI wants to deal with this on a modem =
by modem basis, but sure it's a possibility.

The current consent is that we might send a one time signal with all
statistics details once the interface goes away. Or we can make the
kernel help us here.

However I prefer that we sit this out a little and play with what is
possible before knocking down an API. I am not even sure what different
hardware would give us and how things need to work. I don't see us
having enough information to understand what is needed from a hardware,
driver or oFono core point of view.

Regards

Marcel



--===============0231761514234518904==--

