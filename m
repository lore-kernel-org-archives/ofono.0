Content-Type: multipart/mixed; boundary="===============3120861200542585062=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 00/24] [RFC] Don't rely on undefined behavior when casting
 function pointers
Date: Fri, 22 Apr 2016 13:10:05 +0000
Message-ID: <1461330601-21333-1-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3120861200542585062==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

Casting between incompatible function pointer types is undefined.
While it works fine on x86, it's not a good idea to depend on this.

This RFC uses g_slist_free_full where possible, and when it's not works aro=
und
the casting using other means such as wrappers or fixing function parameter=
s.

John Ernberg (24):
  atmodem: don't rely on undefined behavior when casting function
    pointers
  hfpmodem: don't rely on undefined behavior when casting function
    pointers
  ifxmodem: don't rely on undefined behavior when casting function
    pointers
  ril: don't rely on undefined behavior when casting function pointers
  stemodem: don't rely on undefined behavior when casting function
    pointers
  gatchat: don't rely on undefined behavior when casting function
    pointers
  bluez4: don't rely on undefined behavior when casting function
    pointers
  sm: don't rely on undefined behavior when casting function pointers
  cbs: don't rely on undefined behavior when casting function pointers
  cdma/sms: don't rely on undefined behavior when casting function
    pointers
  handsfree: don't rely on undefined behavior when casting function
    pointers
  modem: don't rely on undefined behavior when casting function pointers
  network: don't rely on undefined behavior when casting function
    pointers
  phonebook: don't rely on undefined behavior when casting function
    pointers
  sim: don't rely on undefined behavior when casting function pointers
  simfs: don't rely on undefined behavior when casting function pointers
  simutil: don't rely on undefined behavior when casting function
    pointers
  sms: don't rely on undefined behavior when casting function pointers
  smsutil: don't rely on undefined behavior when casting function
    pointers
  stk: don't rely on undefined behavior when casting function pointers
  stkutil: don't rely on undefined behavior when casting function
    pointers
  ussd: don't rely on undefined behavior when casting function pointers
  voicecall: don't rely on undefined behavior when casting function
    pointers
  unittest: don't rely on undefined behavior when casting function
    pointers

 drivers/atmodem/voicecall.c  |  6 ++----
 drivers/hfpmodem/voicecall.c |  6 ++----
 drivers/ifxmodem/voicecall.c |  3 +--
 drivers/rilmodem/voicecall.c |  6 ++----
 drivers/stemodem/voicecall.c |  3 +--
 gatchat/gatchat.c            | 13 +++++--------
 plugins/bluez4.c             |  7 +++----
 plugins/smart-messaging.c    |  6 ++----
 src/cbs.c                    | 27 +++++++++------------------
 src/cdma-smsutil.c           |  3 +--
 src/handsfree.c              |  3 +--
 src/modem.c                  |  6 ++----
 src/network.c                |  3 +--
 src/phonebook.c              | 24 ++++++++++++++----------
 src/sim.c                    | 29 ++++++++++-------------------
 src/simfs.c                  |  6 +++---
 src/simutil.c                |  6 ++----
 src/sms.c                    |  9 +++------
 src/smsutil.c                | 21 +++++++--------------
 src/stk.c                    | 10 +++++++---
 src/stkutil.c                | 39 ++++++++++++---------------------------
 src/ussd.c                   | 10 +++++-----
 src/voicecall.c              |  7 ++-----
 unit/test-sms.c              | 21 +++++++--------------
 24 files changed, 104 insertions(+), 170 deletions(-)

-- =

1.9.1

--===============3120861200542585062==--

