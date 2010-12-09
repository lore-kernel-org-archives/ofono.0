Content-Type: multipart/mixed; boundary="===============3862526971343697531=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: CAIF Protocol : oFono
Date: Thu, 09 Dec 2010 23:54:20 +0100
Message-ID: <1291935260.30085.8.camel@aeonflux.mpl.access-company.com>
In-Reply-To: <AANLkTikQRfQZw-YHTvVXJYb2Pr48dDjqXMWP16=d5krV@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3862526971343697531==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> > We understand that CAIF is coming as kernel driver in linux 2.6.36. We =
are
> > trying to write some test application which will
> > make use of CAIF kernel driver to interact with ST-Ericsson Modem.
> >
> > When we connect any modem how OFono recognizes it? Is it based on rule
> > mentioned in "97-ofono.rules"? or will it consider modem.conf file?
> =

> modem.conf support was removed from oFono a while ago. I have sent patches
> and discussed solutions for startup on this list. In a smartphone
> configuration STE will use a
> "modem init daemon" to control start/stop/restart of the modem, so our pr=
oposal
> is that the STE plugin uses the DBUS API from this daemon to recognice
> the STE modem.
> Alternatively we could use udev rules and subscribe to CAIF interface
> state changes.
> I'm still waiting for review comments or feedback for my patches in
> this area (since 17. Nov).

this slipped through. Sorry about that, but we just had way too many
emails lately.

Regards

Marcel



--===============3862526971343697531==--

