Content-Type: multipart/mixed; boundary="===============4146668807023978537=="
MIME-Version: 1.0
From: philippedeswert@gmail.com
Subject: [PATCH 4/8] gprs.c: Add ofono_gprs_get_netreg function
Date: Fri, 15 Feb 2019 14:11:38 +0200
Message-ID: <20190215121142.28163-5-philippedeswert@gmail.com>
In-Reply-To: <20190215121142.28163-1-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4146668807023978537==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Tommi Rekosuo <tommi.rekosuo@treon.fi>

Add function to get registration technology.
---
 src/gprs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/gprs.c b/src/gprs.c
index 3dce001b..f1146d06 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -3392,3 +3392,8 @@ void *ofono_gprs_get_data(struct ofono_gprs *gprs)
 {
 	return gprs->driver_data;
 }
+
+struct ofono_netreg *ofono_gprs_get_netreg(struct ofono_gprs *gprs)
+{
+	return gprs->netreg;
+}
-- =

2.20.1


--===============4146668807023978537==--

