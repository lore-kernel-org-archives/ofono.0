Content-Type: multipart/mixed; boundary="===============5373798312376709705=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH v5 0/3] Huawei GPRS support
Date: Thu, 20 May 2010 13:53:09 +0300
Message-ID: <20100520105215.20968.59029.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5373798312376709705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v5 of my Huawei GPRS support. Hopefully ready now :)

Please take a look and comment.

---

Kalle Valo (3):
      huawei: add gprs context
      Move report_signal_strength to atutil
      huawei: detect possible secondary device


 drivers/atmodem/atutil.h               |   12 +++
 drivers/atmodem/network-registration.c |   26 +++----
 plugins/huawei.c                       |  128 ++++++++++++++++++++++++++++=
----
 plugins/udev.c                         |   61 +++++++++++++--
 4 files changed, 188 insertions(+), 39 deletions(-)


--===============5373798312376709705==--

