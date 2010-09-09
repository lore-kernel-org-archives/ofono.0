Content-Type: multipart/mixed; boundary="===============4315391760969802367=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCHv2 0/6] Add message agent interface
Date: Thu, 09 Sep 2010 12:52:50 +0300
Message-ID: <1284025976-13294-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4315391760969802367==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

Here the same set with a whitespace fix and fix for a discrepancy in
the method name in documentation and in code.

Here is the diffstat:

 Makefile.am         |    3 +-
 doc/message-api.txt |   63 ++++++++
 include/dbus.h      |    1 +
 src/sms.c           |  207 +++++++++++++++++++++++---
 src/smsagent.c      |  416 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/smsagent.h      |   66 ++++++++
 test/sms-agent      |   84 +++++++++++
 7 files changed, 819 insertions(+), 21 deletions(-)

Cheers,
Aki


--===============4315391760969802367==--

