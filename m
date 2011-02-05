Content-Type: multipart/mixed; boundary="===============4747445739067091903=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 0/7] Coding style fix
Date: Sat, 05 Feb 2011 06:29:04 -0800
Message-ID: <1296916151-21778-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4747445739067091903==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 Following patch adds a new mandatory coding rule and provides
the coding style fixes according to the new rule.

Regards,
Jeevaka

Jeevaka Badrappan (7):
  coding-style: Don't use hex with shift operator
  atmodem: M16 coding style fix
  hfpmodem: M16 coding style fix
  ifxmodem: M16 coding style fix
  stemodem: M16 coding style fix
  modem: M16 coding style fix
  smsutil: M16 coding style fix

 doc/coding-style.txt         |   12 ++++++++++++
 drivers/atmodem/voicecall.c  |    8 ++++----
 drivers/hfpmodem/voicecall.c |    2 +-
 drivers/ifxmodem/voicecall.c |   10 +++++-----
 drivers/stemodem/voicecall.c |    8 ++++----
 src/modem.c                  |    6 +++---
 src/smsutil.h                |    4 ++--
 7 files changed, 31 insertions(+), 19 deletions(-)


--===============4747445739067091903==--

