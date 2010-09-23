Content-Type: multipart/mixed; boundary="===============6159208023274117507=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] Add GPRS suspension to doc/features.txt
Date: Thu, 23 Sep 2010 18:11:36 +0300
Message-ID: <1285254696-31910-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6159208023274117507==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 doc/features.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/doc/features.txt b/doc/features.txt
index 534b8de..601d58c 100644
--- a/doc/features.txt
+++ b/doc/features.txt
@@ -96,3 +96,10 @@ Short Messaging Service
   incoming messages is only generated when the SMS is fully assembled.  The
   hash used is SHA1.  This unique identifier is used to identify the SMS
   message to history plugins as well.
+
+
+GPRS
+=3D=3D=3D=3D
+
+- The packet data service may be temporarily suspended while a circuit
+  switched service such as voice call or SMS is active.
-- =

1.7.0.4


--===============6159208023274117507==--

