Content-Type: multipart/mixed; boundary="===============5780264238701023294=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH] call-volume.c: Register the call-volume interface just after
 the +CMUT query
Date: Thu, 16 Feb 2012 12:32:49 +0100
Message-ID: <1329391969-13810-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5780264238701023294==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With this change, the mute status and the volume level are initialised in t=
he
call-volume atom. This allows also to expose the call-volume interface even
if the command +CLVL is not supported as it is the case for IFX.
---
 drivers/atmodem/call-volume.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/atmodem/call-volume.c b/drivers/atmodem/call-volume.c
index e2535b1..4c32ba7 100644
--- a/drivers/atmodem/call-volume.c
+++ b/drivers/atmodem/call-volume.c
@@ -65,6 +65,7 @@ static void cmut_query(gboolean ok, GAtResult *result, gp=
ointer user_data)
 	if (g_at_result_iter_next_number(&iter, &muted) =3D=3D FALSE)
 		return;
 =

+	ofono_call_volume_register(cv);
 	ofono_call_volume_set_muted(cv, muted);
 }
 =

@@ -94,7 +95,6 @@ static void clvl_query(gboolean ok, GAtResult *result, gp=
ointer user_data)
 				(cvd->clvl_max - cvd->clvl_min);
 =

 	ofono_call_volume_set_speaker_volume(cv, percent);
-	ofono_call_volume_register(cv);
 }
 =

 static void clvl_range_query(gboolean ok, GAtResult *result, gpointer user=
_data)
-- =

1.7.1


--===============5780264238701023294==--

