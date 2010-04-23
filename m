Content-Type: multipart/mixed; boundary="===============2097918050825225327=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH 0/3] Huawei E1552 hacks
Date: Fri, 23 Apr 2010 16:40:07 +0300
Message-ID: <20100423133926.2107.66535.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2097918050825225327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I did a quick hack to get my Huawei E1552 working with ofono. Here are
three small patches which was needed to get the modem working.

I would like to get Huawei gprs support to ofono, but I understand
that these patches are not acceptable. I would appreciate to get some
feedback how to properly implement Huawei support.

---

Kalle Valo (3):
      huawei: add gprs context
      atmodem: add a huawei hack to check attachment status
      atmodem: add signal strength support for huawei


 drivers/atmodem/gprs.c                 |   51 ++++++++++++++++++++++++++++=
++++
 drivers/atmodem/network-registration.c |    1 +
 plugins/huawei.c                       |   10 ++++++
 3 files changed, 62 insertions(+), 0 deletions(-)


--===============2097918050825225327==--

