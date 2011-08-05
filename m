Content-Type: multipart/mixed; boundary="===============2922527773008468795=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH_v6 14/14] test: update list-modem to display CDMA DataStrength
 info.
Date: Fri, 05 Aug 2011 15:21:15 +0200
Message-ID: <1312550475-8537-15-git-send-email-bertrand.aygon@intel.com>
In-Reply-To: <1312550475-8537-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2922527773008468795==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/list-modems |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/test/list-modems b/test/list-modems
index 662a3c7..09949b7 100755
--- a/test/list-modems
+++ b/test/list-modems
@@ -52,7 +52,8 @@ for path, properties in modems:
 						"VoicemailMessageCount",
 						"MicrophoneVolume",
 						"SpeakerVolume",
-						"Strength"]:
+						"Strength",
+						"DataStrength"]:
 				val =3D int(properties[key])
 			elif key in ["MainMenu"]:
 				val =3D ", ".join([ text + " (" + str(int(icon)) +
-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============2922527773008468795==--

