Content-Type: multipart/mixed; boundary="===============9022823221070690642=="
MIME-Version: 1.0
From: Djalal Harouni <djalal@endocode.com>
Subject: [PATCH 2/5] doc: document netmon EARFCN, EBand and CQI properties
Date: Tue, 13 Dec 2016 12:05:25 +0100
Message-ID: <1481627128-20233-3-git-send-email-djalal@endocode.com>
In-Reply-To: <1481627128-20233-1-git-send-email-djalal@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9022823221070690642==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Documentation for:
EARFCN: E-UTRA Absolute Radio Frequency Channel Number.
EBand: E-UTRA operating Band.
CQI: Channel Quality Indicator.
---
 doc/networkmonitor-api.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/doc/networkmonitor-api.txt b/doc/networkmonitor-api.txt
index 0d2fe3f..ddace7e 100644
--- a/doc/networkmonitor-api.txt
+++ b/doc/networkmonitor-api.txt
@@ -103,3 +103,20 @@ byte ReferenceSignalReceivedPower [optional, lte]
 =

         Contains the Reference Signal Received Power.  Valid range of valu=
es
         is 0-97. Refer to <rsrp> in 27.007, Section 8.69 for more details.
+
+uint16 EARFCN [optional, lte]
+
+	Contains E-UTRA Absolute Radio Frequency Channel Number.  Valid
+	range of values is 0-65535. Refer to Carrier frequency and
+	EARFCN in 36.101, Section 5.7.3 for more details.
+
+byte EBand [optional, lte]
+
+	Contains E-UTRA operating Band.  Valid range of values is 1-43.
+	Refer to Operating bands in 36.101, Section 5.5 for more
+	details.
+
+byte ChannelQualityIndicator [optional, lte]
+
+	Contains Channel Quality Indicator.  Refer to Channel Quality
+	Indicator definition in 36.213, Section 7.2.3 for more details.
-- =

2.5.5


--===============9022823221070690642==--

