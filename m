Content-Type: multipart/mixed; boundary="===============8211307656743230549=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH 1/1] TODO: task complete
Date: Wed, 02 May 2012 10:43:38 +0200
Message-ID: <1335948218-30329-2-git-send-email-sebastien.bianti@linux.intel.com>
In-Reply-To: <1335948218-30329-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8211307656743230549==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/TODO b/TODO
index 95a40c7..8d82b90 100644
--- a/TODO
+++ b/TODO
@@ -16,20 +16,6 @@ Background
   once the task is better understood.
 =

 =

-MMS Submission
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-- Add MMS submit support.
-  In case of error (HTTP communication error, MMSC rejection of the submit
-  request), the SendMessage Request asynchronous reply should also be sent=
 with
-  the appropriate DBus error status (see __mms_error_XXXX).
-
-  Priority: High
-  Complexity: C4
-  Depends: MMS M-Send.Req PDU encoding support, META file support,
-  "org.ofono.mms.Message" interface implementation.
-  Owner: Sebastien Bianti <sebastien.bianti@linux.intel.com>
-
 D-Bus API
 =3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-- =

1.7.4.4


--===============8211307656743230549==--

