Content-Type: multipart/mixed; boundary="===============5387162138015487002=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH] Add voice call boolean property for MO/MT distinction
Date: Fri, 26 Nov 2010 14:06:04 +0200
Message-ID: <201011261406.04832.remi.denis-courmont@nokia.com>
In-Reply-To: <20101125082310.GA17294@jh-x301>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5387162138015487002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thursday 25 November 2010 10:23:10 ext Johan Hedberg, you wrote:
> > This becomes a problem if we have more than one application "managing"
> > voice calls. And I expect that will _be_ the most common case. You have
> > the main call UI, but you also have the Bluetooth headset/carkit, the
> > USB AT commands port, and possibly some third party call applications.
> =

> Right. At least for HFP the call direction needs to be in the AT+CLCC
> reply. I.e. if the bluetoothd ofono telephony driver is used and
> bluetoothd starts after one or more calls are already in progress
> bluetoothd wouldn't have seen the call setup process and therefore not
> know the direction of the call (without this property).

Yeah. For USB CDC ACM gadget functionality, there is basically the same =

problem. Because oFono assumes it has full control over the modem, most =

cellular commands have to go through the oFono D-Bus API.

However, a number of other commands talk to completely different stuff, =

including but not limited to:
* AT+CBC et al deals with energy management, which is proprietary in Nokia'=
s =

case and hence cannot be reached from GPL'd oFono.
* AT+CKPD, AT+CTSA and friends use either Linux uinput driver or perhaps to =

the windowing framework (X11, Wayland?).
* AT+CBKLT is hooked to the screensaver whatever takes care of it.
* AT+CPBR and friends is hooked to the phonebook, which is Qt-based, and =

therefore inadequate inside oFono.
* At Nokia, we also have some non-standard commands for internal use.
* Some operators require some funky AT commands of their own. It might not =
be =

possible to open-source them, even if we want to.

I would like to emphasize that, even if many of those commands are mostly i=
f =

not only used in testing, they may still need to cooperate with oFono and/o=
r =

to be present in the end-user devices. Besides, duplicating the implementat=
ion =

effort inside and outside oFono would be a waste of time.

All in all, implementing the AT commands DCE emulator inside oFono is not a =

realistic option. That is not to say that it must be closed-source, at leas=
t =

not most parts of it, but it's going to (have to) talk D-Bus to oFono.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============5387162138015487002==--

