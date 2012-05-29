Content-Type: multipart/mixed; boundary="===============0439227690925364912=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 6/6] Extend the list of ofono error types returned by the
 method initiate
Date: Tue, 29 May 2012 18:38:37 +0200
Message-ID: <1338309517-14808-7-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1338309517-14808-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0439227690925364912==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/supplementaryservices-api.txt |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/supplementaryservices-api.txt b/doc/supplementaryservices-=
api.txt
index e855ead..687a14e 100644
--- a/doc/supplementaryservices-api.txt
+++ b/doc/supplementaryservices-api.txt
@@ -27,6 +27,12 @@ Methods		string, variant Initiate(string command)
 					 [service].Error.NotImplemented
 					 [service].Error.InvalidArguments
 					 [service].Error.InvalidFormat
+					 [service].Error.NotSupported
+					 [service].Error.NotAllowed
+					 [service].Error.IncorrectPassword
+					 [service].Error.NotRegistered
+					 [service].Error.Timedout
+					 [service].Error.AccessDenied
 					 [service].Error.Failed
 =

 		string Respond(string reply)
-- =

1.7.9.5


--===============0439227690925364912==--

