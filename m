Content-Type: multipart/mixed; boundary="===============9052399691950762806=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH 04/12] doc: Add AT commands for Call Management
Date: Fri, 18 Mar 2011 13:30:50 +0100
Message-ID: <1300451458-6749-5-git-send-email-olivier.guiter@linux.intel.com>
In-Reply-To: <1300451458-6749-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9052399691950762806==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/dialup-command-set.txt |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/doc/dialup-command-set.txt b/doc/dialup-command-set.txt
index 5d7a43d..735d626 100644
--- a/doc/dialup-command-set.txt
+++ b/doc/dialup-command-set.txt
@@ -83,4 +83,21 @@ Result codes:
 	NO ANSWER
 	DELAYED
 	BLACKLISTED
+  =

+AT commands supported in emulator:
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+    =

+Call management:
+----------------
+	+CBST		Select bearer service type
+	+CHLD		Standard call hold and multiparty handling AT command
+	+CHUP		Hangup call
+	+CMOD		Call mode
+	+CPAS		Phone activity status
+	+CVHU		Voice Hangup Control
+	+CLIP		Calling line identification presentation
+	+CNUM		Subscriber number
+	+VTS		DTMF and tone generation
+	+CACM		Accumulated Call Meter
+	+COLP		Connected Line Identification Presentation
 	=

\ No newline at end of file
-- =

1.7.1


--===============9052399691950762806==--

