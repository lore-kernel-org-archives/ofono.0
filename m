Content-Type: multipart/mixed; boundary="===============8344517270761165725=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 00/10] HFP Service Level Connection establishment
Date: Tue, 22 Jan 2013 18:43:15 -0300
Message-ID: <1358891005-24688-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8344517270761165725==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This series include the modem registration when a BlueZ device appears
with support for HFP AG.

Also, a modem is registered when NewConnection() comes and we don't
have a modem associated yet.

For the SLC establishment, only the file descriptor from NewConnection()
is used.

Cheers,


Vinicius Costa Gomes (10):
  hfp_hf_bluez5: Initial GDBusClient for BlueZ
  hfp_hf_bluez5: Add GDBusProxy for Bluetooth devices
  hfp_hf_bluez5: Register modem for HFP AG capable devices
  hfp_hf_bluez5: Keep track of changes of devices Aliases
  hfp_hf_bluez5: Handle NewConnection from BlueZ
  hfpmodem: Add dynamic hfp_slc_info allocation
  hfpmodem: Implement hfp_slc_info_free
  hfp_hf_bluez4: Use hfp_slc_info_free()
  phonesim: Use hfp_slc_info_free()
  hfp_hf_bluez5: Add SLC establishment procedure

 drivers/hfpmodem/slc.c  |  16 +-
 drivers/hfpmodem/slc.h  |   3 +-
 plugins/bluez5.h        |   6 +-
 plugins/hfp_hf_bluez4.c |  41 +++--
 plugins/hfp_hf_bluez5.c | 421 ++++++++++++++++++++++++++++++++++++++++++++=
++--
 plugins/phonesim.c      |  10 +-
 6 files changed, 460 insertions(+), 37 deletions(-)

-- =

1.8.1.1


--===============8344517270761165725==--

