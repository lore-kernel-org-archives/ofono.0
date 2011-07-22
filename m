Content-Type: multipart/mixed; boundary="===============8168792160945087995=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 0/4] ZTE/SpeedUp specificities
Date: Fri, 22 Jul 2011 18:15:25 +0200
Message-ID: <1311351329-1241-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8168792160945087995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On ZTE/Speedup modem, AT+CPIN? keeps returning CME ERROR 14 for a moment af=
ter successful AT+CPIN=3D".."
As there is no card status notification, a pooling with CPIN queries is use=
d to detect the state change.

On SpeedUp modem (vendor id 0x1c9e), use the proprietary command AT+CPNNUM?=
 to get the remaining SIM PIN attempts.

Philippe Nunes (4):
  atmodem: Add vendor entry for SpeedUp modems
  speedup: Create SIM atom with SpeedUp vendor to handle proprietary
    commands
  atmodem: Add a polling based on CPIN query to detect SIM state change
  atmodem: Add support for the PIN counter command AT+CPNNUM

 drivers/atmodem/sim.c    |  151 ++++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/atmodem/vendor.h |    1 +
 plugins/speedup.c        |    2 +-
 3 files changed, 153 insertions(+), 1 deletions(-)


--===============8168792160945087995==--

