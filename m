Content-Type: multipart/mixed; boundary="===============5143054486518166989=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH 0/2] huawei: PIN unlock working with E1552
Date: Tue, 10 Aug 2010 12:57:28 +0300
Message-ID: <20100810095612.18457.66344.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5143054486518166989==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After these two patches PIN unlock works always with my Huawei E1552.

---

Kalle Valo (2):
      huawei: poll sim state
      huawei: postpone post_sim until SIM is ready


 plugins/huawei.c |  136 ++++++++++++++++++++++++++++++++++----------------=
----
 1 files changed, 86 insertions(+), 50 deletions(-)


--===============5143054486518166989==--

