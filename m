Content-Type: multipart/mixed; boundary="===============3571200011469771840=="
MIME-Version: 1.0
From: George Matveev <george@matveev.se>
Subject: [PATCH 0/7] Add enum called_number_type
Date: Sun, 23 Jan 2011 11:16:29 +0100
Message-ID: <1295777796-19978-1-git-send-email-george@matveev.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3571200011469771840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series adds enumeration called_number_type
based on 3GPP TS 24.008, section 10.5.4.7.
Elements of this enum is to be used whenever phone type
is required, replacing numbers 129, 145 used previously
ad hock throughout the code. =


George Matveev (7):
  src: Introduced enum called_number_type
  atmodem: Phone type defined using enum called_number_type
  huaweimodem: Phone type defined using enum called_number_type
  hfpmodem: Phone type defined using enum called_number_type
  ifxmodem: Phone type defined using enum called_number_type
  calypsomodem: Phone type defined using enum called_number_type
  stemodem: Phone type defined using enum called_number_type

 drivers/atmodem/atutil.c          |    3 ++-
 drivers/atmodem/call-forwarding.c |    3 ++-
 drivers/atmodem/ssn.c             |    3 ++-
 drivers/atmodem/voicecall.c       |    2 +-
 drivers/calypsomodem/voicecall.c  |    3 ++-
 drivers/hfpmodem/voicecall.c      |    2 +-
 drivers/huaweimodem/voicecall.c   |    3 ++-
 drivers/ifxmodem/voicecall.c      |    3 ++-
 drivers/stemodem/voicecall.c      |    2 +-
 src/call-forwarding.c             |    2 +-
 src/common.c                      |    8 ++++----
 src/common.h                      |   10 ++++++++++
 src/phonebook.c                   |    3 +--
 13 files changed, 31 insertions(+), 16 deletions(-)


--===============3571200011469771840==--

