Content-Type: multipart/mixed; boundary="===============0743186745703628521=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/2] atmodem: Probe device for previous APN.
Date: Thu, 06 Dec 2012 00:12:26 +0100
Message-ID: <1354749146.1815.11.camel@aeonflux>
In-Reply-To: <20121205190204.GB27739@alittletooquiet.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0743186745703628521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Forest,

> If the device has retained parameters for a previously defined IP
> context, is is probed via AT+CGDCONT?.

this is really not a good idea. The AT+CGDCONT? settings are on a per
device basis. That is not how oFono actually works. It operates on a per
SIM card basis. And since you do not know to what SIM card these
previous settings apply to, the only sensible thing to do is to ignore
them.

You do know that oFono does keep its settings per SIM card persistent.
So no matter what device you enter that SIM card into, the settings will
be available the next time you try to connect. So it is a one time
configuration option.

Regards

Marcel



--===============0743186745703628521==--

