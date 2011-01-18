Content-Type: multipart/mixed; boundary="===============5450935798283959696=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH] [PATCH v2] doc: Add Bluetooth Dial-up Networking Profile specs
Date: Tue, 18 Jan 2011 10:44:29 +0100
Message-ID: <1295343869-29114-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5450935798283959696==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/bluetooth-cmd-set.txt |   45 +++++++++++++++++++++++++++++++++++++++++=
++++
 doc/standards.txt         |    4 ++++
 2 files changed, 49 insertions(+), 0 deletions(-)
 create mode 100644 doc/bluetooth-cmd-set.txt

diff --git a/doc/bluetooth-cmd-set.txt b/doc/bluetooth-cmd-set.txt
new file mode 100644
index 0000000..a7a1df3
--- /dev/null
+++ b/doc/bluetooth-cmd-set.txt
@@ -0,0 +1,45 @@
+This document specifies the AT command set used in the bluetooth ofono plu=
gins.
+
+Bluetooth Dial-up Networking Profile Features Description
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
+(Ref. document: Dial-up Networking Profile - Bluetooth specification versi=
on 1.1 - 22 February 2001)
+
+- AT COMMAND SET USED:
+Commands:
+	&C	Circuit 109 (DCD) Control
+	&D	Circuit 108 (DTR) Response
+	&F	Set to Factory Defined Configuration
+	+GCAP	Request Complete Capabilities List
+	+GMI	Request Manufacturer Identification
+	+GMM	Read Model Identification
+	+GMR	Read Revision Identification
+	A	Answer Incoming Call
+	D	Dial
+	E	Command Echo
+	H	Hang Up
+	L	Monitor Speaker Loudness
+	M	Monitor Speaker Control
+	O	Return to Online Data Mode
+	P	Select Pulse Dialling
+	Q	Result Code Suppression
+	S0	Automatic Answer Control
+	S10	Automatic Disconnect Delay Control
+	S3	Command Line Termination Character
+	S4	Response Formatting Character
+	S5	Command Line Editing Character (BACKSPACE)
+	S6	Blind Dial Delay Control
+	S7	Connection Completion Timeout
+	S8	Comma Dial Modifier Delay Control
+	T	Select Tone Dialling
+	V	DCE Response Format
+	X	Call Progress Monitoring Control
+	Z	Reset to Default Configuration
+Result codes:
+	OK		Acknowledge execution of a command
+	CONNECT		Connection has been established
+	RING		The DCE has detected an incoming call signal from network
+	NO CARRIER	The connection has been terminated, or attempt to establish
+			a connection failed
+	ERROR		Error
+	NO DIALTONE	No dial-tone detected
+	BUSY		Busy signal detected
diff --git a/doc/standards.txt b/doc/standards.txt
index 2b85cb0..16f8912 100644
--- a/doc/standards.txt
+++ b/doc/standards.txt
@@ -166,3 +166,7 @@ Describes the general background and assumption of wire=
less features.
 	Capability: Network Perspective
 - S.R0006-808:	Wireless Features Description: Circuit Switched Call Preced=
ence Over
 	CDMA Packet Data Session
+
+Bluetooth Specifications
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+- Dial-up Networking Profile - Bluetooth specification version 1.1 - 22 Fe=
bruary 2001
-- =

1.7.1


--===============5450935798283959696==--

