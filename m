Content-Type: multipart/mixed; boundary="===============5020337244239243090=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 15/15] doc: Add Handsfree Audio Card "Connect" errors
Date: Tue, 12 Mar 2013 09:42:13 -0300
Message-ID: <1363092133-1092-16-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1363092133-1092-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5020337244239243090==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/handsfree-audio-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/handsfree-audio-api.txt b/doc/handsfree-audio-api.txt
index 6c3c8b5..7d20925 100644
--- a/doc/handsfree-audio-api.txt
+++ b/doc/handsfree-audio-api.txt
@@ -70,6 +70,11 @@ Methods		dict GetProperties()
 			the audio connection could not be established, this
 			method will return an error.
 =

+			Possible Errors: [service].Error.InProgress
+					 [service].Error.Failed
+					 [service].Error.NotAvailable
+					 [service].Error.NotImplemented
+
 Signals		PropertyChanged(string name, variant value)
 =

 			This signal indicates a changed value of the given
-- =

1.7.11.7


--===============5020337244239243090==--

