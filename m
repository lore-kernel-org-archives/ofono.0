Content-Type: multipart/mixed; boundary="===============1988053203221516827=="
MIME-Version: 1.0
From: Martin Pitt <martin.pitt@ubuntu.com>
Subject: [PATCH 3/5] test: Replace obsolete has_key() with "in" to also work
 with Python 3
Date: Tue, 11 Mar 2014 17:39:20 +0100
Message-ID: <1394555962-21661-3-git-send-email-martin.pitt@ubuntu.com>
In-Reply-To: <1394555962-21661-1-git-send-email-martin.pitt@ubuntu.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1988053203221516827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-modem                | 22 +++++++++++-----------
 test/test-network-registration |  4 ++--
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/test/test-modem b/test/test-modem
index e4dd6bd..7681094 100755
--- a/test/test-modem
+++ b/test/test-modem
@@ -24,39 +24,39 @@ if __name__ =3D=3D "__main__":
 =

 	properties =3D modem.GetProperties()
 =

-	if properties.has_key('Name'):
+	if 'Name' in properties:
 		print("Name: %s" % (properties['Name']))
 =

-	if properties.has_key('Manufacturer'):
+	if 'Manufacturer' in properties:
 		print("Manufacturer: %s" % (properties['Manufacturer']))
 =

-	if properties.has_key('Model'):
+	if 'Model' in properties:
 		print("Model: %s" % (properties['Model']))
 =

-	if properties.has_key('Revision'):
+	if 'Revision' in properties:
 		print("Revision: %s" % (properties['Revision']))
 =

-	if properties.has_key('Serial'):
+	if 'Serial' in properties:
 		print("Serial: %s" % (properties['Serial']))
 =

-	if properties.has_key('Powered'):
+	if 'Powered' in properties:
 		print("Powered: %s" % (properties['Powered']))
 =

-	if properties.has_key('Online'):
+	if 'Online' in properties:
 		print("Online: %s" % (properties['Online']))
 =

-	if properties.has_key('Lockdown'):
+	if 'Lockdown' in properties:
 		print("Lockdown: %s" % (properties['Lockdown']))
 =

-	if properties.has_key('Emergency'):
+	if 'Emergency' in properties:
 		print("Emergency: %s" % (properties['Emergency']))
 =

-	if properties.has_key('Features'):
+	if 'Features' in properties:
 		print("Features:")
 		for feature in properties["Features"]:
 			print("    [ %s ]" % (feature))
 =

-	if properties.has_key('Interfaces'):
+	if 'Interfaces' in properties:
 		print("Interfaces:")
 		for interface in properties["Interfaces"]:
 			print("    [ %s ]" % (interface))
diff --git a/test/test-network-registration b/test/test-network-registration
index 5d3f75e..9410ae6 100755
--- a/test/test-network-registration
+++ b/test/test-network-registration
@@ -47,11 +47,11 @@ if __name__ =3D=3D "__main__":
 	print("Status is: '%s', Operator Name is: '%s'" %\
 		(props['Status'], props['Name']))
 =

-	if props.has_key('LocationAreaCode') and props.has_key('CellId'):
+	if 'LocationAreaCode' in props and 'CellId' in props:
 		print("Location: '%d', Cell: '%d'" %\
 			(props['LocationAreaCode'], props['CellId']))
 =

-	if props.has_key('Technology'):
+	if 'Technology' in props:
 		print("Technology: '%s'" % (props['Technology']))
 =

 	try:
-- =

1.9.0


--===============1988053203221516827==--

