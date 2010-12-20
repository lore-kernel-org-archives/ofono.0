Content-Type: multipart/mixed; boundary="===============4371619441772108105=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 1/2] huawei: cancel poll timeout when going to a valid state
Date: Mon, 20 Dec 2010 19:51:08 -0200
Message-ID: <1292881869-13246-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4371619441772108105==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/huawei.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 0c8d8c0..bff1343 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -205,6 +205,11 @@ static gboolean notify_sim_state(struct ofono_modem *m=
odem,
 	case HUAWEI_SIM_STATE_INVALID_CS:
 	case HUAWEI_SIM_STATE_INVALID_PS:
 	case HUAWEI_SIM_STATE_INVALID_PS_AND_CS:
+		if (data->sim_poll_timeout) {
+			g_source_remove(data->sim_poll_timeout);
+			data->sim_poll_timeout =3D 0;
+		}
+
 		/*
 		 * In the "warm start" case the modem skips
 		 * HUAWEI_SIM_STATE_INVALID_OR_LOCKED altogether, so need
-- =

1.7.3.4


--===============4371619441772108105==--

