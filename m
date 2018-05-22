Content-Type: multipart/mixed; boundary="===============2710030665966298094=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH] plugins: fixed crash in udevng
Date: Tue, 22 May 2018 13:35:49 -0700
Message-ID: <20180522203549.6755-1-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2710030665966298094==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The return value from ofono_modem_register was not being checked. If this f=
ails
the modem object is not setup and causes a crash. This was specifically seen
when using the mbim driver without having configured with mbim support.

Now the modem object gets destroyed properly if the modem registration fail=
s.
---
 plugins/udevng.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index cd56fd56..f4bf61cf 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1802,7 +1802,11 @@ static gboolean create_modem(gpointer key, gpointer =
value, gpointer user_data)
 		if (driver_list[i].setup(modem) =3D=3D TRUE) {
 			ofono_modem_set_string(modem->modem, "SystemPath",
 								syspath);
-			ofono_modem_register(modem->modem);
+			if (ofono_modem_register(modem->modem) < 0) {
+				DBG("could not register modem '%s'", modem->driver);
+				return TRUE;
+			}
+
 			return FALSE;
 		}
 	}
-- =

2.17.0


--===============2710030665966298094==--

