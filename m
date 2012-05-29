Content-Type: multipart/mixed; boundary="===============1734255895205322935=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 1/6] common: Fix typos in error strings
Date: Tue, 29 May 2012 18:38:32 +0200
Message-ID: <1338309517-14808-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1338309517-14808-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1734255895205322935==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/common.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/src/common.c b/src/common.c
index 62f2c5d..50106ac 100644
--- a/src/common.c
+++ b/src/common.c
@@ -49,13 +49,13 @@ struct error_entry cms_errors[] =3D {
 	{ 10,	"Call barred" },
 	{ 21,	"Short message transfer rejected" },
 	{ 27,	"Destination out of service" },
-	{ 28,	"Unindentified subscriber" },
+	{ 28,	"Unidentified subscriber" },
 	{ 29,	"Facility rejected" },
 	{ 30,	"Unknown subscriber" },
 	{ 38,	"Network out of order" },
 	{ 41,	"Temporary failure" },
 	{ 42,	"Congestion" },
-	{ 47,	"Recources unavailable" },
+	{ 47,	"Resources unavailable" },
 	{ 50,	"Requested facility not subscribed" },
 	{ 69,	"Requested facility not implemented" },
 	{ 81,	"Invalid short message transfer reference value" },
@@ -65,8 +65,8 @@ struct error_entry cms_errors[] =3D {
 	{ 98,	"Message not compatible with short message protocol state" },
 	{ 99,	"Information element non-existent or not implemented" },
 	{ 111,	"Protocol error, unspecified" },
-	{ 127,	"Internetworking error, unspecified" },
-	{ 128,	"Telematic internetworking not supported" },
+	{ 127,	"Interworking error, unspecified" },
+	{ 128,	"Telematic interworking not supported" },
 	{ 129,	"Short message type 0 not supported" },
 	{ 130,	"Cannot replace short message" },
 	{ 143,	"Unspecified TP-PID error" },
@@ -89,7 +89,7 @@ struct error_entry cms_errors[] =3D {
 	{ 209,	"No SMS Storage capability in SIM" },
 	{ 210,	"Error in MS" },
 	{ 211,	"Memory capacity exceeded" },
-	{ 212,	"Sim application toolkit busy" },
+	{ 212,	"SIM application toolkit busy" },
 	{ 213,	"SIM data download error" },
 	{ 255,	"Unspecified error cause" },
 	{ 300,	"ME Failure" },
@@ -121,7 +121,7 @@ struct error_entry cms_errors[] =3D {
 struct error_entry cme_errors[] =3D {
 	{ 0,	"Phone failure" },
 	{ 1,	"No connection to phone" },
-	{ 2,	"Phone adapter link reserved" },
+	{ 2,	"Phone adaptor link reserved" },
 	{ 3,	"Operation not allowed" },
 	{ 4,	"Operation not supported" },
 	{ 5,	"PH_SIM PIN required" },
@@ -156,6 +156,7 @@ struct error_entry cme_errors[] =3D {
 	{ 46,	"Corporate personalization PIN required" },
 	{ 47,	"Corporate personalization PUK required" },
 	{ 48,	"PH-SIM PUK required" },
+	{ 50,	"Incorrect parameters" },
 	{ 100,	"Unknown error" },
 	{ 103,	"Illegal MS" },
 	{ 106,	"Illegal ME" },
@@ -204,14 +205,14 @@ struct error_entry ceer_errors[] =3D {
 	{ 38,	"Network out of order" },
 	{ 41,	"Temporary failure" },
 	{ 42,	"Switching equipment congestion" },
-	{ 43,	"Access information discared" },
+	{ 43,	"Access information discarded" },
 	{ 44,	"Requested circuit/channel not available" },
 	{ 47,	"Resource unavailable (unspecified)" },
 	{ 49,	"Quality of service unavailable" },
 	{ 50,	"Requested facility not subscribed" },
 	{ 55,	"Incoming calls barred within the CUG" },
 	{ 57,	"Bearer capability not authorized" },
-	{ 58,	"Bearar capability not presently available" },
+	{ 58,	"Bearer capability not presently available" },
 	{ 63,	"Service or option not available, unspecified" },
 	{ 65,	"Bearer service not implemented" },
 	{ 68,	"ACM equal to or greater than ACMmax" },
@@ -229,7 +230,7 @@ struct error_entry ceer_errors[] =3D {
 	{ 99,	"Information element non-existent or not implemented" },
 	{ 100,	"Conditional IE error" },
 	{ 101,	"Message not compatible with protocol state" },
-	{ 102,	"Recovery on timer expirty" },
+	{ 102,	"Recovery on timer expiry" },
 	{ 111,	"Protocol error, unspecified" },
 	{ 127,	"Interworking, unspecified" },
 };
-- =

1.7.9.5


--===============1734255895205322935==--

