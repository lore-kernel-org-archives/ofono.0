Content-Type: multipart/mixed; boundary="===============8649913277370640460=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH 01/12] doc: fix typo and incorrect line length
Date: Fri, 18 Mar 2011 13:30:47 +0100
Message-ID: <1300451458-6749-2-git-send-email-olivier.guiter@linux.intel.com>
In-Reply-To: <1300451458-6749-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8649913277370640460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/dialup-command-set.txt |   70 ++++++++++++++++++++++------------------=
---
 1 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/doc/dialup-command-set.txt b/doc/dialup-command-set.txt
index a7a1df3..3e40aae 100644
--- a/doc/dialup-command-set.txt
+++ b/doc/dialup-command-set.txt
@@ -1,45 +1,47 @@
-This document specifies the AT command set used in the bluetooth ofono plu=
gins.
+This document specifies the AT command supported in the AT Emulator and at=
oms.
 =

 Bluetooth Dial-up Networking Profile Features Description
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
-(Ref. document: Dial-up Networking Profile - Bluetooth specification versi=
on 1.1 - 22 February 2001)
+(Ref. document: Dial-up Networking Profile - Bluetooth specification
+	 version 1.1- 22 February 2001)
 =

-- AT COMMAND SET USED:
+- AT COMMAND set used:
 Commands:
-	&C	Circuit 109 (DCD) Control
-	&D	Circuit 108 (DTR) Response
-	&F	Set to Factory Defined Configuration
-	+GCAP	Request Complete Capabilities List
-	+GMI	Request Manufacturer Identification
-	+GMM	Read Model Identification
-	+GMR	Read Revision Identification
-	A	Answer Incoming Call
-	D	Dial
-	E	Command Echo
-	H	Hang Up
-	L	Monitor Speaker Loudness
-	M	Monitor Speaker Control
-	O	Return to Online Data Mode
-	P	Select Pulse Dialling
-	Q	Result Code Suppression
-	S0	Automatic Answer Control
-	S10	Automatic Disconnect Delay Control
-	S3	Command Line Termination Character
-	S4	Response Formatting Character
-	S5	Command Line Editing Character (BACKSPACE)
-	S6	Blind Dial Delay Control
-	S7	Connection Completion Timeout
-	S8	Comma Dial Modifier Delay Control
-	T	Select Tone Dialling
-	V	DCE Response Format
-	X	Call Progress Monitoring Control
-	Z	Reset to Default Configuration
+	&C		Circuit 109 (DCD) Control
+	&D		Circuit 108 (DTR) Response
+	&F		Set to Factory Defined Configuration
+	+GCAP		Request Complete Capabilities List
+	+GMI		Request Manufacturer Identification
+	+GMM		Read Model Identification
+	+GMR		Read Revision Identification
+	A		Answer Incoming Call
+	D		Dial
+	E		Command Echo
+	H		Hang Up
+	L		Monitor Speaker Loudness
+	M		Monitor Speaker Control
+	O		Return to Online Data Mode
+	P		Select Pulse Dialling
+	Q		Result Code Suppression
+	S0		Automatic Answer Control
+	S10		Automatic Disconnect Delay Control
+	S3		Command Line Termination Character
+	S4		Response Formatting Character
+	S5		Command Line Editing Character (BACKSPACE)
+	S6		Blind Dial Delay Control
+	S7		Connection Completion Timeout
+	S8		Comma Dial Modifier Delay Control
+	T		Select Tone Dialling
+	V		DCE Response Format
+	X		Call Progress Monitoring Control
+	Z		Reset to Default Configuration
 Result codes:
 	OK		Acknowledge execution of a command
 	CONNECT		Connection has been established
-	RING		The DCE has detected an incoming call signal from network
-	NO CARRIER	The connection has been terminated, or attempt to establish
-			a connection failed
+	RING		The DCE has detected an incoming call signal =

+			from network
+	NO CARRIER	The connection has been terminated, or attempt to
+			establish a connection failed
 	ERROR		Error
 	NO DIALTONE	No dial-tone detected
 	BUSY		Busy signal detected
-- =

1.7.1


--===============8649913277370640460==--

