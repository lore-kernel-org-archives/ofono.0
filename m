Content-Type: multipart/mixed; boundary="===============8305697249103340178=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] Fix multi-line comment style issues
Date: Tue, 21 Sep 2010 12:18:15 -0700
Message-ID: <1285096695-4647-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1285096695-4647-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8305697249103340178==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-barring.c    |    9 ++++++---
 src/call-forwarding.c |   15 ++++++++++-----
 src/call-meter.c      |    6 ++++--
 src/call-settings.c   |    3 ++-
 src/cbs.c             |   15 ++++++++++-----
 src/common.c          |   15 ++++++++++-----
 src/gprs.c            |    9 ++++++---
 src/message-waiting.c |   20 +++++++++++++-------
 src/network.c         |   33 ++++++++++++++++++++++-----------
 src/phonebook.c       |    5 +++--
 src/sim.c             |   18 ++++++++++++------
 src/simutil.c         |   33 ++++++++++++++++++++++-----------
 src/sms.c             |   27 ++++++++++++++++++---------
 src/smsutil.c         |   33 +++++++++++++++++++++------------
 src/stkutil.c         |   18 ++++++++++++------
 src/stkutil.h         |    9 +++++----
 src/ussd.c            |   12 +++++++-----
 src/util.c            |   21 ++++++++++++++-------
 src/voicecall.c       |   33 ++++++++++++++++++++++-----------
 19 files changed, 219 insertions(+), 115 deletions(-)

diff --git a/src/call-barring.c b/src/call-barring.c
index d235211..4bca906 100644
--- a/src/call-barring.c
+++ b/src/call-barring.c
@@ -426,7 +426,8 @@ static gboolean cb_ss_control(int type, const char *sc,
 		return TRUE;
 	}
 =

-	/* According to 27.007, AG, AC and AB only work with mode =3D 0
+	/*
+	 * According to 27.007, AG, AC and AB only work with mode =3D 0
 	 * We support query by querying all relevant types, since we must
 	 * do this for the deactivation case anyway
 	 */
@@ -738,7 +739,8 @@ static void set_lock_callback(const struct ofono_error =
*error, void *data)
 		return;
 	}
 =

-	/* If we successfully set the value, we must query it back
+	/*
+	 * If we successfully set the value, we must query it back
 	 * Call Barring is a special case, since according to 22.088 2.2.1:
 	 * "The PLMN will ensure that only one of the barring programs is
 	 * active per basic service group. The activation of one specific
@@ -785,7 +787,8 @@ static gboolean cb_lock_property_lookup(const char *pro=
perty, const char *value,
 		return FALSE;
 	}
 =

-	/* Gah, this is a special case.  If we're setting a barring to
+	/*
+	 * Gah, this is a special case.  If we're setting a barring to
 	 * disabled, then generate a disable all outgoing/incoming
 	 * request for a particular basic service
 	 */
diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 5eae6cf..f99e4a5 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -144,7 +144,8 @@ static GSList *cf_cond_list_create(int total,
 	int j;
 	struct ofono_call_forwarding_condition *cond;
 =

-	/* Specification is not really clear how the results are reported,
+	/*
+	 * Specification is not really clear how the results are reported,
 	 * so assume both multiple list items & compound values of class
 	 * are possible
 	 */
@@ -219,7 +220,8 @@ static void set_new_cond_list(struct ofono_call_forward=
ing *cf,
 	for (l =3D list; l; l =3D l->next) {
 		lc =3D l->data;
 =

-		/* New condition lists might have attributes we don't care about
+		/*
+		 * New condition lists might have attributes we don't care about
 		 * triggered by e.g. ss control magic strings just skip them
 		 * here.  For now we only support Voice, although Fax & all Data
 		 * basic services are applicable as well.
@@ -457,7 +459,8 @@ static gboolean cf_condition_enabled_property(struct of=
ono_call_forwarding *cf,
 		if (strncmp(property, prefix, len))
 			continue;
 =

-		/* We check the 4 call forwarding types, e.g.
+		/*
+		 * We check the 4 call forwarding types, e.g.
 		 * unconditional, busy, no reply, not reachable
 		 */
 		for (j =3D 0; j < 4; j++)
@@ -928,7 +931,8 @@ static gboolean cf_ss_control(int type, const char *sc,
 		type =3D=3D SS_CONTROL_TYPE_DEACTIVATION))
 		goto error;
 =

-	/* Activation / Registration is figured context specific according to
+	/*
+	 * Activation / Registration is figured context specific according to
 	 * 22.030 Section 6.5.2 "The UE shall determine from the context
 	 * whether, an entry of a single *, activation or registration
 	 * was intended."
@@ -1030,7 +1034,8 @@ static gboolean cf_ss_control(int type, const char *s=
c,
 		break;
 	}
 =

-	/* Some modems don't understand all classes very well, particularly
+	/*
+	 * Some modems don't understand all classes very well, particularly
 	 * the older models.  So if the bearer class is the default, we
 	 * just use the more commonly understood value of 7 since BEARER_SMS
 	 * is not applicable to CallForwarding conditions according to 22.004
diff --git a/src/call-meter.c b/src/call-meter.c
index 335b33c..5199b37 100644
--- a/src/call-meter.c
+++ b/src/call-meter.c
@@ -292,7 +292,8 @@ static DBusMessage *cm_get_properties(DBusConnection *c=
onn, DBusMessage *msg,
 =

 	cm->pending =3D dbus_message_ref(msg);
 =

-	/* We don't need to query ppu, currency & acm_max every time
+	/*
+	 * We don't need to query ppu, currency & acm_max every time
 	 * Not sure if we have to query acm & call_meter every time
 	 * so lets play on the safe side and query them.  They should be
 	 * fast to query anyway
@@ -406,7 +407,8 @@ static void set_puct_callback(const struct ofono_error =
*error, void *data)
 	cm->driver->puct_query(cm, set_puct_query_callback, cm);
 }
 =

-/* This function is for the really bizarre case of someone trying to call
+/*
+ * This function is for the really bizarre case of someone trying to call
  * SetProperty before GetProperties.  But we must handle it...
  */
 static void set_puct_initial_query_callback(const struct ofono_error *erro=
r,
diff --git a/src/call-settings.c b/src/call-settings.c
index 0c46a2a..fa7a11f 100644
--- a/src/call-settings.c
+++ b/src/call-settings.c
@@ -462,7 +462,8 @@ static gboolean cw_ss_control(int type,
 =

 	case SS_CONTROL_TYPE_QUERY:
 		cs->ss_req_type =3D SS_CONTROL_TYPE_QUERY;
-		/* Always query the entire set, SMS not applicable
+		/*
+		 * Always query the entire set, SMS not applicable
 		 * according to 22.004 Appendix A, so CLASS_DEFAULT
 		 * is safe to use here
 		 */
diff --git a/src/cbs.c b/src/cbs.c
index ecba0f9..6bd2f69 100644
--- a/src/cbs.c
+++ b/src/cbs.c
@@ -249,7 +249,8 @@ void ofono_cbs_notify(struct ofono_cbs *cbs, const unsi=
gned char *pdu,
 		goto out;
 	}
 =

-	/* 3GPP 23.041: NOTE=C3=82=C2=A05:	Code 00 is intended for use by the
+	/*
+	 * 3GPP 23.041: NOTE=C3=82=C2=A05:	Code 00 is intended for use by the
 	 * network operators for base station IDs.
 	 */
 	if (c.gs =3D=3D CBS_GEO_SCOPE_CELL_IMMEDIATE) {
@@ -888,8 +889,10 @@ static void cbs_got_imsi(struct ofono_cbs *cbs)
 	if (topics_str)
 		cbs->topics =3D cbs_extract_topic_ranges(topics_str);
 =

-	/* If stored value is invalid or no stored value, bootstrap
-	 * topics list from SIM contents */
+	/*
+	 * If stored value is invalid or no stored value, bootstrap
+	 * topics list from SIM contents
+	 */
 	if (topics_str =3D=3D NULL ||
 			(cbs->topics =3D=3D NULL && topics_str[0] !=3D '\0')) {
 		ofono_sim_read(cbs->sim, SIM_EFCBMI_FILEID,
@@ -972,7 +975,8 @@ static void cbs_location_changed(int status, int lac, i=
nt ci, int tech,
 out:
 	DBG("%d, %d, %d", plmn_changed, lac_changed, ci_changed);
 =

-	/* In order to minimize signal transmissions we wait about X seconds
+	/*
+	 * In order to minimize signal transmissions we wait about X seconds
 	 * before reseting the base station id.  The hope is that we receive
 	 * another cell broadcast with the new base station name within
 	 * that time
@@ -1018,7 +1022,8 @@ static void netreg_watch(struct ofono_atom *atom,
 	cbs->lac =3D ofono_netreg_get_location(cbs->netreg);
 	cbs->ci =3D ofono_netreg_get_cellid(cbs->netreg);
 =

-	/* Clear out the cbs assembly just in case, worst case
+	/*
+	 * Clear out the cbs assembly just in case, worst case
 	 * we will receive the cell broadcasts again
 	 */
 	cbs_assembly_location_changed(cbs->assembly, TRUE, TRUE, TRUE);
diff --git a/src/common.c b/src/common.c
index 8243f21..55c4b40 100644
--- a/src/common.c
+++ b/src/common.c
@@ -38,7 +38,8 @@ struct error_entry {
 	const char *str;
 };
 =

-/* 0-127 from 24.011 Annex E2
+/*
+ * 0-127 from 24.011 Annex E2
  * 127-255 23.040 Section 9.2.3.22
  * Rest are from 27.005 Section 3.2.5
  */
@@ -295,7 +296,8 @@ int mmi_service_code_to_bearer_class(int code)
 {
 	int cls =3D 0;
 =

-	/* Teleservices according to 22.004
+	/*
+	 * Teleservices according to 22.004
 	 * 1 - Voice
 	 * 2 - SMS
 	 * 3,4,5 - Unallocated
@@ -398,7 +400,8 @@ int valid_ussd_string(const char *str)
 	if (!len)
 		return FALSE;
 =

-	/* It is hard to understand exactly what constitutes a valid USSD string
+	/*
+	 * It is hard to understand exactly what constitutes a valid USSD string
 	 * According to 22.090:
 	 * Case a - 1, 2 or 3 digits from the set (*, #) followed by 1X(Y),
 	 * where X=3Dany number 0=C3=A2=C2=80=C2=914, Y=3Dany number 0=C3=A2=C2=
=80=C2=919, then, optionally "*
@@ -460,7 +463,8 @@ const char *ss_control_type_to_string(enum ss_control_t=
ype type)
 		}				\
 	} while (0)				\
 =

-/* Note: The str will be modified, so in case of error you should
+/*
+ * Note: The str will be modified, so in case of error you should
  * throw it away and start over
  */
 gboolean parse_ss_control_string(char *str, int *ss_type,
@@ -519,7 +523,8 @@ gboolean parse_ss_control_string(char *str, int *ss_typ=
e,
 =

 	NEXT_FIELD(c, *sc);
 =

-	/* According to 22.030 SC is 2 or 3 digits, there can be
+	/*
+	 * According to 22.030 SC is 2 or 3 digits, there can be
 	 * an optional digit 'n' if this is a call setup string,
 	 * however 22.030 does not define any SC of length 3
 	 * with an 'n' present
diff --git a/src/gprs.c b/src/gprs.c
index d85e70b..3f085ed 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -465,7 +465,8 @@ static void pri_activate_callback(const struct ofono_er=
ror *error,
 	__ofono_dbus_pending_reply(&gc->pending,
 				dbus_message_new_method_return(gc->pending));
 =

-	/* If we don't have the interface, don't bother emitting any settings,
+	/*
+	 * If we don't have the interface, don't bother emitting any settings,
 	 * as nobody can make use of them
 	 */
 	if (interface !=3D NULL)
@@ -1913,8 +1914,10 @@ static gboolean load_context(struct ofono_gprs *gprs=
, const char *group)
 	if (strlen(apn) > OFONO_GPRS_MAX_APN_LENGTH)
 		goto error;
 =

-	/* Accept empty (just created) APNs, but don't allow other
-	 * invalid ones */
+	/*
+	 * Accept empty (just created) APNs, but don't allow other
+	 * invalid ones
+	 */
 	if (apn[0] !=3D '\0' && is_valid_apn(apn) =3D=3D FALSE)
 		goto error;
 =

diff --git a/src/message-waiting.c b/src/message-waiting.c
index 9e29e83..97a238c 100644
--- a/src/message-waiting.c
+++ b/src/message-waiting.c
@@ -255,8 +255,10 @@ static void mbdn_set_cb(int ok, void *data)
 						&number);
 	}
 =

-	/* Make a single attempt at keeping the CPHS version of the file
-	 * in sync.  */
+	/*
+	 * Make a single attempt at keeping the CPHS version of the file
+	 * in sync.
+	 */
 	if (req->cphs =3D=3D FALSE)
 		set_cphs_mbdn(req->mw, TRUE, req->mailbox,
 				phone_number_to_string(&req->number), NULL);
@@ -274,7 +276,7 @@ static DBusMessage *set_mbdn(struct ofono_message_waiti=
ng *mw, int mailbox,
 	struct mbdn_set_request *req;
 	unsigned char efmbdn[255];
 =

-	/* =

+	/*
 	 * If we have no 3GPP EFmbdn on the card, maybe the
 	 * CPHS version is available
 	 */
@@ -727,10 +729,12 @@ static void handle_special_sms_iei(struct ofono_messa=
ge_waiting *mw,
 		if (type =3D=3D (SMS_MWI_TYPE_OTHER | 4))
 			type =3D SMS_MWI_TYPE_VIDEO;
 		else
-			/* 23.040 9.2.3.24.2: "Terminals should be capable of
+			/*
+			 * 23.040 9.2.3.24.2: "Terminals should be capable of
 			 * receiving any values in octet 1, even including
 			 * those marked as Reserved."  Treat Reserved as
-			 * "Other".  */
+			 * "Other".
+			 */
 			type =3D SMS_MWI_TYPE_OTHER;
 	}
 =

@@ -819,7 +823,8 @@ void __ofono_message_waiting_mwi(struct ofono_message_w=
aiting *mw,
 	if (out_discard)
 		*out_discard =3D FALSE;
 =

-	/* Check MWI types in the order from highest priority to lowest
+	/*
+	 * Check MWI types in the order from highest priority to lowest
 	 * because they must override one another.
 	 */
 =

@@ -880,7 +885,8 @@ void __ofono_message_waiting_mwi(struct ofono_message_w=
aiting *mw,
 		}
 =

 		if (iei_found) {
-			/* 23.040 9.2.3.24.2 says "In the event of a
+			/*
+			 * 23.040 9.2.3.24.2 says "In the event of a
 			 * conflict between this setting and the setting
 			 * of the Data Coding Scheme (see 3GPP TS 23.038 [9])
 			 * then the message shall be stored if either the DCS
diff --git a/src/network.c b/src/network.c
index 190eba9..3cd9be3 100644
--- a/src/network.c
+++ b/src/network.c
@@ -346,9 +346,11 @@ static char *get_operator_display_name(struct ofono_ne=
treg *netreg)
 	int len =3D sizeof(name);
 	int home_or_spdi;
 =

-	/* The name displayed to user depends on whether we're in a home
+	/*
+	 * The name displayed to user depends on whether we're in a home
 	 * PLMN or roaming and on configuration bits from the SIM, all
-	 * together there are four cases to consider.  */
+	 * together there are four cases to consider.
+	 */
 =

 	if (!opd) {
 		g_strlcpy(name, "", len);
@@ -415,7 +417,8 @@ static void set_network_operator_name(struct network_op=
erator_data *opd,
 	strncpy(opd->name, name, OFONO_MAX_OPERATOR_NAME_LENGTH);
 	opd->name[OFONO_MAX_OPERATOR_NAME_LENGTH] =3D '\0';
 =

-	/* If we have Enhanced Operator Name info on the SIM, we always use
+	/*
+	 * If we have Enhanced Operator Name info on the SIM, we always use
 	 * that, so do not need to emit the signal here
 	 */
 	if (opd->eons_info && opd->eons_info->longname)
@@ -896,7 +899,8 @@ static void append_operator_struct_list(struct ofono_ne=
treg *netreg,
 		return;
 	}
 =

-	/* Quoting 27.007: "The list of operators shall be in order: home
+	/*
+	 * Quoting 27.007: "The list of operators shall be in order: home
 	 * network, networks referenced in SIM or active application in the
 	 * UICC (GSM or USIM) in the following order: HPLMN selector, User
 	 * controlled PLMN selector, Operator controlled PLMN selector and
@@ -1108,8 +1112,10 @@ void __ofono_netreg_set_base_station_name(struct ofo=
no_netreg *netreg,
 	if (name =3D=3D NULL) {
 		netreg->base_station =3D NULL;
 =

-		/* We just got unregistered, set name to NULL
-		 * but don't emit signal */
+		/*
+		 * We just got unregistered, set name to NULL
+		 * but don't emit signal
+		 */
 		if (netreg->current_operator =3D=3D NULL)
 			return;
 	} else {
@@ -1365,7 +1371,8 @@ static void init_registration_status(const struct ofo=
no_error *error,
 =

 	ofono_netreg_status_notify(netreg, status, lac, ci, tech);
 =

-	/* Bootstrap our signal strength value without waiting for the
+	/*
+	 * Bootstrap our signal strength value without waiting for the
 	 * stack to report it
 	 */
 	if (netreg->status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED ||
@@ -1392,7 +1399,8 @@ void ofono_netreg_strength_notify(struct ofono_netreg=
 *netreg, int strength)
 	if (netreg->signal_strength =3D=3D strength)
 		return;
 =

-	/* Theoretically we can get signal strength even when not registered
+	/*
+	 * Theoretically we can get signal strength even when not registered
 	 * to any network.  However, what do we do with it in that case?
 	 */
 	if (netreg->status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED &&
@@ -1474,10 +1482,12 @@ static void sim_pnn_read_cb(int ok, int length, int=
 record,
 		return;
 =

 check:
-	/* If PNN is not present then OPL is not useful, don't
+	/*
+	 * If PNN is not present then OPL is not useful, don't
 	 * retrieve it.  If OPL is not there then PNN[1] will
 	 * still be used for the HPLMN and/or EHPLMN, if PNN
-	 * is present.  */
+	 * is present.
+	 */
 	if (netreg->eons && !sim_eons_pnn_is_empty(netreg->eons))
 		ofono_sim_read(netreg->sim, SIM_EFOPL_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_FIXED,
@@ -1530,7 +1540,8 @@ static void sim_spn_read_cb(int ok, int length, int r=
ecord,
 =

 	dcbyte =3D data[0];
 =

-	/* TS 31.102 says:
+	/*
+	 * TS 31.102 says:
 	 *
 	 * the string shall use:
 	 *
diff --git a/src/phonebook.c b/src/phonebook.c
index 2727282..ed768bd 100644
--- a/src/phonebook.c
+++ b/src/phonebook.c
@@ -105,8 +105,9 @@ static void vcard_printf(GString *str, const char *fmt,=
 ...)
 	g_string_append(str, "\r\n");
 }
 =

-/* According to RFC 2426, we need escape following characters:
- *  '\n', '\r', ';', ',', '\'.
+/*
+ * According to RFC 2426, we need escape following characters:
+ * '\n', '\r', ';', ',', '\'.
  */
 static void add_slash(char *dest, const char *src, int len_max, int len)
 {
diff --git a/src/sim.c b/src/sim.c
index fdb4579..6f10d4c 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -582,7 +582,8 @@ static DBusMessage *sim_lock_or_unlock(struct ofono_sim=
 *sim, int lock,
 =

 	type =3D sim_string_to_passwd(typestr);
 =

-	/* SIM PIN2 cannot be locked / unlocked according to 27.007,
+	/*
+	 * SIM PIN2 cannot be locked / unlocked according to 27.007,
 	 * however the PIN combination can be changed
 	 */
 	if (password_is_pin(type) =3D=3D FALSE ||
@@ -1283,7 +1284,8 @@ static gboolean sim_efli_format(const unsigned char *=
ef, int length)
 		if (ef[i] =3D=3D 0xff && ef[i+1] =3D=3D 0xff)
 			continue;
 =

-		/* ISO 639 country codes are each two lower-case SMS 7-bit
+		/*
+		 * ISO 639 country codes are each two lower-case SMS 7-bit
 		 * characters while CB DCS language codes are in ranges
 		 * (0 - 15) or (32 - 47), so the ranges don't overlap
 		 */
@@ -1306,7 +1308,8 @@ static GSList *parse_language_list(const unsigned cha=
r *ef, int length)
 		if (ef[i] > 0x7f || ef[i+1] > 0x7f)
 			continue;
 =

-		/* ISO 639 codes contain only characters that are coded
+		/*
+		 * ISO 639 codes contain only characters that are coded
 		 * identically in SMS 7 bit charset, ASCII or UTF8 so
 		 * no conversion.
 		 */
@@ -1395,7 +1398,8 @@ skip_efpl:
 			efli =3D parse_eflp(sim->efli, sim->efli_length);
 	}
 =

-	/* If efli_format is TRUE, make a list of languages in both files in
+	/*
+	 * If efli_format is TRUE, make a list of languages in both files in
 	 * order of preference following TS 31.102.
 	 * Quoting 31.102 Section 5.1.1.2:
 	 * The preferred language selection shall always use the EFLI in
@@ -1466,7 +1470,8 @@ static void sim_iccid_read_cb(int ok, int length, int=
 record,
 =

 static void sim_initialize(struct ofono_sim *sim)
 {
-	/* Perform SIM initialization according to 3GPP 31.102 Section 5.1.1.2
+	/*
+	 * Perform SIM initialization according to 3GPP 31.102 Section 5.1.1.2
 	 * The assumption here is that if sim manager is being initialized,
 	 * then sim commands are implemented, and the sim manager is then
 	 * responsible for checking the PIN, reading the IMSI and signaling
@@ -1498,7 +1503,8 @@ static void sim_initialize(struct ofono_sim *sim)
 =

 	/* EFecc is read by the voicecall atom */
 =

-	/* According to 31.102 the EFli is read first and EFpl is then
+	/*
+	 * According to 31.102 the EFli is read first and EFpl is then
 	 * only read if none of the EFli languages are supported by user
 	 * interface.  51.011 mandates the exact opposite, making EFpl/EFelp
 	 * preferred over EFlp (same EFid as EFli, different format).
diff --git a/src/simutil.c b/src/simutil.c
index 4af6810..65ce1ac 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -579,8 +579,10 @@ gboolean ber_tlv_builder_next(struct ber_tlv_builder *=
builder,
 	return TRUE;
 }
 =

-/* Resize the TLV because the content of Value field needs more space.  If
- * this TLV is part of another TLV, resize that one too.  */
+/*
+ * Resize the TLV because the content of Value field needs more space.
+ * If this TLV is part of another TLV, resize that one too.
+ */
 gboolean ber_tlv_builder_set_length(struct ber_tlv_builder *builder,
 					unsigned int new_len)
 {
@@ -709,8 +711,10 @@ gboolean comprehension_tlv_builder_next(
 	return TRUE;
 }
 =

-/* Resize the TLV because the content of Value field needs more space.  If
- * this TLV is part of another TLV, resize that one too.  */
+/*
+ * Resize the TLV because the content of Value field needs more space.
+ * If this TLV is part of another TLV, resize that one too.
+ */
 gboolean comprehension_tlv_builder_set_length(
 				struct comprehension_tlv_builder *builder,
 				unsigned int new_len)
@@ -781,8 +785,10 @@ static char *sim_network_name_parse(const unsigned cha=
r *buffer, int length,
 	dcs =3D *buffer++;
 	length--;
 =

-	/* "The MS should add the letters for the Country's Initials and a
-	 * separator (e.g. a space)" */
+	/*
+	 * "The MS should add the letters for the Country's Initials and a
+	 * separator (e.g. a space)"
+	 */
 	if (is_bit_set(dcs, 4))
 		ci =3D TRUE;
 =

@@ -1303,8 +1309,10 @@ gboolean sim_parse_3g_get_response(const unsigned ch=
ar *data, int len,
 	if (fcp =3D=3D NULL)
 		return FALSE;
 =

-	/* Find the file size tag 0x80 according to
-	 * ETSI 102.221 Section 11.1.1.3.2 */
+	/*
+	 * Find the file size tag 0x80 according to
+	 * ETSI 102.221 Section 11.1.1.3.2
+	 */
 	tlv =3D ber_tlv_find_by_tag(fcp, 0x80, fcp_length, &tlv_length);
 =

 	if (!tlv || tlv_length < 2)
@@ -1347,14 +1355,17 @@ gboolean sim_parse_3g_get_response(const unsigned c=
har *data, int len,
 	if (str !=3D 0x00 && tlv_length !=3D 5)
 		return FALSE;
 =

-	/* strictly speaking the record length is 16 bit, but the valid
-	 * range is 0x01 to 0xFF according to 102.221 */
+	/*
+	 * strictly speaking the record length is 16 bit, but the valid
+	 * range is 0x01 to 0xFF according to 102.221
+	 */
 	if (str !=3D 0x00)
 		rlen =3D tlv[3];
 	else
 		rlen =3D 0;
 =

-	/* The 3G response data contains references to EFarr which actually
+	/*
+	 * The 3G response data contains references to EFarr which actually
 	 * contains the security attributes.  These are usually not carried
 	 * along with the response data unlike in 2G.  Instead of querying
 	 * this, we simply look it up in our database.  We fudge it somewhat
diff --git a/src/sms.c b/src/sms.c
index 8b7670d..2785d55 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -867,7 +867,8 @@ static void sms_dispatch(struct ofono_sms *sms, GSList =
*sms_list)
 	if (sms_list =3D=3D NULL)
 		return;
 =

-	/* Qutoting 23.040: The TP elements in the SMS=C3=A2=C2=80=C2=91SUBMIT PD=
U, apart from
+	/*
+	 * Qutoting 23.040: The TP elements in the SMS=C3=A2=C2=80=C2=91SUBMIT PD=
U, apart from
 	 * TP=C3=A2=C2=80=C2=91MR, TP-SRR, TP=C3=A2=C2=80=C2=91UDL and TP=C3=A2=
=C2=80=C2=91UD, should remain unchanged for each
 	 * SM which forms part of a concatenated SM, otherwise this may lead
 	 * to irrational behaviour
@@ -1058,8 +1059,10 @@ void ofono_sms_deliver_notify(struct ofono_sms *sms,=
 unsigned char *pdu,
 		return;
 	}
 =

-	/* This is an older style MWI notification, process MWI
-	 * headers and handle it like any other message */
+	/*
+	 * This is an older style MWI notification, process MWI
+	 * headers and handle it like any other message
+	 */
 	if (s.deliver.pid =3D=3D SMS_PID_TYPE_RETURN_CALL) {
 		if (handle_mwi(sms, &s))
 			return;
@@ -1067,8 +1070,10 @@ void ofono_sms_deliver_notify(struct ofono_sms *sms,=
 unsigned char *pdu,
 		goto out;
 	}
 =

-	/* The DCS indicates this is an MWI notification, process it
-	 * and then handle the User-Data as any other message */
+	/*
+	 * The DCS indicates this is an MWI notification, process it
+	 * and then handle the User-Data as any other message
+	 */
 	if (sms_mwi_dcs_decode(s.deliver.dcs, NULL, NULL, NULL, NULL)) {
 		if (handle_mwi(sms, &s))
 			return;
@@ -1109,7 +1114,8 @@ void ofono_sms_deliver_notify(struct ofono_sms *sms, =
unsigned char *pdu,
 		break;
 	}
 =

-	/* Check to see if the SMS has any other MWI related headers,
+	/*
+	 * Check to see if the SMS has any other MWI related headers,
 	 * as sometimes they are "tacked on" by the SMSC.
 	 * While we're doing this we also check for messages containing
 	 * WCMP headers or headers that can't possibly be in a normal
@@ -1133,9 +1139,11 @@ void ofono_sms_deliver_notify(struct ofono_sms *sms,=
 unsigned char *pdu,
 			switch (iei) {
 			case SMS_IEI_SPECIAL_MESSAGE_INDICATION:
 			case SMS_IEI_ENHANCED_VOICE_MAIL_INFORMATION:
-				/* TODO: ignore if not in the very first
+				/*
+				 * TODO: ignore if not in the very first
 				 * segment of a concatenated SM so as not
-				 * to repeat the indication.  */
+				 * to repeat the indication.
+				 */
 				if (handle_mwi(sms, &s))
 					return;
 =

@@ -1406,7 +1414,8 @@ void ofono_sms_register(struct ofono_sms *sms)
 =

 	sim_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
 =

-	/* If we have a sim atom, we can uniquely identify the SIM,
+	/*
+	 * If we have a sim atom, we can uniquely identify the SIM,
 	 * otherwise create an sms assembly which doesn't backup the fragment
 	 * store.
 	 */
diff --git a/src/smsutil.c b/src/smsutil.c
index cd0fef2..f192ee8 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -1861,7 +1861,7 @@ static gboolean extract_app_port_common(struct sms_ud=
h_iter *iter, int *dst,
 	 * processing@the next information element) any information element
 	 * where the value of the Information-Element-Data is Reserved or not
 	 * supported.
-	*/
+	 */
 	while ((iei =3D sms_udh_iter_get_ie_type(iter)) !=3D
 			SMS_IEI_INVALID) {
 		switch (iei) {
@@ -3048,7 +3048,8 @@ static inline GSList *sms_list_append(GSList *l, cons=
t struct sms *in)
 	return l;
 }
 =

-/* Prepares the text for transmission.  Breaks up into fragments if
+/*
+ * Prepares the text for transmission.  Breaks up into fragments if
  * necessary using ref as the concatenated message reference number.
  * Returns a list of sms messages in order.  If ref_offset is given,
  * then the ref_offset contains the reference number offset or 0
@@ -3343,7 +3344,8 @@ gboolean cbs_decode(const unsigned char *pdu, int len=
, struct cbs *out)
 	out->max_pages =3D pdu[5] & 0xf;
 	out->page =3D (pdu[5] >> 4) & 0xf;
 =

-	/* If a mobile receives the code 0000 in either the first field or
+	/*
+	 * If a mobile receives the code 0000 in either the first field or
 	 * the second field then it shall treat the CBS message exactly the
 	 * same as a CBS message with page parameter 0001 0001 (i.e. a single
 	 * page message).
@@ -3511,7 +3513,8 @@ char *cbs_decode_text(GSList *cbs_list, char *iso639_=
lang)
 	if (cbs_list =3D=3D NULL)
 		return NULL;
 =

-	/* CBS can only come from the network, so we're much less lenient
+	/*
+	 * CBS can only come from the network, so we're much less lenient
 	 * on what we support.  Namely we require the same charset to be
 	 * used across all pages.
 	 */
@@ -3601,7 +3604,8 @@ char *cbs_decode_text(GSList *cbs_list, char *iso639_=
lang)
 =

 			i =3D iso639 ? 3 : 0;
 =

-			/* CR is a padding character, which means we can
+			/*
+			 * CR is a padding character, which means we can
 			 * safely discard everything afterwards
 			 */
 			for (; i < written; i++, bufsize++) {
@@ -3611,7 +3615,8 @@ char *cbs_decode_text(GSList *cbs_list, char *iso639_=
lang)
 				buf[bufsize] =3D unpacked[i];
 			}
 =

-			/* It isn't clear whether extension sequences
+			/*
+			 * It isn't clear whether extension sequences
 			 * (2 septets) must be wholly present in the page
 			 * and not broken over multiple pages.  The behavior
 			 * is probably the same as SMS, but we don't make
@@ -3622,9 +3627,10 @@ char *cbs_decode_text(GSList *cbs_list, char *iso639=
_lang)
 			int i =3D taken;
 			int max_offset =3D taken + num_ucs2_chars * 2;
 =

-			/* It is completely unclear how UCS2 chars are handled
+			/*
+			 * It is completely unclear how UCS2 chars are handled
 			 * especially across pages or when the UDH is present.
-			 * For now do the best we can
+			 * For now do the best we can.
 			 */
 			if (iso639) {
 				i +=3D 2;
@@ -3662,7 +3668,8 @@ static inline gboolean cbs_is_update_newer(unsigned i=
nt n, unsigned int o)
 	if (new_update =3D=3D old_update)
 		return FALSE;
 =

-	/* Any Update Number eight or less higher (modulo 16) than the last
+	/*
+	 * Any Update Number eight or less higher (modulo 16) than the last
 	 * received Update Number will be considered more recent, and shall be
 	 * treated as a new CBS message, provided the mobile has not been
 	 * switched off.
@@ -3741,8 +3748,9 @@ static void cbs_assembly_expire(struct cbs_assembly *=
assembly,
 	GSList *prev;
 	GSList *tmp;
 =

-	/* Take care of the case where several updates are being
-	 * reassembled at the same time.  If the newer one is assembled
+	/*
+	 * Take care of the case where several updates are being
+	 * reassembled@the same time. If the newer one is assembled
 	 * first, then the subsequent old update is discarded, make
 	 * sure that we're also discarding the assembly node for the
 	 * partially assembled ones
@@ -3776,7 +3784,8 @@ static void cbs_assembly_expire(struct cbs_assembly *=
assembly,
 void cbs_assembly_location_changed(struct cbs_assembly *assembly, gboolean=
 plmn,
 					gboolean lac, gboolean ci)
 {
-	/* Location Area wide (in GSM) (which means that a CBS message with the
+	/*
+	 * Location Area wide (in GSM) (which means that a CBS message with the
 	 * same Message Code and Update Number may or may not be "new" in the
 	 * next cell according to whether the next cell is in the same Location
 	 * Area as the current cell), or
diff --git a/src/stkutil.c b/src/stkutil.c
index cdd6b4e..82da079 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -4148,7 +4148,8 @@ static gboolean build_dataobj_text(struct stk_tlv_bui=
lder *tlv,
 		return FALSE;
 =

 	if (text->yesno =3D=3D TRUE) {
-		/* Section 6.8.5:
+		/*
+		 * Section 6.8.5:
 		 * When the terminal issues [...] command qualifier set
 		 * to "Yes/No", it shall supply the value "01" when the
 		 * answer is "positive" and the value '00' when the
@@ -4299,7 +4300,8 @@ static gboolean build_empty_dataobj_location_info(str=
uct stk_tlv_builder *tlv,
 		stk_tlv_builder_close_container(tlv);
 }
 =

-/* Described in TS 102.223 Section 8.20
+/*
+ * Described in TS 102.223 Section 8.20
  *
  * See format note in parse_dataobj_imei.
  */
@@ -4862,7 +4864,8 @@ static gboolean build_dataobj_pdp_context_params(stru=
ct stk_tlv_builder *tlv,
 		stk_tlv_builder_close_container(tlv);
 }
 =

-/* Described in TS 102.223 Section 8.74
+/*
+ * Described in TS 102.223 Section 8.74
  *
  * See format note in parse_dataobj_imeisv.
  */
@@ -4998,8 +5001,10 @@ static gboolean build_dataobj_mms_transfer_status(st=
ruct stk_tlv_builder *tlv,
 	const struct stk_mms_transfer_status *mts =3D data;
 	unsigned char tag =3D STK_DATA_OBJECT_TYPE_MMS_TRANSFER_STATUS;
 =

-	/* Assume the length is never 0 for a valid Result message, however
-	 * the whole data object's presence is conditional.  */
+	/*
+	 * Assume the length is never 0 for a valid Result message, however
+	 * the whole data object's presence is conditional.
+	 */
 	if (mts->len =3D=3D 0)
 		return TRUE;
 =

@@ -5387,7 +5392,8 @@ const unsigned char *stk_pdu_from_response(const stru=
ct stk_response *response,
 	if (stk_tlv_builder_close_container(&builder) =3D=3D FALSE)
 		return NULL;
 =

-	/* TS 102 223 section 6.8 states:
+	/*
+	 * TS 102 223 section 6.8 states:
 	 * "For all COMPREHENSION-TLV objects with Min =3D N, the terminal
 	 * should set the CR flag to comprehension not required."
 	 * All the data objects except "Command Details" and "Result" have
diff --git a/src/stkutil.h b/src/stkutil.h
index 36b18f0..2d98185 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -586,8 +586,8 @@ struct stk_address {
  * and a maximum length of 23 octets"
  *
  * According to TS 31.102 Section 4.4.2.4: "The subaddress data contains
- * information as defined for this purpose in TS=C3=82=C2=A024.008=C3=82=
=C2=A0[9]. All information
- * defined in TS=C3=82=C2=A024.008, except the information element identif=
ier, shall be
+ * information as defined for this purpose in TS 24.008 [9]. All informati=
on
+ * defined in TS 24.008, except the information element identifier, shall =
be
  * stored in the USIM. The length of this subaddress data can be up to 22
  * bytes."
  */
@@ -602,7 +602,7 @@ struct stk_subaddress {
  *
  * According to 24.008 Section 10.5.4.5 "The bearer capability is a type 4
  * information element with a minimum length of 3 octets and a maximum len=
gth
- * of 16=C3=82=C2=A0octets."
+ * of 16 octets."
  *
  * According to TS 31.102 Section 4.2.38 the CCP length is 15 bytes.
  *
@@ -663,7 +663,8 @@ struct stk_ussd_string {
 	int len;
 };
 =

-/* Define the struct of single file in TS102.223 Section 8.18.
+/*
+ * Define the struct of single file in TS102.223 Section 8.18.
  * According to TS 11.11 Section 6.2, each file id has two bytes, and the
  * maximum Dedicated File level is 2. So the maximum size of file is 8, wh=
ich
  * contains two bytes of Master File, 2 bytes of 1st level Dedicated File,
diff --git a/src/ussd.c b/src/ussd.c
index bbb9aed..aad7d32 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -251,9 +251,11 @@ static gboolean recognized_control_string(struct ofono=
_ussd *ussd,
 		DBG("Got parse result: %d, %s, %s, %s, %s, %s, %s",
 				type, sc, sia, sib, sic, sid, dn);
 =

-		/* A password change string needs to be treated separately
+		/*
+		 * A password change string needs to be treated separately
 		 * because it uses a fourth SI and is thus not a valid
-		 * control string.  */
+		 * control string.
+		 */
 		if (recognized_passwd_change_string(ussd, type, sc,
 					sia, sib, sic, sid, dn, msg)) {
 			ret =3D TRUE;
@@ -280,10 +282,10 @@ static gboolean recognized_control_string(struct ofon=
o_ussd *ussd,
 =

 	/* TODO: Handle all strings that control voice calls */
 =

-	/* TODO: Handle Multiple subscriber profile DN*59#SEND and *59#SEND
-	 */
+	/* TODO: Handle Multiple subscriber profile DN*59#SEND and *59#SEND */
 =

-	/* Note: SIM PIN/PIN2 change and unblock and IMEI presentation
+	/*
+	 * Note: SIM PIN/PIN2 change and unblock and IMEI presentation
 	 * procedures are not handled by the daemon since they are not followed
 	 * by SEND and are not valid USSD requests.
 	 */
diff --git a/src/util.c b/src/util.c
index 269de7b..94b2fca 100644
--- a/src/util.c
+++ b/src/util.c
@@ -917,17 +917,21 @@ unsigned char *unpack_7bit_own_buf(const unsigned cha=
r *in, long len,
 		/* Figure out the remainder */
 		rest =3D (in[i] >> bits) & ((1 << (8-bits)) - 1);
 =

-		/* We have the entire character, here we don't increate
+		/*
+		 * We have the entire character, here we don't increate
 		 * out if this is we started at an offset.  Instead
-		 * we effectively populate variable rest */
+		 * we effectively populate variable rest
+		 */
 		if (i !=3D 0 || bits =3D=3D 7)
 			out++;
 =

 		if ((out-buf) =3D=3D max_to_unpack)
 			break;
 =

-		/* We expected only 1 bit from this octet, means there's 7
-		 * left, take care of them here */
+		/*
+		 * We expected only 1 bit from this octet, means there's 7
+		 * left, take care of them here
+		 */
 		if (bits =3D=3D 1) {
 			*out =3D rest;
 			out++;
@@ -938,7 +942,8 @@ unsigned char *unpack_7bit_own_buf(const unsigned char =
*in, long len,
 		}
 	}
 =

-	/* According to 23.038 6.1.2.3.1, last paragraph:
+	/*
+	 * According to 23.038 6.1.2.3.1, last paragraph:
 	 * "If the total number of characters to be sent equals (8n-1)
 	 * where n=3D1,2,3 etc. then there are 7 spare bits@the end
 	 * of the message. To avoid the situation where the receiving
@@ -1021,7 +1026,8 @@ unsigned char *pack_7bit_own_buf(const unsigned char =
*in, long len,
 			bits =3D bits - 1;
 	}
 =

-	/* If <CR> is intended to be the last character and the message
+	/*
+	 * If <CR> is intended to be the last character and the message
 	 * (including the wanted <CR>) ends on an octet boundary, then
 	 * another <CR> must be added together with a padding bit 0. The
 	 * receiving entity will perform the carriage return function twice,
@@ -1096,7 +1102,8 @@ char *sim_string_to_utf8(const unsigned char *buffer,=
 int length)
 		return NULL;
 =

 	if (buffer[0] < 0x80) {
-		/* We have to find the real length, since on SIM file system
+		/*
+		 * We have to find the real length, since on SIM file system
 		 * alpha fields are 0xff padded
 		 */
 		for (i =3D 0; i < length; i++)
diff --git a/src/voicecall.c b/src/voicecall.c
index 2f846d7..f6ed988 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -599,10 +599,12 @@ static void voicecall_set_call_lineid(struct voicecal=
l *v,
 		call->clip_validity =3D=3D clip_validity)
 		return;
 =

-	/* Two cases: We get an incoming call with CLIP factored in, or
+	/*
+	 * Two cases: We get an incoming call with CLIP factored in, or
 	 * CLIP comes in later as a separate event
 	 * For COLP only the phone number should be checked, it can come
-	 * in with the initial call event or later as a separate event */
+	 * in with the initial call event or later as a separate event
+	 */
 =

 	/* For plugins that don't keep state, ignore */
 	if (call->clip_validity =3D=3D CLIP_VALIDITY_VALID &&
@@ -755,8 +757,10 @@ static GSList *voicecalls_held_list(struct ofono_voice=
call *vc)
 	return r;
 }
 =

-/* Intended to be used for multiparty, which cannot be incoming,
- * alerting or dialing */
+/*
+ * Intended to be used for multiparty, which cannot be incoming,
+ * alerting or dialing
+ */
 static GSList *voicecalls_active_list(struct ofono_voicecall *vc)
 {
 	GSList *l;
@@ -1007,8 +1011,10 @@ static struct voicecall *dial_handle_result(struct o=
fono_voicecall *vc,
 		return NULL;
 	}
 =

-	/* Two things can happen, the call notification arrived before dial
-	 * callback or dial callback was first.	Handle here */
+	/*
+	 * Two things can happen, the call notification arrived before dial
+	 * callback or dial callback was first.	Handle here
+	 */
 	for (l =3D vc->call_list; l; l =3D l->next) {
 		v =3D l->data;
 =

@@ -1130,7 +1136,8 @@ static DBusMessage *manager_transfer(DBusConnection *=
conn,
 =

 	numactive =3D voicecalls_num_active(vc);
 =

-	/* According to 22.091 section 5.8, the network has the option of
+	/*
+	 * According to 22.091 section 5.8, the network has the option of
 	 * implementing the call transfer operation for a call that is
 	 * still dialing/alerting.
 	 */
@@ -1223,7 +1230,8 @@ static DBusMessage *manager_hold_and_answer(DBusConne=
ction *conn,
 	if (voicecalls_have_waiting(vc) =3D=3D FALSE)
 		return __ofono_error_failed(msg);
 =

-	/* We have waiting call and both an active and held call.  According
+	/*
+	 * We have waiting call and both an active and held call.  According
 	 * to 22.030 we cannot use CHLD=3D2 in this situation.
 	 */
 	if (voicecalls_have_active(vc) && voicecalls_have_held(vc))
@@ -1378,7 +1386,8 @@ static DBusMessage *multiparty_private_chat(DBusConne=
ction *conn,
 	if (!l)
 		return __ofono_error_not_found(msg);
 =

-	/* If we found id on the list of multiparty calls, then by definition
+	/*
+	 * If we found id on the list of multiparty calls, then by definition
 	 * the multiparty call exists.	Only thing to check is whether we have
 	 * held calls
 	 */
@@ -1498,7 +1507,8 @@ static DBusMessage *multiparty_hangup(DBusConnection =
*conn,
 			goto out;
 		}
 =

-		/* Multiparty is currently active, if we have held calls
+		/*
+		 * Multiparty is currently active, if we have held calls
 		 * we shouldn't use release_all_active here since this also
 		 * has the side-effect of activating held calls
 		 */
@@ -2113,7 +2123,8 @@ void ofono_voicecall_register(struct ofono_voicecall =
*vc)
 =

 	ofono_modem_add_interface(modem, OFONO_VOICECALL_MANAGER_INTERFACE);
 =

-	/* Start out with the 22.101 mandated numbers, if we have a SIM and
+	/*
+	 * Start out with the 22.101 mandated numbers, if we have a SIM and
 	 * the SIM contains EFecc, then we update the list once we've read them
 	 */
 	add_to_en_list(&vc->en_list, default_en_list_no_sim);
-- =

1.7.0.4


--===============8305697249103340178==--

