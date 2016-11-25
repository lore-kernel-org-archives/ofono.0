Content-Type: multipart/mixed; boundary="===============3682019141347705847=="
MIME-Version: 1.0
From: djalal@endocode.com
Subject: [PATCH 5/5] test: support
 OFONO_NETMON_INFO_{RSCP|ECN0|RSRQ|RSRP|OPERATOR}
Date: Fri, 25 Nov 2016 15:00:15 +0100
Message-ID: <1480082415-30822-6-git-send-email-djalal@endocode.com>
In-Reply-To: <1480082415-30822-1-git-send-email-djalal@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3682019141347705847==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Djalal Harouni <djalal@endocode.com>

Display the following fields if they are returned.

RXLEV:  Received Signal Strength
RSCP:   Received Signal Code Power
ECN0:   Received Energy Ratio
RSRQ:   Reference Signal Received Quality
RSRP:   Reference Signal Received Power
OPERATOR: The operator
---
 test/get-serving-cell-info | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/test/get-serving-cell-info b/test/get-serving-cell-info
index 05dc9fe..e4c9efb 100755
--- a/test/get-serving-cell-info
+++ b/test/get-serving-cell-info
@@ -26,6 +26,12 @@ cid =3D 'CellId'
 psc =3D 'PrimaryScramblingCode'
 rssi =3D 'Strength'
 ber =3D 'BitErrorRate'
+rxlev =3D 'ReceivedSignalStrength'
+rscp =3D 'ReceivedSignalCodePower'
+ecn0 =3D 'ReceivedEnergyRatio'
+rsrq =3D 'ReferenceSignalReceivedQuality'
+rsrp =3D 'ReferenceSignalReceivedPower'
+op =3D 'Operator'
 =

 print("Current serving cell information:")
 =

@@ -50,7 +56,25 @@ if psc in servingcell:
 if rssi in servingcell:
 	print("    [ Signal Strength =3D %d]" % (servingcell[rssi]))
 =

+if rxlev in servingcell:
+	print("    [ Received Signal Strength =3D %d]" % (servingcell[rxlev]))
+
 if ber in servingcell:
 	print("    [ Bit Error Rate =3D %d]" % (servingcell[ber]))
 =

+if rscp in servingcell:
+	print("    [ Received Signal Code Power =3D %d]" % (servingcell[rscp]))
+
+if ecn0 in servingcell:
+	print("    [ Received Energy Ratio =3D %d]" % (servingcell[ecn0]))
+
+if rsrq in servingcell:
+	print("    [ Reference Signal Received Quality =3D %d]" % (servingcell[rs=
rq]))
+
+if rsrp in servingcell:
+	print("    [ Reference Signal Received Power =3D %d]" % (servingcell[rsrp=
]))
+
+if op in servingcell:
+	print("    [ Operator =3D %s ]" % (servingcell[op]))
+
 print('')
-- =

2.5.5


--===============3682019141347705847==--

