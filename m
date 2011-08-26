Content-Type: multipart/mixed; boundary="===============6062110669084054354=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 0/4] udev rules update
Date: Fri, 26 Aug 2011 17:21:49 +0200
Message-ID: <1314372113-29410-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6062110669084054354==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For dongle ZTE MF190, 6 interfaces are present and we shall use the interfa=
ce ttyUSB4 for modem channel.
But to not break the support of ZTE modems with 5 interfaces (which are usi=
ng the 4th one for PPP, like K3570), I decided finally to add a specific ru=
le.

I added also a specific rule for the dongle ZTE MF668 as the modem channel =
is not on the latest interface.

For Speedup dongles, I switched aux channel and modem channel (should solve=
 the bug #20553).
For Speedup cdma dongles, modem channel is set to ttyUSB0.

Philippe Nunes (4):
  udevng.c: Switch aux channel and modem channel for Speedup dongles
  udevng.c: Assign modem channel to ttyUSB0 for speedup cdma dongles
  udev: Add rules to support ZTE MF668 dongle
  udev: Add rules to support ZTE MF190 dongle

 plugins/ofono.rules |   12 ++++++++++++
 plugins/udevng.c    |   13 +++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)


--===============6062110669084054354==--

