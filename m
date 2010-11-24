Content-Type: multipart/mixed; boundary="===============1739091758821651818=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH] TODO: Add a new task for CELL_DCH state indication
Date: Wed, 24 Nov 2010 14:50:59 +0200
Message-ID: <1290603059-5556-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1739091758821651818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index c484871..5806ef0 100644
--- a/TODO
+++ b/TODO
@@ -507,3 +507,13 @@ Miscellaneous
   Priority: Medium
   Complexity: C2
   Owner: Sjur Br=EF=BF=BD=EF=BF=BDndeland <sjur.brandeland@stericsson.co=
m>
+
+- Add CELL_DCH state indication support.  Add a new optional property to t=
he
+  RadioSettings atom for indicating radio bearer idle/active status.  This
+  feature is useful for many types of power management schemes that schedu=
le
+  non-realtime operations over the UMTS radio interface to when the interf=
ace is
+  active for other purposes as well, i.e., in CELL_DCH state.
+
+  Priority: Medium
+  Complexity: C4
+  Owner: Aki Niemi <aki.niemi@nokia.com>
-- =

1.7.1


--===============1739091758821651818==--

