Content-Type: multipart/mixed; boundary="===============4428351339680904052=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH 0/4] huawei: minor cleanups
Date: Tue, 25 May 2010 17:23:06 +0300
Message-ID: <20100525142205.10449.64616.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4428351339680904052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some more love to Huawei, based on Dennis' comments.

---

Kalle Valo (4):
      huawei: remove voicecall support
      huawei: send a prefix with AT commands
      huawei: properly notify sim state to ofono
      huawei: use g_at_result_iter_skip_next()


 plugins/huawei.c |   67 +++++++++++++++++++++++++++++---------------------=
----
 1 files changed, 36 insertions(+), 31 deletions(-)


--===============4428351339680904052==--

