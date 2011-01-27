Content-Type: multipart/mixed; boundary="===============2204164788556404181=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [sim-auth PATCHv2 2/3] Add GBA_U to SIM authentication API
Date: Thu, 27 Jan 2011 20:06:11 +0200
Message-ID: <1296151572-3721-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1296151572-3721-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2204164788556404181==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 doc/sim-authentication-api.txt |   90 ++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 90 insertions(+), 0 deletions(-)

diff --git a/doc/sim-authentication-api.txt b/doc/sim-authentication-api.txt
index 27090e7..2db80bb 100644
--- a/doc/sim-authentication-api.txt
+++ b/doc/sim-authentication-api.txt
@@ -29,6 +29,7 @@ Properties	array{string} Suites [readonly]
 =

 			"SIM" - SIM authentication
 			"AKA" - AKA authentication
+			"GBA_U" - UICC-based GBA authentication
 =

 SIM Authentication Suite
 ------------------------
@@ -36,6 +37,11 @@ SIM Authentication Suite
 		SIM authentication (A8) can be used to implement EAP SIM
 		or 2G GBA authentication.
 =

+		The input dictionary must contain following input
+		parameters:
+
+			byte{array} "RAND" - RAND parameter
+
 		In case of successful SIM authentication the returned
 		dictionary contains following items:
 =

@@ -79,3 +85,87 @@ AKA Authentication Suite
 			byte{array} "AUTS" - AKA AUTS parameter
 =

 		All the AKA parameters and keys are 16-byte arrays.
+
+GBA_U Suite
+-----------
+
+		GBA_U is a GBA variant used if USIM or ISIM application
+		supports it.
+
+		The GBA_U authentication suite has three different
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
+		The GBA bootstrapping authentication is done after
+		receiving AKA challenge from bootstrap server (BSF).
+		After successful authentication, SIM will store the RAND
+		and the Ks for further use.
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
+GBA Update
+
+		If the bootstrap operation is successful, the "btid" and
+		"lifetime" parameters received from bootstrap server
+		should be stored on the SIM card. The "btid" parameter
+		will be used as user identity with NAF servers.
+
+		The input dictionary for GBA update must contain
+		following parameters:
+
+			string "btid" - B-TID parameter
+			string "lifetime" - expected lifetime of Ks key
+
+		In case of successful update, an empty dictionary is
+		returned.
+
+NAF Key Derivation
+
+		The NAF key is used to authenticate mobile with a server
+		using GBA.
+
+		The input dictionary for NAF key derivation must contain
+		the following parameters:
+
+			string "name" - NAF domain name
+
+			byte{array} "protocol" - security protocol identifier
+
+		The security protocol identifier is usually a 5 byte
+		array. It indicates the protocol used between the mobile
+		device (UE) and the network server (NAF).  See 3GPP TS
+		33.220 Annex H for protocol identifiers.
+
+		In case of successful NAF key derivation the returned
+		dictionary contains following item:
+
+			byte{array} "KS-NAF" - KS_ext_NAF key
+
+		The KS-NAF is a 32-byte array.
+
+		The applications running on SIM can use GBA_U to derive
+		so called KS_int_NAF keys, however, they are not
+		accessible outside SIM card.
-- =

1.7.1


--===============2204164788556404181==--

