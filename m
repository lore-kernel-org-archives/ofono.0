Content-Type: multipart/mixed; boundary="===============4944097783956391465=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 1/2] gprs: fix memory leak
Date: Thu, 24 Mar 2011 14:32:23 +0200
Message-ID: <1300969944-20659-2-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1300969944-20659-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4944097783956391465==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 00f6d6d..f9e327a 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -865,6 +865,7 @@ static void pri_activate_callback(const struct ofono_er=
ror *error, void *data)
 				telephony_error_to_str(error));
 		__ofono_dbus_pending_reply(&ctx->pending,
 					__ofono_error_failed(ctx->pending));
+		context_settings_free(ctx->context_driver->settings);
 		release_context(ctx);
 		return;
 	}
@@ -1841,6 +1842,7 @@ static void gprs_deactivate_for_remove(const struct o=
fono_error *error,
 		return;
 	}
 =

+	pri_reset_context_settings(ctx);
 	release_context(ctx);
 =

 	if (gprs->settings) {
-- =

1.7.1


--===============4944097783956391465==--

