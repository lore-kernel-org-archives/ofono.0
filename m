Content-Type: multipart/mixed; boundary="===============6039046447743412841=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v5 00/12] org.bluez.Telephony interface integration
Date: Thu, 26 Apr 2012 16:26:52 +0200
Message-ID: <1335450424-19964-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6039046447743412841==
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
- Patch 4
  forward declare the structute used in bluetooth plug-in by
  bluetooth_set_audio_management() and bluetooth_free_audio_management()
- Patch 5
  Fix DBus pending call management in case of HFP emulator unregistration
  Remove ofono_emulator_remove_handler() calls
- Patches 9 and 10
  Add APIs to set/get data for emulator atom
- Patch 11 (previously 9)
  Remove IO watch as data destroyer associated to emulator will be called
  on atom removal

RFC v4:
- Patche 1
  move agent registration from adapter_added() to adapter_properties_cb()
- Patches 4 to 10:
  Rewrote support of AT+NREC, AT+VGM, +VGM, AT+VGS, +VGS and +BSIR into
  bluetooth plugin


Fr=C3=A9d=C3=A9ric Danis (12):
  bluetooth: Add org.bluez.Telephony helpers
  hfp_hf: Update to org.bluez.Telephony interface
  hfp_ag: Update to org.bluez.Telephony interface
  bluetooth: Add audio APIs for HFP AG
  bluetooth: Add AT+NREC support
  bluetooth: Add +BSIR support
  bluetooth: Add AT+VGM support
  bluetooth: Add AT+VGS support
  include: add set/get data APIs to emulator
  emulator: add set/get data APIs
  hfp_ag: Add media transport support
  emulator: Update supported features

 include/emulator.h  |    5 +
 plugins/bluetooth.c |  546 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/bluetooth.h |   19 ++
 plugins/hfp_ag.c    |  132 ++++++-------
 plugins/hfp_hf.c    |  166 ++++++----------
 src/emulator.c      |   19 ++
 6 files changed, 714 insertions(+), 173 deletions(-)


--===============6039046447743412841==--

