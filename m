Content-Type: multipart/mixed; boundary="===============1312539691727935774=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 0/4] Immediate digit response
Date: Fri, 24 Aug 2012 16:28:21 +0200
Message-ID: <1345818505-17175-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1312539691727935774==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For GET-INPUT proactive command, the command qualifier can require
to send the response immediately after the user has entered a digit.
In this mode, the entered digit shall not be displayed and the character
'+' is not allowed for user input.

Philippe Nunes (4):
  stk: check if immediate digit response is requested
  stkagent: Add argument to notify when immediate digit response is
    required
  doc: Update STK API regarding the new argument immediate_response
  test: Print the immediate_response argument for RequestDigit

 doc/stk-api.txt    |   13 +++++++++----
 src/stk.c          |    6 ++++--
 src/stkagent.c     |    6 ++++--
 src/stkagent.h     |    5 +++--
 test/test-stk-menu |    5 +++--
 5 files changed, 23 insertions(+), 12 deletions(-)

-- =

1.7.9.5


--===============1312539691727935774==--

