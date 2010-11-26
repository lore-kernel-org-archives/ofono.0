Content-Type: multipart/mixed; boundary="===============7676294214511609226=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC 7/7] doc: Add new property to call forwarding
Date: Thu, 25 Nov 2010 22:23:37 -0800
Message-ID: <1290752617-19024-8-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1290752617-19024-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7676294214511609226==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/call-forwarding-api.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/doc/call-forwarding-api.txt b/doc/call-forwarding-api.txt
index 067531a..5dfb48e 100644
--- a/doc/call-forwarding-api.txt
+++ b/doc/call-forwarding-api.txt
@@ -57,3 +57,8 @@ Properties	string VoiceUnconditional [readwrite]
 =

 			Contains the value of the voice "Not Reachable" call
 			forwarding rule.
+
+		boolean VoiceUnconditionalStatus [readonly]
+
+			Boolean representing the voice unconditional call
+			forwarding rule status.
-- =

1.7.0.4


--===============7676294214511609226==--

