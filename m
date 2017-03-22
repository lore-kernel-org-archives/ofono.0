Content-Type: multipart/mixed; boundary="===============1059542037854955282=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: [PATCH v2 0/5] Telit LE910 V1 QMI support
Date: Wed, 22 Mar 2017 18:14:48 +0000
Message-ID: <1490206493-17454-1-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1059542037854955282==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lukasz Nowak <lnowak@tycoint.com>

Changes from V1:
- split into multiple smaller commits
- added comments in code, documenting issues with the Telit QMI firmware
- disabled non-working low-power operating modes in additional cases
- use mccmnc string instead of truncating an invalid operator name

Lukasz Nowak (5):
  qmimodem: telit LE910 V1 - fix ESN string
  qmimodem: read ss_info at probe time
  qmimodem: detect utf-8 string as operator name
  gobi: Do not use low-power modes for some modems
  udevng: add Telit LE910 V1 support

 drivers/qmimodem/devinfo.c              |  3 ++-
 drivers/qmimodem/gprs.c                 |  7 ++++++
 drivers/qmimodem/network-registration.c | 19 ++++++++++++---
 plugins/gobi.c                          | 41 ++++++++++++++++++++++++++---=
----
 plugins/udevng.c                        | 24 +++++++++++++++----
 5 files changed, 78 insertions(+), 16 deletions(-)

-- =

2.7.4


--===============1059542037854955282==--

