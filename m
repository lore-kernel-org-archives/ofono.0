Content-Type: multipart/mixed; boundary="===============3329964611821112177=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 4/4] doc: Add Handsfree Audio Card "Connect" errors
Date: Wed, 20 Mar 2013 20:03:04 -0300
Message-ID: <1363820584-24513-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1363820584-24513-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3329964611821112177==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

---
 doc/handsfree-audio-api.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/handsfree-audio-api.txt b/doc/handsfree-audio-api.txt
index 6c3c8b5..89b5aab 100644
--- a/doc/handsfree-audio-api.txt
+++ b/doc/handsfree-audio-api.txt
@@ -70,6 +70,12 @@ Methods		dict GetProperties()
 			the audio connection could not be established, this
 			method will return an error.
 =

+			Possible Errors: [service].Error.InProgress
+					 [service].Error.Failed
+					 [service].Error.NotAvailable
+					 [service].Error.NotImplemented
+					 [service].Error.NotAllowed
+
 Signals		PropertyChanged(string name, variant value)
 =

 			This signal indicates a changed value of the given
-- =

1.8.1.5


--===============3329964611821112177==--

