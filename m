Content-Type: multipart/mixed; boundary="===============2152649380264078039=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 1/2] TODO: Splitting DUN task in 2 parts Bluetooth DUN and USB
 DUN
Date: Thu, 25 Aug 2011 16:19:50 +0200
Message-ID: <1314281991-16595-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2152649380264078039==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/TODO b/TODO
index f03a112..9cc5dc0 100644
--- a/TODO
+++ b/TODO
@@ -111,12 +111,17 @@ Modem Emulator
   Complexity: C1
 =

 - Support DUN emulator. Implement the Bluetooth DUN profile with only mand=
atory
-  AT command support. Implement USB DUN as well.
+  AT command support.
 =

   Complexity: C4
   Priority: Medium
   Owner: Guillaume Zajac <guillaume.zajac@linux.intel.com>
 =

+- Implement USB DUN.
+
+  Complexity: C4
+  Priority: Medium
+
   Depends: PPP Server mode
 =

 - Support Bluetooth SPP profile.
-- =

1.7.1


--===============2152649380264078039==--

