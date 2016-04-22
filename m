Content-Type: multipart/mixed; boundary="===============4198560523239818020=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 0/5] Clean up atoms on modem_unregister
Date: Fri, 22 Apr 2016 13:07:15 +0000
Message-ID: <1461330431-20206-1-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4198560523239818020==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

When using e.g. a USB modem and it's unplugged oFono may crash with a
SIGSEGV or SIGFPE due to atoms not getting cleaned up properly.

John Ernberg (5):
  modem: clean up atoms on modem_unregister
  bluez4: track and clean up atom watches
  bluez5: track and clean up atom watches
  push notification: track and clean up atom watches
  smart messaging: track and clean up atom watches

 plugins/dun_gw_bluez4.c     | 24 ++++++++++++++++++++++--
 plugins/dun_gw_bluez5.c     | 24 ++++++++++++++++++++++--
 plugins/hfp_ag_bluez4.c     | 25 ++++++++++++++++++++++---
 plugins/hfp_ag_bluez5.c     | 36 +++++++++++++++++++++++++++++++-----
 plugins/push-notification.c | 26 +++++++++++++++++++++++---
 plugins/smart-messaging.c   | 26 +++++++++++++++++++++++---
 src/modem.c                 |  3 +++
 7 files changed, 146 insertions(+), 18 deletions(-)

-- =

1.9.1

--===============4198560523239818020==--

