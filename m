Content-Type: multipart/mixed; boundary="===============2371402416897304748=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [PATCH 0/3] gprs-provision: Add SPN to provision API
Date: Tue, 08 Feb 2011 12:03:45 +0200
Message-ID: <1297159428-2409-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2371402416897304748==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello

This patchset adds Service Provider Name (SPN) into GPRS context provisioni=
ng API.
SPN is read (asynchronously) in the middle of gprs atom registration, if pr=
ovisioning is needed.

--Jukka

Jukka Saunamaki (3):
      gprs-provision: add SPN to provisioning API header
      gprs,gprs-provision: add SPN to provisioning API
      gprs-provision: update example with SPN

 examples/provision.c     |    8 +++--
 include/gprs-provision.h |    2 +-
 src/gprs-provision.c     |    4 +-
 src/gprs.c               |   87 ++++++++++++++++++++++++++++++++++--------=
---
 src/ofono.h              |    2 +-
 5 files changed, 74 insertions(+), 29 deletions(-)



--===============2371402416897304748==--

