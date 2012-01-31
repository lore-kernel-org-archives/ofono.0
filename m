Content-Type: multipart/mixed; boundary="===============2279483506723012006=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC 0/3] org.bluez.Telephony interface integration
Date: Tue, 31 Jan 2012 16:50:02 +0100
Message-ID: <1328025005-12012-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2279483506723012006==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Those patches integrates the future org.bluez.Telephony interface into
oFono for HFP HF and HFP AG plugins.

For HFP AG plugin, the bluetooth rfcomm server is replaced by a
Telephony Agent registered to org.bluez.Telephony.
For HFP HF plugin, RegisterAgent call of org.bluez.HandsfreeGateway is
replaced by the one of org.bluez.Telephony

Fr=C3=A9d=C3=A9ric Danis (3):
  bluetooth: add org.bluez.Telephony helpers
  hfp_hf: update to org.bluez.Telephony interface
  hfp_ag: update to org.bluez.Telephony interface

 plugins/bluetooth.c |  198 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/bluetooth.h |   14 ++++
 plugins/hfp_ag.c    |  119 +++++++++++++------------------
 plugins/hfp_hf.c    |  165 ++++++++++++++++--------------------------
 4 files changed, 323 insertions(+), 173 deletions(-)


--===============2279483506723012006==--

