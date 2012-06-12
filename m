Content-Type: multipart/mixed; boundary="===============8836664050726734629=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH] TODO: Remove infeasible SIM task
Date: Tue, 12 Jun 2012 17:05:46 +0200
Message-ID: <1339513546-14612-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8836664050726734629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |   17 -----------------
 1 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/TODO b/TODO
index 1fef651..3ddf363 100644
--- a/TODO
+++ b/TODO
@@ -66,23 +66,6 @@ SIM / SIM File system
   Priority: Low
   Complexity: C2
 =

-- Add support for SIM 'ready' notifications from the driver to the core.  =
Most
-  modem manufacturers initialize the SIM (e.g. cache SIM file system, STK
-  initialization, etc) internally before allowing the telephony stack to
-  access these portions.  When the PIN is locked, this can lead to oFono b=
eing
-  too fast for the modem and asking it for things before the firmware is r=
eady.
-
-  The proposal is to introduce a new sim function:
-    void ofono_sim_ready_notify(struct ofono_sim *sim);
-
-  When oFono determines the SIM PIN is READY, it checks whether
-  ofono_sim_ready_notify has been called.  If it hasn't, then it stalls the
-  initialization procedure (and calling post_sim) until
-  ofono_sim_ready_notify is called.
-
-  Priority: High
-  Complexity: C2
-
 - Support SIM authentication: SIM and AKA suites.
 =

   Priority: Medium
-- =

1.7.5.4


--===============8836664050726734629==--

