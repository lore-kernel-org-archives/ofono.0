Content-Type: multipart/mixed; boundary="===============1044777889096963288=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH] doc: Update BT HFP / Add Emulator AT command set
Date: Thu, 17 Mar 2011 15:42:50 +0100
Message-ID: <1300372970-3069-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1044777889096963288==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/dialup-command-set.txt |  252 ++++++++++++++++++++++++++++++++++++++--=
----
 1 files changed, 218 insertions(+), 34 deletions(-)

diff --git a/doc/dialup-command-set.txt b/doc/dialup-command-set.txt
index a7a1df3..9d80170 100644
--- a/doc/dialup-command-set.txt
+++ b/doc/dialup-command-set.txt
@@ -1,45 +1,229 @@
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
+*	+GMI		Request Manufacturer Identification
+*	+GMM		Read Model Identification
+*	+GMR		Read Revision Identification
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
+
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

+(* : see below )
+    	=

+Unsolicited result:
+    	+CIEV
+    	+BSIR		Bluetooth Setting of In-band Ring tone   	=

+Result codes:
+	NO ANSWER
+	DELAYED
+	BLACKLISTED
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
+
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
+General:
+--------
+	+CEER		Extended error report
+	+CFUN		Set phone functionality
+	+CGEQMIN	3G Quality of Service Profile (Minimum acceptable)
+	+CLAC		List all available AT commands
+	+CLCK		Facility lock
+	+CMEC		Mobile Termination control mode
+	+CMEC		Mobile Termination control mode
+	+CMEE		Report Mobile Termination error
+	+CMER		Mobile Termination event reporting
+	+CPWD		Change password
+	+CTSA		Command Touch Screen Action
+	+CIMI		Request international mobile subscriber identity
+	+FCLASS		Service Class Selection and Identification
+
+GPRS:
+-----
+	+CGACT		PDP context activate or deactivate
+	+CGATT		PS attach or detach
+	+CGCMOD		PDP Context Modify
+	+CGDCONT	Define PDP Context
+	+CGEQREQ	3G Quality of Service Profile (Requested)
+	+CGQREQ		Quality of Service Profile (Requested)
+	+CGREG		GPRS network registration status
+	+CGDSCONT	Define Secondary PDP Context
+	+CGDATA		Enter Data State
+	+CGTFT		Traffic Flow Template
+	+CGQMIN		Quality of Service Profile (Minimum Acceptable)
+	+CGEQNEG	3G Quality of Service Profile (Negotiated) =

+	+CGCMOD		PDP Context Modify
+	+CGCLASS	GPRS Mobile Station Class
+	+CGPADDR	Show PDP address
+	+CGCLASS	GPRS Mobile Station Class
+	+DR		Data Compression Reporting
+	+DS		Data Compression
+
+Network:
+--------
+	*CNTI		Network RAT capabilities
+	+COPS		PLMN selection
+	+CPOL		Preferred PLMN list
+	+CREG		Network registration
+	+CSQ		Signal quality
+	+CTZU		Automatic Time Zone Update
+	+CTZR		Time Zone Reporting
+
+SIM:
+----
+	+CPBR		Read phonebook entries
+	+CPBS		Select phonebook memory storage
+	+CPBW		Write phonebook entry
+	+CPBF		Find Phonebook Entries
+	+CPIN		Enter PIN
+	+CRSM		Restricted SIM access
+	+CSIM		Generic SIM access
+	+CUSD		Unstructured supplementary service data
+	+CASIM		SIM Slot
+	+CRES		Restore Settings (SMS)
+	+CSAS		Save Settings  (SMS)
+	+CCID		Request SIM Card Identification
+
+Supplementary Services:
+-----------------------
+	+CCFC		Call forwarding number and conditions
+	+CCWA		Call waiting
+	+CLCC		List current calls
+	+CLIR		Calling line identification restriction
+	+CSSN		Supplementary Service Notifications
+
+SMS:
+----
+	+CMTI		A GSM/GPRS modem or mobile phone uses +CMTI to notify =

+			the computer / PC that a new SMS message has been =

+			received and the memory location where it is stored.
+	+CMT		A GSM/GPRS modem or mobile phone uses +CMT to forward
+			a newly received SMS message to the computer / PC.
+	+CGSMS		Select service for MO SMS messages
+	+CMGF		Message Format
+	+CMGS		Send Message
+	+CSCA		Service Centre Address
+	+CESP		Enter SMS Block Mode Protocol
+	+CMGC		Send Command
+	+CMGD		Delete Message
+	+CMGL		List Messages
+	+CMGR		Read Message
+	+CMGW		Write Message to Memory
+	+CMMS		More Messages to Send
+	+CMSS		Send Message from Storage
+	+CNMA		New Message Acknowledgement to ME/TA
+	+CNMI		New Message Indications to TE
+	+CPMS		Preferred Message Storage
+	+CSCS	 	Select TE Character Set
+	+CSCB		Select Cell Broadcast Message Types
+	+CSDH		Show Text Mode Parameters
+	+CSMP		Set Text Mode Parameters
+	+CSMS		Select Message Service
+
+Debug:
+------
+	+TRACE		Switch Trace ON/OFF
+
+AGPS:
+-----
+	+CMOLR		Mobile Originated Location Request =

+	+CCLRAD		Needed for clearing of old Assistance Data stored =

+			for AGPS positioning
+
-- =

1.7.1


--===============1044777889096963288==--

