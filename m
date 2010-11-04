Content-Type: multipart/mixed; boundary="===============8173645426219399342=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC] plugin/ste: Use D-Bus API from Modem Init Daemon for
 autoconfig.
Date: Thu, 04 Nov 2010 16:19:08 +0100
Message-ID: <1288883948.9615.94.camel@aeonflux>
In-Reply-To: <1288880304-16142-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8173645426219399342==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> This patch introduces auto discovery of ST-Ericsson modems.
> ST-Ericsson modems are managed by a Modem Init Daemon which
> is responsible for start/stop/restart flashing etc. The
> STE plugin monitors the modem state exposed from the
> Modem Init Damon Dbus API. When the modem is in state "on"
> the STE modem is created and registered.
> =

> The reason for not using the standard udev paradigm is that
> the CAIF device is up before the modem is ready to setup AT channels.
> For flashless modems CAIF is used as part of the boot. The Modem Init
> Daemon is managing the flashless boot procedure and sets the State to
> "on" when the modem is available.

so I don't like this at all. This looks pretty nasty and like an ugly
hack to get something working.

Please show us what Modem Init Daemon is actually doing.

Regards

Marcel



--===============8173645426219399342==--

