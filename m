Content-Type: multipart/mixed; boundary="===============6762536510011579836=="
MIME-Version: 1.0
From: Djalal Harouni <djalal@endocode.com>
Subject: [PATCH 4/5] test:netmon: support EARFCN,
 Eband and CQI in testing scripts
Date: Tue, 13 Dec 2016 12:05:27 +0100
Message-ID: <1481627128-20233-5-git-send-email-djalal@endocode.com>
In-Reply-To: <1481627128-20233-1-git-send-email-djalal@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6762536510011579836==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/get-serving-cell-info | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/test/get-serving-cell-info b/test/get-serving-cell-info
index 94e1c54..7a5d898 100755
--- a/test/get-serving-cell-info
+++ b/test/get-serving-cell-info
@@ -31,6 +31,9 @@ rscp =3D 'ReceivedSignalCodePower'
 ecn0 =3D 'ReceivedEnergyRatio'
 rsrq =3D 'ReferenceSignalReceivedQuality'
 rsrp =3D 'ReferenceSignalReceivedPower'
+earfcn =3D 'EARFCN'
+eband =3D 'EBand'
+cqi =3D 'ChannelQualityIndicator'
 =

 print("Current serving cell information:")
 =

@@ -73,4 +76,13 @@ if rsrq in servingcell:
 if rsrp in servingcell:
 	print("    [ Reference Signal Received Power =3D %d]" % (servingcell[rsrp=
]))
 =

+if earfcn in servingcell:
+	print("    [ E-UTRA Absolue Radio Frequency Channel =3D %d ]" % (servingc=
ell[earfcn]))
+
+if eband in servingcell:
+	print("    [ E-UTRA operating Band =3D %d ]" % (servingcell[eband]))
+
+if cqi in servingcell:
+	print("    [ Channel Quality Indicator =3D %d ]" % (servingcell[cqi]))
+
 print('')
-- =

2.5.5


--===============6762536510011579836==--

