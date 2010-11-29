Content-Type: multipart/mixed; boundary="===============3981095814099947194=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: ConnectionContext creation for LTE PDN Connection.
Date: Mon, 29 Nov 2010 16:38:28 +0100
Message-ID: <1291045108.4795.29.camel@aeonflux>
In-Reply-To: <201011291712.51520.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3981095814099947194==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> > Or should oFono automatically create a Connection Context?
> > =

> > Furthermore, should oFono automatically proceed and
> > set Active=3Dtrue, bind the connection to a network interface
> > and set network interface in state UP,
> =

> Definitely not. This would interfere with any other existing IP connectio=
n, say =

> WiFi.

why would bringing an interface up interfere? We are doing this right
now. Just the IP assignment is done by ConnMan, but the interface
up/down status is controlled by oFono or even BlueZ in case of
Bluetooth.

Regards

Marcel



--===============3981095814099947194==--

