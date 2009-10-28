Content-Type: multipart/mixed; boundary="===============6216986849318419057=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: [PATCH 3/3] Add voicecall driver for Handsfree profile update
Date: Wed, 28 Oct 2009 08:42:19 +0800
Message-ID: <0463F45F3606F4428ED35AC8C709F92E089B924EEE@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6216986849318419057==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

HFP voicecall driver uses AT+CIEV indicator to notify call status update
according to Bluetooth HFP spec v1.5. First version support single call, mu=
lti
call support will be ready soon.

---
 Makefile.am                  |    3 +-
 drivers/hfpmodem/hfpmodem.c  |    3 +
 drivers/hfpmodem/voicecall.c |  622 ++++++++++++++++++++++++++++++++++++++=
++++
 plugins/hfp.c                |    3 +
 4 files changed, 630 insertions(+), 1 deletions(-)
 create mode 100644 drivers/hfpmodem/voicecall.c

diff --git a/Makefile.am b/Makefile.am
index 8247f9d..8e56568 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -125,7 +125,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 builtin_modules +=3D hfpmodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
                        drivers/hfpmodem/hfpmodem.h \
-                       drivers/hfpmodem/hfpmodem.c
+                       drivers/hfpmodem/hfpmodem.c \
+                       drivers/hfpmodem/voicecall.c

 builtin_modules +=3D mbmmodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
diff --git a/drivers/hfpmodem/hfpmodem.c b/drivers/hfpmodem/hfpmodem.c
index 615acd3..03b5ea0 100644
--- a/drivers/hfpmodem/hfpmodem.c
+++ b/drivers/hfpmodem/hfpmodem.c
@@ -41,11 +41,14 @@

 static int hfpmodem_init(void)
 {
+       hfp_voicecall_init();
+
        return 0;
 }

 static void hfpmodem_exit(void)
 {
+       hfp_voicecall_exit();
 }

 OFONO_PLUGIN_DEFINE(hfpmodem, "Hands-Free Profile Driver", VERSION,
diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
new file mode 100644
index 0000000..c1e1eed
--- /dev/null
+++ b/drivers/hfpmodem/voicecall.c
@@ -0,0 +1,622 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/voicecall.h>
+#include <common.h>
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "hfpmodem.h"
+
+#define AG_CHLD_0 0x01
+#define AG_CHLD_1 0x02
+#define AG_CHLD_1x 0x04
+#define AG_CHLD_2 0x08
+#define AG_CHLD_2x 0x10
+#define AG_CHLD_3 0x20
+#define AG_CHLD_4 0x40
+
+static const char *none_prefix[] =3D { NULL };
+static const char *chld_prefix[] =3D { "+CHLD:", NULL };
+
+struct voicecall_data {
+       GAtChat *chat;
+       GSList *calls;
+       struct ofono_call *call;
+       gboolean mpty_call;
+       unsigned int ag_features;
+       unsigned int ag_mpty_features;
+       unsigned char cind_pos[HFP_INDICATOR_LAST];
+       int cind_val[HFP_INDICATOR_LAST];
+       unsigned int id_list;
+       unsigned int local_release;
+};
+
+struct release_id_req {
+       struct ofono_voicecall *vc;
+       ofono_voicecall_cb_t cb;
+       void *data;
+       int id;
+};
+
+struct change_state_req {
+       struct ofono_voicecall *vc;
+       ofono_voicecall_cb_t cb;
+       void *data;
+       int affected_types;
+};
+
+static unsigned int alloc_next_id(struct voicecall_data *d)
+{
+       unsigned int i;
+
+       for (i =3D 1; i < sizeof(d->id_list) * 8; i++) {
+               if (d->id_list & (0x1 << i))
+                       continue;
+
+               d->id_list |=3D (0x1 << i);
+               return i;
+       }
+
+       return 0;
+}
+
+static inline void release_id(struct voicecall_data *d, unsigned int id)
+{
+       d->id_list &=3D ~(0x1 << id);
+}
+
+static struct ofono_call *create_call(struct voicecall_data *d, int type,
+                                       int direction, int status,
+                                       const char *num, int num_type, int =
clip)
+{
+       struct ofono_call *call;
+
+       /* Generate a call structure for the waiting call */
+       call =3D g_try_new0(struct ofono_call, 1);
+
+       if (!call)
+               return NULL;
+
+       call->id =3D alloc_next_id(d);
+       call->type =3D type;
+       call->direction =3D direction;
+       call->status =3D status;
+
+       if (clip !=3D 2) {
+               strncpy(call->phone_number.number, num,
+                       OFONO_MAX_PHONE_NUMBER_LENGTH);
+               call->phone_number.type =3D num_type;
+       }
+
+       d->calls =3D g_slist_insert_sorted(d->calls, call, at_util_call_com=
pare);
+
+       call->clip_validity =3D clip;
+
+       if (d->call)
+               d->mpty_call =3D TRUE;
+
+       d->call =3D call;
+
+       return call;
+}
+
+static void generic_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+       struct change_state_req *req =3D user_data;
+       struct voicecall_data *vd =3D ofono_voicecall_get_data(req->vc);
+       struct ofono_error error;
+
+       dump_response("generic_cb", ok, result);
+       decode_at_error(&error, g_at_result_final_response(result));
+
+       if (ok && req->affected_types) {
+               GSList *l;
+               struct ofono_call *call;
+
+               for (l =3D vd->calls; l; l =3D l->next) {
+                       call =3D l->data;
+
+                       if (req->affected_types & (0x1 << call->status))
+                               vd->local_release |=3D
+                                       (0x1 << call->id);
+               }
+       }
+
+       req->cb(&error, req->data);
+}
+
+static void atd_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+       struct cb_data *cbd =3D user_data;
+       struct ofono_voicecall *vc =3D cbd->user;
+       struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+       ofono_voicecall_cb_t cb =3D cbd->cb;
+       GAtResultIter iter;
+       int type =3D 128;
+       int validity =3D 2;
+       struct ofono_error error;
+       struct ofono_call *call;
+
+       dump_response("atd_cb", ok, result);
+
+       decode_at_error(&error, g_at_result_final_response(result));
+
+       if (!ok)
+               goto out;
+
+       g_at_result_iter_init(&iter, result);
+
+       call =3D create_call(vd, 0, 0, CALL_STATUS_DIALING, NULL, type, val=
idity);
+
+       if (!call) {
+               ofono_error("Unable to allocate call, "
+                               "call tracking will fail!");
+               return;
+       }
+
+out:
+       cb(&error, cbd->data);
+}
+
+static void hfp_dial(struct ofono_voicecall *vc,
+                       const struct ofono_phone_number *ph,
+                       enum ofono_clir_option clir, enum ofono_cug_option =
cug,
+                       ofono_voicecall_cb_t cb, void *data)
+{
+       struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+       struct cb_data *cbd =3D cb_data_new(cb, data);
+       char buf[256];
+
+       if (!cbd)
+               goto error;
+
+       cbd->user =3D vc;
+       if (ph->type =3D=3D 145)
+               sprintf(buf, "ATD+%s", ph->number);
+       else
+               sprintf(buf, "ATD%s", ph->number);
+
+       switch (clir) {
+       case OFONO_CLIR_OPTION_INVOCATION:
+               strcat(buf, "I");
+               break;
+       case OFONO_CLIR_OPTION_SUPPRESSION:
+               strcat(buf, "i");
+               break;
+       default:
+               break;
+       }
+
+       switch (cug) {
+       case OFONO_CUG_OPTION_INVOCATION:
+               strcat(buf, "G");
+               break;
+       default:
+               break;
+       }
+
+       strcat(buf, ";");
+
+       if (g_at_chat_send(vd->chat, buf, none_prefix,
+                               atd_cb, cbd, g_free) > 0)
+               return;
+
+error:
+       if (cbd)
+               g_free(cbd);
+
+       CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void hfp_template(const char *cmd, struct ofono_voicecall *vc,
+                       GAtResultFunc result_cb, unsigned int affected_type=
s,
+                       ofono_voicecall_cb_t cb, void *data)
+{
+       struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+       struct change_state_req *req =3D g_try_new0(struct change_state_req=
, 1);
+
+       if (!req)
+               goto error;
+
+       req->vc =3D vc;
+       req->cb =3D cb;
+       req->data =3D data;
+       req->affected_types =3D affected_types;
+
+       if (g_at_chat_send(vd->chat, cmd, none_prefix,
+                               result_cb, req, g_free) > 0)
+               return;
+
+error:
+       if (req)
+               g_free(req);
+
+       CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void hfp_answer(struct ofono_voicecall *vc,
+                       ofono_voicecall_cb_t cb, void *data)
+{
+       hfp_template("ATA", vc, generic_cb, 0, cb, data);
+}
+
+static void hfp_hangup(struct ofono_voicecall *vc,
+                       ofono_voicecall_cb_t cb, void *data)
+{
+       /* Hangup all calls */
+       hfp_template("AT+CHUP", vc, generic_cb, 0x3f, cb, data);
+}
+
+static void release_id_cb(gboolean ok, GAtResult *result,
+                               gpointer user_data)
+{
+       struct release_id_req *req =3D user_data;
+       struct voicecall_data *vd =3D ofono_voicecall_get_data(req->vc);
+       struct ofono_error error;
+
+       dump_response("release_id_cb", ok, result);
+       decode_at_error(&error, g_at_result_final_response(result));
+
+       if (ok)
+               vd->local_release =3D 0x1 << req->id;
+
+       req->cb(&error, req->data);
+}
+
+static void hfp_release_specific(struct ofono_voicecall *vc, int id,
+                               ofono_voicecall_cb_t cb, void *data)
+{
+       struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+       struct release_id_req *req =3D g_try_new0(struct release_id_req, 1);
+
+       if (!req)
+               goto error;
+
+       req->vc =3D vc;
+       req->cb =3D cb;
+       req->data =3D data;
+       req->id =3D id;
+
+       if (vd->mpty_call =3D=3D FALSE)
+               g_at_chat_send(vd->chat, "AT+CHUP", none_prefix,
+                               release_id_cb, req, g_free);
+
+       return;
+
+error:
+       if (req)
+               g_free(req);
+
+       CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void ring_notify(GAtResult *result, gpointer user_data)
+{
+       struct ofono_voicecall *vc =3D user_data;
+       struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+       struct ofono_call *call;
+
+       dump_response("ring_notify", TRUE, result);
+
+       /* RING can repeat, ignore if we already have an incoming call */
+       if (g_slist_find_custom(vd->calls,
+                               GINT_TO_POINTER(CALL_STATUS_INCOMING),
+                               at_util_call_compare_by_status))
+               return;
+
+       /* ignore if we already have a waiting call */
+       if (g_slist_find_custom(vd->calls,
+                               GINT_TO_POINTER(CALL_STATUS_WAITING),
+                               at_util_call_compare_by_status))
+               return;
+
+       /* Generate an incoming call of voice type */
+       call =3D create_call(vd, 0, 1, CALL_STATUS_INCOMING, NULL, 128, 2);
+
+       if (!call) {
+               ofono_error("Couldn't create call, call management is fubar=
!");
+               return;
+       }
+}
+
+static void clip_notify(GAtResult *result, gpointer user_data)
+{
+       struct ofono_voicecall *vc =3D user_data;
+       struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+       GAtResultIter iter;
+       const char *num;
+       int type, validity;
+       GSList *l;
+       struct ofono_call *call;
+
+       dump_response("clip_notify", TRUE, result);
+
+       l =3D g_slist_find_custom(vd->calls,
+                               GINT_TO_POINTER(CALL_STATUS_INCOMING),
+                               at_util_call_compare_by_status);
+
+       if (l =3D=3D NULL) {
+               ofono_error("CLIP for unknown call");
+               return;
+       }
+
+       g_at_result_iter_init(&iter, result);
+
+       if (!g_at_result_iter_next(&iter, "+CLIP:"))
+               return;
+
+       if (!g_at_result_iter_next_string(&iter, &num))
+               return;
+
+       if (!g_at_result_iter_next_number(&iter, &type))
+               return;
+
+       if (strlen(num) > 0)
+               validity =3D 0;
+       else
+               validity =3D 2;
+
+       /* Skip subaddr, satype, alpha and validity */
+       g_at_result_iter_skip_next(&iter);
+       g_at_result_iter_skip_next(&iter);
+       g_at_result_iter_skip_next(&iter);
+       g_at_result_iter_skip_next(&iter);
+
+       ofono_debug("clip_notify: %s %d %d", num, type, validity);
+
+       call =3D l->data;
+
+       strncpy(call->phone_number.number, num,
+               OFONO_MAX_PHONE_NUMBER_LENGTH);
+       call->phone_number.number[OFONO_MAX_PHONE_NUMBER_LENGTH] =3D '\0';
+       call->phone_number.type =3D type;
+       call->clip_validity =3D validity;
+
+       ofono_voicecall_notify(vc, call);
+}
+
+static void release_call(struct ofono_voicecall *vc, struct ofono_call *ca=
ll)
+{
+       struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+       enum ofono_disconnect_reason reason;
+
+       if (call =3D=3D NULL)
+               return;
+
+       if (vd->local_release & (0x1 << call->id))
+               reason =3D OFONO_DISCONNECT_REASON_LOCAL_HANGUP;
+       else
+               reason =3D OFONO_DISCONNECT_REASON_REMOTE_HANGUP;
+
+       ofono_voicecall_disconnected(vc, call->id, reason, NULL);
+       release_id(vd, call->id);
+
+       if (vd->mpty_call =3D=3D FALSE)
+               vd->local_release =3D 0;
+
+       vd->calls =3D g_slist_remove(vd->calls, call);
+
+       if (call =3D=3D vd->call)
+               vd->call =3D NULL;
+
+       g_free(call);
+       call =3D NULL;
+}
+
+static void single_call_notify(struct ofono_voicecall *vc,
+                       struct ofono_call *call,
+                       unsigned int index, unsigned int value)
+{
+       struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+       int call_pos, callsetup_pos;
+
+       if (index =3D=3D vd->cind_pos[HFP_INDICATOR_CALL]) {
+               if (value =3D=3D 1) {
+                       call->status =3D CALL_STATUS_ACTIVE;
+                       ofono_voicecall_notify(vc, call);
+               } else if (value =3D=3D 0)
+                       release_call(vc, call);
+       } else if (index =3D=3D vd->cind_pos[HFP_INDICATOR_CALLSETUP]) {
+               if (value =3D=3D 3) {
+                       call->status =3D CALL_STATUS_ALERTING;
+                       ofono_voicecall_notify(vc, call);
+               } else if (value =3D=3D 0) {
+                       /* call=3D0 and callsetup=3D1: reject an incoming c=
all
+                        * call=3D0 and callsetup=3D2,3: interrupt an outgo=
ing call
+                        */
+                       call_pos =3D vd->cind_pos[HFP_INDICATOR_CALL];
+                       callsetup_pos =3D vd->cind_pos[HFP_INDICATOR_CALLSE=
TUP];
+
+                       if ((vd->cind_val[call_pos] =3D=3D 0) &&
+                                       (vd->cind_val[callsetup_pos] > 0))
+                               release_call(vc, call);
+               }
+       }
+
+       vd->cind_val[index] =3D value;
+}
+
+static void ciev_notify(GAtResult *result, gpointer user_data)
+{
+       struct ofono_voicecall *vc =3D user_data;
+       struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+       struct ofono_call *call =3D vd->call;
+       int index;
+       int value;
+       GAtResultIter iter;
+
+       g_at_result_iter_init(&iter, result);
+
+       if (!g_at_result_iter_next(&iter, "+CIEV:"))
+               return;
+
+       if (!g_at_result_iter_next_number(&iter, &index))
+               return;
+
+       if (!g_at_result_iter_next_number(&iter, &value))
+               return;
+
+       if ((index =3D=3D vd->cind_pos[HFP_INDICATOR_CALL]) ||
+               (index =3D=3D vd->cind_pos[HFP_INDICATOR_CALLSETUP]) ||
+               (index =3D=3D vd->cind_pos[HFP_INDICATOR_CALLHELD])) {
+               if (vd->mpty_call =3D=3D FALSE)
+                       single_call_notify(vc, call, index, value);
+       }
+}
+
+static void chld_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+       struct voicecall_data *vd =3D user_data;
+       unsigned int ag_mpty_feature =3D 0;
+       GAtResultIter iter;
+       const char *str;
+
+       if (!ok)
+               goto error;
+
+       g_at_result_iter_init(&iter, result);
+       if (!g_at_result_iter_next(&iter, "+CHLD:"))
+               goto error;
+
+       if (!g_at_result_iter_open_list(&iter))
+               goto error;
+
+       while (g_at_result_iter_next_unquoted_string(&iter, &str)) {
+               if (!strcmp(str, "0"))
+                       ag_mpty_feature |=3D AG_CHLD_0;
+               else if (!strcmp(str, "1"))
+                       ag_mpty_feature |=3D AG_CHLD_1;
+               else if (!strcmp(str, "1x"))
+                       ag_mpty_feature |=3D AG_CHLD_1x;
+               else if (!strcmp(str, "2"))
+                       ag_mpty_feature |=3D AG_CHLD_2;
+               else if (!strcmp(str, "2x"))
+                       ag_mpty_feature |=3D AG_CHLD_2x;
+               else if (!strcmp(str, "3"))
+                       ag_mpty_feature |=3D AG_CHLD_3;
+               else if (!strcmp(str, "4"))
+                       ag_mpty_feature |=3D AG_CHLD_4;
+       }
+
+       if (!g_at_result_iter_close_list(&iter))
+               goto error;
+
+       vd->ag_mpty_features =3D ag_mpty_feature;
+       return;
+
+error:
+       return;
+}
+
+static void hfp_voicecall_initialized(gboolean ok, GAtResult *result,
+                                       gpointer user_data)
+{
+       struct ofono_voicecall *vc =3D user_data;
+       struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+
+       ofono_debug("hfp_voicecall_init: registering to notifications");
+
+       g_at_chat_register(vd->chat, "RING", ring_notify, FALSE, vc, NULL);
+       g_at_chat_register(vd->chat, "+CLIP:", clip_notify, FALSE, vc, NULL=
);
+       g_at_chat_register(vd->chat, "+CIEV:", ciev_notify, FALSE, vc, NULL=
);
+
+       ofono_voicecall_register(vc);
+}
+
+static int hfp_voicecall_probe(struct ofono_voicecall *vc, unsigned int ve=
ndor,
+                               gpointer user_data)
+{
+       struct hfp_data *data =3D user_data;
+       struct voicecall_data *vd;
+
+       vd =3D g_new0(struct voicecall_data, 1);
+       vd->chat =3D data->chat;
+       vd->ag_features =3D data->ag_features;
+       vd->call =3D NULL;
+       vd->mpty_call =3D FALSE;
+       memcpy(vd->cind_pos, data->cind_pos, HFP_INDICATOR_LAST);
+       memcpy(vd->cind_val, data->cind_val, HFP_INDICATOR_LAST);
+
+       if (vd->ag_features & AG_FEATURE_3WAY)
+               g_at_chat_send(vd->chat, "AT+CHLD=3D?", chld_prefix,
+                       chld_cb, vd, NULL);
+
+       ofono_voicecall_set_data(vc, vd);
+
+       g_at_chat_send(vd->chat, "AT+CLIP=3D1", NULL, NULL, NULL, NULL);
+       g_at_chat_send(vd->chat, "AT+CCWA=3D1", NULL,
+                               hfp_voicecall_initialized, vc, NULL);
+       return 0;
+}
+
+static void hfp_voicecall_remove(struct ofono_voicecall *vc)
+{
+       struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+
+       g_slist_foreach(vd->calls, (GFunc) g_free, NULL);
+       g_slist_free(vd->calls);
+       g_free(vd);
+}
+
+static struct ofono_voicecall_driver driver =3D {
+       .name                   =3D "hfpmodem",
+       .probe                  =3D hfp_voicecall_probe,
+       .remove                 =3D hfp_voicecall_remove,
+       .dial                   =3D hfp_dial,
+       .answer                 =3D hfp_answer,
+       .hangup                 =3D hfp_hangup,
+       .list_calls             =3D NULL,
+       .hold_all_active        =3D NULL,
+       .release_all_held       =3D NULL,
+       .set_udub               =3D NULL,
+       .release_all_active     =3D NULL,
+       .release_specific       =3D hfp_release_specific,
+       .private_chat           =3D NULL,
+       .create_multiparty      =3D NULL,
+       .transfer               =3D NULL,
+       .deflect                =3D NULL,
+       .swap_without_accept    =3D NULL,
+       .send_tones             =3D NULL
+};
+
+void hfp_voicecall_init()
+{
+       ofono_voicecall_driver_register(&driver);
+}
+
+void hfp_voicecall_exit()
+{
+       ofono_voicecall_driver_unregister(&driver);
+}
diff --git a/plugins/hfp.c b/plugins/hfp.c
index 9733cfc..5e94a05 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -307,7 +307,10 @@ static int hfp_disable(struct ofono_modem *modem)

 static void hfp_pre_sim(struct ofono_modem *modem)
 {
+       struct hfp_data *data =3D ofono_modem_get_data(modem);
+
        DBG("%p", modem);
+       ofono_voicecall_create(modem, 0, "hfpmodem", data);
 }

 static void hfp_post_sim(struct ofono_modem *modem)
--
1.6.2.5


Regards,
Zhenhua


--===============6216986849318419057==--

