Content-Type: multipart/mixed; boundary="===============2541643465540203186=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH] phonesim: fixup to remove printf from recent commit
Date: Wed, 04 Oct 2017 09:52:17 -0700
Message-ID: <1507135937-12868-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2541643465540203186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/phonesim.cpp | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index cf7d5a1..ec3900a 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -630,8 +630,6 @@ SimRules::SimRules( int fd, QObject *p,  const QString&=
 filename, HardwareManipu
             loadPhoneBook( *n );
 =

         } else if ( n->tag =3D=3D "simauth" ) {
-            printf("\n\nPARSING SIMAUTH\n\n");
-
             _simAuth =3D new SimAuth( this, *n );
             connect( _simAuth, SIGNAL(send(QString)),
                     this, SLOT(respond(QString)) );
-- =

2.7.4


--===============2541643465540203186==--

