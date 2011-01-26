Content-Type: multipart/mixed; boundary="===============6876073130522945454=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 0/1] Remove ofono_cug_option
Date: Wed, 26 Jan 2011 14:17:51 -0800
Message-ID: <1296080272-19253-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6876073130522945454==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 Following patch removes the ofono_cug_option enum and its usage
across ofono.

Regards,
Jeevaka

Jeevaka Badrappan (1):
  remove ofono_cug_option

 drivers/atmodem/voicecall.c      |   12 ++----------
 drivers/calypsomodem/voicecall.c |    9 ---------
 drivers/hfpmodem/voicecall.c     |    4 ++--
 drivers/huaweimodem/voicecall.c  |    9 ---------
 drivers/ifxmodem/voicecall.c     |   12 ++----------
 drivers/isimodem/voicecall.c     |   14 ++------------
 drivers/stemodem/voicecall.c     |   12 ++----------
 include/types.h                  |    6 ------
 include/voicecall.h              |    4 ++--
 src/voicecall.c                  |    5 ++---
 10 files changed, 14 insertions(+), 73 deletions(-)


--===============6876073130522945454==--

