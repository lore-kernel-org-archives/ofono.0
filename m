Content-Type: multipart/mixed; boundary="===============1500774134358503892=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v3 3/4] voicecall: network emergency number list support
Date: Fri, 01 Apr 2011 07:29:35 -0700
Message-ID: <1301668176-19356-4-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1301668176-19356-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1500774134358503892==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index d7d8424..42ff6dc 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2162,6 +2162,13 @@ check:
 	set_new_ecc(vc);
 }
 =

+void ofono_voicecall_en_list_notify(struct ofono_voicecall *vc,
+						char **nw_en_list)
+{
+	vc->new_en_list =3D nw_en_list;
+	set_new_ecc(vc);
+}
+
 int ofono_voicecall_driver_register(const struct ofono_voicecall_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
-- =

1.7.0.4


--===============1500774134358503892==--

