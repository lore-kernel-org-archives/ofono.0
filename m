Content-Type: multipart/mixed; boundary="===============2127861179626381551=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: [PATCH 0/2] Add new rilmodem SMS test cases
Date: Tue, 24 Nov 2015 14:38:50 -0500
Message-ID: <1448393932-16043-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2127861179626381551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patchset adds new rilmodem SMS test cases, including
tests for incoming SMS unsolicited responses.

Tony Espy (2):
  unit: add write support to rilmodem-test-server
  unit: add new test-rilmodem-sms test cases

 unit/rilmodem-test-server.c | 113 ++++++++------
 unit/rilmodem-test-server.h |  11 +-
 unit/test-rilmodem-cs.c     |   6 +-
 unit/test-rilmodem-sms.c    | 356 ++++++++++++++++++++++++++++++++++++++++=
++--
 4 files changed, 426 insertions(+), 60 deletions(-)

-- =

2.1.4


--===============2127861179626381551==--

