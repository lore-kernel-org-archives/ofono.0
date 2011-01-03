Content-Type: multipart/mixed; boundary="===============6220202832701417047=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [RFC sim-authenticate PATCH 2/3] Added doc/sim-authentication-api.txt.
Date: Mon, 03 Jan 2011 16:58:20 +0200
Message-ID: <1294066701-27298-3-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1294066701-27298-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6220202832701417047==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

The EAP applications on SIM should be handled separately. The
EapSimAuthenticate and EapAkaAuthenticate do not require a special EAP
application on SIM, but they use ordinary cellular authentication.
---
 doc/sim-authentication-api.txt |   66 ++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 66 insertions(+), 0 deletions(-)
 create mode 100644 doc/sim-authentication-api.txt

diff --git a/doc/sim-authentication-api.txt b/doc/sim-authentication-api.txt
new file mode 100644
index 0000000..9a033bf
--- /dev/null
+++ b/doc/sim-authentication-api.txt
@@ -0,0 +1,66 @@
+SimAuthentication hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.SimAuthentication
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		byte{array} EapSimAuthenticate(array{byte} rand)
+
+			Executes the SIM authentication algorithm for
+			RFC 4186 EAP SIM authentication method.
+
+			The input parameter is RAND, a 16-byte array.
+			In case of successful authentication operation
+			the SRES parameter is returned as a 4-byte array.
+
+			Possible Errors: [service].Error.InvalidArguments
+				 	 [service].Error.NotImplemented
+
+		dict EapAkaAuthenticate(array{byte} rand, array{byte} autn)
+
+			Executes the AKA authentication algorithm for
+			RFC 4187 EAP AKA authentication method.
+
+			All the parameters and keys are 16-byte arrays.
+
+			In case of successful authentication the
+			returned dictionary contains following items:
+
+			byte{array} "RES" - AKA RES parameter
+
+			byte{array} "CK" - AKA Ciphering key
+
+			byte{array} "IK" - AKA Integrity key
+
+			In case of unsuccessful authentication the
+			returned dictionary contain following item:
+
+			byte{array} "AUTS" - AKA AUTS parameter
+
+			Possible Errors: [service].Error.InvalidArguments
+				 	 [service].Error.NotImplemented
+
+		dict ImsAkaAuthenticate(array{byte} rand, array{byte} autn)
+
+			Executes the AKA authentication algorithm in
+			ISIM or, if ISIM is not available, in USIM.
+
+			All the parameters and keys are 16-byte arrays.
+
+			In case of successful authentication the
+			returned dictionary contains following items:
+
+			byte{array} "RES" - AKA RES parameter
+
+			byte{array} "CK" - AKA Ciphering key
+
+			byte{array} "IK" - AKA Integrity key
+
+			In case of unsuccessful authentication the
+			returned dictionary contain following item:
+
+			byte{array} "AUTS" - AKA AUTS parameter
+
+			Possible Errors: [service].Error.InvalidArguments
+				 	 [service].Error.NotImplemented
-- =

1.7.1


--===============6220202832701417047==--

