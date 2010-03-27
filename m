Content-Type: multipart/mixed; boundary="===============6373937373582272551=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 0/2] ppp authentication bug fixes (resend)
Date: Fri, 26 Mar 2010 21:36:48 -0700
Message-ID: <1269664610-31900-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6373937373582272551==
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


--===============6373937373582272551==--

