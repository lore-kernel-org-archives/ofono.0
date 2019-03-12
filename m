Content-Type: multipart/mixed; boundary="===============1071783883637769438=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 00/14] ublox patches
Date: Tue, 12 Mar 2019 12:09:54 +0100
Message-ID: <20190312111008.29258-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1071783883637769438==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series provides cleanups that should facilitate extending the
ublox driver to more easily cover all device models.  Points of
interest:

- provides model descriptors that can be extended to account for
differences between devices
- queries the device model directly instead of relying on
information from udev
- provides detection and rudimentary support for TOBY L4 modems
- updated LTE driver to be used across all ublox models

The TOBY L4 support is a work in progress and this is also to be extended to
the SARA-R4/N4 series.  I currently only have a TOBY L4 available, so
I'm hoping that somebody with an L2 could give this a shake to make sure
nothing's been broken there.

/Jonas

Jonas Bonn (14):
  Fix whitespace weirdness
  ublox: drop vendor type for Toby L2 model
  ublox: make device selection more flexible
  ublox: create model data structures
  ublox: query device model
  ublox: add model flag HAVE_USBCONF
  ublox: query USBCONF for applicable devices
  udevng: ublox: Model string no longer used
  ublox: add device flags
  ublox: add TOBY L4 models
  udevng: detect ublox TOBY L4
  Separate ATE and AT+CMEE commands
  ublox: extend LTE driver
  ublox: pass model id to LTE plugin

 drivers/atmodem/gprs.c                 |   1 -
 drivers/atmodem/network-registration.c |  19 +--
 drivers/atmodem/sim.c                  |   1 -
 drivers/atmodem/vendor.h               |   1 -
 drivers/ubloxmodem/lte.c               | 101 ++++++++++++--
 drivers/ubloxmodem/ubloxmodem.c        |  78 +++++++++++
 drivers/ubloxmodem/ubloxmodem.h        |  17 +++
 plugins/ublox.c                        | 180 ++++++++++++++++++-------
 plugins/udevng.c                       |  15 ++-
 9 files changed, 336 insertions(+), 77 deletions(-)

-- =

2.19.1


--===============1071783883637769438==--

