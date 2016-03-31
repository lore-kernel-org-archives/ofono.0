Content-Type: multipart/mixed; boundary="===============6340475649754636057=="
MIME-Version: 1.0
From: Samrat Guha Niyogi <samrat.guha.niyogi@intel.com>
Subject: [PATCH] devinfo: Add support of IMEISV
Date: Thu, 31 Mar 2016 13:17:53 +0530
Message-ID: <1459410473-2115-1-git-send-email-samrat.guha.niyogi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6340475649754636057==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-modem | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/test/test-modem b/test/test-modem
index aa38b1f..59e9163 100755
--- a/test/test-modem
+++ b/test/test-modem
@@ -39,6 +39,9 @@ if __name__ =3D=3D "__main__":
 	if 'Serial' in properties:
 		print("Serial: %s" % (properties['Serial']))
 =

+	if 'SoftwareVersionNumber' in properties:
+		print("SoftwareVersionNumber: %s" % (properties['SoftwareVersionNumber']=
))
+
 	if 'Powered' in properties:
 		print("Powered: %s" % (properties['Powered']))
 =

-- =

1.9.1


--===============6340475649754636057==--

