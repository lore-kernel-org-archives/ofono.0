Content-Type: multipart/mixed; boundary="===============0071988008277773902=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Using ofono HFP
Date: Sun, 26 Sep 2010 19:26:42 -0500
Message-ID: <4C9FE4C2.9060507@gmail.com>
In-Reply-To: <AANLkTimM6B4VQZW=cTP4DfzOukrKCM9wEKs-iCRbFPDK@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0071988008277773902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Moises,

> I was advised by padovan on IRC that I should try dbus >=3D 1.3 ... I am
> going to try that today, I was putting that off cuz this seemed like a
> lower level issue and upgrading dbus seemed like non-trivial since many
> things depend on dbus and fedora 13 does not seem to include rpm for
> dbus >=3D 1.3

Neither oFono nor BlueZ will enable the plugins for HFP support unless
DBus-1.3 is installed (or alternatively a hacked dbus-1.2 with file
descriptor passing support)

> =

> Can I somehow to try ofono connect to my cell and not the other way aroun=
d?

The connection initiator is actually irrelevant.  You just need to make
sure that BlueZ has paired with your device and the HandsfreeGateway
interface is created for your device.

> The final goal here is NOT use this with pulseaudio, but rather have
> access to the SCO socket so I can manipulate the audio.

If you want this, then you will need to eventually write your own plugin
that will manage the RFCOMM and SCO sockets.  Today, BlueZ does this part...

Regards,
-Denis

--===============0071988008277773902==--

