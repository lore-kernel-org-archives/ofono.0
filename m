Content-Type: multipart/mixed; boundary="===============8952939891208593502=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: how ofono runs with simulator
Date: Wed, 16 Sep 2009 08:03:12 -0700
Message-ID: <1253113392.28416.8.camel@localhost.localdomain>
In-Reply-To: <38D9F46DFF92C54980D2F2C1E8EE313001AB9211B2@pdsmsx503.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8952939891208593502==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

can I just remind you guys that top posting is not allowed on this
mailing list. Use proper quoting.

> The following steps work for latest 0.4 version:
> =

> 1. Modify modem.conf to config your simulator
> # Sample for using phone simulator
> [phonesim]
> Driver=3Dphonesim
> Address=3D127.0.0.1
> Port=3D12345
> =

> 2. Start simulator by
> Phonesim -p 12345 -gui data/moblin.xml
> =

> 3. Start ofono by
> ofonod -nd
> =

> 4. power on the modem
> dbus-send --system --print-reply --dest=3Dorg.ofono /phonesim0 org.ofono.=
Modem.SetProperty string:Powered variant:boolean:true

The script test/enable-modem would we way simpler than this line :)

Regards

Marcel



--===============8952939891208593502==--

