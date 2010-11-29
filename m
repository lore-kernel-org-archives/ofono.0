Content-Type: multipart/mixed; boundary="===============1513163975281100226=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Add voice call boolean property for MO/MT distinction
Date: Mon, 29 Nov 2010 10:41:18 +0100
Message-ID: <1291023678.4795.26.camel@aeonflux>
In-Reply-To: <201011261406.04832.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1513163975281100226==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> > > This becomes a problem if we have more than one application "managing"
> > > voice calls. And I expect that will _be_ the most common case. You ha=
ve
> > > the main call UI, but you also have the Bluetooth headset/carkit, the
> > > USB AT commands port, and possibly some third party call applications.
> > =

> > Right. At least for HFP the call direction needs to be in the AT+CLCC
> > reply. I.e. if the bluetoothd ofono telephony driver is used and
> > bluetoothd starts after one or more calls are already in progress
> > bluetoothd wouldn't have seen the call setup process and therefore not
> > know the direction of the call (without this property).
> =

> Yeah. For USB CDC ACM gadget functionality, there is basically the same =

> problem. Because oFono assumes it has full control over the modem, most =

> cellular commands have to go through the oFono D-Bus API.
> =

> However, a number of other commands talk to completely different stuff, =

> including but not limited to:
> * AT+CBC et al deals with energy management, which is proprietary in Noki=
a's =

> case and hence cannot be reached from GPL'd oFono.

where is the problem here. An oFono plugin could just talk D-Bus to this
daemon.

> * AT+CKPD, AT+CTSA and friends use either Linux uinput driver or perhaps =
to =

> the windowing framework (X11, Wayland?).

This is not even a problem. Using uinput and this is solved. Wayland
talks kernel input only anyway and so can X11.

> * AT+CBKLT is hooked to the screensaver whatever takes care of it.

No matter what you do, this is a more complex problem. The screensaver
run as user session. You might just need to modify it to also listen on
the D-Bus system bus on a well defined service name and problem solved.

> * AT+CPBR and friends is hooked to the phonebook, which is Qt-based, and =

> therefore inadequate inside oFono.

I am not buying into the AT+CPBR for the local and user specific
phonebook. That one is inside Tracker anyway and also inside the user
session. Trying to really support this is a broken idea. CPBR can not
expose the information of modern contacts storage anyway, so just don't
bother.

If you really care about it then use Bluetooth PBAP via obexd which we
have enabled already.

> * At Nokia, we also have some non-standard commands for internal use.
> * Some operators require some funky AT commands of their own. It might no=
t be =

> possible to open-source them, even if we want to.

And these should be on an engineering mode only USB CDC ACM interface
with a different backend anyway.

> I would like to emphasize that, even if many of those commands are mostly=
 if =

> not only used in testing, they may still need to cooperate with oFono and=
/or =

> to be present in the end-user devices. Besides, duplicating the implement=
ation =

> effort inside and outside oFono would be a waste of time.
> =

> All in all, implementing the AT commands DCE emulator inside oFono is not=
 a =

> realistic option. That is not to say that it must be closed-source, at le=
ast =

> not most parts of it, but it's going to (have to) talk D-Bus to oFono.

I disagree here. The AT commands emulator belongs inside oFono.

Only because someone wants to shoehorn this into something nasty,
doesn't mean we should do it. And I am not going to scarifies the
simplicity of the oFono D-Bus API for this.

Regards

Marcel



--===============1513163975281100226==--

