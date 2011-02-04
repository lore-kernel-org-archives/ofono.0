Content-Type: multipart/mixed; boundary="===============1297683386955935157=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 0/5] Make use of defined call_status enum
Date: Fri, 04 Feb 2011 12:35:38 -0800
Message-ID: <1296851743-14483-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1297683386955935157==
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
 drivers/stemodem/voicecall.c    |    3 +-
 5 files changed, 74 insertions(+), 45 deletions(-)


--===============1297683386955935157==--

