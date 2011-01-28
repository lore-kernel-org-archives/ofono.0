Content-Type: multipart/mixed; boundary="===============0949705525283278021=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 0/5] Add missing NULL check
Date: Fri, 28 Jan 2011 03:50:03 -0800
Message-ID: <1296215408-4946-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0949705525283278021==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 Following set of patches adds the missing NULL check in
radio-setting atom driver for all the modems.

Regards,
Jeevaka

Jeevaka Badrappan (5):
  ifxmodem: add NULL check
  hsomodem: add NULL check
  huaweimodem: add NULL check
  stemodem: add NULL check
  nwmodem: add NULL check

 drivers/hsomodem/radio-settings.c    |   15 ++++++++++-----
 drivers/huaweimodem/radio-settings.c |   30 ++++++++++++++++++++----------
 drivers/ifxmodem/radio-settings.c    |   15 ++++++++++-----
 drivers/nwmodem/radio-settings.c     |   15 ++++++++++-----
 drivers/stemodem/radio-settings.c    |   33 +++++++++++++++++++-----------=
---
 5 files changed, 69 insertions(+), 39 deletions(-)


--===============0949705525283278021==--

