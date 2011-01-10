Content-Type: multipart/mixed; boundary="===============2048374094825638367=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 05/10] Update documentation for GPRS technology
Date: Mon, 10 Jan 2011 15:15:20 +0200
Message-ID: <1294665325-11937-5-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <201101101515.04596.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2048374094825638367==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/connman-api.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/doc/connman-api.txt b/doc/connman-api.txt
index 22e02e5..b13efd1 100644
--- a/doc/connman-api.txt
+++ b/doc/connman-api.txt
@@ -77,6 +77,14 @@ Properties	boolean Attached [readonly]
 			be available, e.g. receiving SMS over packet radio
 			or network initiated PDP activation.
 =

+		string Technology [readonly, optional]
+
+			Contains the data technology as reported by the
+			GPRS service registration (if known).
+
+			Possible values are the same as for the Technology
+			property the NetworkRegistration object.
+
 		boolean Suspended [readonly, optional]
 =

 			Contains whether the GPRS service is suspended.
-- =

1.7.1


--===============2048374094825638367==--

