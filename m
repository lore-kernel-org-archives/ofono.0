Content-Type: multipart/mixed; boundary="===============8337360030489985632=="
MIME-Version: 1.0
From: Nishanth V <nishanth.v@intel.com>
Subject: [PATCH] rilmodem: netmon fix missing notify for g_ril_send
Date: Mon, 11 Sep 2017 11:45:10 +0530
Message-ID: <1505110510-25293-1-git-send-email-nishanth.v@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8337360030489985632==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/rilmodem/netmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rilmodem/netmon.c b/drivers/rilmodem/netmon.c
index a1e5f6c..709997c 100644
--- a/drivers/rilmodem/netmon.c
+++ b/drivers/rilmodem/netmon.c
@@ -296,7 +296,7 @@ static void ril_netmon_request_update(struct ofono_netm=
on *netmon,
 	struct cb_data *cbd =3D cb_data_new(cb, data, nmd);
 =

 	if (g_ril_send(nmd->ril, RIL_REQUEST_GET_CELL_INFO_LIST, NULL,
-			ril_netmon_update_cb, cbd, NULL) > 0)
+			ril_netmon_update_cb, cbd, g_free) > 0)
 		return;
 =

 	g_free(cbd);
-- =

1.9.1


--===============8337360030489985632==--

