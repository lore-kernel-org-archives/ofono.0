Content-Type: multipart/mixed; boundary="===============2353098667461970500=="
MIME-Version: 1.0
From: JongSeok Won <wjs890204@gmail.com>
Subject: [PATCHv2 3/3] doc: added PCI, TAC, SNR property in networkmonitor-api
Date: Fri, 31 Jul 2020 11:21:03 +0900
Message-ID: <20200731022103.19023-1-wjs890204@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2353098667461970500==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/networkmonitor-api.txt | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/doc/networkmonitor-api.txt b/doc/networkmonitor-api.txt
index 1cc73d2c..e9018d72 100644
--- a/doc/networkmonitor-api.txt
+++ b/doc/networkmonitor-api.txt
@@ -118,7 +118,7 @@ uint16 PrimaryScramblingCode [optional, umts]
 =

 	Contains the scrambling code.  Valid range of values is 0-512.
 =

-byte TimingAdvance [optional, gsm]
+byte TimingAdvance [optional, gsm, lte]
 =

 	Contains the Timing Advance.  Valid range of values is 0-219.
 =

@@ -165,3 +165,18 @@ byte ChannelQualityIndicator [optional, lte]
 =

 	Contains Channel Quality Indicator.  Refer to Channel Quality
 	Indicator definition in 36.213, Section 7.2.3 for more details.
+
+uint16 PhysicalCellId [optional, lte]
+
+    Contains Physical Cell Id.  Valid range of values is 0-503.
+	=

+uint16 TrackingAreaCode [optional, lte]
+	=

+	Contains Tracking Area Code.  Valid range of values is 0-65535.
+	=

+int32 SingalToNoiseRatio [optional, lte]
+
+    Contains Signal To Noise Ratio.  Valid range of values is -200 to +300.
+    The value is in 0.1 dB units. (-200 =3D -20.0 dB, +300 =3D 30dB)
+    Refer to <snr> in 36.101, Section 8.1.1 for more details. =

+	=

\ No newline at end of file
-- =

2.17.1

--===============2353098667461970500==--

