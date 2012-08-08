Content-Type: multipart/mixed; boundary="===============2255445269129277807=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCHv2 2/3] doc: Describe DBus method to set delivery-report
Date: Wed, 08 Aug 2012 15:21:45 +0200
Message-ID: <1344432106-23105-3-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1344432106-23105-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2255445269129277807==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/service-api.txt |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/doc/service-api.txt b/doc/service-api.txt
index 02396ff..25f2d0d 100644
--- a/doc/service-api.txt
+++ b/doc/service-api.txt
@@ -82,6 +82,12 @@ Methods		array{object,dict} GetMessages()

 			Possible Errors: [service].Error.InvalidArguments

+		void SetProperty(string name, variant value)
+
+			Changes the value of the specified property.
+
+			Possible Errors: [service].Error.InvalidArguments
+

 Signals		MessageAdded(object path, dict properties)

@@ -94,3 +100,10 @@ Signals		MessageAdded(object path, dict properties)
 			Signal that is sent when a message has been removed.
 			The object path is no longer accessible after this
 			signal and only emitted for reference.
+
+Properties	boolean UseDeliveryReports
+
+			This property controls whether MMS Status Reports,
+			sometimes better known as Delivery Reports are to be
+			used.  If enabled, all outgoing MMS messages will be
+			flagged to request a status report from the MMSC.
--
1.7.9.5


--===============2255445269129277807==--

