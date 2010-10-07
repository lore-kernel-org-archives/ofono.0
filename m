Content-Type: multipart/mixed; boundary="===============0928222716213851420=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: airplus MCD-650
Date: Thu, 07 Oct 2010 13:13:02 +0200
Message-ID: <1286449982.6145.102.camel@aeonflux>
In-Reply-To: <1286446426.22751.4.camel@mezon.ru>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0928222716213851420==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alex,

> I have a modem airplus MCD-650 =

> =

> lsusb
> =

> Bus 002 Device 055: ID 1edf:6004
> =

> =

> /etc/ofono/modem.conf
> [atgen]
> Driver=3Datgen
> Device=3D/dev/ttyACM0
> Baud=3D460800

using atgen is most likely the wrong modem driver. So what kind of
device is the MCD-650?

Regards

Marcel



--===============0928222716213851420==--

