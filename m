Content-Type: multipart/mixed; boundary="===============2850044832239324456=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 2/6] stk-api.txt. Introduce the new API ConfirmOpenChannel
Date: Fri, 08 Apr 2011 18:33:27 +0200
Message-ID: <1302280411-20762-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2850044832239324456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/stk-api.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/doc/stk-api.txt b/doc/stk-api.txt
index 0bcc6b5..aaa9fba 100644
--- a/doc/stk-api.txt
+++ b/doc/stk-api.txt
@@ -278,6 +278,13 @@ Methods		byte RequestSelection(string title, byte icon=
_id,
 =

 			Possible Errors: [service].Error.SimToolkit.EndSession
 =

+		boolean ConfirmOpenChannel(string information, byte icon_id)
+
+			Asks the agent to request user to confirm the channel
+			set-up.
+
+			Possible Errors: [service].Error.SimToolkit.EndSession
+
 		void Cancel() [noreply]
 =

 			Asks the agent to cancel any ongoing operation in
-- =

1.7.1


--===============2850044832239324456==--

