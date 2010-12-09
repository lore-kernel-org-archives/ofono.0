Content-Type: multipart/mixed; boundary="===============4236333092876161186=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: CAIF Protocol : oFono
Date: Thu, 09 Dec 2010 19:40:47 +0100
Message-ID: <AANLkTikQRfQZw-YHTvVXJYb2Pr48dDjqXMWP16=d5krV@mail.gmail.com>
In-Reply-To: <COL106-W1298F464B5B44AC6F140ABF62D0@phx.gbl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4236333092876161186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Krishna,

> We understand that CAIF is coming as kernel driver in linux 2.6.36. We are
> trying to write some test application which will
> make use of CAIF kernel driver to interact with ST-Ericsson Modem.
>
> When we connect any modem how OFono recognizes it? Is it based on rule
> mentioned in "97-ofono.rules"? or will it consider modem.conf file?

modem.conf support was removed from oFono a while ago. I have sent patches
and discussed solutions for startup on this list. In a smartphone
configuration STE will use a
"modem init daemon" to control start/stop/restart of the modem, so our prop=
osal
is that the STE plugin uses the DBUS API from this daemon to recognice
the STE modem.
Alternatively we could use udev rules and subscribe to CAIF interface
state changes.
I'm still waiting for review comments or feedback for my patches in
this area (since 17. Nov).

> Please suggest us about the right kernel version we need to deal with in
> order to get complete CAIF implementation.

CAIF was introduced in linux kernel 2.6.35, so 2.6.35 or later would
do for serial communication.

Regards,
Sjur

--===============4236333092876161186==--

