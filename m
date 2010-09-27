Content-Type: multipart/mixed; boundary="===============7379452691957492815=="
MIME-Version: 1.0
From: Benoit Monin <benoit.monin@laposte.net>
Subject: [PATCH] Set username and password with create-context
Date: Mon, 27 Sep 2010 14:37:20 +0200
Message-ID: <27648846.26052.1285591040517.JavaMail.www@wwinf8219>
In-Reply-To: <4701421.25982.1285590974586.JavaMail.www@wwinf8219>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7379452691957492815==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Add the possibility to set the username and the password
with create-context, in complement of the APN.
---
test/create-context | 28 +++++++++++++++++++++++-----
1 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/test/create-context b/test/create-context
index 6777ba7..6e42053 100755
--- a/test/create-context
+++ b/test/create-context
@@ -27,10 +27,28 @@ for path, properties in modems:
context =3D dbus.Interface(bus.get_object('org.ofono', path),
'org.ofono.ConnectionContext')

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


--===============7379452691957492815==--

