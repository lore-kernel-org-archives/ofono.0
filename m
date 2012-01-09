Content-Type: multipart/mixed; boundary="===============3085353766021614857=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 0/5] Unify SpeedUp plugin
Date: Mon, 09 Jan 2012 14:10:55 +0100
Message-ID: <1326114660-10111-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3085353766021614857==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Patch 1 is deleting huaweicdma label in udevng.
I submitted it again into this set of patch to avoid conflicts.
The 4 next patches are doing same job as for Huawei plugin on SpeedUp plugi=
n.

Kind regards,
Guillaume

Guillaume Zajac (5):
  udevng: Remove huaweicdma label from driver_list
  speedup: Check for supported modem capabilities first
  speedup: Create GSM/UMTS atoms only if support has been detected
  speedup: Create CDMA atoms if support has been detected
  udevng: Simplify vendor and driver list for SpeedUp

 plugins/speedup.c |   99 ++++++++++++++++++++++++++++++++++++++++---------=
---
 plugins/udevng.c  |    3 --
 2 files changed, 76 insertions(+), 26 deletions(-)


--===============3085353766021614857==--

