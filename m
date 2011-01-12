Content-Type: multipart/mixed; boundary="===============2311398940453063581=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [sim-auth RFCv2 2/4] Added doc/sim-authentication-api.txt.
Date: Thu, 13 Jan 2011 01:08:20 +0200
Message-ID: <1294873702-10316-3-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1294873702-10316-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2311398940453063581==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

The authentication mechanisms include SIM authentication (basic A8
authentication used with GSM), AKA authentication and UICC-based GBA
authentication.

The SIM and AKA can be used to implement EAP and GBA authentication
algorithms.

The interface can be applied to both SIM/USIM or ISIMs.
---
 doc/sim-authentication-api.txt |  186 ++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 186 insertions(+), 0 deletions(-)
 create mode 100644 doc/sim-authentication-api.txt

diff --git a/doc/sim-authentication-api.txt b/doc/sim-authentication-api.txt
new file mode 100644
index 0000000..97f4fac
--- /dev/null
+++ b/doc/sim-authentication-api.txt
@@ -0,0 +1,186 @@
+SimAuthentication hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.SimAuthentication
+Object path	[variable prefix]/{modem0,modem1,...} for SIM/USIM
+       		[variable prefix]/{modem0,modem1,...}/{isim01,...} for ISIM
+
+Methods		dict GetProperties()
+
+			Returns all properties for this object. See the
+			properties section for available properties.
+
+			Possible Errors: [service].Error.InvalidArguments
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
+			"GBA_U" - UICC-based GBA authentication
+
+		string IPMultimediaPrivateIdentity [readonly, optional]
+
+			GBA identity read from ISIM or derived from IMSI.
+
+		string BootstrappingServerFunctionAddress [readonly, optional]
+
+			FQDN read from ISIM or derived from IMSI,
+			used with GBA.
+
+		string TMPI [readonly, optional]
+
+			Temporary identity used in GBA bootstrapping.
+
+		string BTID [readonly, optional]
+
+			Unique identity obtained from BSF server.
+
+SIM Authentication Suite
+------------------------
+
+		SIM authentication can be used to implement EAP SIM or
+		GBA_ME authentication.
+
+		In case of successful SIM authentication the returned
+		dictionary contains following items:
+
+			byte{array} "SRES" - SRES parameter
+
+			byte{array} "Kc" - Kc ciphering key
+
+		The SRES parameter is a 4-byte array.
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
+		contain following item:
+
+			byte{array} "AUTS" - AKA AUTS parameter
+
+		All the AKA parameters and keys are 16-byte arrays.
+
+UICC-based GBA Authentication Suite
+-----------------------------------
+
+		GBA is used to establish a unique identity and a shared
+		secret between SIM card and a network service.
+
+		The GBA_ME variant where the Ks key is stored outside
+		SIM card can be implemented using ordinary SIM or AKA
+		authentication.
+
+		The UICC-based GBA variant, GBA_U, keeps the Ks key
+		stored on the SIM card (UICC) and lets the SIM card
+		calculate the NAF keys.
+
+		For further reference on GBA, see 3GPP TS 33.220
+		and 3GPP TS 24.109.
+
+		The GBA authentication suite has three different
+		operations:
+
+		- bootstrapping (AKA authentication with BSF)
+		- update (storing result from BSF to SIM)
+		- NAF key derivation
+
+		The GBA suite recognizes the operations based on the
+		input parameters.
+
+GBA Bootstrapping
+
+		The input dictionary for the GBA bootstrapping must
+		contain following parameters:
+
+			byte{array} "RAND" - AKA RAND parameter
+
+			byte{array} "AUTN" - AKA AUTN parameter
+
+		In case of successful initial GBA bootstrapping the
+		returned dictionary contains following items:
+
+			byte{array} "RES" - AKA RES parameter
+
+		In case of unsuccessful bootstrapping the returned
+		dictionary contains following item:
+
+			byte{array} "AUTS" - AKA AUTS parameter
+
+		If the bootstrapping server accepts the RES parameter,
+		it will return an XML document containing bootstrapping
+		transaction identifier (B-TID) and the lifetime of the
+		KS_NAF keys.
+
+GBA Update
+
+		The input dictionary for GBA update must contain
+		following parameters:
+
+			string "BTID" - B-TID parameter
+			string "lifetime" - NAF key lifetime
+
+		In case of succesful update, an empty dictionary is
+		returned.
+
+NAF Key Derivation
+
+		The input dictionary for NAF key derivation must contain
+		the following parameters:
+
+			string "variant" - "gba-u" or "gba-me"
+
+			string "NAF" - FQDN of NAF
+
+			byte{array} "protocol" - security protocol identifier
+
+		The variant indicates whether the KS_int_NAF or
+		KS_ext_NAF is required.
+
+		The security protocol identifier is usually a 5 byte
+		array. It indicates the protocol used between mobile
+		(UE) and network server (NAF).
+
+		In case of successful NAF key derivation the returned
+		dictionary contains following item:
+
+			byte{array} "KS-NAF" - NAF key
+
+		The KS-NAF is a 32-byte array.
-- =

1.7.1


--===============2311398940453063581==--

