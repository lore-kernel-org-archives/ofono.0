Content-Type: multipart/mixed; boundary="===============3952903218783155150=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 0/2] ppp authentication bug fixes 
Date: Thu, 25 Mar 2010 13:04:34 -0700
Message-ID: <1269547476-23161-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3952903218783155150==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here are a couple bug fixes for the PPP authentication.  First patch
fixes the seg fault when the secret is empty, as reported by marcel.
Second, if we do fail to authenticate, we need to change ppp phases
to terminate the link.

Kristen Carlson Accardi (2):
  ppp: allow empty secret for chap challenge
  ppp: send PPP_FAIL when authentication fails

 gatchat/ppp_auth.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)


--===============3952903218783155150==--

