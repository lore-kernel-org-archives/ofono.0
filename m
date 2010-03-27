Content-Type: multipart/mixed; boundary="===============7095184396085692083=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 0/5] ppp: error path fixes 
Date: Fri, 26 Mar 2010 18:34:25 -0700
Message-ID: <1269653670-31352-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7095184396085692083==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here are some patches which fix some issues with the error paths in
the PPP control protocol code.

Kristen Carlson Accardi (5):
  ppp: fix segfault in pppcp_send_code_reject()
  ppp: comment fix
  ppp: send Protocol-Reject
  ppp: use common code to get options from pppcp packet data
  ppp: handle Config-Reject

 gatchat/ppp.c     |   29 ++++++---
 gatchat/ppp.h     |    1 +
 gatchat/ppp_cp.c  |  179 +++++++++++++++++++++++++++++++++++++++----------=
---
 gatchat/ppp_cp.h  |    2 +
 gatchat/ppp_lcp.c |    5 ++
 5 files changed, 161 insertions(+), 55 deletions(-)


--===============7095184396085692083==--

