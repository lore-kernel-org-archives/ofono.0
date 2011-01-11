Content-Type: multipart/mixed; boundary="===============4261033239699262326=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 06/11] Update documentation for GPRS technology
Date: Tue, 11 Jan 2011 16:08:34 +0200
Message-ID: <1294754919-9687-6-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <1294754919-9687-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4261033239699262326==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/connman-api.txt |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/doc/connman-api.txt b/doc/connman-api.txt
index 22e02e5..9e7db3b 100644
--- a/doc/connman-api.txt
+++ b/doc/connman-api.txt
@@ -77,6 +77,16 @@ Properties	boolean Attached [readonly]
 			be available, e.g. receiving SMS over packet radio
 			or network initiated PDP activation.
 =

+		string Technology [readonly, optional]
+
+			Contains the data technology as reported by the
+			GPRS service registration (if known).
+
+			Possible values are:
+			"gsm", "edge", "umts", "hsdpa", "hsupa",
+			"hspa" (HSDPA and HSUPA at the same time) and
+			"lte"
+
 		boolean Suspended [readonly, optional]
 =

 			Contains whether the GPRS service is suspended.
-- =

1.7.1


--===============4261033239699262326==--

