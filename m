Content-Type: multipart/mixed; boundary="===============2962345822146716242=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH v2 0/6] Huawei GPRS support
Date: Fri, 30 Apr 2010 15:54:50 +0300
Message-ID: <20100430124405.30019.86945.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2962345822146716242==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello all,

here's my current patch set of adding Huawei GPRS support to ofono. I
have tested it with Huawei E1552 USB dongle and finnish Saunalahti prepaid
sim.

Because I had to somehow provide the second GAtChat to atmodem's gprs and
netreg modules, I decided to add two new structs.

There's one major bug still, ofono segfaults when I deactivate the gprs
context. I don't know the reason for this yet.

Please comment.

---

Kalle Valo (6):
      huawei: add gprs context
      atmodem: add signal strength support for huawei
      atmodem: follow separate event chat with huawei
      huawei: detect SecondaryDevice which is used for events
      atmodem: create struct atmodem_network_registration
      atmodem: create struct atmodem_gprs


 drivers/atmodem/gprs.c                 |   23 ++++++++---
 drivers/atmodem/gprs.h                 |   29 ++++++++++++++
 drivers/atmodem/network-registration.c |   37 ++++++++++++++++--
 drivers/atmodem/network-registration.h |   29 ++++++++++++++
 plugins/atgen.c                        |    7 +++
 plugins/calypso.c                      |    7 +++
 plugins/em770.c                        |    2 +
 plugins/g1.c                           |    8 +++-
 plugins/hso.c                          |   15 ++++++-
 plugins/huawei.c                       |   66 ++++++++++++++++++++++++++++=
+++-
 plugins/mbm.c                          |   14 ++++++-
 plugins/novatel.c                      |    9 ++++
 plugins/palmpre.c                      |   15 ++++++-
 plugins/phonesim.c                     |   16 ++++++--
 plugins/ste.c                          |   15 ++++++-
 plugins/udev.c                         |   61 ++++++++++++++++++++++++++--=
--
 16 files changed, 319 insertions(+), 34 deletions(-)
 create mode 100644 drivers/atmodem/gprs.h
 create mode 100644 drivers/atmodem/network-registration.h


--===============2962345822146716242==--

