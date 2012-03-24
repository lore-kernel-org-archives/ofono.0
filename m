Content-Type: multipart/mixed; boundary="===============1686961130250771687=="
MIME-Version: 1.0
From: devel@jlranta.com
Subject: [PATCH v2] huawei: fix AT^DDSETEX=2 timing
Date: Sat, 24 Mar 2012 04:06:01 +0200
Message-ID: <1332554761-30808-2-git-send-email-devel@jlranta.com>
In-Reply-To: <1332554761-30808-1-git-send-email-devel@jlranta.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1686961130250771687==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jarkko Lehtoranta <devel@jlranta.com>

Voice output serial port is enabled on some Huawei models (e.g. E169)
without problems, but for example on E173u-2 it is never enabled
during an incoming call. There might also be other Huawei models
having the same issue.

I traced the issue down to "^DDSETEX" AT command, which is used
to notify the device to start streaming audio. It seems that Ofono
sends this command too early on incoming calls. The command should
always be sent *after* the dial "D" or answer "A" command. The patch
fixes this behavior and afterwards voice will also work on E173u-2.

Signed-off-by: Jarkko Lehtoranta <devel@jlranta.com>
---
 drivers/huaweimodem/voicecall.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/huaweimodem/voicecall.c b/drivers/huaweimodem/voicecal=
l.c
index 1ea2613..3952b95 100644
--- a/drivers/huaweimodem/voicecall.c
+++ b/drivers/huaweimodem/voicecall.c
@@ -78,9 +78,6 @@ static struct ofono_call *create_call(struct ofono_voicec=
all *vc, int type,
 =

 	d->calls =3D g_slist_insert_sorted(d->calls, call, at_util_call_compare);
 =

-	g_at_chat_send(d->chat, "AT^DDSETEX=3D2", none_prefix,
-						NULL, NULL, NULL);
-
 	return call;
 }
 =

@@ -117,6 +114,7 @@ static void huawei_dial(struct ofono_voicecall *vc,
 				ofono_voicecall_cb_t cb, void *data)
 {
 	char buf[256];
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 =

 	if (ph->type =3D=3D 145)
 		snprintf(buf, sizeof(buf), "ATD+%s", ph->number);
@@ -137,12 +135,20 @@ static void huawei_dial(struct ofono_voicecall *vc,
 	strcat(buf, ";");
 =

 	huawei_template(vc, buf, cb, data);
+	=

+	g_at_chat_send(vd->chat, "AT^DDSETEX=3D2", none_prefix,
+						NULL, NULL, NULL);
 }
 =

 static void huawei_answer(struct ofono_voicecall *vc,
 				ofono_voicecall_cb_t cb, void *data)
 {
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	=

 	huawei_template(vc, "ATA", cb, data);
+	=

+	g_at_chat_send(vd->chat, "AT^DDSETEX=3D2", none_prefix,
+						NULL, NULL, NULL);
 }
 =

 static void huawei_hangup(struct ofono_voicecall *vc,
-- =

1.7.9.3


--===============1686961130250771687==--

