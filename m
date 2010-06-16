Content-Type: multipart/mixed; boundary="===============3633121351193631139=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/4] stk: Handle the More Time command as a nop.
Date: Wed, 16 Jun 2010 17:26:54 +0200
Message-ID: <1276702015-8711-3-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1276702015-8711-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3633121351193631139==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 1dd5b77..6138c8e 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -225,6 +225,15 @@ static void stk_command_handler_register(struct ofono_=
stk *stk,
 	stk->handlers[type] =3D handler;
 }
 =

+static gboolean handle_command_more_time(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	/* Do nothing */
+
+	return TRUE;
+}
+
 int ofono_stk_driver_register(const struct ofono_stk_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
@@ -295,6 +304,9 @@ struct ofono_stk *ofono_stk_create(struct ofono_modem *=
modem,
 		break;
 	}
 =

+	stk_command_handler_register(stk, STK_COMMAND_TYPE_MORE_TIME,
+					handle_command_more_time);
+
 	return stk;
 }
 =

-- =

1.7.1.86.g0e460.dirty


--===============3633121351193631139==--

