Content-Type: multipart/mixed; boundary="===============2641962994801534138=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH] gprs: Fix release cid in gprs_deactive_for_remove
Date: Mon, 09 Aug 2010 17:28:11 +0800
Message-ID: <1281346091-24758-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2641962994801534138==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Similiar to pri_deactive_callback, we should release the context id in
gprs_deactive_for_remove() as well.
---
 src/gprs.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 8d807dd..2c5bb4e 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1262,6 +1262,9 @@ static void gprs_deactivate_for_remove(const struct o=
fono_error *error,
 		return;
 	}
 =

+	gprs_cid_release(gprs, ctx->context.cid);
+	ctx->context.cid =3D 0;
+
 	if (gprs->settings) {
 		g_key_file_remove_group(gprs->settings, ctx->key, NULL);
 		storage_sync(gprs->imsi, SETTINGS_STORE, gprs->settings);
-- =

1.7.0.4


--===============2641962994801534138==--

