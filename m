Content-Type: multipart/mixed; boundary="===============8324242244125554297=="
MIME-Version: 1.0
From: Tommi Kenakkala <tommi.kenakkala@tieto.com>
Subject: [PATCH 2/2] doc: Document ResetProperties method
Date: Thu, 19 Feb 2015 13:59:53 +0200
Message-ID: <1424347193-6828-3-git-send-email-tommi.kenakkala@tieto.com>
In-Reply-To: <1424347193-6828-1-git-send-email-tommi.kenakkala@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8324242244125554297==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Slava Monich <slava.monich@jolla.com>

---
 doc/connman-api.txt |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/connman-api.txt b/doc/connman-api.txt
index 8f72087..3861c9a 100644
--- a/doc/connman-api.txt
+++ b/doc/connman-api.txt
@@ -155,6 +155,15 @@ Methods		dict GetProperties()
 					 [service].Error.AttachInProgress
 					 [service].Error.NotImplemented
 =

+		void ResetProperties()
+			Resets all properties back to default.
+			Fails if there are no provisioning settings.
+			The context will be deactivated before any significant
+			property is updated.
+
+			Possible Errors: [service].Error.Failed
+					 [service].Error.NotAvailable
+
 Signals		PropertyChanged(string property, variant value)
 =

 			This signal indicates a changed value of the given
-- =

1.7.9.5


--===============8324242244125554297==--

