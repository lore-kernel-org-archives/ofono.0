Content-Type: multipart/mixed; boundary="===============4304415643629924969=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v3 00/12] org.bluez.Telephony interface integration
Date: Mon, 02 Apr 2012 15:27:10 +0200
Message-ID: <1333373242-11117-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4304415643629924969==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Those patches integrates the future org.bluez.Telephony interface into
oFono for HFP HF and HFP AG plugins.

For HFP AG plugin, the bluetooth rfcomm server is replaced by a
Telephony Agent registered to org.bluez.Telephony.
For HFP HF plugin, RegisterAgent call of org.bluez.HandsfreeGateway is
replaced by the one of org.bluez.Telephony

Since latest RFC :
- Patch 9:
  - Fix PropertyChanged callback for InbandRingtone
RFC v2:
- add support of org.bluez.MediaTransport interface in emulator.
  This allows support of audio related functions with the new
  architecture.
- add support for AT+NREC command
- add support of In-band ring tone (+BSIR event)
- add support of volume management (AT+VGS and AT+VGM commands,
  +VGS and +VGM events)

Any comments appreciated.

Fr=C3=A9d=C3=A9ric Danis (12):
  bluetooth: Add org.bluez.Telephony helpers
  hfp_hf: Update to org.bluez.Telephony interface
  hfp_ag: Update to org.bluez.Telephony interface
  bluetooth: Add org.bluez.MediaTransport interface
  include: Add audio transport set API
  emulator: Add audio transport set
  hfp_ag: Add media transport support
  emulator: Add AT+NREC support
  emulator: Add +BSIR support
  emulator: Add AT+VGM support
  emulator: Add AT+VGS support
  hfp_ag: Update supported features

 include/emulator.h  |    3 +
 plugins/bluetooth.c |  199 +++++++++++++++++++++++++++++
 plugins/bluetooth.h |   15 +++
 plugins/hfp_ag.c    |  129 +++++++++----------
 plugins/hfp_hf.c    |  165 +++++++++---------------
 src/emulator.c      |  348 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 6 files changed, 686 insertions(+), 173 deletions(-)


--===============4304415643629924969==--

