Content-Type: multipart/mixed; boundary="===============0960114240899317803=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v4 10/12] devinfo: avoid crash if query_model not supported
Date: Fri, 21 Oct 2011 18:51:35 +0200
Message-ID: <1319215897-6310-11-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1319215897-6310-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0960114240899317803==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 52b9714..344a2a6 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -1398,6 +1398,7 @@ static void query_model(struct ofono_devinfo *info)
 	if (info->driver->query_model =3D=3D NULL) {
 		/* If model is not supported, don't bother querying revision */
 		query_serial(info);
+		return;
 	}
 =

 	info->driver->query_model(info, query_model_cb, info);
-- =

1.7.6.4


--===============0960114240899317803==--

