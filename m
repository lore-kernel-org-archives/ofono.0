Content-Type: multipart/mixed; boundary="===============8525206825162711221=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 1/2] ctm: add ofono_ctm_get_modem interface
Date: Mon, 10 Jan 2011 17:54:59 +0200
Message-ID: <1294674900-10256-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294674900-10256-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8525206825162711221==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/ctm.h |    2 ++
 src/ctm.c     |    5 +++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/ctm.h b/include/ctm.h
index 5305469..71e3d61 100644
--- a/include/ctm.h
+++ b/include/ctm.h
@@ -59,6 +59,8 @@ void ofono_ctm_remove(struct ofono_ctm *ctm);
 void ofono_ctm_set_data(struct ofono_ctm *ctm, void *data);
 void *ofono_ctm_get_data(struct ofono_ctm *ctm);
 =

+struct ofono_modem *ofono_ctm_get_modem(struct ofono_ctm *ctm);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/ctm.c b/src/ctm.c
index 1df34c2..389bb8e 100644
--- a/src/ctm.c
+++ b/src/ctm.c
@@ -330,3 +330,8 @@ void *ofono_ctm_get_data(struct ofono_ctm *ctm)
 {
 	return ctm->driver_data;
 }
+
+struct ofono_modem *ofono_ctm_get_modem(struct ofono_ctm *ctm)
+{
+	return __ofono_atom_get_modem(ctm->atom);
+}
\ No newline at end of file
-- =

1.7.0.4


--===============8525206825162711221==--

