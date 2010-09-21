Content-Type: multipart/mixed; boundary="===============0781187946215374170=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 0/5] Patch Description
Date: Tue, 21 Sep 2010 18:21:14 +0800
Message-ID: <1285064479-12907-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0781187946215374170==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series of patches are to handle send ss proactive command by splitting=
 the path of D-Bus and stk request. In this version, only call-forwarding i=
s handled, but others (call-barring, call-settings) would be quite similar. =

Comments are welcome!

------

Yang Gu (5):
  Add macro for general result and additional info
  stk: Support send ss response
  ss: Use function to judge if it's busy
  ss: Use errno for ssc handling functions
  cf: Handle send ss proactive command

 src/call-barring.c    |   71 ++++-------
 src/call-forwarding.c |  327 ++++++++++++++++++++++++++++++++++++++++-----=
----
 src/call-settings.c   |   44 +++----
 src/ofono.h           |   28 ++++
 src/stk.c             |  130 +++++++++++++++++++
 src/stkutil.c         |    2 +
 src/stkutil.h         |   23 ++++
 src/ussd.c            |  201 +++++++++++++++++++++++++++---
 8 files changed, 673 insertions(+), 153 deletions(-)

-- =

1.7.2.3


--===============0781187946215374170==--

