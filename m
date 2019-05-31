Content-Type: multipart/mixed; boundary="===============0635717897999156086=="
MIME-Version: 1.0
From: Philippe De Swert <philippedeswert@gmail.com>
Subject: [PATCH 0/4] RFC2: ublox serial modem support
Date: Fri, 31 May 2019 14:44:17 +0300
Message-ID: <20190531114421.21092-1-philippe.deswert@digitalistgroup.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0635717897999156086==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After the comments on the last patchset, as requested I tried to take
the approach where the serial support is merged into the existing ublox dri=
ver.

Some notes/caveats:
1. Not sure if filtering on device path is the right approach to identify a=
 serial modem
2. This will not really work unless we fix the CEREG/CREG mess
3. There is still the CHAP NO_AUTH ppp issue also
4. There is an issue with missing support for AT+CGDATA for SARA ublox mode=
ms. Did not =

   find a better way than mandate atd99 for all ublox modems based on vendo=
r. Maybe there
   is a cleaner/better way?


Philippe De Swert (4):
  ubloxmodem: pre-eliminary support for ublox SARA serial modems
  plugins/ublox: Enable serial connection for an ublox modem
  udev: Recognize ublox serial modems
  atmodem: Use atd99 as ppp command for ublox

 drivers/atmodem/gprs-context.c  | 11 ++++---
 drivers/ubloxmodem/lte.c        |  9 ++++++
 drivers/ubloxmodem/netmon.c     |  2 ++
 drivers/ubloxmodem/ubloxmodem.c | 14 +++++++++
 drivers/ubloxmodem/ubloxmodem.h |  2 ++
 plugins/ublox.c                 | 55 ++++++++++++++++++++++++++++++++-
 plugins/udevng.c                |  7 +++++
 7 files changed, 95 insertions(+), 5 deletions(-)

-- =

2.20.1


--===============0635717897999156086==--

