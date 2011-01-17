Content-Type: multipart/mixed; boundary="===============5521229467018787823=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH] doc: Add Bluetooth Dial-up Networking Profile specs
Date: Mon, 17 Jan 2011 12:56:22 +0100
Message-ID: <1295265382-14024-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5521229467018787823==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/standards.txt |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/doc/standards.txt b/doc/standards.txt
index 2b85cb0..773300e 100644
--- a/doc/standards.txt
+++ b/doc/standards.txt
@@ -166,3 +166,52 @@ Describes the general background and assumption of wir=
eless features.
 	Capability: Network Perspective
 - S.R0006-808:	Wireless Features Description: Circuit Switched Call Preced=
ence Over
 	CDMA Packet Data Session
+
+Bluetooth Specifications
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+- Dial-up Networking Profile - Bluetooth specification version 1.1 - 22 Fe=
bruary 2001
+
+Bluetooth Dial-up Networking Profile Features Description
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
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
+	=

+Result codes:
+	OK		Acknowledge execution of a command
+	CONNECT		Connection has been established
+	RING		The DCE has detected an incoming call signal from network
+	NO CARRIER	The connection has been terminated, or attempt to establish
+			a connection failed
+	ERROR		Error
+	NO DIALTONE	No dial-tone detected
+	BUSY		Busy signal detected
+
+
-- =

1.7.1


--===============5521229467018787823==--

