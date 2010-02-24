Content-Type: multipart/mixed; boundary="===============5153161243579926700=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Jo=C3=A3o?= Paulo Rechi Vita <jprvita@profusion.mobi>
Subject: [PATCH] test: show number beeing dialed.
Date: Wed, 24 Feb 2010 16:14:27 -0300
Message-ID: <1267038867-28929-3-git-send-email-jprvita@profusion.mobi>
In-Reply-To: <1267038867-28929-2-git-send-email-jprvita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5153161243579926700==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-voicecall |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/test/test-voicecall b/test/test-voicecall
index 2da7703..e7d0dc0 100755
--- a/test/test-voicecall
+++ b/test/test-voicecall
@@ -72,7 +72,7 @@ if __name__ =3D=3D "__main__":
 =

 	voicecalls_property_changed('Calls', properties['Calls'])
 =

-	print "Dialing...."
+	print "Dialing %s..." % number
 	obj =3D vcmanager.Dial(number, "")
 	print "Dialing in progress, got obj: %s" % (obj)
 =

-- =

1.6.3.3


--===============5153161243579926700==--

