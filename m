Content-Type: multipart/mixed; boundary="===============0087450170871418643=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: Using ofono HFP
Date: Tue, 28 Sep 2010 09:26:21 +0800
Message-ID: <33AB447FBD802F4E932063B962385B352D8D7DC7@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <4C9FE4C2.9060507@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0087450170871418643==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Moises,

Denis Kenzior wrote:
> Hi Moises,
> =

>> I was advised by padovan on IRC that I should try dbus >=3D 1.3 ... I
>> am going to try that today, I was putting that off cuz this seemed
>> like a lower level issue and upgrading dbus seemed like non-trivial
>> since many things depend on dbus and fedora 13 does not seem to
>> include rpm for dbus >=3D 1.3
> =

> Neither oFono nor BlueZ will enable the plugins for HFP support unless
> DBus-1.3 is installed (or alternatively a hacked dbus-1.2 with file
> descriptor passing support) =


Denis is right. For example, my ubuntu 10.04 has dbus-1.3.0 so HFP works sm=
oothly on my laptop. I remember there's someone has a hacked dbus-1.2 with =
fd passing support. It does work but I would recommend you use dbus-1.3.

>> =

>> Can I somehow to try ofono connect to my cell and not the other way
>> around? =

> =

> The connection initiator is actually irrelevant.  You just need to
> make sure that BlueZ has paired with your device and the
> HandsfreeGateway interface is created for your device.
> =

>> The final goal here is NOT use this with pulseaudio, but rather have
>> access to the SCO socket so I can manipulate the audio.
> =

> If you want this, then you will need to eventually write your
> own plugin
> that will manage the RFCOMM and SCO sockets.  Today, BlueZ
> does this part...

Right. See bluez/audio/unix.c for BlueZ part SCO code that cooperate with p=
ulseaudio. BlueZ sends SCO fd to pulseaudio via UNIX type socks.

> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

Regards,
Zhenhua


--===============0087450170871418643==--

