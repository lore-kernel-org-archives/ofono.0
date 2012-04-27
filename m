Content-Type: multipart/mixed; boundary="===============6106696897687676124=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH 1/2] TODO: MMS reception error management done
Date: Fri, 27 Apr 2012 17:47:03 +0200
Message-ID: <1335541624-23000-2-git-send-email-sebastien.bianti@linux.intel.com>
In-Reply-To: <1335541624-23000-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6106696897687676124==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/TODO b/TODO
index c75468d..95a40c7 100644
--- a/TODO
+++ b/TODO
@@ -30,19 +30,6 @@ MMS Submission
   "org.ofono.mms.Message" interface implementation.
   Owner: Sebastien Bianti <sebastien.bianti@linux.intel.com>
 =

-MMS Reception
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-- Add MMS Automatic Retrieval support.
-  Error cases should handled and reported to the application layer.
-
-  Priority: High
-  Complexity: C4
-  Depends: META file support, MMS M-Retrieve.conf PDU decoding support,
-  "org.ofono.mms.Message" interface implementation, HTTP GWeb POST request
-  support.
-  Owner: Ronald Tessier <ronald.tessier@linux.intel.com>
-
 D-Bus API
 =3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-- =

1.7.4.4


--===============6106696897687676124==--

