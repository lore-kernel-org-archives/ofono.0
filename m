Content-Type: multipart/mixed; boundary="===============2915255550114777413=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 3/4] doc: Update STK API regarding the new argument
 immediate_response
Date: Fri, 24 Aug 2012 16:28:24 +0200
Message-ID: <1345818505-17175-4-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1345818505-17175-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2915255550114777413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/stk-api.txt |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/doc/stk-api.txt b/doc/stk-api.txt
index 471e5d6..0d96246 100644
--- a/doc/stk-api.txt
+++ b/doc/stk-api.txt
@@ -170,8 +170,9 @@ Methods		byte RequestSelection(string title, byte icon_=
id,
 					string default, byte min, byte max,
 					boolean hide_typing)
 =

-			Same as GetInput but only digit characters (0-9, *#+)
-			are expected.
+			Same as RequestInput but only digit characters
+			(0-9, *#+) are expected. In hidden entry mode, "+" is
+			not allowed for user input.
 =

 			Possible Errors: [service].Error.SimToolkit.GoBack
 					 [service].Error.SimToolkit.EndSession
@@ -185,10 +186,14 @@ Methods		byte RequestSelection(string title, byte ico=
n_id,
 			Possible Errors: [service].Error.SimToolkit.GoBack
 					 [service].Error.SimToolkit.EndSession
 =

-		string RequestDigit(string alpha, byte icon_id)
+		string RequestDigit(string alpha, byte icon_id,
+					boolean immediate_response)
 =

 			Same as above, but only digits (0-9, *#+) are
-			expected.
+			expected. The parameter immediate_response indicates
+			that the entered digit shall not be displayed and the
+			response shall be sent immediately after the key press.
+			"+" is not allowed for user input in this mode.
 =

 			Possible Errors: [service].Error.SimToolkit.GoBack
 					 [service].Error.SimToolkit.EndSession
-- =

1.7.9.5


--===============2915255550114777413==--

