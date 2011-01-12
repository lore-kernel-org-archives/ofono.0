Content-Type: multipart/mixed; boundary="===============8569013818493461542=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 01/16] smsutil: M15 coding style fix
Date: Wed, 12 Jan 2011 12:52:03 +0200
Message-ID: <1294829538-3893-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294829538-3893-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8569013818493461542==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsutil.c |    2 +-
 src/smsutil.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 5e1d233..3a54fe6 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -3902,7 +3902,7 @@ static inline gboolean cbs_is_update_newer(unsigned i=
nt n, unsigned int o)
 	return FALSE;
 }
 =

-struct cbs_assembly *cbs_assembly_new()
+struct cbs_assembly *cbs_assembly_new(void)
 {
 	return g_new0(struct cbs_assembly, 1);
 }
diff --git a/src/smsutil.h b/src/smsutil.h
index 4b6159f..dd65884 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -540,7 +540,7 @@ gboolean cbs_extract_app_port(const struct cbs *cbs, in=
t *dst, int *src,
 =

 char *cbs_decode_text(GSList *cbs_list, char *iso639_lang);
 =

-struct cbs_assembly *cbs_assembly_new();
+struct cbs_assembly *cbs_assembly_new(void);
 void cbs_assembly_free(struct cbs_assembly *assembly);
 GSList *cbs_assembly_add_page(struct cbs_assembly *assembly,
 				const struct cbs *cbs);
-- =

1.7.0.4


--===============8569013818493461542==--

