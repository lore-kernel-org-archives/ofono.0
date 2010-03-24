Content-Type: multipart/mixed; boundary="===============8262330316158453687=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 0/3] fix memory leaks in PPP 
Date: Wed, 24 Mar 2010 10:13:22 -0700
Message-ID: <1269450805-3661-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8262330316158453687==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix a few memory leaks in PPP

Kristen Carlson Accardi (3):
  fix memory leaks in option handling
  fix memory leaks after ppp_transmit
  fix memory leak in ppp_auth

 gatchat/ppp_auth.c |    1 +
 gatchat/ppp_cp.c   |   51 +++++++++++++++++++++++++++++++++++++++++-------=
---
 2 files changed, 42 insertions(+), 10 deletions(-)


--===============8262330316158453687==--

