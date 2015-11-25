Content-Type: multipart/mixed; boundary="===============5764645875355403882=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: [PATCH] rilmodem: fix set_call_barring reply trace (mako)
Date: Tue, 24 Nov 2015 19:18:42 -0500
Message-ID: <1448410722-30592-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5764645875355403882==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This change restores the trace output for a reply to a
REQUEST_SET_FACILITY_LOCK used by the set function.
---
 drivers/rilmodem/call-barring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rilmodem/call-barring.c b/drivers/rilmodem/call-barrin=
g.c
index 70b0b56..719bbe1 100644
--- a/drivers/rilmodem/call-barring.c
+++ b/drivers/rilmodem/call-barring.c
@@ -119,7 +119,7 @@ static void ril_call_barring_set_cb(struct ril_msg *mes=
sage, gpointer user_data)
 	ofono_call_barring_set_cb_t cb =3D cbd->cb;
 	struct barring_data *bd =3D cbd->user;
 	struct parcel rilp;
-	int retries;
+	int retries =3D -1;
 =

 	if (message->error !=3D RIL_E_SUCCESS)
 		goto error;
@@ -138,10 +138,10 @@ static void ril_call_barring_set_cb(struct ril_msg *m=
essage, gpointer user_data)
 	if (rilp.malformed)
 		goto error;
 =

+done:
 	g_ril_append_print_buf(bd->ril, "{%d}", retries);
 	g_ril_print_response(bd->ril, message);
 =

-done:
 	CALLBACK_WITH_SUCCESS(cb, cbd->data);
 	return;
 =

-- =

2.1.4


--===============5764645875355403882==--

