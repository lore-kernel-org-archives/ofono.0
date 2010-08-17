Content-Type: multipart/mixed; boundary="===============4389467582877675775=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] stk: Update agent_called with GetInkey and GetInput support.
Date: Tue, 17 Aug 2010 17:37:02 +0200
Message-ID: <1282059423-28864-4-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1282059423-28864-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4389467582877675775==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 7d98f92..16cc906 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -424,6 +424,8 @@ static gboolean agent_called(struct ofono_stk *stk)
 	switch (stk->pending_cmd->type) {
 	case STK_COMMAND_TYPE_SELECT_ITEM:
 	case STK_COMMAND_TYPE_DISPLAY_TEXT:
+	case STK_COMMAND_TYPE_GET_INPUT:
+	case STK_COMMAND_TYPE_GET_INKEY:
 		return TRUE;
 	}
 =

-- =

1.7.1.86.g0e460.dirty


--===============4389467582877675775==--

