Content-Type: multipart/mixed; boundary="===============0714149700079593516=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH] doc: Complete possible errors
Date: Thu, 24 Mar 2011 17:42:49 +0100
Message-ID: <1300984969-4376-1-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0714149700079593516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/stk-api.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/doc/stk-api.txt b/doc/stk-api.txt
index 529c734..f8a115e 100644
--- a/doc/stk-api.txt
+++ b/doc/stk-api.txt
@@ -96,6 +96,7 @@ Methods		byte RequestSelection(string title, byte icon_id,
 			an error given below.
 =

 			Possible Errors: [service].Error.SimToolkit.GoBack
+					 [service].Error.SimToolkit.EndSession
 =

 			Implementation notes:
 =

@@ -111,6 +112,7 @@ Methods		byte RequestSelection(string title, byte icon_=
id,
 			cleared prior to the display of this text.
 =

 			Possible Errors: [service].Error.SimToolkit.GoBack
+					 [service].Error.SimToolkit.EndSession
 					 [service].Error.SimToolkit.Busy
 =

 			Implementation notes:
@@ -154,6 +156,7 @@ Methods		byte RequestSelection(string title, byte icon_=
id,
 			should be opaque.
 =

 			Possible Errors: [service].Error.SimToolkit.GoBack
+					 [service].Error.SimToolkit.EndSession
 =

 			Implementation notes:
 =

@@ -171,6 +174,7 @@ Methods		byte RequestSelection(string title, byte icon_=
id,
 			are expected.
 =

 			Possible Errors: [service].Error.SimToolkit.GoBack
+					 [service].Error.SimToolkit.EndSession
 =

 		string RequestKey(string alpha, byte icon_id)
 =

@@ -179,6 +183,7 @@ Methods		byte RequestSelection(string title, byte icon_=
id,
 			for the request.
 =

 			Possible Errors: [service].Error.SimToolkit.GoBack
+					 [service].Error.SimToolkit.EndSession
 =

 		string RequestDigit(string alpha, byte icon_id)
 =

@@ -186,12 +191,14 @@ Methods		byte RequestSelection(string title, byte ico=
n_id,
 			expected.
 =

 			Possible Errors: [service].Error.SimToolkit.GoBack
+					 [service].Error.SimToolkit.EndSession
 =

 		boolean RequestConfirmation(string alpha, byte icon_id)
 =

 			Asks the agent to get confirmation from the user.
 =

 			Possible Errors: [service].Error.SimToolkit.GoBack
+					 [service].Error.SimToolkit.EndSession
 =

 		boolean ConfirmCallSetup(string information, byte icon_id)
 =

-- =

1.7.1


--===============0714149700079593516==--

