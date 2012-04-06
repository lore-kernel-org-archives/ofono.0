Content-Type: multipart/mixed; boundary="===============4547321328656794644=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v4 00/10] org.bluez.Telephony interface integration
Date: Fri, 06 Apr 2012 15:17:02 +0200
Message-ID: <1333718232-8447-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4547321328656794644==
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
- Patche 1
  move agent registration from adapter_added() to adapter_properties_cb()
- Patches 4 to 10:
  Rewrote support of AT+NREC, AT+VGM, +VGM, AT+VGS, +VGS and +BSIR into
  bluetooth plugin

Fr=C3=A9d=C3=A9ric Danis (10):
  bluetooth: Add org.bluez.Telephony helpers
  hfp_hf: Update to org.bluez.Telephony interface
  hfp_ag: Update to org.bluez.Telephony interface
  bluetooth: Add audio APIs for HFP AG
  bluetooth: Add AT+NREC support
  bluetooth: Add +BSIR support
  bluetooth: Add AT+VGM support
  bluetooth: Add AT+VGS support
  hfp_ag: Add media transport support
  emulator: Update supported features

 plugins/bluetooth.c |  531 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/bluetooth.h |   18 ++
 plugins/hfp_ag.c    |  143 +++++++-------
 plugins/hfp_hf.c    |  165 ++++++----------
 src/emulator.c      |    2 +
 5 files changed, 686 insertions(+), 173 deletions(-)


--===============4547321328656794644==--

