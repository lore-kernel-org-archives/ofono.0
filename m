Content-Type: multipart/mixed; boundary="===============5042079763580564107=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: [PATCH 0/2] Support new rilmodem call-settings tests
Date: Thu, 05 Nov 2015 13:10:16 -0500
Message-ID: <1446747018-5885-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5042079763580564107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patchset adds new build-time tests for the rilmodem driver's
call-settings atom functions.  These tests are intended to eventually
replace the former grilrequest/reply/unsol unit tests which are being
re-moved as part of rilmodem re-factoring.

Tony Espy (2):
  unit: add new test-rilmodem-cs
  build: add support for unit/rilmodem-cs

 Makefile.am             |  11 +-
 unit/test-rilmodem-cs.c | 707 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 717 insertions(+), 1 deletion(-)
 create mode 100644 unit/test-rilmodem-cs.c

-- =

2.1.4


--===============5042079763580564107==--

