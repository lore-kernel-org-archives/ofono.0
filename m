Content-Type: multipart/mixed; boundary="===============6721531413565584216=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/4] Fix possible memory leak on SIM reading error.
Date: Thu, 30 Jul 2009 10:05:32 +0200
Message-ID: <1248941132-13206-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6721531413565584216==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This would also stall the SIM op queue if there's a read error for a record
other than the first.  The other solution would be "goto next;" (keep
reading further records).
---
 src/sim.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index deab6bd..695744f 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -317,9 +317,7 @@ static void sim_op_retrieve_cb(const struct ofono_error=
 *error,
 	int fd;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		if (op->current =3D=3D 1)
-			sim_op_error(modem);
-
+		sim_op_error(modem);
 		return;
 	}
 =

-- =

1.6.1


--===============6721531413565584216==--

