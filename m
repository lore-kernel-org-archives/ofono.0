Content-Type: multipart/mixed; boundary="===============4087752931463019710=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 0/3] oFono rules update 
Date: Thu, 11 Aug 2011 17:38:21 +0200
Message-ID: <1313077104-13397-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4087752931463019710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Based on the latest usb_modeswitch rules, some 3G dongles require
to modify the ofono rules to be supported correctly (tests done in India)  =



Philippe Nunes (3):
  udev: use ttyUSB3 for ZTE K3570 modem port.
  udev:  add support for Olive HSDPA modem
  udev: Use ttyUSB4 for Huawei E367 Pcui port

 plugins/ofono.rules |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)


--===============4087752931463019710==--

