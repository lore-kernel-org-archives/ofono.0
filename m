Content-Type: multipart/mixed; boundary="===============5947065422325398435=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/8] stk: Handle the More Time command as a nop.
Date: Tue, 22 Jun 2010 13:20:46 +0200
Message-ID: <1277205651-29369-3-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1277205651-29369-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5947065422325398435==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 0d7fc33..e3f6253 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -229,6 +229,15 @@ static gboolean stk_command_handler_register(struct of=
ono_stk *stk,
 	return TRUE;
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
@@ -299,6 +308,9 @@ struct ofono_stk *ofono_stk_create(struct ofono_modem *=
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


--===============5947065422325398435==--

