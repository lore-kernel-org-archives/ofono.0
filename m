Content-Type: multipart/mixed; boundary="===============1419712017762243245=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v0 0/3] Unify huawei and huaweicdma plugins
Date: Fri, 06 Jan 2012 16:28:35 +0100
Message-ID: <1325863718-19357-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1419712017762243245==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This set of patch is unifying huawei and huaweicdma plugin.
ATI command is now sent after ATE0 +CMEE=3D1 to check whether the modem is
CDMA or GSM type. Atoms are now created accordingly.

Concerning CDMA modem with embedded SIM, no sim atom will be created.
We always set online the modem.
Other CDMA modems will have a sim atom that will manage PIN rountine only.
Sim File System cannot be managed for the moment.

Offline command for CDMA modems that support ^RFSWITCH is AT+CFUN=3D5
unlike GSM modems which is AT+CFUN=3D7.

Kind regards,
Guillaume

Guillaume Zajac (3):
  udevng: Simplify vendor_list for Huawei constructor
  huawei: Add modem type detection
  huaweicdma: Delete unused plugin

 Makefile.am          |    3 -
 plugins/huawei.c     |   77 ++++++++++++++--
 plugins/huaweicdma.c |  247 ----------------------------------------------=
----
 plugins/udevng.c     |    4 +-
 4 files changed, 70 insertions(+), 261 deletions(-)
 delete mode 100644 plugins/huaweicdma.c


--===============1419712017762243245==--

