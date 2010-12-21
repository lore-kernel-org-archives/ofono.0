Content-Type: multipart/mixed; boundary="===============3362036152761164028=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/2] doc: Describe DisplayActionInformation().
Date: Tue, 21 Dec 2010 10:34:44 +0100
Message-ID: <1292924084-6929-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1292924084-6929-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3362036152761164028==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/stk-api.txt |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/doc/stk-api.txt b/doc/stk-api.txt
index 79daee6..80d3ed6 100644
--- a/doc/stk-api.txt
+++ b/doc/stk-api.txt
@@ -249,12 +249,20 @@ Methods		byte RequestSelection(string title, byte ico=
n_id,
 =

 			Possible Errors: [service].Error.SimToolkit.EndSession
 =

+		void DisplayActionInformation(string text, byte icon_id)
+
+			Supplies a text string and/or icon concerning the
+			current activity in the terminal and UICC.  The
+			text should be displayed to the user on screen
+			until the call is canceled using Cancel().  This
+			method should not return.
+
 		void Cancel()
 =

 			Asks the agent to cancel any ongoing operation in
 			progress.  This is usually either because the agent
-			is taking too long to respond or the Sim Application
-			has terminated the session.
+			is taking too long to respond, the Sim Application
+			has terminated the session or a task has finished.
 =

 		void Release()
 =

-- =

1.7.1.86.g0e460.dirty


--===============3362036152761164028==--

