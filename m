Content-Type: multipart/mixed; boundary="===============1268285842175763297=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 5/9] include: add method for querying cdip support
Date: Wed, 12 Jan 2011 09:27:43 -0200
Message-ID: <1294831667-7447-6-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1294831667-7447-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1268285842175763297==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/call-settings.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/call-settings.h b/include/call-settings.h
index c1ff668..55300ab 100644
--- a/include/call-settings.h
+++ b/include/call-settings.h
@@ -48,6 +48,8 @@ struct ofono_call_settings_driver {
 				ofono_call_settings_status_cb_t cb, void *data);
 	void (*cnap_query)(struct ofono_call_settings *cs,
 				ofono_call_settings_status_cb_t cb, void *data);
+	void (*cdip_query)(struct ofono_call_settings *cs,
+				ofono_call_settings_status_cb_t cb, void *data);
 	void (*colp_query)(struct ofono_call_settings *cs,
 				ofono_call_settings_status_cb_t cb, void *data);
 	void (*clir_query)(struct ofono_call_settings *cs,
-- =

1.7.3.5


--===============1268285842175763297==--

