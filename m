Content-Type: multipart/mixed; boundary="===============8259909238987592930=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 0/2] Fix issue with DST
Date: Tue, 01 Feb 2011 13:44:03 +0200
Message-ID: <1296560645-19062-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8259909238987592930==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 Following patch converts the DST from hours to seconds which is the
expected outcome.

Regards,
Jeevaka

Jeevaka Badrappan (2):
  atmodem: convert dst from hours to seconds
  isimodem: convert dst from hours to seconds

 drivers/atmodem/network-registration.c  |    2 +-
 drivers/isimodem/network-registration.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


--===============8259909238987592930==--

