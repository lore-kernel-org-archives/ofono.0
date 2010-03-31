Content-Type: multipart/mixed; boundary="===============3846910349533594319=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Update property name in test-ussd
Date: Wed, 31 Mar 2010 06:56:45 +0200
Message-ID: <1270011405-6686-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3846910349533594319==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-ussd |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/test/test-ussd b/test/test-ussd
index 656c73e..79dd596 100755
--- a/test/test-ussd
+++ b/test/test-ussd
@@ -14,7 +14,7 @@ def ussd_request_received(content):
 	ss.Cancel()
 =

 def ussd_property_changed(name, value):
-	if name !=3D "USSDState":
+	if name !=3D "State":
 		return
 	print("USSD session state is " + value)
 =

-- =

1.6.1


--===============3846910349533594319==--

