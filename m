Content-Type: multipart/mixed; boundary="===============3701231886104805379=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [RFC PATCH v1 0/2] huawei: fix cold start
Date: Fri, 17 Sep 2010 13:23:45 +0300
Message-ID: <20100917101755.8517.58836.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3701231886104805379==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I finally was able to start look at Huawei again. Like reported multiple
times, huawei currently works in only in the "warm start" case (ie. plug in =

modem and restart ofono). This is a regression, this worked ok a month ago.

Here's currently what I have, but pin locked sims still don't work. I'll
send the patches as RFC anyway. Please test and give feedback.

---

Kalle Valo (2):
      huawei: poll sim state
      huawei: fix online logic


 plugins/huawei.c |  121 ++++++++++++++++++++++++++++++++++++++++++++------=
----
 1 files changed, 99 insertions(+), 22 deletions(-)

--===============3701231886104805379==--

