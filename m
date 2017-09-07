Content-Type: multipart/mixed; boundary="===============3734731810647944087=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH 3/6] qmimodem: add strength (in %) to the debug output
Date: Thu, 07 Sep 2017 22:22:57 +0200
Message-ID: <20170907202300.23952-3-lynxis@fe80.eu>
In-Reply-To: <20170907202300.23952-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3734731810647944087==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/network-registration.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/qmimodem/network-registration.c b/drivers/qmimodem/net=
work-registration.c
index 04de5a5b87f9..41caa414477b 100644
--- a/drivers/qmimodem/network-registration.c
+++ b/drivers/qmimodem/network-registration.c
@@ -450,10 +450,11 @@ static void event_notify(struct qmi_result *result, v=
oid *user_data)
         if (ss) {
 		int strength;
 =

-		DBG("signal with %d dBm on %d", ss->dbm, ss->rat);
-
 		strength =3D dbm_to_strength(ss->dbm);
 =

+		DBG("signal with %d%%(%d dBm) on %d",
+				strength, ss->dbm, ss->rat);
+
 		ofono_netreg_strength_notify(netreg, strength);
 	}
 =

-- =

2.14.1


--===============3734731810647944087==--

