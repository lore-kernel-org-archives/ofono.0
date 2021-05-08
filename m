Content-Type: multipart/mixed; boundary="===============0719862003243421550=="
MIME-Version: 1.0
From: Smitty <me@smitop.com>
Subject: [PATCH] Better display serving cell info
Date: Sat, 08 May 2021 19:12:26 -0400
Message-ID: <20210508231225.18672-1-me@smitop.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0719862003243421550==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fixes some missing space in the output:
[ Mobile Country Code =3D 722 ]
Instead of:
[ Mobile Country Code =3D 722]

This also unifies the display logic between {get,test}-serving-cell-info
---
 test/get-serving-cell-info  | 48 ++++++++++++++++++++-----------
 test/test-serving-cell-info | 56 +++++++++++++++++++++++++++++++------
 2 files changed, 80 insertions(+), 24 deletions(-)

diff --git a/test/get-serving-cell-info b/test/get-serving-cell-info
index 7a5d8981..b9609bdf 100755
--- a/test/get-serving-cell-info
+++ b/test/get-serving-cell-info
@@ -38,51 +38,67 @@ cqi =3D 'ChannelQualityIndicator'
 print("Current serving cell information:")
 =

 if tech in servingcell:
-	print("    [ Radio Access Technology =3D %s]" % (servingcell[tech]))
+	print("    [ Radio Access Technology =3D %s ]" \
+		% (servingcell[tech]))
 =

 if mcc in servingcell:
-	print("    [ Mobile Country Code =3D %s]" % (servingcell[mcc]))
+	print("    [ Mobile Country Code =3D %s ]" \
+		% (servingcell[mcc]))
 =

 if mnc in servingcell:
-	print("    [ Mobile Network Code =3D %s]" % (servingcell[mnc]))
+	print("    [ Mobile Network Code =3D %s ]" \
+		% (servingcell[mnc]))
 =

 if lac in servingcell:
-	print("    [ Location Area Code =3D %d]" % (servingcell[lac]))
+	print("    [ Location Area Code =3D %d ]" \
+		% (servingcell[lac]))
 =

 if cid in servingcell:
-	print("    [ Cell Identity =3D %d]" % (servingcell[cid]))
+	print("    [ Cell Identity =3D %d ]" \
+		% (servingcell[cid]))
 =

 if psc in servingcell:
-	print("    [ Primary Scrambling Code =3D %d]" % (servingcell[psc]))
+	print("    [ Primary Scrambling Code =3D %d ]" \
+		% (servingcell[psc]))
 =

 if rssi in servingcell:
-	print("    [ Signal Strength =3D %d]" % (servingcell[rssi]))
+	print("    [ Signal Strength =3D %d ]" \
+		% (servingcell[rssi]))
 =

 if rxlev in servingcell:
-	print("    [ Received Signal Strength =3D %d]" % (servingcell[rxlev]))
+	print("    [ Received Signal Strength =3D %d ]" \
+		% (servingcell[rxlev]))
 =

 if ber in servingcell:
-	print("    [ Bit Error Rate =3D %d]" % (servingcell[ber]))
+	print("    [ Bit Error Rate =3D %d ]" \
+		% (servingcell[ber]))
 =

 if rscp in servingcell:
-	print("    [ Received Signal Code Power =3D %d]" % (servingcell[rscp]))
+	print("    [ Received Signal Code Power =3D %d ]" \
+		% (servingcell[rscp]))
 =

 if ecn0 in servingcell:
-	print("    [ Received Energy Ratio =3D %d]" % (servingcell[ecn0]))
+	print("    [ Received Energy Ratio =3D %d ]" \
+		% (servingcell[ecn0]))
 =

 if rsrq in servingcell:
-	print("    [ Reference Signal Received Quality =3D %d]" % (servingcell[rs=
rq]))
+	print("    [ Reference Signal Received Quality =3D %d ]" \
+		% (servingcell[rsrq]))
 =

 if rsrp in servingcell:
-	print("    [ Reference Signal Received Power =3D %d]" % (servingcell[rsrp=
]))
+	print("    [ Reference Signal Received Power =3D %d ]" \
+		% (servingcell[rsrp]))
 =

 if earfcn in servingcell:
-	print("    [ E-UTRA Absolue Radio Frequency Channel =3D %d ]" % (servingc=
ell[earfcn]))
+	print("    [ E-UTRA Absolue Radio Frequency Channel =3D %d ]" \
+		% (servingcell[earfcn]))
 =

 if eband in servingcell:
-	print("    [ E-UTRA operating Band =3D %d ]" % (servingcell[eband]))
+	print("    [ E-UTRA operating Band =3D %d ]" \
+		% (servingcell[eband]))
 =

 if cqi in servingcell:
-	print("    [ Channel Quality Indicator =3D %d ]" % (servingcell[cqi]))
+	print("    [ Channel Quality Indicator =3D %d ]" \
+		% (servingcell[cqi]))
 =

 print('')
diff --git a/test/test-serving-cell-info b/test/test-serving-cell-info
index 498ce88b..df4a9b52 100755
--- a/test/test-serving-cell-info
+++ b/test/test-serving-cell-info
@@ -30,39 +30,79 @@ class NetworkMonitorAgent(dbus.service.Object):
 		psc =3D 'PrimaryScramblingCode'
 		rssi =3D 'Strength'
 		ber =3D 'BitErrorRate'
+		rxlev =3D 'ReceivedSignalStrength'
+		rscp =3D 'ReceivedSignalCodePower'
+		ecn0 =3D 'ReceivedEnergyRatio'
+		rsrq =3D 'ReferenceSignalReceivedQuality'
+		rsrp =3D 'ReferenceSignalReceivedPower'
+		earfcn =3D 'EARFCN'
+		eband =3D 'EBand'
+		cqi =3D 'ChannelQualityIndicator'
 =

 		if tech in servingcell:
-			print("    [ Radio Access Technology =3D %s]" \
+			print("    [ Radio Access Technology =3D %s ]" \
 				% (servingcell[tech]))
 =

 		if mcc in servingcell:
-			print("    [ Mobile Country Code =3D %s]" \
+			print("    [ Mobile Country Code =3D %s ]" \
 				% (servingcell[mcc]))
 =

 		if mnc in servingcell:
-			print("    [ Mobile Network Code =3D %s]" \
+			print("    [ Mobile Network Code =3D %s ]" \
 				% (servingcell[mnc]))
 =

 		if lac in servingcell:
-			print("    [ Location Area Code =3D %d]" \
+			print("    [ Location Area Code =3D %d ]" \
 				% (servingcell[lac]))
 =

 		if cid in servingcell:
-			print("    [ Cell Identity =3D %d]" \
+			print("    [ Cell Identity =3D %d ]" \
 				% (servingcell[cid]))
 =

 		if psc in servingcell:
-			print("    [ Primary Scrambling Code =3D %d]" \
+			print("    [ Primary Scrambling Code =3D %d ]" \
 				% (servingcell[psc]))
 =

 		if rssi in servingcell:
-			print("    [ Signal Strength =3D %d]" \
+			print("    [ Signal Strength =3D %d ]" \
 				% (servingcell[rssi]))
 =

+		if rxlev in servingcell:
+			print("    [ Received Signal Strength =3D %d ]" \
+				% (servingcell[rxlev]))
+
 		if ber in servingcell:
-			print("    [ Bit Error Rate =3D %d]" \
+			print("    [ Bit Error Rate =3D %d ]" \
 				% (servingcell[ber]))
 =

+		if rscp in servingcell:
+			print("    [ Received Signal Code Power =3D %d ]" \
+				% (servingcell[rscp]))
+
+		if ecn0 in servingcell:
+			print("    [ Received Energy Ratio =3D %d ]" \
+				% (servingcell[ecn0]))
+
+		if rsrq in servingcell:
+			print("    [ Reference Signal Received Quality =3D %d ]" \
+				% (servingcell[rsrq]))
+
+		if rsrp in servingcell:
+			print("    [ Reference Signal Received Power =3D %d ]" \
+				% (servingcell[rsrp]))
+
+		if earfcn in servingcell:
+			print("    [ E-UTRA Absolue Radio Frequency Channel =3D %d ]" \
+				% (servingcell[earfcn]))
+
+		if eband in servingcell:
+			print("    [ E-UTRA operating Band =3D %d ]" \
+				% (servingcell[eband]))
+
+		if cqi in servingcell:
+			print("    [ Channel Quality Indicator =3D %d ]" \
+				% (servingcell[cqi]))
+
 		print('')
 =

 if __name__ =3D=3D '__main__':
-- =

2.27.0

--===============0719862003243421550==--

