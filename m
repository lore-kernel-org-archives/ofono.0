Content-Type: multipart/mixed; boundary="===============1006139319267992628=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] atmodem: Fix use after free in sim_state_cb
Date: Thu, 05 Oct 2017 18:36:23 +0300
Message-ID: <1507217783-13414-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1006139319267992628==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

=3D=3D2941=3D=3D Invalid read of size 4
=3D=3D2941=3D=3D    at 0x69338: sim_state_cb (sim.c:1301)
=3D=3D2941=3D=3D    by 0x71DCB: cpin_check_cb (atutil.c:567)
=3D=3D2941=3D=3D    by 0xA602B: at_chat_finish_command (gatchat.c:459)
=3D=3D2941=3D=3D    by 0xA6277: at_chat_handle_command_response (gatchat.c:=
521)
=3D=3D2941=3D=3D    by 0xA6587: have_line (gatchat.c:600)
=3D=3D2941=3D=3D    by 0xA6BB7: new_bytes (gatchat.c:759)
=3D=3D2941=3D=3D    by 0xAAFAF: received_data (gatio.c:124)
=3D=3D2941=3D=3D    by 0x4AF606F: g_main_dispatch (gmain.c:3154)
=3D=3D2941=3D=3D    by 0x4AF606F: g_main_context_dispatch (gmain.c:3769)
=3D=3D2941=3D=3D    by 0x4AF658F: g_main_loop_run (gmain.c:4034)
=3D=3D2941=3D=3D    by 0xBDDBB: main (main.c:261)
=3D=3D2941=3D=3D  Address 0x519c344 is 4 bytes inside a block of size 12 fr=
ee'd
=3D=3D2941=3D=3D    at 0x4840B28: free (vg_replace_malloc.c:530)
=3D=3D2941=3D=3D    by 0x71F33: at_util_sim_state_query_free (atutil.c:613)
=3D=3D2941=3D=3D    by 0x6930B: sim_state_cb (sim.c:1297)
=3D=3D2941=3D=3D    by 0x71DCB: cpin_check_cb (atutil.c:567)
=3D=3D2941=3D=3D    by 0xA602B: at_chat_finish_command (gatchat.c:459)
=3D=3D2941=3D=3D    by 0xA6277: at_chat_handle_command_response (gatchat.c:=
521)
=3D=3D2941=3D=3D    by 0xA6587: have_line (gatchat.c:600)
=3D=3D2941=3D=3D    by 0xA6BB7: new_bytes (gatchat.c:759)
=3D=3D2941=3D=3D    by 0xAAFAF: received_data (gatio.c:124)
=3D=3D2941=3D=3D    by 0x4AF606F: g_main_dispatch (gmain.c:3154)
=3D=3D2941=3D=3D    by 0x4AF606F: g_main_context_dispatch (gmain.c:3769)
=3D=3D2941=3D=3D    by 0x4AF658F: g_main_loop_run (gmain.c:4034)
=3D=3D2941=3D=3D    by 0xBDDBB: main (main.c:261)
---
 drivers/atmodem/sim.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 7c33c22..6395a04 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -1293,14 +1293,15 @@ static void sim_state_cb(gboolean present, gpointer=
 user_data)
 	struct cb_data *cbd =3D user_data;
 	struct sim_data *sd =3D cbd->user;
 	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	void *data =3D cbd->data;
 =

 	at_util_sim_state_query_free(sd->sim_state_query);
 	sd->sim_state_query =3D NULL;
 =

 	if (present =3D=3D 1)
-		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+		CALLBACK_WITH_SUCCESS(cb, data);
 	else
-		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		CALLBACK_WITH_FAILURE(cb, data);
 }
 =

 static void at_pin_send_cb(gboolean ok, GAtResult *result,
-- =

1.9.1


--===============1006139319267992628==--

