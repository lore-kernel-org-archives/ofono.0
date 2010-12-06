Content-Type: multipart/mixed; boundary="===============6603962873528960592=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 01/14] test: fix bug in test-ss-control-cs
Date: Mon, 06 Dec 2010 18:12:29 -0200
Message-ID: <1291666362-19128-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6603962873528960592==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-ss-control-cs |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/test/test-ss-control-cs b/test/test-ss-control-cs
index bf59789..e04a4a0 100755
--- a/test/test-ss-control-cs
+++ b/test/test-ss-control-cs
@@ -29,7 +29,7 @@ if __name__ =3D=3D "__main__":
 =

         cs.connect_to_signal("PropertyChanged", property_changed)
 =

-	ss =3D dbus.Interface(bus.get_object('org.ofono', modems[0]),
+	ss =3D dbus.Interface(bus.get_object('org.ofono', modems[0][0]),
 							'org.ofono.SupplementaryServices')
 =

 	print_properties(cs)
-- =

1.7.3.2


--===============6603962873528960592==--

