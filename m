Content-Type: multipart/mixed; boundary="===============6209381998049513260=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v3 1/4] include: Add ofono_voicecall_en_list_notify api
Date: Fri, 01 Apr 2011 07:29:33 -0700
Message-ID: <1301668176-19356-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1301668176-19356-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6209381998049513260==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/voicecall.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/voicecall.h b/include/voicecall.h
index 5e6da02..73eee26 100644
--- a/include/voicecall.h
+++ b/include/voicecall.h
@@ -140,6 +140,9 @@ struct ofono_voicecall_driver {
 			ofono_voicecall_cb_t cb, void *data);
 };
 =

+void ofono_voicecall_en_list_notify(struct ofono_voicecall *vc,
+					char **nw_en_list);
+
 void ofono_voicecall_notify(struct ofono_voicecall *vc,
 				const struct ofono_call *call);
 void ofono_voicecall_disconnected(struct ofono_voicecall *vc, int id,
-- =

1.7.0.4


--===============6209381998049513260==--

