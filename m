Content-Type: multipart/mixed; boundary="===============4107793079872298102=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: [PATCH 0/2] New rilmodem sms test
Date: Tue, 17 Nov 2015 20:45:14 -0500
Message-ID: <1447811116-11970-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4107793079872298102==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series adds a second rilmodem test for SMS.
The common server test functions have been extracted
for use by future rilmodem tests.

Tony Espy (2):
  unit: add new test-rilmodem-sms
  build: add support for test-rilmodem-sms

 Makefile.am                 |  14 ++-
 unit/rilmodem-test-server.c | 198 ++++++++++++++++++++++++++++++++
 unit/rilmodem-test-server.h |  40 +++++++
 unit/test-rilmodem-sms.c    | 267 ++++++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 518 insertions(+), 1 deletion(-)
 create mode 100644 unit/rilmodem-test-server.c
 create mode 100644 unit/rilmodem-test-server.h
 create mode 100644 unit/test-rilmodem-sms.c

-- =

2.1.4


--===============4107793079872298102==--

