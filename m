Content-Type: multipart/mixed; boundary="===============0472213197585057852=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [originated PATCH 1/2] doc/voicecall: add Originated property
Date: Mon, 06 Sep 2010 18:09:27 +0300
Message-ID: <1283785768-4509-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1283785768-4509-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0472213197585057852==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 doc/voicecall-api.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/doc/voicecall-api.txt b/doc/voicecall-api.txt
index f0ba316..97b112c 100644
--- a/doc/voicecall-api.txt
+++ b/doc/voicecall-api.txt
@@ -95,6 +95,12 @@ Properties	string LineIdentification [readonly]
 			Notifications if a call becomes part or leaves a
 			multipart call are sent.
 =

+		boolean Originated [readonly]
+
+			Indicates the direction of the call. This property
+			is true if the call is mobile originated (MO) or
+			false if the call is mobile terminated (MT).
+
 		string State [readonly]
 =

 			Contains the state of the current call.  The state
-- =

1.7.0.4


--===============0472213197585057852==--

