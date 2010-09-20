Content-Type: multipart/mixed; boundary="===============4972988717468686579=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH v2 0/2] huawei: fix cold start
Date: Mon, 20 Sep 2010 15:40:20 +0300
Message-ID: <20100920123957.12498.61806.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4972988717468686579==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here's my second round of getting huawei working again in cold start.
Locked pin sims worked in v1, but in these patches they are again
broken. I had to omit that problem now because I want to have Huawei
working again quickly.

Please test and provide feedback.

---

Kalle Valo (2):
      huawei: poll sim state
      huawei: fix online logic


 plugins/huawei.c |  133 +++++++++++++++++++++++++++++++++++++++++---------=
----
 1 files changed, 101 insertions(+), 32 deletions(-)


--===============4972988717468686579==--

