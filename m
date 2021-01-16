Content-Type: multipart/mixed; boundary="===============3635009650550202893=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v3 2/3] sim: validate IMS private identity
Date: Sat, 16 Jan 2021 22:21:06 +0300
Message-ID: <20210116192107.18568-3-geomatsi@gmail.com>
In-Reply-To: <20210116192107.18568-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3635009650550202893==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make sure that IMS private identity is a valid UTF8 string before
setting sim->impi field. Otherwise ofono may crash on dbus assert
when SIM properties are reported via org.ofono.SimManager interface.
---
 src/sim.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/sim.c b/src/sim.c
index 33e1245f..793ff64a 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1664,7 +1664,8 @@ static void impi_read_cb(int ok, int total_length, in=
t record,
 		return;
 	}
 =

-	sim->impi =3D g_strndup((const char *)data + 2, data[1]);
+	if (validate_utf8_tlv(data))
+		sim->impi =3D g_strndup((const char *)data + 2, data[1]);
 }
 =

 static void discover_apps_cb(const struct ofono_error *error,
--===============3635009650550202893==--

