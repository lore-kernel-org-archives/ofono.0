Content-Type: multipart/mixed; boundary="===============8218448807420877624=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v2 1/4] include: Add ofono_voicecall_en_list_notify api
Date: Mon, 28 Mar 2011 06:58:06 -0700
Message-ID: <1301320689-25201-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1301320689-25201-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8218448807420877624==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/voicecall.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/voicecall.h b/include/voicecall.h
index 5e6da02..477b226 100644
--- a/include/voicecall.h
+++ b/include/voicecall.h
@@ -140,6 +140,9 @@ struct ofono_voicecall_driver {
 			ofono_voicecall_cb_t cb, void *data);
 };
 =

+void ofono_voicecall_en_list_notify(struct ofono_voicecall *vc,
+					GSList *nw_en_list);
+
 void ofono_voicecall_notify(struct ofono_voicecall *vc,
 				const struct ofono_call *call);
 void ofono_voicecall_disconnected(struct ofono_voicecall *vc, int id,
-- =

1.7.0.4


--===============8218448807420877624==--

