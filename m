Content-Type: multipart/mixed; boundary="===============8189052319008764077=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 2/3] doc: Add description for ResetContexts method
Date: Thu, 14 May 2015 18:39:09 +0200
Message-ID: <1431621550-25131-3-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1431621550-25131-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8189052319008764077==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/connman-api.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/doc/connman-api.txt b/doc/connman-api.txt
index 8f72087..1ce1d61 100644
--- a/doc/connman-api.txt
+++ b/doc/connman-api.txt
@@ -60,6 +60,16 @@ Methods		dict GetProperties()
 					 [service].Error.NotFound
 					 [service].Error.Failed
 =

+		void ResetContexts()
+
+			Removes all contexts and re-provisions from the APN
+			database. Contexts must all be deactivated for this
+			method to work, and the atom must not be powered.
+
+			Possible Errors: [service].Error.InProgress
+					 [service].Error.InvalidArguments
+					 [service].Error.NotAllowed
+
 Signals		PropertyChanged(string property, variant value)
 =

 			This signal indicates a changed value of the given
-- =

2.1.4


--===============8189052319008764077==--

