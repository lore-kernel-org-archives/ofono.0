Content-Type: multipart/mixed; boundary="===============8104088071182226598=="
MIME-Version: 1.0
From: Jussi Kangas <jussi.kangas@tieto.com>
Subject: [PATCH] TODO: Mark pin check status task as done
Date: Wed, 02 Mar 2011 17:20:22 +0200
Message-ID: <1299079222-11604-1-git-send-email-jussi.kangas@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8104088071182226598==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---

Hi, =


This can now be set as done.

Br,
Jussi

 TODO |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/TODO b/TODO
index 3735e6d..c432cba 100644
--- a/TODO
+++ b/TODO
@@ -81,13 +81,6 @@ SIM / SIM File system
   Complexity: C2
   Owner: Pekka Pessi <pekka.pessi@nokia.com>
 =

-- Check SIM pin status if sim_change_pin fails. If it is anything other th=
an
-  READY, we must tear the state back to pre_sim state and set the modem of=
fline.
-
-  Priority: Medium
-  Complexity: C1
-  Owner: Marit Henriksen <marit.henriksen@stericsson.com>
-
 - Add support for CPHS Customer Service Profile (CSP).  This task adds sup=
port
   for reading the EFcsp file and in particular, interpreting the PLMN mode=
 bit
   within the 'Value Added Services' service group.
-- =

1.7.1


--===============8104088071182226598==--

