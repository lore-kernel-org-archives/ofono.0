Content-Type: multipart/mixed; boundary="===============8674598112905483059=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] doc: Fix wording.
Date: Tue, 28 Dec 2010 10:17:59 +0100
Message-ID: <1293527879-3369-6-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1293527879-3369-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8674598112905483059==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/sim-api.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/doc/sim-api.txt b/doc/sim-api.txt
index d4d2b1b..89c321e 100644
--- a/doc/sim-api.txt
+++ b/doc/sim-api.txt
@@ -44,7 +44,7 @@ Methods		dict GetProperties()
 =

 			Obtain the icon given by id.  Only ids greater than 1
 			are valid.  XPM format is currently used to return the
-			icon format.
+			icon data.
 =

 Signals		PropertyChanged(string name, variant value)
 =

-- =

1.7.1.86.g0e460.dirty


--===============8674598112905483059==--

