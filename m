Content-Type: multipart/mixed; boundary="===============2749897006034785326=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] Document Proxy-CSCF setting.
Date: Wed, 27 Oct 2010 17:54:41 +0300
Message-ID: <1288191281-16360-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2749897006034785326==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Proxy-CSCF is a SIP proxy for IMS connections.
---
 doc/connman-api.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/doc/connman-api.txt b/doc/connman-api.txt
index dc94a89..872589e 100644
--- a/doc/connman-api.txt
+++ b/doc/connman-api.txt
@@ -212,6 +212,11 @@ Properties	boolean Active [readwrite]
 =

 				Holds the gateway IP for this connection.
 =

+			array{string} ProxyCSCF [readonly, optional]
+
+				Holds the list of IMS P-CSCF servers for
+				this connection.
+
 		string MessageProxy [readwrite, MMS only]
 =

 			Holds the MMS Proxy setting.
-- =

1.7.1


--===============2749897006034785326==--

