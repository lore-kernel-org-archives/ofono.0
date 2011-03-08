Content-Type: multipart/mixed; boundary="===============2174887215445568202=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] test/test-modem: display more properties (Name, Online,
 Lockdown...)
Date: Tue, 08 Mar 2011 16:08:41 +0100
Message-ID: <1299596921-6708-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2174887215445568202==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-modem |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/test/test-modem b/test/test-modem
index 5859ae3..c1eeedf 100755
--- a/test/test-modem
+++ b/test/test-modem
@@ -24,6 +24,9 @@ if __name__ =3D=3D "__main__":
 =

 	properties =3D modem.GetProperties()
 =

+	if properties.has_key('Name'):
+		print "Name: %s" % (properties['Name'])
+		=

 	if properties.has_key('Manufacturer'):
 		print "Manufacturer: %s" % (properties['Manufacturer'])
 =

@@ -36,5 +39,27 @@ if __name__ =3D=3D "__main__":
 	if properties.has_key('Serial'):
 		print "Serial: %s" % (properties['Serial'])
 =

+	if properties.has_key('Powered'):
+		print "Powered: %s" % (properties['Powered'])
+
+	if properties.has_key('Online'):
+		print "Online: %s" % (properties['Online'])
+
+	if properties.has_key('Lockdown'):
+		print "Lockdown: %s" % (properties['Lockdown'])
+
+	if properties.has_key('Emergency'):
+		print "Emergency: %s" % (properties['Emergency'])
+
+	if properties.has_key('Features'):
+		print "Features:"
+		for feature in properties["Features"]:
+			print "    [ %s ]" % (feature)
+
+	if properties.has_key('Interfaces'):
+		print "Interfaces:"
+		for interface in properties["Interfaces"]:
+			print "    [ %s ]" % (interface)
+
 	mainloop =3D gobject.MainLoop()
 	mainloop.run()
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

--===============2174887215445568202==--

