Content-Type: multipart/mixed; boundary="===============7644469995401167379=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v1 00/10] HFP Service Level Connection establishment
Date: Wed, 23 Jan 2013 15:27:51 -0300
Message-ID: <1358965681-7420-1-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1358891005-24688-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7644469995401167379==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Changes from last version (from review comments):

 - Better error handling when using GDBusProxy;
 - Fixed some indentation issues;
 - Proper use of the ofono_modem functionality to keep associated data;
 - Simplifications that these changes allowed;


Cheers,

Vinicius Costa Gomes (10):
  hfp_hf_bluez5: Initial GDBusClient for BlueZ
  hfp_hf_bluez5: Add GDBusProxy for Bluetooth devices
  hfp_hf_bluez5: Register modem for HFP AG capable devices
  hfp_hf_bluez5: Keep track of changes of devices Aliases
  hfp_hf_bluez5: Handle NewConnection from BlueZ
  hfpmodem: Add dynamic hfp_slc_info allocation
  hfpmodem: Implement hfp_slc_info_free()
  hfp_hf_bluez4: Use hfp_slc_info_free()
  phonesim: Use hfp_slc_info_free()
  hfp_hf_bluez5: Add SLC establishment procedure

 drivers/hfpmodem/slc.c  |  19 ++-
 drivers/hfpmodem/slc.h  |   3 +-
 plugins/bluez5.h        |   5 +-
 plugins/hfp_hf_bluez4.c |  37 ++---
 plugins/hfp_hf_bluez5.c | 375 ++++++++++++++++++++++++++++++++++++++++++++=
+++-
 plugins/phonesim.c      |  10 +-
 6 files changed, 416 insertions(+), 33 deletions(-)

-- =

1.8.1.1


--===============7644469995401167379==--

