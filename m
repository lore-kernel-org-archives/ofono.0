Content-Type: multipart/mixed; boundary="===============2706786839126668415=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [sim-auth PATCHv2 3/3] Add doc/gba-authentication.txt
Date: Thu, 27 Jan 2011 20:06:12 +0200
Message-ID: <1296151572-3721-3-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1296151572-3721-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2706786839126668415==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 Makefile.am                |    4 +-
 doc/gba-authentication.txt |   67 ++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 69 insertions(+), 2 deletions(-)
 create mode 100644 doc/gba-authentication.txt

diff --git a/Makefile.am b/Makefile.am
index 65b488a..462b05f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -396,8 +396,8 @@ doc_files =3D doc/overview.txt doc/ofono-paper.txt doc/=
release-faq.txt \
 			doc/sim-api.txt doc/stk-api.txt \
 			doc/sim-authentication-api.txt \
 			doc/audio-settings-api.txt doc/text-telephony-api.txt \
-			doc/calypso-modem.txt
-
+			doc/calypso-modem.txt \
+			doc/gba-authentication.txt
 =

 test_scripts =3D test/backtrace \
 		test/create-internet-context \
diff --git a/doc/gba-authentication.txt b/doc/gba-authentication.txt
new file mode 100644
index 0000000..e233b1c
--- /dev/null
+++ b/doc/gba-authentication.txt
@@ -0,0 +1,67 @@
+GBA Authentication
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+	GBA authentication uses SIM card to establish a unique identity
+	and a shared secret for a network service. The shared secret is
+	computed from the domain name of the service and a special
+	boostrap key, Ks.
+
+	GBA is used to authenticate the mobile with the IMS XCAP
+	servers.
+
+	The mobile obtains the bootstrap key and a temporary identity
+	used with network services from a special boostraps bootstrap
+	server, BSF. Mobile authenticates itself with BSF using AKA
+	authentication and the BSF returns it the identity to use with
+	network services (known as NAF). The bootstrap key is formed
+	from the AKA authentication results, too.
+
+	In the initial phase the client will send its user identity, the
+	IP Multimedia Private Identity (IMPI) to the BSF server. The BSF
+	server fetches an AKA challenge from operator's subscriber
+	database along with correct response: RAND, AUTN, XRES, CK and
+	IK. Server returns the AKA challenge RAND and AUTN to mobile.
+
+	The client uses SIM to calculate the AKA RES, CK and IK from the
+	challenge, and uses RES to generate AKA Digest credentials sent
+	back to the bootstrap server.
+
+	The bootstrapping server verifies the response using XRES, and
+	if accepted, it will return an XML document containing the
+	bootstrapping transaction identifier (B-TID) and the lifetime of
+	the KS_NAF keys.
+
+	The CK and IK parameters from AKA authentication are used for
+	Ks. The Ks can now be used to derive unique key for each NSF
+	service.
+
+	For further reference on GBA, see 3GPP TS 33.220 and 3GPP TS
+	24.109.
+
+
+GBA Variants
+------------
+
+	There are three different GBA variants: 2G GBA, GBA_ME and
+	GBA_U. The variant is selected based on SIM card
+	capabilities.The 2G GBA is used if there is no 3G USIM
+	available. The GBA_ME is used if there is USIM or ISIM
+	application on SIM card (also known as UICC), but there is no
+	support for GBA service.
+
+	In the GBA_ME variant the Ks key is stored outside SIM card. It
+	is implemented using ordinary AKA authentication.
+
+	In the 2G variant, there is no AKA authentication, but it is
+	rather simulated using 2G A8 SIM authentication algorithm. The
+	2G variant is described in the 3GPP 33.220 Annex I.
+
+	The UICC-based GBA variant, GBA_U, keeps the Ks key stored on
+	the SIM card (UICC) and lets the SIM card calculate the NAF
+	keys.
+
+	Note that the device cannot downgrade the protocol: subscriber
+	database has recorded if the SIM card supports GBA_U and the
+	information is included in the AKA challenge. The SIM card will
+	reject a GBA_U-related AKA challenge if it is used with ordinary
+	AKA service.
-- =

1.7.1


--===============2706786839126668415==--

