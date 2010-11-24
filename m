Content-Type: multipart/mixed; boundary="===============2703389173343567374=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] call-forwarding: skip property change data and fax
Date: Wed, 24 Nov 2010 01:57:33 -0800
Message-ID: <1290592653-21828-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1290592653-21828-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2703389173343567374==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 715ce02..ce03c40 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -285,6 +285,13 @@ static void set_new_cond_list(struct ofono_call_forwar=
ding *cf,
 	for (o =3D old; o; o =3D o->next) {
 		oc =3D o->data;
 =

+		/*
+		 * For now we only support Voice, although Fax & all Data
+		 * basic services are applicable as well.
+		 */
+		if (oc->cls > BEARER_CLASS_VOICE)
+			continue;
+
 		snprintf(attr, sizeof(attr), "%s%s",
 			bearer_class_to_string(oc->cls), cf_type_lut[type]);
 =

-- =

1.7.0.4


--===============2703389173343567374==--

