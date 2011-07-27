Content-Type: multipart/mixed; boundary="===============0753545822840348276=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] huawei: add a debug info to help debugging.
Date: Wed, 27 Jul 2011 14:02:19 +0200
Message-ID: <1311768139-3558-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0753545822840348276==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/huawei.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index c1f1ae4..b915a85 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -652,6 +652,8 @@ static void huawei_post_online(struct ofono_modem *mode=
m)
 {
 	struct huawei_data *data =3D ofono_modem_get_data(modem);
 =

+	DBG("%p", modem);
+
 	if (data->sim_state !=3D HUAWEI_SIM_STATE_VALID &&
 			data->sim_state !=3D HUAWEI_SIM_STATE_INVALID_CS &&
 			data->sim_state !=3D HUAWEI_SIM_STATE_INVALID_PS) {
-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============0753545822840348276==--

