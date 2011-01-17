Content-Type: multipart/mixed; boundary="===============2640416001643262908=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] sim: fix issue with sizeof call
Date: Mon, 17 Jan 2011 17:55:48 +0200
Message-ID: <1295279748-20005-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2640416001643262908==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In some compilers, sizeof the functional argument is
not returning the actual sizeof the argument.
---
 src/sim.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index d627647..6ffff2e 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -423,7 +423,7 @@ static void sim_pin_retries_query_cb(const struct ofono=
_error *error,
 		return;
 	}
 =

-	if (!memcmp(retries, sim->pin_retries, sizeof(retries)))
+	if (!memcmp(retries, sim->pin_retries, sizeof(sim->pin_retries)))
 		return;
 =

 	memcpy(sim->pin_retries, retries, sizeof(sim->pin_retries));
-- =

1.7.0.4


--===============2640416001643262908==--

