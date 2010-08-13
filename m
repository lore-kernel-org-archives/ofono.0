Content-Type: multipart/mixed; boundary="===============5506483312718633409=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Enabling/disabling the GPS part of a Huawei EM770W
Date: Fri, 13 Aug 2010 15:00:05 +0200
Message-ID: <1281704405.23399.7.camel@localhost.localdomain>
In-Reply-To: <4C650F0E.2060401@mayer-electronics.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5506483312718633409==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

> is it possible to enable / disable the GPS part of a Huawei EM770W 3G =

> modem through a DBUS command? It is done with the command AT^WPDGP and =

> AT^WPEND on the modem (tested it on PCUI port). Or is it possible to =

> send generic AT commands through DBUS?

we know that we need some sort of power control atom for GPS devices.
The Ericsson MBM and Option HSO have also GPS chips on board. So far
nobody has proposed a GPS atom for power control of the GPS device yet.
So you could be the first one. Go ahead and send a patch.

Regards

Marcel



--===============5506483312718633409==--

