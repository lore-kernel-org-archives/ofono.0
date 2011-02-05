Content-Type: multipart/mixed; boundary="===============1219200320603423618=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v2 0/5] Make use of defined call_status enum
Date: Sat, 05 Feb 2011 05:02:58 -0800
Message-ID: <1296910983-20402-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1219200320603423618==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 Following set of patches makes use of the defined call_status enum
instead of using the actual defined values.

Regards,
Jeevaka

Jeevaka Badrappan (5):
  atmodem: use defined call_status enum
  hfpmodem: Use defined call_status enum
  huaweimodem: Use defined call_status enum
  ifxmodem: Use defined call_status enum
  stemodem: Use defined call_status enum

 drivers/atmodem/voicecall.c     |   51 ++++++++++++++++++++++++-----------=
---
 drivers/hfpmodem/voicecall.c    |   12 +++++----
 drivers/huaweimodem/voicecall.c |   20 +++++++++------
 drivers/ifxmodem/voicecall.c    |   33 ++++++++++++++++---------
 drivers/stemodem/voicecall.c    |   15 +++++++----
 5 files changed, 81 insertions(+), 50 deletions(-)


--===============1219200320603423618==--

