Content-Type: multipart/mixed; boundary="===============5199625241233401729=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: how ofono runs with simulator
Date: Wed, 16 Sep 2009 12:56:13 +0800
Message-ID: <38D9F46DFF92C54980D2F2C1E8EE313001AB9211B2@pdsmsx503.ccr.corp.intel.com>
In-Reply-To: <61563CE63B4F854986A895DA7AD3C17709DD9B5ED6@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5199625241233401729==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The following steps work for latest 0.4 version:

1. Modify modem.conf to config your simulator
# Sample for using phone simulator
[phonesim]
Driver=3Dphonesim
Address=3D127.0.0.1
Port=3D12345

2. Start simulator by
Phonesim -p 12345 -gui data/moblin.xml

3. Start ofono by
ofonod -nd

4. power on the modem
dbus-send --system --print-reply --dest=3Dorg.ofono /phonesim0 org.ofono.Mo=
dem.SetProperty string:Powered variant:boolean:true

BTW, if you have a mobile phone, there is another way to use it instead of =
the simulator. =


Regards,
-Yang

From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Behal=
f Of Zhao, Lihan
Sent: Wednesday, September 16, 2009 12:39 PM
To: ofono(a)ofono.org
Subject: how ofono runs with simulator

Hi,

I have got the source code through git, and I build it as the HACKING guide=
s.

But now I do not have a modem, and cannot run ofono on the true environment.

I have one simulator, can anyone know how to run ofono with simulator?

Thank you!

Best Regards,
Lihan


--===============5199625241233401729==--

