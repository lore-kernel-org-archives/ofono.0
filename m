Content-Type: multipart/mixed; boundary="===============7388529585822720348=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] TODO: long phone numbers
Date: Fri, 08 Oct 2010 18:39:17 +0300
Message-ID: <1286552357-19501-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7388529585822720348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 TODO |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 5589bb1..f963954 100644
--- a/TODO
+++ b/TODO
@@ -285,6 +285,12 @@ Voicecall
   Complexity: C1
   Owner: Pekka Pessi <pekka.pessi@nokia.com>
 =

+- Long phone numbers. According to 3GPP TS 24.008, the callee address
+  can be up to 80 digits long.
+
+  Priority: Medium
+  Complexity: C2
+
 - Dial strings. Include CLIR prefixes and 2nd stage dial strings in the
   DialString call property. Add dialstring accessor method to C API.
 =

-- =

1.7.0.4


--===============7388529585822720348==--

