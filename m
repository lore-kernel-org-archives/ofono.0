Content-Type: multipart/mixed; boundary="===============1409688396638294659=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 1/4] stk-api.txt: Introduce a new API to display abortable
 information
Date: Mon, 28 Mar 2011 18:32:29 +0200
Message-ID: <1301329952-10152-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1409688396638294659==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/stk-api.txt |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/doc/stk-api.txt b/doc/stk-api.txt
index f8a115e..fc69bb9 100644
--- a/doc/stk-api.txt
+++ b/doc/stk-api.txt
@@ -252,6 +252,7 @@ Methods		byte RequestSelection(string title, byte icon_=
id,
 			Possible Errors: [service].Error.SimToolkit.EndSession
 =

 		void DisplayActionInformation(string text, byte icon_id)
+						[noreply]
 =

 			Supplies a text string and/or icon concerning the
 			current activity in the terminal and UICC.  The
@@ -267,6 +268,16 @@ Methods		byte RequestSelection(string title, byte icon=
_id,
 			confirmation message to oFono and then should open
 			the launch browser with the given url.
 =

+		void DisplayAbortableActionInfo(string text, byte icon_id)
+
+			Supplies a text string and/or icon concerning the
+			current activity in the terminal and UICC. The
+			text should be displayed to the user on screen
+			until the call is canceled using Cancel() or until the
+			user decides to end the session.
+
+			Possible Errors: [service].Error.SimToolkit.EndSession
+
 		void Cancel() [noreply]
 =

 			Asks the agent to cancel any ongoing operation in
-- =

1.7.1


--===============1409688396638294659==--

