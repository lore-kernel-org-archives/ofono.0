Content-Type: multipart/mixed; boundary="===============6670646937249903298=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 00/32] Add ModemType
Date: Tue, 22 Nov 2011 18:09:29 +0100
Message-ID: <1321981801-5452-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6670646937249903298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

Hi,

here are the patches to add the ModemType to the Modem interface.

cheers,
daniel

Daniel Wagner (32):
  modem: Add modem type to ofono_modem_driver
  alcatel: Add modem type hardware
  calypso: Add modem type hardware
  g1: Add modem type hardware
  gobi: Add mode type hardware
  hfp_hf: Add modem type hfp
  hso: Add modem type hardware
  huawei: Add modem type hardware
  huaweicdma: Add modem type hardware
  ifx: Add modem type hardware
  isiusb: Add modem type hardware
  linktop: Add modem type hardware
  mbm: Add modem type hardware
  n900: Add modem type hardware
  nokia: Add modem type hardware
  novatelcdma: Add modem type hardware
  novatel: Add modem type hardware
  palmpre: Add modem type hardware
  phonesim: Add modem type hardware
  samsumg: Add modem type hardware
  sap: Add modem type sap
  sierra: Add modem type hardware
  speedup: Add modem type hardware
  speedupcdma: Add modem type hardware
  ste: Add modem type hardware
  tc65: Add modem type hardware
  telit: Add modem type hardware
  u8500: Add modem type hardware
  wavecom: Add modem type hardware
  zte: Add modem type hardware
  modem: Append ModemType to GetProperties()
  modem: Update documation on ModemType

 doc/modem-api.txt     |   11 +++++++++++
 include/modem.h       |    7 +++++++
 plugins/alcatel.c     |    1 +
 plugins/calypso.c     |    1 +
 plugins/g1.c          |    1 +
 plugins/gobi.c        |    1 +
 plugins/hfp_hf.c      |    1 +
 plugins/hso.c         |    1 +
 plugins/huawei.c      |    1 +
 plugins/huaweicdma.c  |    1 +
 plugins/ifx.c         |    1 +
 plugins/isiusb.c      |    1 +
 plugins/linktop.c     |    1 +
 plugins/mbm.c         |    1 +
 plugins/n900.c        |    1 +
 plugins/nokia.c       |    1 +
 plugins/nokiacdma.c   |    1 +
 plugins/novatel.c     |    1 +
 plugins/palmpre.c     |    1 +
 plugins/phonesim.c    |    2 ++
 plugins/samsung.c     |    1 +
 plugins/sap.c         |    1 +
 plugins/sierra.c      |    1 +
 plugins/speedup.c     |    1 +
 plugins/speedupcdma.c |    1 +
 plugins/ste.c         |    1 +
 plugins/tc65.c        |    1 +
 plugins/telit.c       |    1 +
 plugins/u8500.c       |    1 +
 plugins/wavecom.c     |    1 +
 plugins/zte.c         |    1 +
 src/modem.c           |   18 ++++++++++++++++++
 32 files changed, 66 insertions(+), 0 deletions(-)

-- =

1.7.8.rc1.14.g248db


--===============6670646937249903298==--

