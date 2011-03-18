Content-Type: multipart/mixed; boundary="===============4519129799791356636=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH 02/12] doc: Add BT HFP AT commands list
Date: Fri, 18 Mar 2011 13:30:48 +0100
Message-ID: <1300451458-6749-3-git-send-email-olivier.guiter@linux.intel.com>
In-Reply-To: <1300451458-6749-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4519129799791356636==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/dialup-command-set.txt |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/doc/dialup-command-set.txt b/doc/dialup-command-set.txt
index 3e40aae..2067dfb 100644
--- a/doc/dialup-command-set.txt
+++ b/doc/dialup-command-set.txt
@@ -45,3 +45,41 @@ Result codes:
 	ERROR		Error
 	NO DIALTONE	No dial-tone detected
 	BUSY		Busy signal detected
+	=

+Bluetooth Hands-Free Profile Description
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
+(Ref. document: HFP1.5_SPEC (Car Working Group) - version V10r00 - 2005-11=
-25)
+
+- AT COMMAND set used:
+Commands:
+ 	D>		Extension of the standard ATD command, intended for
+ 			memory dialing. Only voice calls are covered here
+    	+CIND		Standard indicator update AT command.    	=

+
+    	+NREC		Noise Reduction and Echo Canceling    	=

+    	+VGM		Gain of Microphone    	=

+    	+VGS		Gain of Speaker
+    	+BINP		Bluetooth INPut    	=

+    	+BLDN		Bluetooth Last Dialed Number    	=

+    	+BVRA		Bluetooth Voice Recognition Activation
+    	+BRSF		Bluetooth Retrieve Supported Features    	=

+    	+BTRH		Bluetooth Response and Hold Feature    	=

+    	+CCWA		=

+    	+CHLD
+    	+CHUP
+    	+CLCC
+    	+COPS
+    	+CMEE
+    	+CLIP
+    	+CMER
+    	+VTS
+    	+CNUM		=

+    	=

+Unsolicited result:
+    	+CIEV
+    	+BSIR		Bluetooth Setting of In-band Ring tone   	=

+Result codes:
+	NO ANSWER
+	DELAYED
+	BLACKLISTED
+	=

\ No newline at end of file
-- =

1.7.1


--===============4519129799791356636==--

