Content-Type: multipart/mixed; boundary="===============1182924240928039249=="
MIME-Version: 1.0
From: Sergio Checa Blanco <sergio.checa@oss.bmw-carit.de>
Subject: [PATCH] hfpmodem: Fix crash with more than two calls
Date: Fri, 27 Jun 2014 09:56:07 +0200
Message-ID: <1403855767-10561-1-git-send-email-sergio.checa@oss.bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1182924240928039249==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sergio Checa Blanco <sergio.checa@bmw-carit.de>

A periodic CLCC polling is started when there is an ongoing multiparty
call and a new call appears in the system. A simple way to reproduce
the crashing scenario is:

1. Place a call.
2. Place a second call.
3. Create a multiparty call with both calls.
4. Place a third call (incoming or outgoing does not matter).
5. Disconnect HFP from the modem.

Within the function ciev_callheld_notify, the AT+CLCC command is also
invoked, thus a new cyclic CLCC polling is started, and it overwrites
the timer resource identifier stored in voicecall_data.clcc_source.
This means that there are several timers doing the CLCC polling, but
only one of those is under control, i.e. it can be removed through its
source identifier, hence a timer source leak.

This has a fatal consequence when the HFP modem is disconnected. The
function hfp_voicecall_remove stops the timer that is under control
before freeing the voicecall_data struct. However there are other timers
that are still active and will execute its handler poll_clcc afterwards.
Inside poll_clcc the driver_data is accessed, which is already NULL.

A solution for this is to avoid starting a CLCC polling if there is
already one active, i.e. clcc_source is not 0. By doing this the
uncontrolled timers will not cycle forever.
---
 drivers/hfpmodem/voicecall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index f16282c..07e7824 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -295,7 +295,7 @@ static void clcc_poll_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 	 * we won't get indicator update if any of them is released by CHLD=3D1x.
 	 * So we have to poll it.
 	 */
-	if (num_active > 1 || num_held > 1)
+	if ((num_active > 1 || num_held > 1) && !vd->clcc_source)
 		vd->clcc_source =3D g_timeout_add(POLL_CLCC_INTERVAL, poll_clcc,
 							vc);
 }
-- =

2.0.0


--===============1182924240928039249==--

