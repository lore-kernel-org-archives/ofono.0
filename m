Content-Type: multipart/mixed; boundary="===============1853885313780043163=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 1/4] doc: Add new STK Agent API to get digit response on
 single key press
Date: Tue, 28 Aug 2012 15:21:19 +0200
Message-ID: <1346160082-11077-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1346160082-11077-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1853885313780043163==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/stk-api.txt |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/stk-api.txt b/doc/stk-api.txt
index 471e5d6..6875354 100644
--- a/doc/stk-api.txt
+++ b/doc/stk-api.txt
@@ -193,6 +193,15 @@ Methods		byte RequestSelection(string title, byte icon=
_id,
 			Possible Errors: [service].Error.SimToolkit.GoBack
 					 [service].Error.SimToolkit.EndSession
 =

+		string RequestQuickDigit(string alpha, byte icon_id)
+
+			Same as above but the entered digit shall not be
+			displayed and the response shall be sent immediately
+			after the key press. "+" is not allowed for user input.
+
+			Possible Errors: [service].Error.SimToolkit.GoBack
+					 [service].Error.SimToolkit.EndSession		=

+
 		boolean RequestConfirmation(string alpha, byte icon_id)
 =

 			Asks the agent to get confirmation from the user.
-- =

1.7.9.5


--===============1853885313780043163==--

