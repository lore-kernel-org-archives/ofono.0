Content-Type: multipart/mixed; boundary="===============9049526815043059319=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 1/1] Set MNC length to 2 if EFad doesn't specify it
Date: Thu, 13 Sep 2012 08:44:19 +0000
Message-ID: <1347525847-2991-1-git-send-email-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9049526815043059319==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Byte 4 of the EFAD structure, which specifies the MNC length, is optional.
If this byte is not present, then there is no way to determine the length
of the MNC.  As the, by far, most common length is 2, we might as well
default to this value.

This patch changes the ofono_error to a warning as it's not really an
error that we're encountering, but the user should nonetheless be given
a heads-up that something might not work as expected.

Signed-off-by: Jonas Bonn <jonas@southpole.se>
---
 src/sim.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/sim.c b/src/sim.c
index 4384eb0..f6109c6 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1760,7 +1760,9 @@ static void sim_ad_read_cb(int ok, int length, int re=
cord,
 		return;
 =

 	if (length < 4) {
-		ofono_error("EFad should contain@least four bytes");
+		ofono_warn("EFad does not specify (optional) MNC length"
+			   ", defaulting to 2");
+		sim->mnc_length =3D 2;
 		return;
 	}
 =

-- =

1.7.9.5


--===============9049526815043059319==--

