Content-Type: multipart/mixed; boundary="===============2331498988834267048=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] sim: Set valid number length in empty EFmsisdn records.
Date: Mon, 20 Dec 2010 13:52:33 +0100
Message-ID: <1292849553-4823-3-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1292849553-4823-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2331498988834267048==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Valid number length range is 1 - 10 bytes, other values, such as 0xff,
could potentially crash external parsers.
---
 src/sim.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 9263e75..b98c4b2 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -437,6 +437,8 @@ static gboolean set_own_numbers(struct ofono_sim *sim,
 			new_numbers =3D new_numbers->next;
 		} else {
 			memset(efmsisdn, 0xff, sim->efmsisdn_length);
+			/* Set number length */
+			efmsisdn[sim->efmsisdn_length - 14] =3D 1;
 		}
 =

 		if (ofono_sim_write(req->sim, SIM_EFMSISDN_FILEID,
-- =

1.7.1.86.g0e460.dirty


--===============2331498988834267048==--

