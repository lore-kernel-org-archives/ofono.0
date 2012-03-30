Content-Type: multipart/mixed; boundary="===============2866799402298780920=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH 2/2] TODO: storage task complete
Date: Fri, 30 Mar 2012 17:40:53 +0200
Message-ID: <1333122053-30708-3-git-send-email-sebastien.bianti@linux.intel.com>
In-Reply-To: <1333122053-30708-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2866799402298780920==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/TODO b/TODO
index 42e25a6..c75468d 100644
--- a/TODO
+++ b/TODO
@@ -43,20 +43,6 @@ MMS Reception
   support.
   Owner: Ronald Tessier <ronald.tessier@linux.intel.com>
 =

-MMS Storage
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-- Add pending/incompleted transactions recovery on mmsd restart.
-  In the case of a restart of the mmsd, all the incomplete/pending MMS
-  transactions identified thanks to the META file information
-  (status key value) should be re-processed (i.e.: added to the mms_servic=
e =

-  structure request_queue).
-
-  Priority: Medium
-  Complexity: C2
-  Depends: META file support, MMS submit support.
-  Owner: Sebastien Bianti <sebastien.bianti@linux.intel.com>
-
 D-Bus API
 =3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-- =

1.7.4.4


--===============2866799402298780920==--

