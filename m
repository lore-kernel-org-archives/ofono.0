Content-Type: multipart/mixed; boundary="===============8153883843814577966=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 0/4] Use sim atom with cdma modems
Date: Mon, 21 Nov 2011 11:54:01 +0100
Message-ID: <1321872845-24754-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8153883843814577966==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Changelog from v1:
	- Implement sim specific cdmamodem drivers.
	- If no read drivers are implemented, call callback with failure
	  to continue with sim initialization routines.
	- If SIM is embedded but AT+CPIN? answers SIM not inserted, continue
	  with sim_initialize_after_pin() to get the IMSI.

Kind regards,
Guillaume

Guillaume Zajac (4):
  cdmamodem: Add sim driver implementation
  simfs: Call callback with failure if driver is not implemented
  huaweicdma: Add SIM creation and set_online method driver
  sim: Get IMSI if sim state is OFONO_SIM_STATE_INSERTED

 Makefile.am                   |    3 +-
 drivers/cdmamodem/cdmamodem.c |    2 +
 drivers/cdmamodem/cdmamodem.h |    3 +
 drivers/cdmamodem/sim.c       |  582 +++++++++++++++++++++++++++++++++++++=
++++
 plugins/huaweicdma.c          |  283 +++++++++++++++++++-
 src/sim.c                     |    2 +
 src/simfs.c                   |    4 +-
 7 files changed, 870 insertions(+), 9 deletions(-)
 create mode 100644 drivers/cdmamodem/sim.c


--===============8153883843814577966==--

