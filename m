Content-Type: multipart/mixed; boundary="===============5228269637247487128=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v4 0/6] Provider name and SID
Date: Wed, 18 Jan 2012 18:05:11 +0100
Message-ID: <1326906317-11601-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5228269637247487128==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This version introduces a QCDM helper library.
Also, to simplify the QCDM handling, a dedicated callback is set for each
command sent.
Currently, we are not considering that a new command can be issued before t=
he
answer from the previous command is handled. If this case occurs, then we w=
ould
need to introduce a command queue in the GAtHDLC structure to be able to in=
voke
properly the callbacks.

Philippe.    =


Philippe Nunes (6):
  gatchat: Add g_at_chat_set_slave_qcdm / g_at_chat_get_slave_qcdm
  huawei: Open qcdm port to fetch network status & SID
  gatqcdm: Add helper functions for QCDM handling
  huaweimodem: Probe the QCDM port with the version info request
  huaweimodem: Add 'serving_system' entry point to get SID
  udevng: Add a default assignment for Huawei QCDM port

 Makefile.am                       |    1 +
 drivers/huaweimodem/cdma-netreg.c |  174 +++++++++++++++++++++++++++++++++=
+---
 gatchat/gatchat.c                 |   26 ++++++
 gatchat/gatchat.h                 |    4 +
 gatchat/gatqcdm.c                 |   84 ++++++++++++++++++
 gatchat/gatqcdm.h                 |   57 ++++++++++++
 plugins/huawei.c                  |   44 +++++++++
 plugins/udevng.c                  |   30 +++++--
 8 files changed, 400 insertions(+), 20 deletions(-)
 create mode 100644 gatchat/gatqcdm.c
 create mode 100644 gatchat/gatqcdm.h


--===============5228269637247487128==--

