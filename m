Content-Type: multipart/mixed; boundary="===============6828426870531197542=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] radio-settings: update doc with possible errors
Date: Tue, 23 Nov 2010 16:08:35 -0200
Message-ID: <1290535715-18955-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6828426870531197542==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When GetProperties() and SetProperty() are called, there are more errors
that might be returned. Add them in documentation.
---
 doc/radio-settings-api.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/doc/radio-settings-api.txt b/doc/radio-settings-api.txt
index ebf6138..e073d1d 100644
--- a/doc/radio-settings-api.txt
+++ b/doc/radio-settings-api.txt
@@ -11,6 +11,9 @@ Methods		dict GetProperties()
 			properties section for available properties.
 =

 			Possible Errors: [service].Error.InvalidArguments
+					 [service].Error.NotImplemented
+					 [service].Error.InProgress
+					 [service].Error.Failed
 =

 		void SetProperty(string name, variant value)
 =

@@ -22,6 +25,7 @@ Methods		dict GetProperties()
 			Possible Errors: [service].Error.InvalidArguments
 					 [service].Error.DoesNotExist
 					 [service].Error.InProgress
+					 [service].Error.Failed
 =

 Signals		PropertyChanged(string property, variant value)
 =

-- =

1.7.3.2


--===============6828426870531197542==--

