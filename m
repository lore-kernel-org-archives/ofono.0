Content-Type: multipart/mixed; boundary="===============1577429546122556101=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC 5/5] doc: Describe TextTelephony property
Date: Mon, 10 Jan 2011 16:01:32 +0200
Message-ID: <1294668092-27896-6-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294668092-27896-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1577429546122556101==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/voicecall-api.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/doc/voicecall-api.txt b/doc/voicecall-api.txt
index 4f38e6a..8df8fd2 100644
--- a/doc/voicecall-api.txt
+++ b/doc/voicecall-api.txt
@@ -100,6 +100,13 @@ Properties	string LineIdentification [readonly]
 			Notifications if a call becomes part or leaves a
 			multipart call are sent.
 =

+		boolean TextTelephony [readonly]
+
+			Contains the indication if the voice call is a
+			text telephony call or not.
+
+			Notifications if a call is a text telephony call.
+
 		string State [readonly]
 =

 			Contains the state of the current call.  The state
-- =

1.7.0.4


--===============1577429546122556101==--

