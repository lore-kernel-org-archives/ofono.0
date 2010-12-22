Content-Type: multipart/mixed; boundary="===============3308002164011857132=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH] TODO: Add CDMA network and voicecall tasks
Date: Wed, 22 Dec 2010 12:12:09 -0800
Message-ID: <1293048729-17393-1-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3308002164011857132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Also updates the task ownership fields to be consistent
with the tasks that are actually currently active.
---
 TODO |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+---
 1 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/TODO b/TODO
index ee32e34..a644fde 100644
--- a/TODO
+++ b/TODO
@@ -475,7 +475,6 @@ CDMA Voicecall
 =

   Priority: High
   Complexity: C2
-  Owner: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
 =

 - Add support for Call Waiting over a CDMA network. Call Waiting (CW) prov=
ides
   notification of an incoming call to an originating subscriber, while the
@@ -495,13 +494,23 @@ CDMA Voicecall
 =

   Priority: High
   Complexity: C2
-  Owner: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
 =

 - Support sending DTMF tones over CDMA network.
 =

   Priority: High
   Complexity: C2
-  Owner: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
+
+- Support optional network-based Plus Code Dialing for international calls=
 over
+  a CDMA network. An input key, e.g. the "+" key, or a functional equivale=
nt
+  can be used to replace the international access prefix when dialing. When
+  received, transmitted or stored, an international indicator can be inclu=
ded
+  with the address digits although it is the responsibility of the network=
 to
+  ignore the international indicator when attached to a national number. T=
his
+  is described in Section 2.7.1.3.2.4 of 3GPP2 C.S0005-E v2.0 and Section =
1.2
+  of 3GPP2 N.S0027 v1.0.
+
+  Priority: High
+  Complexity: C2
 =

 CDMA SMS
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -591,3 +600,54 @@ CDMA CMAS
 =

   Priority: Medium
   Complexity: C4
+
+CDMA NETWORK ACQUISITION
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+- Support reporting of the received signal strength indicator (RSSI)
+  measurement and of the pilot energy ratio (Ec/Io) measurement, for the
+  currently acquired CDMA network.
+
+  Priority: Medium
+  Complexity: C1
+  Owner: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
+
+- Support reporting of the received signal strength indicator (RSSI)
+  measurement and of the signal to interference-plus-noise ratio (SINR)
+  measurement, for the currently acquired 1xEV-DO data network.
+
+  Priority: Medium
+  Complexity: C1
+
+- Support reporting of the Enhanced Roaming Indicators (ERI) to indicate t=
he
+  current roaming condition of the CDMA mobile device. Each indicator maps=
 to
+  a unique display number within the Standard and Non-Standard service ran=
ges,
+  as described in Section 8 of 3GPP2 C.R1001-C v1.0.
+  These numbers are stored on the device in the (Enhanced) Preferred Roami=
ng
+  List (PRL) and it is the responsibility of the modem to broadcast the
+  relevant indicator for a currently acquired system. Further details of t=
he
+  system acquisition process are described in 3GPP2 C.S0016-B v1.0.
+
+  Priority: Medium
+  Complexity: C2
+
+- Support reporting of identifiers of the currently acquired CDMA network,
+  including the System Identifier (SID) and the Network Identifier (NID),
+  It is the responsibility of the modem to broadcast the relevant identifi=
ers
+  for a currently acquired system, and these identifiers are provided by t=
he
+  network. This is described in 3GPP2 C.S0005-E v2.0.
+
+  Priority: Medium
+  Complexity: C2
+
+- Support International Roaming, including support for reporting the Mobile
+  Country Code (MCC) and the Mobile Network Code (MNC) for the currently
+  acquired network. International Roaming is provided via enhancements to =
the
+  PRL by encoding the MCC and the (two digit only) MNC in existing SID/NID
+  fields, as described in the CDMA Development Group standards Document "I=
PRL
+  Enhancements for International Roaming - CDG Doc #86". It is the
+  responsibility of the modem to broadcast the values for the currently
+  acquired system.
+
+  Priority: Medium
+  Complexity: C2
-- =

1.7.0.4


--===============3308002164011857132==--

