Content-Type: multipart/mixed; boundary="===============7138835758811855372=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] Fix usage of test/test-call-settings: add missing properties
Date: Fri, 04 Mar 2011 11:25:28 +0100
Message-ID: <1299234328-4737-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7138835758811855372==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-call-settings |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/test/test-call-settings b/test/test-call-settings
index 187b405..97cec86 100755
--- a/test/test-call-settings
+++ b/test/test-call-settings
@@ -15,7 +15,10 @@ def property_changed(name, value):
 if __name__ =3D=3D "__main__":
 	if len(sys.argv) < 3:
 		print "Usage: %s [modem] <property> <newvalue>" % (sys.argv[0])
-		print "Properties can be: VoiceCallWaiting, HideCallerId"
+		print "Properties can be: VoiceCallWaiting,"
+		print "	ConnectedLineRestriction, CallingLineRestriction,"
+		print "	CallingLinePresentation, CalledLinePresentation,"
+		print "	ConnectedLinePresentation, HideCallerId"
 		sys.exit(1)
 =

 	canexit =3D False
-- =

1.7.1

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

--===============7138835758811855372==--

