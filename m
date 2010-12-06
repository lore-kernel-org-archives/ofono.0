Content-Type: multipart/mixed; boundary="===============0607054201300822793=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 10/14] include: add cnap_query callback
Date: Mon, 06 Dec 2010 18:12:38 -0200
Message-ID: <1291666362-19128-10-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1291666362-19128-9-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0607054201300822793==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/call-settings.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/call-settings.h b/include/call-settings.h
index 77e0440..c1ff668 100644
--- a/include/call-settings.h
+++ b/include/call-settings.h
@@ -46,6 +46,8 @@ struct ofono_call_settings_driver {
 	void (*remove)(struct ofono_call_settings *cs);
 	void (*clip_query)(struct ofono_call_settings *cs,
 				ofono_call_settings_status_cb_t cb, void *data);
+	void (*cnap_query)(struct ofono_call_settings *cs,
+				ofono_call_settings_status_cb_t cb, void *data);
 	void (*colp_query)(struct ofono_call_settings *cs,
 				ofono_call_settings_status_cb_t cb, void *data);
 	void (*clir_query)(struct ofono_call_settings *cs,
-- =

1.7.3.2


--===============0607054201300822793==--

