Content-Type: multipart/mixed; boundary="===============0572962920818229179=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: [PATCH 2/3] rilmodem: fix call_barring_query_cb
Date: Tue, 15 Dec 2015 11:34:34 -0500
Message-ID: <1450197275-5463-2-git-send-email-espy@canonical.com>
In-Reply-To: <1450197275-5463-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0572962920818229179==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The return value from a RIL_REQUEST_GET_FACILITY_LOCK
is the TS 27.007 service class bit vector of services
for the specified barring facility.  The value canf be
zero, which indicates "disabled for all".
---
 drivers/rilmodem/call-barring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rilmodem/call-barring.c b/drivers/rilmodem/call-barrin=
g.c
index 719bbe1..eb6e7c4 100644
--- a/drivers/rilmodem/call-barring.c
+++ b/drivers/rilmodem/call-barring.c
@@ -67,7 +67,7 @@ static void ril_call_barring_query_cb(struct ril_msg *mes=
sage,
 =

 	bearer_class =3D parcel_r_int32(&rilp);
 =

-	if (bearer_class < 1 || rilp.malformed)
+	if (bearer_class < 0 || rilp.malformed)
 		goto error;
 =

 	g_ril_append_print_buf(bd->ril, "{%d}", bearer_class);
-- =

2.1.4


--===============0572962920818229179==--

