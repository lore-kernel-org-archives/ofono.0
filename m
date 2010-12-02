Content-Type: multipart/mixed; boundary="===============7043058101298743707=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 2/3] gprs: update documentation
Date: Thu, 02 Dec 2010 18:16:21 +0200
Message-ID: <1291306582-19024-3-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1291306582-19024-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7043058101298743707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/connman-api.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/doc/connman-api.txt b/doc/connman-api.txt
index 22e02e5..e53032c 100644
--- a/doc/connman-api.txt
+++ b/doc/connman-api.txt
@@ -142,6 +142,9 @@ Properties	boolean Active [readwrite]
 			Holds whether the context is activated.  This value
 			can be set to activate / deactivate the context.
 =

+			Activating a context will automatically trigger the
+			GPRS attach procedure if necessary.
+
 		string AccessPointName [readwrite]
 =

 			Holds the name of the access point.  This is
-- =

1.7.1


--===============7043058101298743707==--

