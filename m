Content-Type: multipart/mixed; boundary="===============5525330877013452922=="
MIME-Version: 1.0
From: philippedeswert@gmail.com
Subject: [PATCH 0/8] [RFC] Support for serial u-blox NB-IoT modems
Date: Fri, 15 Feb 2019 14:11:34 +0200
Message-ID: <20190215121142.28163-1-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5525330877013452922==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Philippe De Swert <philippe.deswert@digitalistgroup.com>

Hi,

Lately we have been trying to get a u-blox SARA-R410 and R412 to work with =
ofono.
We inspired ourselves on the existing u-blox driver and ran into some weird
issues (mostly issues with roaming sims). So it would be nice to get some f=
eedback =

on what we might have done wrong. We did have issues with ATD99
and would be very interested in knowing what we missed or did wrong there a=
s we
needed to force it. We also found a small bug related to ppp and disconnect=
s.

Thanks!


Philippe De Swert (7):
  ublox-serial: add new plugin for u-blox
  Makefile.am : include new u-blox serial modem driver
  gprs-context : Force use of atd99
  common: Add new NB-IoT technologies

Tommi Rekosuo (1):
  gprs.h: Add ofono_gprs_get_netreg function
  gprs.c: Add ofono_gprs_get_netreg function
  atmodem/gprs.c: Add CEREG support
  Fix gprs_netreg_update behaviour if PPP connection active

 Makefile.am                    |   4 +
 drivers/atmodem/gprs-context.c |   5 +-
 drivers/atmodem/gprs.c         |  60 ++++-
 include/gprs.h                 |   1 +
 plugins/ublox-serial.c         | 393 +++++++++++++++++++++++++++++++++
 plugins/udevng.c               |   1 +
 src/common.c                   |   4 +
 src/common.h                   |   2 +
 src/gprs.c                     |  29 ++-
 9 files changed, 493 insertions(+), 6 deletions(-)
 create mode 100644 plugins/ublox-serial.c

-- =

2.20.1


--===============5525330877013452922==--

