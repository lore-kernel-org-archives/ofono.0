Content-Type: multipart/mixed; boundary="===============9208412345533034998=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH v4 0/3] Huawei GPRS support
Date: Thu, 20 May 2010 11:04:02 +0300
Message-ID: <20100520080214.17288.7485.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9208412345533034998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

here's v4 of Huawei GPRS support. Lots of whitespace cleanup, a memory leak
fixed and a new function at_util_convert_signal_strength(). All based on
comments from Denis.

---

Kalle Valo (3):
      huawei: add gprs context
      Move report_signal_strength to atutil
      huawei: detect possible secondary device


 drivers/atmodem/atutil.h               |   12 +++
 drivers/atmodem/network-registration.c |    8 +-
 plugins/huawei.c                       |  129 ++++++++++++++++++++++++++++=
+---
 plugins/udev.c                         |   61 +++++++++++++--
 4 files changed, 186 insertions(+), 24 deletions(-)


--===============9208412345533034998==--

