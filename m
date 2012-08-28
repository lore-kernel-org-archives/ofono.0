Content-Type: multipart/mixed; boundary="===============3710192914684266899=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 0/4] Immediate digit response
Date: Tue, 28 Aug 2012 15:21:18 +0200
Message-ID: <1346160082-11077-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3710192914684266899==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Introduce a new STK method to get digit response on single key press.
This method asks to not display the entered digit and does not accept
the character '+'.

Philippe Nunes (4):
  doc: Add new STK Agent API to get digit response on single key press
  stkagent: Add new API to get digit response on single key press
  stk: Ask for immediate digit response if specified by command
    qualifier
  test: Update with RequestQuickDigit API

 doc/stk-api.txt    |    9 +++++++++
 src/stk.c          |    9 +++++++--
 src/stkagent.c     |   32 ++++++++++++++++++++++++++++++++
 src/stkagent.h     |    5 +++++
 test/test-stk-menu |   37 +++++++++++++++++++++++++++++++++++++
 5 files changed, 90 insertions(+), 2 deletions(-)

-- =

1.7.9.5


--===============3710192914684266899==--

