Content-Type: multipart/mixed; boundary="===============1606933836407333608=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH 09/12] doc: Add AT commands for device management
Date: Fri, 18 Mar 2011 13:30:55 +0100
Message-ID: <1300451458-6749-10-git-send-email-olivier.guiter@linux.intel.com>
In-Reply-To: <1300451458-6749-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1606933836407333608==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/dialup-command-set.txt |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/doc/dialup-command-set.txt b/doc/dialup-command-set.txt
index 6480577..647d269 100644
--- a/doc/dialup-command-set.txt
+++ b/doc/dialup-command-set.txt
@@ -167,3 +167,21 @@ SMS:
 	+CSMS		Select Message Service
 	+CRES		Restore Settings (SMS)
 	+CSAS		Save Settings  (SMS)
+Device:
+--------
+	+CBC		Battery charge
+	+CBKLT		Backlight
+	+CCLK		Clock
+	+CSO		Command Screen Orientation
+	+CPWROFF	Switch off MS
+	+CPOS		Positioning Control
+	+CSS		Command Screen Size
+	+CGMI		Request manufacturer identification
+	+CGMM		Request model identification
+	+CGMR		Request revision identification
+	+GMI		Request Manufacturer Identification
+	+GMM		Request Model Identification
+	+GMR		Request Revision Identification
+	+CGSN		Request product serial number identification
+	+CKPD		Keypad control
+
-- =

1.7.1


--===============1606933836407333608==--

