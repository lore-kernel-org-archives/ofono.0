Content-Type: multipart/mixed; boundary="===============4495610745597101565=="
MIME-Version: 1.0
From: Pau Espin Pedrol <pespin@sysmocom.de>
Subject: Re: [PATCH 2/2] udevng: Catch network interface renames
Date: Wed, 03 Apr 2019 18:34:27 +0200
Message-ID: <8dd2beef-dd40-7bde-9943-634c33900e89@sysmocom.de>
In-Reply-To: <9CFB4CE7-93E7-4098-AFDC-47CA49EE3BE6@holtmann.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4495610745597101565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 4/3/19 4:49 PM, Marcel Holtmann wrote:
> =

> Wouldn=E2=80=99t it generally be better for reading the name after oFono =
has brought up the interface. In case we need this for the D-Bus API someho=
w. And for sake of matching we start and handing this to the plugins and dr=
ivers we should start using the ifindex.
> =


I'm sorry but I didn't fully understand you here. Can you =

rephrase/extend your thoughts? We need it for the D-Bus API, it is =

announced to dbus clients when activating a PDP Context tgether with =

other IP information in order to let the clients know which iface to use =

for it.

=3D=3D General scenario for the patch:
You have a modem and it has iface name wwan0. You decide you want to =

rename it manually:
ip link set wwan0 down && ip link set wwan0 name mymodem && ip link set =

wwan0 up
Currently ofono is unable to catch this change and will continue to =

advertise "wwan0" on the DBUs API.


=3D=3D Our specific scenario:
As you may have heard already before, at Osmocom [1] we use ofono in =

order to operate QMI modems (EC20, SierraW, gobi2000, etc.) to test our =

core networks on a wired HW setup, all orchestrated by osmo-gsm-tester =

[2][3].

In order to provide correct routing (avoid loops) from different modems =

to different GGSNs on the same machine, we move modem network interfaces =

to their own network namespace. In order to do that, we required adding =

a small hack-patch [4] into our own ofono branch [5] to prevent ofono =

from dropping the whole modem when the net iface disappears (because =

udev is unable to track different net namespaces than default, which =

means from udev point of view the iface is not there).

Furthermore, we experience sporadic crashes in the modem firmware while =

executing tests, which from linux system point of view means the =

interface is removed and re-appears. When it is re-registered with the =

kernel, it may give a new different iface name than the previous one. =

That also means the ifindex of this new interface is not the same it =

used to be before. Since due to our patch we didn't drop the modem =

during netif removed (moved to different netns), the modem is kept alive =

during crash but still points to old net iface name. More information =

about this scenario can be found in [6].

I'm so far fixing it using persistent naming in our net ifaces by means =

of udev rules.

[1] https://osmocom.org/
[2] https://osmocom.org/projects/osmo-gsm-tester
[3] https://git.osmocom.org/osmo-gsm-tester/
[4] =

https://git.sysmocom.de/ofono/commit/?h=3Dosmo-gsm-tester&id=3De77b82a1bd19=
86aab42a119e0556c5941795992e
[5] https://git.sysmocom.de/ofono/log/?h=3Dosmo-gsm-tester
[6] https://osmocom.org/issues/3881

-- =

- Pau Espin Pedrol <pespin@sysmocom.de>         http://www.sysmocom.de/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
* sysmocom - systems for mobile communications GmbH
* Alt-Moabit 93
* 10559 Berlin, Germany
* Sitz / Registered office: Berlin, HRB 134158 B
* Geschaeftsfuehrer / Managing Director: Harald Welte

--===============4495610745597101565==--

