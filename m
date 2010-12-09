Content-Type: multipart/mixed; boundary="===============1326450319956198483=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 6/7] doc: Add new property to call forwarding
Date: Thu, 09 Dec 2010 09:44:00 -0800
Message-ID: <1291916641-531-7-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1291916641-531-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1326450319956198483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/call-forwarding-api.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/doc/call-forwarding-api.txt b/doc/call-forwarding-api.txt
index 067531a..e8b4b9f 100644
--- a/doc/call-forwarding-api.txt
+++ b/doc/call-forwarding-api.txt
@@ -57,3 +57,8 @@ Properties	string VoiceUnconditional [readwrite]
 =

 			Contains the value of the voice "Not Reachable" call
 			forwarding rule.
+
+		boolean ForwardingFlagOnSim [readonly]
+
+			Boolean representing the voice unconditional call
+			forwarding rule status.
-- =

1.7.0.4


--===============1326450319956198483==--

