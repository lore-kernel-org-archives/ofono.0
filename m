Content-Type: multipart/mixed; boundary="===============7392456606902185704=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH v3 0/2] Huawei GPRS support
Date: Wed, 19 May 2010 17:06:46 +0300
Message-ID: <20100519140208.3163.29523.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7392456606902185704==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here's v3 of my Huawei GPRS patches. I followed Marcel's advice and
implemented all Huawei quirks in the huawei plugin. Now the patches
are a lot smaller.

Please comment.

---

Kalle Valo (2):
      huawei: add gprs context
      huawei: detect SecondaryDevice which is used for events


 drivers/atmodem/network-registration.c |    4 +
 plugins/huawei.c                       |  112 ++++++++++++++++++++++++++++=
+++-
 plugins/udev.c                         |   61 +++++++++++++++--
 3 files changed, 167 insertions(+), 10 deletions(-)


--===============7392456606902185704==--

