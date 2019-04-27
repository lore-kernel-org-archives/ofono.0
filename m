Content-Type: multipart/mixed; boundary="===============1525455523397531392=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH 2/2] network: debug log the network time on update
Date: Sat, 27 Apr 2019 16:16:49 +0200
Message-ID: <20190427141649.12587-2-lynxis@fe80.eu>
In-Reply-To: <20190427141649.12587-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1525455523397531392==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/network.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/network.c b/src/network.c
index 19e7e7824067..2824eae6c35e 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1407,6 +1407,11 @@ void ofono_netreg_time_notify(struct ofono_netreg *n=
etreg,
 	if (info =3D=3D NULL)
 		return;
 =

+	DBG("net time %d-%02d-%02d %02d:%02d:%02d utcoff %d dst %d",
+	    info->year, info->mon, info->mday,
+	    info->hour, info->min, info->sec,
+	    info->utcoff, info->dst);
+
 	__ofono_nettime_info_received(modem, info);
 }
 =

-- =

2.21.0


--===============1525455523397531392==--

