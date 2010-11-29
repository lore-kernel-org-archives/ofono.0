Content-Type: multipart/mixed; boundary="===============9050300671736180449=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 6/7] doc: Add new property to call forwarding
Date: Mon, 29 Nov 2010 02:38:02 -0800
Message-ID: <1291027083-19231-7-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1291027083-19231-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9050300671736180449==
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


--===============9050300671736180449==--

