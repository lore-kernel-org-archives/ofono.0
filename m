Content-Type: multipart/mixed; boundary="===============4093953881000790531=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v6 00/12] Add org.bluez.Telephony interface
Date: Wed, 01 Aug 2012 12:09:35 +0200
Message-ID: <1343815787-22670-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4093953881000790531==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Those patches integrates the future org.bluez.Telephony interface into
oFono for HFP HF, HFP AG and DUN GW plugins.

For HFP AG and DUN GW plugins, the bluetooth rfcomm server is replaced
by a Telephony Agent registered to org.bluez.Telephony.
For HFP HF plugin, RegisterAgent call of org.bluez.HandsfreeGateway is
replaced by the one of org.bluez.Telephony

Any comments appreciated.

Regards

PS: =

This version works with version 16 of "Add org.bluez.Telephony interface"
patches sent to BlueZ mailing list.

Since latest RFC :
- Patches 1, 2 and 3: remove UUID when parsing properties of NewConnection =
method
- Patch 3: update to use new GDBus
- Patches 7 to 10 (previously 5 to 8): move audio code from bluetooth.c to
  hfp_ag.c (dundee did not build if code is in bluetooth.c)
- Patch 9 (previously 7):
  - use right dbus_uint16_t variables when sending volume properties
  - changes volume management from MicrophoneGain to InputGain
- Patch 10 (previously 8):
  - use right dbus_uint16_t variables when sending volume properties
  - changes volume management from SpeakerGain to OutputGain

Fr=C3=A9d=C3=A9ric Danis (12):
  bluetooth: Add org.bluez.Telephony helpers
  hfp_hf: Update to org.bluez.Telephony interface
  hfp_ag: Update to org.bluez.Telephony interface
  bluetooth: Add define for MediaTransport interface
  include: Add set/get data APIs to emulator
  emulator: Add set/get data APIs
  hfp_ag: Add AT+NREC support
  hfp_ag: Add +BSIR support
  hfp_ag: Add AT+VGM support
  hfp_ag: Add AT+VGS support
  emulator: Update supported features
  dun_gw: Update to org.bluez.Telephony interface

 include/emulator.h  |    5 +
 plugins/bluetooth.c |  191 +++++++++++++++++++++
 plugins/bluetooth.h |   14 ++
 plugins/dun_gw.c    |  119 ++++++-------
 plugins/hfp_ag.c    |  477 +++++++++++++++++++++++++++++++++++++++++++----=
----
 plugins/hfp_hf.c    |  169 +++++++-----------
 src/emulator.c      |   19 ++
 7 files changed, 754 insertions(+), 240 deletions(-)

-- =

1.7.9.5


--===============4093953881000790531==--

