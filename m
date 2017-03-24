Content-Type: multipart/mixed; boundary="===============3355865332161214719=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: [PATCH v3 0/2] Telit LE910 V1 QMI support
Date: Fri, 24 Mar 2017 14:51:44 +0000
Message-ID: <1490367106-8401-1-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3355865332161214719==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lukasz Nowak <lnowak@tycoint.com>

Changes from V2:
- made AlwaysOnline flow cleaner in gobi.c
- it turns out that AlwaysOnline is already a part of core logic
  in src/modem.c which have the same effect as if the driver had
  no set_online() function at all. Hence removed changes to
  gobi_set_online() as it is never called.


Changes from V1:
- split into multiple smaller commits
- added comments in code, documenting issues with the Telit QMI firmware
- disabled non-working low-power operating modes in additional cases
- use mccmnc string instead of truncating an invalid operator name

Lukasz Nowak (2):
  gobi: Do not use low-power modes for some modems
  udevng: add Telit LE910 V1 support

 plugins/gobi.c   | 19 +++++++++++++++++++
 plugins/udevng.c | 24 ++++++++++++++++++++----
 2 files changed, 39 insertions(+), 4 deletions(-)

-- =

2.7.4


--===============3355865332161214719==--

