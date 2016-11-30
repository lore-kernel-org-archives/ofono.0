Content-Type: multipart/mixed; boundary="===============2302943074897096165=="
MIME-Version: 1.0
From: Djalal Harouni <djalal@endocode.com>
Subject: [PATCH v3 3/7] doc: documentation for
 OFONO_NETMON_INFO_{RSCP|ECN0|RSRQ|RSRP}
Date: Wed, 30 Nov 2016 13:31:41 +0100
Message-ID: <1480509105-17934-4-git-send-email-djalal@endocode.com>
In-Reply-To: <1480509105-17934-1-git-send-email-djalal@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2302943074897096165==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds documentation for the following fields in
networkmonitor-api.txt

RSCP: Received Signal Code Power
ECN0: Received Energy Ratio
RSRQ: Reference Signal Received Quality
RSRP: Reference Signal Received Power
---
 doc/networkmonitor-api.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/doc/networkmonitor-api.txt b/doc/networkmonitor-api.txt
index 703f19b..0d2fe3f 100644
--- a/doc/networkmonitor-api.txt
+++ b/doc/networkmonitor-api.txt
@@ -81,3 +81,25 @@ byte Strength [optional, gsm, umts]
 =

 	Contains the signal strength.  Valid values are 0-31.  Refer to <rssi>
 	in 27.007, Section 8.5.
+
+byte ReceivedSignalCodePower [optional, umts]
+
+        Contains the Received Signal Code Power.  Valid range of values
+        is 0-96. Refer to <rscp> in 27.007, Section 8.69 for more details.
+
+byte ReceivedEnergyRatio [optional, umts]
+
+        Contains the Ratio of received energy per PN chip to the total
+        received power spectral density.  Valid range of values is 0-49.
+        Refer to <ecno> in 27.007, Section 8.69 for more details.
+
+byte ReferenceSignalReceivedQuality [optional, lte]
+
+        Contains the Reference Signal Received Quality.  Valid range of
+        values is 0-34. Refer to <rsrq> in 27.007, Section 8.69 for more
+        details.
+
+byte ReferenceSignalReceivedPower [optional, lte]
+
+        Contains the Reference Signal Received Power.  Valid range of valu=
es
+        is 0-97. Refer to <rsrp> in 27.007, Section 8.69 for more details.
-- =

2.5.5


--===============2302943074897096165==--

