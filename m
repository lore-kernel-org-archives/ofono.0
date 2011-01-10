Content-Type: multipart/mixed; boundary="===============3177665304150080592=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC 4/4] doc: Describe LaunchBrowser method
Date: Mon, 10 Jan 2011 11:43:43 +0200
Message-ID: <1294652623-17287-5-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294652623-17287-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3177665304150080592==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/stk-api.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/doc/stk-api.txt b/doc/stk-api.txt
index 425ee23..347e39d 100644
--- a/doc/stk-api.txt
+++ b/doc/stk-api.txt
@@ -257,6 +257,14 @@ Methods		byte RequestSelection(string title, byte icon=
_id,
 			until the call is canceled using Cancel().  This
 			method should not return.
 =

+		boolean LaunchBrowser() (string information, byte icon_id,
+						string url)
+
+			Asks the agent to request user to confirm launch
+			browser. If confirmed, then the agent should send
+			confirmation message to oFono and then should open
+			the launch browser with the given url.
+
 		void Cancel() [noreply]
 =

 			Asks the agent to cancel any ongoing operation in
-- =

1.7.0.4


--===============3177665304150080592==--

