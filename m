Content-Type: multipart/mixed; boundary="===============2100954651839750649=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 2/9] gprs-context.h: add op for reading context config
Date: Thu, 17 Mar 2016 18:02:13 +0100
Message-ID: <1458234140-7936-3-git-send-email-dragos@endocode.com>
In-Reply-To: <1458234140-7936-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2100954651839750649==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will be implemented by a gprs-context driver to support
automatic context activation. The gprs atom will call the driver
to read the ip configuration without activating the context.
---
 include/gprs-context.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index 0090cc4..b792fc6 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -79,6 +79,9 @@ struct ofono_gprs_context_driver {
 					ofono_gprs_context_cb_t cb, void *data);
 	void (*detach_shutdown)(struct ofono_gprs_context *gc,
 					unsigned int id);
+	void (*read_settings)(struct ofono_gprs_context *gc,
+				const struct ofono_gprs_primary_context *ctx,
+				ofono_gprs_context_cb_t cb, void *data);
 };
 =

 void ofono_gprs_context_deactivated(struct ofono_gprs_context *gc,
-- =

2.5.0


--===============2100954651839750649==--

