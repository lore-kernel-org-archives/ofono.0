Content-Type: multipart/mixed; boundary="===============0371052765819809533=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH] TODO: Mark silent modem reset task as done
Date: Wed, 22 Dec 2010 17:06:58 -0200
Message-ID: <1293044818-25198-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1293044818-25198-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0371052765819809533==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO             |    7 -------
 doc/features.txt |    7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/TODO b/TODO
index 39f3af8..3c2ff15 100644
--- a/TODO
+++ b/TODO
@@ -408,13 +408,6 @@ Miscellaneous
   Complexity: C8
   Owner: Jukka Saunam=C3=A4ki <jukka.saunamaki@nokia.com>
 =

-- Support for modem 'silent' reset notifications.  oFono will remove all a=
toms
-  and re-initialize.
-
-  Priority: Medium
-  Complexity: C2
-  Owner: Gustavo F Padovan <padovan@profusion.mobi>
-
 - Add support for Modem 'power down & lock' and 'unlock & power up'.  When=
 the
   'power down & lock' is given, the calling application is noted and all
   other applications are blocked from powering up the modem.  Only the cal=
ling
diff --git a/doc/features.txt b/doc/features.txt
index b2843a8..5c7d6c1 100644
--- a/doc/features.txt
+++ b/doc/features.txt
@@ -158,6 +158,13 @@ The following commands are expected to be handled by t=
he modem:
   information is included in the proactive command.
 =

 =

+Modem
+=3D=3D=3D=3D=3D
+
+- 'silent' modem reset. Sometimes modems get in a bad state and have to re=
set
+  itself. Now oFono can be notified when a reset happens and do proper wor=
k to
+  put the modem back to work restoring the state before the reset.
+
 Short Messaging Service
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-- =

1.7.3.4


--===============0371052765819809533==--

