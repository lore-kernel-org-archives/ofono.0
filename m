Content-Type: multipart/mixed; boundary="===============0797372308455211030=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [sim-auth PATCHv2 1/3] Add doc/sim-authentication-api.txt
Date: Thu, 27 Jan 2011 20:06:10 +0200
Message-ID: <1296151572-3721-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0797372308455211030==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

The authentication suites include SIM authentication (basic A8
authentication used with GSM) and AKA authentication on USIM.

The SIM and AKA can be used to implement EAP, AKA Digest and GBA
authentication algorithms.
---
 Makefile.am                    |    1 +
 doc/sim-authentication-api.txt |   81 ++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 82 insertions(+), 0 deletions(-)
 create mode 100644 doc/sim-authentication-api.txt

diff --git a/Makefile.am b/Makefile.am
index c1c34ca..65b488a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -394,6 +394,7 @@ doc_files =3D doc/overview.txt doc/ofono-paper.txt doc/=
release-faq.txt \
 			doc/message-api.txt doc/message-waiting-api.txt \
 			doc/phonebook-api.txt doc/radio-settings-api.txt \
 			doc/sim-api.txt doc/stk-api.txt \
+			doc/sim-authentication-api.txt \
 			doc/audio-settings-api.txt doc/text-telephony-api.txt \
 			doc/calypso-modem.txt
 =

diff --git a/doc/sim-authentication-api.txt b/doc/sim-authentication-api.txt
new file mode 100644
index 0000000..27090e7
--- /dev/null
+++ b/doc/sim-authentication-api.txt
@@ -0,0 +1,81 @@
+SimAuthentication hierarchy [experimental]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.SimAuthentication
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		dict GetProperties()
+
+			Returns all properties for this object. See the
+			properties section for available properties.
+
+		dict Authenticate(string suite, dict input)
+
+			Executes the requested authentication suite.
+			The input and returned result depend on the
+			authentication suite.
+
+			See the suite sections for input and results for
+			each suite.
+
+			Possible Errors: [service].Error.InvalidArguments
+					 [service].Error.NotImplemented
+
+Properties	array{string} Suites [readonly]
+
+			Contains the list of supported authentication
+			suites and applications. The possible values are:
+
+			"SIM" - SIM authentication
+			"AKA" - AKA authentication
+
+SIM Authentication Suite
+------------------------
+
+		SIM authentication (A8) can be used to implement EAP SIM
+		or 2G GBA authentication.
+
+		In case of successful SIM authentication the returned
+		dictionary contains following items:
+
+			byte{array} "SRES" - SRES parameter
+
+			byte{array} "Kc" - Kc ciphering key
+
+		The RAND parameter is a 16-byte array.
+
+		The SRES parameter is a 4-byte array.
+
+		The Kc parameter is a 8-byte array.
+
+AKA Authentication Suite
+------------------------
+
+		AKA authentication can be used to implement EAP AKA, AKA
+		digest or GBA_ME authentication.
+
+		The input dictionary must contain following input
+		parameters:
+
+			byte{array} "RAND" - RAND parameter
+
+			byte{array} "AUTN" - AUTN parameter
+
+		In case of successful AKA authentication the returned
+		dictionary contains following items:
+
+			byte{array} "RES" - AKA RES parameter
+
+			byte{array} "CK" - AKA Ciphering key
+
+			byte{array} "IK" - AKA Integrity key
+
+		AKA is a mutual authentication algorithm: terminal and
+		network authenticate each other. In case the terminal
+		rejects the AUTN from network, the returned dictionary
+		contains following item:
+
+			byte{array} "AUTS" - AKA AUTS parameter
+
+		All the AKA parameters and keys are 16-byte arrays.
-- =

1.7.1


--===============0797372308455211030==--

