Content-Type: multipart/mixed; boundary="===============5192788244255848668=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] TODO: Mark Language Notification task as done
Date: Wed, 01 Dec 2010 11:47:21 -0800
Message-ID: <1291232841-16341-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5192788244255848668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO             |    6 ------
 doc/features.txt |    4 ++++
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/TODO b/TODO
index a421a99..f64b122 100644
--- a/TODO
+++ b/TODO
@@ -359,12 +359,6 @@ Sim Toolkit
   Priority: High
   Complexity: C8
 =

-- Support Language Notification proactive command.
-
-  Priority: Medium
-  Complexity: C1
-  Owner: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
-
 - Support Provide Local Information.  Whenever oFono receives a Provide Lo=
cal
   Information proactive command, it should check the type of the informati=
on
   requested.  If the information is about the time/date or the language of=
 the
diff --git a/doc/features.txt b/doc/features.txt
index ef20cf2..bd73e2e 100644
--- a/doc/features.txt
+++ b/doc/features.txt
@@ -95,6 +95,10 @@ Supported Proactive Commands:
 =

   NOTE: This command can also be handled by the modem.
 =

+- Language Notification proactive command. Whenever oFono receives a Langu=
age
+  Notification proactive command, it prints the language code and sends
+  terminal response to the SIM immediately.
+
 - Sim icon support.  oFono supports icons that are stored on the SIM.  If =
the
   SIM notifies oFono that an icon is available for a particular proactive
   command, oFono passes this information to the UI.  The UI is able to obt=
ain
-- =

1.7.0.4


--===============5192788244255848668==--

