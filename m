Content-Type: multipart/mixed; boundary="===============2613311732170487624=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Beno=C3=AEt?= Monin <benoit.monin@gmx.fr>
Subject: [PATCH resend] test/list-modems : print Strength as an integer
Date: Fri, 17 Dec 2010 21:33:06 +0100
Message-ID: <201012172133.06584.benoit.monin@gmx.fr>
In-Reply-To: <4D0AB550.9000308@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2613311732170487624==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

org.ofono.NetworkRegistration property Strength is an integer,
so print it as such.
---
 test/list-modems |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/test/list-modems b/test/list-modems
index 557efd5..8c075ac 100755
--- a/test/list-modems
+++ b/test/list-modems
@@ -51,7 +51,8 @@ for path, properties in modems:
 			elif key in ["MobileNetworkCodeLength",
 						"VoicemailMessageCount",
 						"MicrophoneVolume",
-						"SpeakerVolume"]:
+						"SpeakerVolume",
+						"Strength"]:
 				val =3D int(properties[key])
 			elif key in ["MainMenu"]:
 				val =3D ", ".join([ text + " (" + str(int(icon)) +
-- =

1.7.1


--===============2613311732170487624==--

