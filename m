Content-Type: multipart/mixed; boundary="===============0696180298325589182=="
MIME-Version: 1.0
From: Benoit Monin <benoit.monin@laposte.net>
Subject: Set username and password with create-context
Date: Tue, 22 Jun 2010 09:16:00 +0000
Message-ID: <14587206.98572.1277198155336.JavaMail.www@wwinf8402>
In-Reply-To: <25118539.98442.1277198076995.JavaMail.www@wwinf8402>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0696180298325589182==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



Add the possibility to set the username and the password
with create-context, in complement of the APN.

Signed-off-by: Beno=C3=AEt Monin =

---
test/create-context | 28 +++++++++++++++++++++++-----
1 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/test/create-context b/test/create-context
index 4523c3a..c9ffeac 100755
--- a/test/create-context
+++ b/test/create-context
@@ -32,10 +32,28 @@ for path in properties["Modems"]:
context =3D dbus.Interface(bus.get_object('org.ofono', path),
'org.ofono.PrimaryDataContext')

- try:
- context.SetProperty("AccessPointName", sys.argv[1])
- except IndexError:
- print "Usage: %s " % sys.argv[0]
+ if len(sys.argv) =3D=3D 2:
+ AccessPointName =3D sys.argv[1]
+ Username =3D ""
+ Password =3D ""
+ elif len(sys.argv) =3D=3D 3:
+ AccessPointName =3D sys.argv[1]
+ Username =3D ""
+ Password =3D sys.argv[2]
+ elif len(sys.argv) =3D=3D 4:
+ AccessPointName =3D sys.argv[1]
+ Username =3D sys.argv[2]
+ Password =3D sys.argv[3]
+ else:
+ print "Usage:"
+ print "\t%s " % sys.argv[0]
+ print "\t%s  =

" % sys.argv[0]
+ print "\t%s   =

" % sys.argv[0]
exit(1)

- print "Setting APN of %s to %s" % (path, sys.argv[1])
+ context.SetProperty("AccessPointName", AccessPointName)
+ print "Setting APN of %s to \"%s\"" % (path, AccessPointName)
+ context.SetProperty("Username", Username)
+ print "Setting username of %s to \"%s\"" % (path, Username)
+ context.SetProperty("Password", Password)
+ print "Setting password of %s to \"%s\"" % (path, Password)
--






Une messagerie gratuite, garantie =C3=A0 vie et des services en plus, =C3=
=A7a vous tente ?
Je cr=C3=A9e ma bo=C3=AEte mail www.laposte.net


--===============0696180298325589182==--

