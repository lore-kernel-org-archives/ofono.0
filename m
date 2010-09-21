Content-Type: multipart/mixed; boundary="===============8322637291413141251=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 5/5] cf: Handle send ss proactive command
Date: Tue, 21 Sep 2010 18:21:19 +0800
Message-ID: <1285064479-12907-6-git-send-email-yang.gu@intel.com>
In-Reply-To: <1285064479-12907-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8322637291413141251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |  259 +++++++++++++++++++++++++++++++++++++++++++++=
+---
 src/ofono.h           |   28 ++++++
 src/stk.c             |  130 +++++++++++++++++++++++++
 src/ussd.c            |  145 +++++++++++++++++++++++++++
 4 files changed, 546 insertions(+), 16 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 4a0f1cd..34dc263 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -55,11 +55,14 @@ struct ofono_call_forwarding {
 	GSList *cf_conditions[4];
 	int flags;
 	DBusMessage *pending;
+	struct ofono_ss_request *req;
 	int query_next;
 	int query_end;
 	struct cf_ss_request *ss_req;
 	struct ofono_ussd *ussd;
+	struct ofono_stk *stk;
 	unsigned int ussd_watch;
+	unsigned int stk_watch;
 	const struct ofono_call_forwarding_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -68,6 +71,7 @@ struct ofono_call_forwarding {
 static void get_query_next_cf_cond(struct ofono_call_forwarding *cf);
 static void set_query_next_cf_cond(struct ofono_call_forwarding *cf);
 static void ss_set_query_next_cf_cond(struct ofono_call_forwarding *cf);
+static void ss_set_query_next_cf_cond_stk(struct ofono_call_forwarding *cf=
);
 static void cf_unregister_ss_controls(struct ofono_call_forwarding *cf);
 =

 struct cf_ss_request {
@@ -77,6 +81,27 @@ struct cf_ss_request {
 	GSList *cf_list[4];
 };
 =

+static void request_finish_stk(struct ofono_call_forwarding *cf,
+					const struct ofono_error *error)
+{
+	struct ofono_ss_request *req =3D cf->req;
+
+	if (req && req->cb)
+		req->cb(error, req->user_data);
+
+	cf->req =3D NULL;
+}
+
+static void request_cancel_stk(void *ss)
+{
+	struct ofono_call_forwarding *cf =3D ss;
+
+	if (!cf->req || !cf->req->cb)
+		return;
+
+	cf->req =3D NULL;
+}
+
 static gint cf_condition_compare(gconstpointer a, gconstpointer b)
 {
 	const struct ofono_call_forwarding_condition *ca =3D a;
@@ -857,12 +882,52 @@ static void ss_set_query_cf_callback(const struct ofo=
no_error *error, int total,
 	}
 }
 =

+static void ss_set_query_cf_cb_stk(const struct ofono_error *error, int to=
tal,
+			const struct ofono_call_forwarding_condition *list,
+			void *data)
+{
+	struct ofono_call_forwarding *cf =3D data;
+	GSList *l;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_error("Setting succeeded, but query failed");
+		cf->flags &=3D ~CALL_FORWARDING_FLAG_CACHED;
+		request_finish_stk(cf, error);
+		return;
+	}
+
+	l =3D cf_cond_list_create(total, list);
+	DBG("%s conditions:", cf_type_lut[cf->query_next]);
+	cf_cond_list_print(l);
+
+	cf->ss_req->cf_list[cf->query_next] =3D l;
+
+	if (cf->query_next =3D=3D cf->query_end) {
+		request_finish_stk(cf, error);
+		g_free(cf->ss_req);
+		cf->ss_req =3D NULL;
+	}
+
+	set_new_cond_list(cf, cf->query_next, l);
+
+	if (cf->query_next !=3D cf->query_end) {
+		cf->query_next++;
+		ss_set_query_next_cf_cond_stk(cf);
+	}
+}
+
 static void ss_set_query_next_cf_cond(struct ofono_call_forwarding *cf)
 {
 	cf->driver->query(cf, cf->query_next, BEARER_CLASS_DEFAULT,
 			ss_set_query_cf_callback, cf);
 }
 =

+static void ss_set_query_next_cf_cond_stk(struct ofono_call_forwarding *cf)
+{
+	cf->driver->query(cf, cf->query_next, BEARER_CLASS_DEFAULT,
+			ss_set_query_cf_cb_stk, cf);
+}
+
 static void cf_ss_control_callback(const struct ofono_error *error, void *=
data)
 {
 	struct ofono_call_forwarding *cf =3D data;
@@ -880,16 +945,31 @@ static void cf_ss_control_callback(const struct ofono=
_error *error, void *data)
 	ss_set_query_next_cf_cond(cf);
 }
 =

-static int cf_ss_control(int type, const char *sc,
-				const char *sia, const char *sib,
-				const char *sic, const char *dn,
-				DBusMessage *msg, void *data)
+static void cf_ss_control_cb_stk(const struct ofono_error *error, void *da=
ta)
 {
 	struct ofono_call_forwarding *cf =3D data;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Error occurred during cf ss control set/erasure");
+
+		request_finish_stk(cf, error);
+
+		g_free(cf->ss_req);
+		cf->ss_req =3D NULL;
+		return;
+	}
+
+	ss_set_query_next_cf_cond_stk(cf);
+}
+
+static int parse_ss_control(struct ofono_call_forwarding *cf, int type,
+				const char *sc, const char *sia,
+				const char *sib, const char *sic,
+				const char *dn)
+{
 	int cls =3D BEARER_CLASS_SS_DEFAULT;
 	int timeout =3D DEFAULT_NO_REPLY_TIMEOUT;
 	int cf_type;
-	struct ofono_phone_number ph;
 	void *operation =3D NULL;
 =

 	/* Before we do anything, make sure we're actually initialized */
@@ -1000,9 +1080,16 @@ static int cf_ss_control(int type, const char *sc,
 =

 	cf->ss_req->ss_type =3D type;
 	cf->ss_req->cf_type =3D cf_type;
-	cf->ss_req->cls =3D cls;
 =

-	cf->pending =3D dbus_message_ref(msg);
+	/* Some modems don't understand all classes very well, particularly
+	 * the older models.  So if the bearer class is the default, we
+	 * just use the more commonly understood value of 7 since BEARER_SMS
+	 * is not applicable to CallForwarding conditions according to 22.004
+	 * Annex A
+	 */
+	if (cls =3D=3D BEARER_CLASS_SS_DEFAULT)
+		cls =3D BEARER_CLASS_DEFAULT;
+	cf->ss_req->cls =3D cls;
 =

 	switch (cf->ss_req->cf_type) {
 	case CALL_FORWARDING_TYPE_ALL:
@@ -1019,14 +1106,34 @@ static int cf_ss_control(int type, const char *sc,
 		break;
 	}
 =

-	/* Some modems don't understand all classes very well, particularly
-	 * the older models.  So if the bearer class is the default, we
-	 * just use the more commonly understood value of 7 since BEARER_SMS
-	 * is not applicable to CallForwarding conditions according to 22.004
-	 * Annex A
-	 */
-	if (cls =3D=3D BEARER_CLASS_SS_DEFAULT)
-		cls =3D BEARER_CLASS_DEFAULT;
+	return 0;
+}
+
+static int cf_ss_control(int type, const char *sc,
+				const char *sia, const char *sib,
+				const char *sic, const char *dn,
+				DBusMessage *msg, void *data)
+{
+	struct ofono_call_forwarding *cf =3D data;
+	int ret;
+	char *end;
+	int timeout;
+	int cls;
+	int cf_type;
+	struct ofono_phone_number ph;
+
+	ret =3D parse_ss_control(cf, type, sc, sia, sib, sic, dn);
+	if (ret !=3D 0)
+		return ret;
+
+	cls =3D cf->ss_req->cls;
+	cf_type =3D cf->ss_req->cf_type;
+
+	timeout =3D DEFAULT_NO_REPLY_TIMEOUT;
+	if (strlen(sic) > 0)
+		timeout =3D strtoul(sic, &end, 10);
+
+	cf->pending =3D dbus_message_ref(msg);
 =

 	switch (cf->ss_req->ss_type) {
 	case SS_CONTROL_TYPE_REGISTRATION:
@@ -1054,6 +1161,60 @@ static int cf_ss_control(int type, const char *sc,
 	return 0;
 }
 =

+static int cf_ss_control_stk(int type, const char *sc,
+				const char *sia, const char *sib,
+				const char *sic, const char *dn,
+				struct ofono_ss_request *req, void *data)
+{
+	struct ofono_call_forwarding *cf =3D data;
+	int ret;
+	char *end;
+	int timeout;
+	int cls;
+	int cf_type;
+	struct ofono_phone_number ph;
+
+	ret =3D parse_ss_control(cf, type, sc, sia, sib, sic, dn);
+	if (ret !=3D 0)
+		return ret;
+
+	cls =3D cf->ss_req->cls;
+	cf_type =3D cf->ss_req->cf_type;
+
+	timeout =3D DEFAULT_NO_REPLY_TIMEOUT;
+	if (strlen(sic) > 0)
+		timeout =3D strtoul(sic, &end, 10);
+
+	cf->req =3D req;
+	cf->req->cancel =3D request_cancel_stk;
+	cf->req->ss =3D cf;
+
+	switch (cf->ss_req->ss_type) {
+	case SS_CONTROL_TYPE_REGISTRATION:
+		string_to_phone_number(sia, &ph);
+		cf->driver->registration(cf, cf_type, cls, &ph, timeout,
+					cf_ss_control_cb_stk, cf);
+		break;
+	case SS_CONTROL_TYPE_ACTIVATION:
+		cf->driver->activation(cf, cf_type, cls, cf_ss_control_cb_stk,
+					cf);
+		break;
+	case SS_CONTROL_TYPE_DEACTIVATION:
+		cf->driver->deactivation(cf, cf_type, cls,
+					cf_ss_control_cb_stk, cf);
+		break;
+	case SS_CONTROL_TYPE_ERASURE:
+		cf->driver->erasure(cf, cf_type, cls, cf_ss_control_cb_stk,
+					cf);
+		break;
+	case SS_CONTROL_TYPE_QUERY:
+		ss_set_query_next_cf_cond_stk(cf);
+		break;
+	}
+
+	return 0;
+}
+
 static void cf_register_ss_controls(struct ofono_call_forwarding *cf)
 {
 	__ofono_ussd_ssc_register(cf->ussd, "21", cf_ss_control, cf, NULL);
@@ -1065,6 +1226,23 @@ static void cf_register_ss_controls(struct ofono_cal=
l_forwarding *cf)
 	__ofono_ussd_ssc_register(cf->ussd, "004", cf_ss_control, cf, NULL);
 }
 =

+static void cf_register_ss_controls_stk(struct ofono_call_forwarding *cf)
+{
+	__ofono_ussd_ssc_register_stk(cf->ussd, "21",
+					cf_ss_control_stk, cf, NULL);
+	__ofono_ussd_ssc_register_stk(cf->ussd, "67",
+					cf_ss_control_stk, cf, NULL);
+	__ofono_ussd_ssc_register_stk(cf->ussd, "61",
+					cf_ss_control_stk, cf, NULL);
+	__ofono_ussd_ssc_register_stk(cf->ussd, "62",
+					cf_ss_control_stk, cf, NULL);
+
+	__ofono_ussd_ssc_register_stk(cf->ussd, "002",
+					cf_ss_control_stk, cf, NULL);
+	__ofono_ussd_ssc_register_stk(cf->ussd, "004",
+					cf_ss_control_stk, cf, NULL);
+}
+
 static void cf_unregister_ss_controls(struct ofono_call_forwarding *cf)
 {
 	__ofono_ussd_ssc_unregister(cf->ussd, "21");
@@ -1076,9 +1254,26 @@ static void cf_unregister_ss_controls(struct ofono_c=
all_forwarding *cf)
 	__ofono_ussd_ssc_unregister(cf->ussd, "004");
 }
 =

+static void cf_unregister_ss_controls_stk(struct ofono_call_forwarding *cf)
+{
+	__ofono_ussd_ssc_unregister_stk(cf->ussd, "21");
+	__ofono_ussd_ssc_unregister_stk(cf->ussd, "67");
+	__ofono_ussd_ssc_unregister_stk(cf->ussd, "61");
+	__ofono_ussd_ssc_unregister_stk(cf->ussd, "62");
+
+	__ofono_ussd_ssc_unregister_stk(cf->ussd, "002");
+	__ofono_ussd_ssc_unregister_stk(cf->ussd, "004");
+}
+
 gboolean __ofono_call_forwarding_is_busy(struct ofono_call_forwarding *cf)
 {
-	return cf->pending ? TRUE : FALSE;
+	if (!cf)
+		return FALSE;
+
+	if (cf->pending || cf->req)
+		return TRUE;
+
+	return FALSE;
 }
 =

 int ofono_call_forwarding_driver_register(const struct ofono_call_forwardi=
ng_driver *d)
@@ -1116,6 +1311,12 @@ static void call_forwarding_unregister(struct ofono_=
atom *atom)
 =

 	if (cf->ussd_watch)
 		__ofono_modem_remove_atom_watch(modem, cf->ussd_watch);
+
+	if (cf->stk)
+		cf_unregister_ss_controls_stk(cf);
+
+	if (cf->stk_watch)
+		__ofono_modem_remove_atom_watch(modem, cf->stk_watch);
 }
 =

 static void call_forwarding_remove(struct ofono_atom *atom)
@@ -1170,10 +1371,26 @@ struct ofono_call_forwarding *ofono_call_forwarding=
_create(struct ofono_modem *m
 	return cf;
 }
 =

+static void stk_watch(struct ofono_atom *atom,
+			enum ofono_atom_watch_condition cond, void *data)
+{
+	struct ofono_call_forwarding *cf =3D data;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		cf->stk =3D NULL;
+		return;
+	}
+
+	cf->stk =3D __ofono_atom_get_data(atom);
+	cf_register_ss_controls_stk(cf);
+}
+
 static void ussd_watch(struct ofono_atom *atom,
 			enum ofono_atom_watch_condition cond, void *data)
 {
 	struct ofono_call_forwarding *cf =3D data;
+	struct ofono_atom *stk_atom;
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(cf->atom);
 =

 	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
 		cf->ussd =3D NULL;
@@ -1182,6 +1399,16 @@ static void ussd_watch(struct ofono_atom *atom,
 =

 	cf->ussd =3D __ofono_atom_get_data(atom);
 	cf_register_ss_controls(cf);
+
+	cf->stk_watch =3D __ofono_modem_add_atom_watch(modem,
+					OFONO_ATOM_TYPE_STK,
+					stk_watch, cf, NULL);
+
+	stk_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_STK);
+
+	if (stk_atom && __ofono_atom_get_registered(stk_atom))
+		stk_watch(stk_atom, OFONO_ATOM_WATCH_CONDITION_REGISTERED,
+				cf);
 }
 =

 void ofono_call_forwarding_register(struct ofono_call_forwarding *cf)
diff --git a/src/ofono.h b/src/ofono.h
index f64f149..2e781d8 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -260,11 +260,35 @@ typedef gboolean (*ofono_ussd_passwd_cb_t)(const char=
 *sc,
 =

 typedef void (*ofono_ussd_request_cb_t)(int error, int dcs,
 					const unsigned char *pdu, int len, void *data);
+typedef void (*ofono_ss_request_cb_t)(const struct ofono_error *error,
+					void *data);
+typedef void (*ofono_ss_request_cancel_t)(void *ss);
+
+struct ofono_ss_request {
+	ofono_ss_request_cb_t cb;
+	void *user_data;
+	ofono_ss_request_cancel_t cancel;
+	void *ss;
+};
+
+typedef gboolean (*ofono_ussd_ssc_cb_stk_t)(int type, const char *sc,
+					const char *sia, const char *sib,
+					const char *sic, const char *dn,
+					struct ofono_ss_request *req,
+					void *data);
+typedef gboolean (*ofono_ussd_passwd_cb_stk_t)(const char *sc,
+					const char *old, const char *new,
+					struct ofono_ss_request *req,
+					void *data);
 =

 gboolean __ofono_ussd_ssc_register(struct ofono_ussd *ussd, const char *sc,
 					ofono_ussd_ssc_cb_t cb, void *data,
 					ofono_destroy_func destroy);
+gboolean __ofono_ussd_ssc_register_stk(struct ofono_ussd *ussd, const char=
 *sc,
+					ofono_ussd_ssc_cb_stk_t cb, void *data,
+					ofono_destroy_func destroy);
 void __ofono_ussd_ssc_unregister(struct ofono_ussd *ussd, const char *sc);
+void __ofono_ussd_ssc_unregister_stk(struct ofono_ussd *ussd, const char *=
sc);
 =

 gboolean __ofono_ussd_passwd_register(struct ofono_ussd *ussd, const char =
*sc,
 					ofono_ussd_passwd_cb_t cb, void *data,
@@ -277,6 +301,10 @@ int __ofono_ussd_initiate(struct ofono_ussd *ussd, int=
 dcs,
 			ofono_ussd_request_cb_t cb, void *user_data);
 void __ofono_ussd_initiate_cancel(struct ofono_ussd *ussd);
 =

+int __ofono_ussd_recognized_control_string_stk(struct ofono_ussd *ussd,
+						const char *ss_str,
+						struct ofono_ss_request *req);
+
 #include <ofono/netreg.h>
 =

 typedef void (*ofono_netreg_status_notify_cb_t)(int status, int lac, int c=
i,
diff --git a/src/stk.c b/src/stk.c
index 63b1fd3..0aecb24 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -72,6 +72,7 @@ struct ofono_stk {
 	struct sms_submit_req *sms_submit_req;
 	char *idle_mode_text;
 	struct timeval get_inkey_start_ts;
+	struct ofono_ss_request *ss_req;
 };
 =

 struct envelope_op {
@@ -648,6 +649,13 @@ static GDBusSignalTable stk_signals[] =3D {
 	{ }
 };
 =

+static gboolean set_result_type(struct stk_response *rsp,
+					enum stk_result_type type)
+{
+	rsp->result.type =3D type;
+	return TRUE;
+}
+
 static gboolean handle_command_more_time(const struct stk_command *cmd,
 						struct stk_response *rsp,
 						struct ofono_stk *stk)
@@ -731,6 +739,123 @@ static gboolean handle_command_send_sms(const struct =
stk_command *cmd,
 	return FALSE;
 }
 =

+static void send_ss_cancel(struct ofono_stk *stk)
+{
+	if (!stk->ss_req || !stk->ss_req->cancel)
+		return;
+
+	stk->ss_req->cancel(stk->ss_req->ss);
+
+	g_free(stk->ss_req);
+	stk->ss_req =3D NULL;
+
+	if (stk->pending_cmd->send_ss.alpha_id &&
+			stk->pending_cmd->send_ss.alpha_id[0])
+		stk_alpha_id_unset(stk);
+}
+
+static void send_ss_cb(const struct ofono_error *error, void *data)
+{
+	struct ofono_stk *stk =3D data;
+	static struct ofono_error oe =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
+	struct stk_response rsp;
+	unsigned char addnl[2];
+
+	if (stk->pending_cmd->send_ss.alpha_id &&
+			stk->pending_cmd->send_ss.alpha_id[0])
+		stk_alpha_id_unset(stk);
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	switch (error->type) {
+	case OFONO_ERROR_TYPE_NO_ERROR:
+		rsp.result.type =3D STK_RESULT_TYPE_SUCCESS;
+		break;
+	default:
+		DBG("Send ss finishes with error type: %d", error->type);
+		rsp.result.type =3D STK_RESULT_TYPE_SS_RETURN_ERROR;
+		addnl[0] =3D (unsigned char) error->error;
+		addnl[1] =3D STK_RESULT_ADDNL_SS_PB_NO_SPECIFIC_CAUSE;
+		rsp.result.additional =3D addnl;
+		rsp.result.additional_len =3D 2;
+		break;
+	}
+
+	g_free(stk->ss_req);
+	stk->ss_req =3D NULL;
+
+	if (stk_respond(stk, &rsp, stk_command_cb))
+		stk_command_cb(&oe, stk);
+}
+
+static gboolean handle_command_send_ss(const struct stk_command *cmd,
+					struct stk_response *rsp,
+					struct ofono_stk *stk)
+{
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(stk->atom);
+	static unsigned char busy_on_ss_result[] =3D {
+				STK_RESULT_ADDNL_ME_PB_SS_BUSY };
+	static unsigned char busy_on_ussd_result[] =3D {
+				STK_RESULT_ADDNL_ME_PB_USSD_BUSY };
+	char *str =3D cmd->send_ss.ss.ss;
+	struct ofono_atom *ussd_atom;
+	struct ofono_ussd *ussd;
+	int result;
+	struct ofono_ss_request *req;
+
+	ussd_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_USSD);
+
+	if (!ussd_atom || !__ofono_atom_get_registered(ussd_atom))
+		return set_result_type(rsp, STK_RESULT_TYPE_NOT_CAPABLE);
+
+	ussd =3D __ofono_atom_get_data(ussd_atom);
+
+	if (__ofono_ussd_is_busy(ussd)) {
+		rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
+		rsp->result.additional_len =3D sizeof(busy_on_ussd_result);
+		rsp->result.additional =3D busy_on_ussd_result;
+		return TRUE;
+	}
+
+	if (strlen(str) =3D=3D 0)
+		return set_result_type(rsp,
+					STK_RESULT_TYPE_COMMAND_NOT_UNDERSTOOD);
+
+	req =3D g_try_new0(struct ofono_ss_request, 1);
+	req->cb =3D send_ss_cb;
+	req->user_data =3D stk;
+
+	result =3D __ofono_ussd_recognized_control_string_stk(ussd, str, req);
+
+	if (result !=3D 0) {
+		DBG("Failed to send ss with result: %d", result);
+		g_free(req);
+	}
+
+	switch (result) {
+	case EBUSY:
+		rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
+		rsp->result.additional_len =3D sizeof(busy_on_ss_result);
+		rsp->result.additional =3D busy_on_ss_result;
+		return TRUE;
+	case ENOSYS:
+	case ENOMEM:
+		return set_result_type(rsp, STK_RESULT_TYPE_NOT_CAPABLE);
+	case 0:
+		stk->ss_req =3D req;
+		stk->cancel_cmd =3D send_ss_cancel;
+
+		if (cmd->send_ss.alpha_id && cmd->send_ss.alpha_id[0])
+			stk_alpha_id_set(stk, cmd->send_ss.alpha_id);
+
+		return FALSE;
+	case EINVAL:
+	default:
+		return set_result_type(rsp,
+					STK_RESULT_TYPE_COMMAND_NOT_UNDERSTOOD);
+	}
+}
+
 static gboolean handle_command_set_idle_text(const struct stk_command *cmd,
 						struct stk_response *rsp,
 						struct ofono_stk *stk)
@@ -1857,6 +1982,11 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
 							&rsp, stk);
 		break;
 =

+	case STK_COMMAND_TYPE_SEND_SS:
+		respond =3D handle_command_send_ss(stk->pending_cmd,
+							&rsp, stk);
+		break;
+
 	case STK_COMMAND_TYPE_SETUP_IDLE_MODE_TEXT:
 		respond =3D handle_command_set_idle_text(stk->pending_cmd,
 							&rsp, stk);
diff --git a/src/ussd.c b/src/ussd.c
index 6119573..ff4d03c 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -60,7 +60,9 @@ struct ofono_ussd {
 	DBusMessage *cancel;
 	int flags;
 	GSList *ss_control_list;
+	GSList *ss_control_list_stk;
 	GSList *ss_passwd_list;
+	GSList *ss_passwd_list_stk;
 	const struct ofono_ussd_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
@@ -138,6 +140,26 @@ gboolean __ofono_ussd_ssc_register(struct ofono_ussd *=
ussd, const char *sc,
 	return TRUE;
 }
 =

+gboolean __ofono_ussd_ssc_register_stk(struct ofono_ussd *ussd, const char=
 *sc,
+					ofono_ussd_ssc_cb_stk_t cb, void *data,
+					ofono_destroy_func destroy)
+{
+	struct ssc_entry *entry;
+
+	if (!ussd)
+		return FALSE;
+
+	entry =3D ssc_entry_create(sc, cb, data, destroy);
+
+	if (!entry)
+		return FALSE;
+
+	ussd->ss_control_list_stk =3D
+			g_slist_prepend(ussd->ss_control_list_stk, entry);
+
+	return TRUE;
+}
+
 void __ofono_ussd_ssc_unregister(struct ofono_ussd *ussd, const char *sc)
 {
 	GSList *l;
@@ -155,6 +177,24 @@ void __ofono_ussd_ssc_unregister(struct ofono_ussd *us=
sd, const char *sc)
 	ussd->ss_control_list =3D g_slist_remove(ussd->ss_control_list, l->data);
 }
 =

+void __ofono_ussd_ssc_unregister_stk(struct ofono_ussd *ussd, const char *=
sc)
+{
+	GSList *l;
+
+	if (!ussd)
+		return;
+
+	l =3D g_slist_find_custom(ussd->ss_control_list_stk, sc,
+				ssc_entry_find_by_service);
+
+	if (!l)
+		return;
+
+	ssc_entry_destroy(l->data);
+	ussd->ss_control_list_stk =3D
+			g_slist_remove(ussd->ss_control_list_stk, l->data);
+}
+
 gboolean __ofono_ussd_passwd_register(struct ofono_ussd *ussd, const char =
*sc,
 					ofono_ussd_passwd_cb_t cb, void *data,
 					ofono_destroy_func destroy)
@@ -230,6 +270,45 @@ static gboolean recognized_passwd_change_string(struct=
 ofono_ussd *ussd,
 	return -ENOENT;
 }
 =

+static int recognized_passwd_change_string_stk(struct ofono_ussd *ussd,
+						int type, char *sc, char *sia,
+						char *sib, char *sic,
+						char *sid, char *dn,
+						struct ofono_ss_request *req)
+{
+	GSList *l =3D ussd->ss_passwd_list;
+
+	switch (type) {
+	case SS_CONTROL_TYPE_ACTIVATION:
+	case SS_CONTROL_TYPE_REGISTRATION:
+		break;
+
+	default:
+		return -ENOENT;
+	}
+
+	if (strcmp(sc, "03") || strlen(dn))
+		return -ENOENT;
+
+	/* If SIC & SID don't match, then we just bail out here */
+	if (strcmp(sic, sid))
+		return EINVAL;
+
+	while ((l =3D g_slist_find_custom(l, sia,
+			ssc_entry_find_by_service)) !=3D NULL) {
+		struct ssc_entry *entry =3D l->data;
+		ofono_ussd_passwd_cb_stk_t cb =3D entry->cb;
+		int result =3D cb(sia, sib, sic, req, entry->user);
+
+		if (result >=3D 0)
+			return result;
+
+		l =3D l->next;
+	}
+
+	return -ENOENT;
+}
+
 static gboolean recognized_control_string(struct ofono_ussd *ussd,
 						const char *ss_str,
 						DBusMessage *msg)
@@ -297,6 +376,72 @@ out:
 	return ret;
 }
 =

+int __ofono_ussd_recognized_control_string_stk(struct ofono_ussd *ussd,
+			const char *ss_str, struct ofono_ss_request *req)
+{
+	char *str =3D g_strdup(ss_str);
+	char *sc, *sia, *sib, *sic, *sid, *dn;
+	int type;
+	int ret =3D -ENOENT;
+	int result;
+
+	DBG("parsing control string");
+
+	if (parse_ss_control_string(str, &type, &sc,
+				&sia, &sib, &sic, &sid, &dn)) {
+		GSList *l =3D ussd->ss_control_list_stk;
+
+		DBG("Got parse result: %d, %s, %s, %s, %s, %s, %s",
+				type, sc, sia, sib, sic, sid, dn);
+
+		/* A password change string needs to be treated separately
+		 * because it uses a fourth SI and is thus not a valid
+		 * control string.  */
+		result =3D recognized_passwd_change_string_stk(ussd, type, sc,
+						sia, sib, sic, sid, dn, req);
+
+		if (result >=3D 0) {
+			ret =3D result;
+			goto out;
+		}
+
+		if (*sid !=3D '\0')
+			goto out;
+
+		while ((l =3D g_slist_find_custom(l, sc,
+				ssc_entry_find_by_service)) !=3D NULL) {
+			struct ssc_entry *entry =3D l->data;
+			ofono_ussd_ssc_cb_stk_t cb =3D entry->cb;
+
+			result =3D cb(type, sc, sia, sib, sic, dn,
+							req, entry->user);
+
+			if (result >=3D 0) {
+				ret =3D result;
+				goto out;
+			}
+
+			l =3D l->next;
+		}
+
+	}
+
+	/* TODO: Handle all strings that control voice calls */
+
+	/* TODO: Handle Multiple subscriber profile DN*59#SEND and *59#SEND
+	 */
+
+	/* Note: SIM PIN/PIN2 change and unblock and IMEI presentation
+	 * procedures are not handled by the daemon since they are not followed
+	 * by SEND and are not valid USSD requests.
+	 */
+
+out:
+	g_free(str);
+
+	return ret;
+}
+
 static const char *ussd_get_state_string(struct ofono_ussd *ussd)
 {
 	switch (ussd->state) {
-- =

1.7.2.3


--===============8322637291413141251==--

