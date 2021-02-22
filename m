Content-Type: multipart/mixed; boundary="===============7902223839655230172=="
MIME-Version: 1.0
From: Jupiter <jupiter.hce@gmail.com>
Subject: [PATCH 0/4] SARA R4 patches  
Date: Mon, 22 Feb 2021 21:14:45 +1100
Message-ID: <20210222101449.2809-1-jupiter.hce@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7902223839655230172==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: jupiter <jupiter.hce@gmail.com>

Resubmit to write proper messages.

jupiter (4):
  SARA R4 QMI support based on uBlox model vendor ID
  Add OFONO_VENDOR_UBLOX_SARA_R4 =

  Check SARA R4 vendor ID, need to make it conditional on the actions being=
 attach and detach
  Add SARA R4 vendor and enable vendor in gprs create

 drivers/atmodem/vendor.h |  1 +
 drivers/qmimodem/gprs.c  | 15 +++++++++++++++
 plugins/gobi.c           | 11 ++++++++++-
 plugins/udevng.c         | 41 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 1 deletion(-)

-- =

2.17.1

--===============7902223839655230172==--

