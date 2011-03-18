Content-Type: multipart/mixed; boundary="===============9148684670332985927=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH 03/12] doc: Add AT command reference mark
Date: Fri, 18 Mar 2011 13:30:49 +0100
Message-ID: <1300451458-6749-4-git-send-email-olivier.guiter@linux.intel.com>
In-Reply-To: <1300451458-6749-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9148684670332985927==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/dialup-command-set.txt |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/doc/dialup-command-set.txt b/doc/dialup-command-set.txt
index 2067dfb..5d7a43d 100644
--- a/doc/dialup-command-set.txt
+++ b/doc/dialup-command-set.txt
@@ -11,9 +11,9 @@ Commands:
 	&D		Circuit 108 (DTR) Response
 	&F		Set to Factory Defined Configuration
 	+GCAP		Request Complete Capabilities List
-	+GMI		Request Manufacturer Identification
-	+GMM		Read Model Identification
-	+GMR		Read Revision Identification
+*	+GMI		Request Manufacturer Identification
+*	+GMM		Read Model Identification
+*	+GMR		Read Revision Identification
 	A		Answer Incoming Call
 	D		Dial
 	E		Command Echo
@@ -64,17 +64,18 @@ Commands:
     	+BVRA		Bluetooth Voice Recognition Activation
     	+BRSF		Bluetooth Retrieve Supported Features    	=

     	+BTRH		Bluetooth Response and Hold Feature    	=

-    	+CCWA		=

-    	+CHLD
-    	+CHUP
-    	+CLCC
-    	+COPS
-    	+CMEE
-    	+CLIP
-    	+CMER
-    	+VTS
-    	+CNUM		=

-    	=

+*    	+CCWA		=

+*    	+CHLD
+*    	+CHUP
+*    	+CLCC
+*    	+COPS
+*    	+CMEE
+*    	+CLIP
+*    	+CMER
+*    	+VTS
+*    	+CNUM		=

+ (*: AT command referenced below)   =

+ 	=

 Unsolicited result:
     	+CIEV
     	+BSIR		Bluetooth Setting of In-band Ring tone   	=

-- =

1.7.1


--===============9148684670332985927==--

