Content-Type: multipart/mixed; boundary="===============2652543825691148543=="
MIME-Version: 1.0
From: Jaakko Kiviluoto <jaakko.j.kiviluoto@intel.com>
Subject: [PATCH] TODO: Add vCard export to SM/ME stores
Date: Fri, 12 Nov 2010 08:39:33 +0200
Message-ID: <1289543973-7518-1-git-send-email-jaakko.j.kiviluoto@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2652543825691148543==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index bf2305b..9dcb43f 100644
--- a/TODO
+++ b/TODO
@@ -496,3 +496,14 @@ Miscellaneous
 =

   Priority: Low
   Complexity: C4
+
+- Enable exporting contact information from vCard data to SM and ME stores.
+  Need to implement a robust vCard parser that can extract at least the
+  fields supported by the existing phonebook module.  Functionality should
+  be analoguous to existing import functionality.
+
+  Implements feature request http://bugs.meego.com/show_bug.cgi?id=3D4476
+
+  Priority: Low
+  Complexity: C1
+  Owner: Jaakko Kiviluoto <jaakko.j.kiviluoto@intel.com>
-- =

1.7.0.4

---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki =

Business Identity Code: 0357606 - 4 =

Domiciled in Helsinki =


This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============2652543825691148543==--

