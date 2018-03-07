Content-Type: multipart/mixed; boundary="===============2867283638469986536=="
MIME-Version: 1.0
From: Philippe De Swert <philippedeswert@gmail.com>
Subject: [PATCH 1/1] doc: Fix documentation for HFP memory dialling
Date: Wed, 07 Mar 2018 23:18:14 +0200
Message-ID: <20180307211814.30527-2-philippedeswert@gmail.com>
In-Reply-To: <20180307211814.30527-1-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2867283638469986536==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Philippe De Swert <philippedeswert@gmail.com>
---
 doc/voicecallmanager-api.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/voicecallmanager-api.txt b/doc/voicecallmanager-api.txt
index 5c4ce11b..96492ced 100644
--- a/doc/voicecallmanager-api.txt
+++ b/doc/voicecallmanager-api.txt
@@ -69,10 +69,10 @@ Methods		dict GetProperties()
 					 [service].Error.NotImplemented
 					 [service].Error.Failed
 =

-		object DialMemory(string memory position, string hide_callerid)
+		object DialMemory(unsigned int memory position)
 =

 			Initiates a new outgoing call to the number in the given memory
-			position/favourite. For callerid see the Dial method.
+			position/favourite.
 =

 			Possible Errors: [service].Error.InProgress
 					 [service].Error.InvalidArguments
-- =

2.11.0


--===============2867283638469986536==--

