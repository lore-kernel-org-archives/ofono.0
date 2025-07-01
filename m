Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B4F238C0A
	for <ofono@lists.linux.dev>; Tue,  1 Jul 2025 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751362201; cv=none; b=oodQxiQhUc7vnRQZBmUiMEMZwur/mzBFfCXrha6Md+HAu24grJaoZHq25luRydrm1F6Y93fuMMZVAxIjQn0ILel7FMYi54rJ8aRAuEBg4m1/I7do4ApEiRLJoQGDplcpvOxOlVufkA5FFL6Rw+xv9iuM6zSHEA0X9G+k9r+jxy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751362201; c=relaxed/simple;
	bh=8s7CaA301cp/L9P14rUyyYQLVSBefqSTWw/ubKk1avY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=G3x/CvPBxmYHRlAFmy2pVOSXTdc71Ulkao8F1VwKWmvHptDsOEAGwFw3OzUkLMwK/5MYBdqYQTqNFFBhAE1CzXvrqhdCwDz0jlmEMVAVF6d2wMpLVrg5sz9gJYNWVguNC0okv/XkN+VybEJ1aoYcDjrRHIkEPIMH0q4uUwz4Jb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=CBzWc/E2; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="CBzWc/E2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1751362189; x=1751621389;
	bh=+uy+AfIw5L7n1kDm1qI9Z5zdZ1/voVjUgetwU0JHue0=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:From:To:Cc:
	 Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=CBzWc/E2k0SdFBKVhfuNJcHoucxD8E9+ZHT8k0JrSFDM8Cv7WYkafFeQTeaAn/iPv
	 Idx9CdCmeiUM8jv8Nj5yLMnrYFtkCN1L9tVtRFNRxARYLgysr92hrdW6Ryo5a0Vzjz
	 3cnfbG8U5p5S58jNezTJyuTFK/BcaTwn8uz9+qEhza/PARZh4Z+tBmx4qDHTuTl4Am
	 44nXANJWQAaHkbjzCzarAKG7WzMrh3u4qNGaPgdrbkJTtrkZAyXg+yQ9S+qRsC+sJt
	 3FVBtM+/9YI/CdRNSSs1RFs5h7X3dIf9zstQno1O2hEBcg73csmIN5bYP4epxodaoX
	 I7xrmIsBFMGKg==
X-Pm-Submission-Id: 4bWd641M5pz1DDrG
From: Sean Nyekjaer <sean@geanix.com>
Date: Tue, 01 Jul 2025 11:29:29 +0200
Subject: [PATCH 2/4] sim: Show forbidden operator list(PLMN) with
 GetProperties
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-fplmn-v1-2-d7fe9c901b57@geanix.com>
References: <20250701-fplmn-v1-0-d7fe9c901b57@geanix.com>
In-Reply-To: <20250701-fplmn-v1-0-d7fe9c901b57@geanix.com>
To: denkenz@gmail.com, ofono@lists.linux.dev
X-Mailer: b4 0.14.2

---
 src/sim.c     | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/simutil.h |  1 +
 2 files changed, 61 insertions(+)

diff --git a/src/sim.c b/src/sim.c
index 7d9a180abd0c5b7adedebfe7026125dbada9752e..c33ee27058a0f1624d1f8f162cf7624bf3305da4 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -55,6 +55,11 @@ struct ofono_sim_aid_session {
 	enum session_state state;
 };
 
+struct ofono_fplmn {
+	char mcc[OFONO_MAX_MCC_LENGTH + 1];
+	char mnc[OFONO_MAX_MNC_LENGTH + 1];
+};
+
 struct ofono_sim {
 	/* Contents of the SIM file system, in rough initialization order */
 	char *iccid;
@@ -119,6 +124,8 @@ struct ofono_sim {
 	unsigned int active_card_slot;
 	unsigned int pending_active_card_slot;
 
+	struct ofono_fplmn fplmn[SIM_MAX_FPLMN];
+
 	GSList *aid_sessions;
 	GSList *aid_list;
 	char *impi;
@@ -341,6 +348,25 @@ static char **get_service_numbers(GSList *service_numbers)
 	return ret;
 }
 
+static char **get_fplmns(struct ofono_sim *sim)
+{
+	int i;
+	char **ret;
+
+	ret = l_new(char *, SIM_MAX_FPLMN + 1);
+
+	for (i = 0; i < SIM_MAX_FPLMN; i++) {
+		if (sim->fplmn[i].mcc[0] != 0) {
+			ret[i] = l_strdup_printf("%s%s", sim->fplmn[i].mcc,
+					sim->fplmn[i].mnc);
+
+			DBG("%s", ret[i]);
+		}
+	}
+
+	return ret;
+}
+
 static void service_number_free(gpointer pointer)
 {
 	struct service_number *num = pointer;
@@ -377,6 +403,9 @@ static DBusMessage *sim_get_properties(DBusConnection *conn,
 	dbus_bool_t present = sim->state != OFONO_SIM_STATE_NOT_PRESENT;
 	dbus_bool_t fdn;
 	dbus_bool_t bdn;
+	char **fplmn;
+
+	DBG("");
 
 	reply = dbus_message_new_method_return(msg);
 	if (reply == NULL)
@@ -465,6 +494,11 @@ static DBusMessage *sim_get_properties(DBusConnection *conn,
 	ofono_dbus_dict_append(&dict, "ActiveCardSlot", DBUS_TYPE_UINT32,
 							&sim->active_card_slot);
 
+	fplmn = get_fplmns(sim);
+	ofono_dbus_dict_append_array(&dict, "ForbiddenPLMN",
+					DBUS_TYPE_STRING, &fplmn);
+	l_strv_free(fplmn);
+
 	g_free(pin_retries_dict);
 	g_free(dbus_retries);
 
@@ -1720,6 +1754,29 @@ static void sim_efimg_changed(int id, void *userdata)
 	/* TODO: notify D-bus clients */
 }
 
+static void sim_fplmn_cb(const struct ofono_error *error,
+			 const unsigned char *data, int len, void *user)
+{
+	struct ofono_sim *sim = user;
+	int i;
+
+	if (error->type != OFONO_ERROR_TYPE_NO_ERROR || len != 12) {
+		ofono_error("Unable to read Forbidden PLMN");
+		return;
+	}
+
+	for (i = 0; i < SIM_MAX_FPLMN; i++, data += 3) {
+		/* Only update valid entries */
+		if (*data != 0xff) {
+			sim_parse_mcc_mnc(data, sim->fplmn[i].mcc, sim->fplmn[i].mnc);
+			sim->fplmn[i].mcc[OFONO_MAX_MCC_LENGTH] = '\0';
+			sim->fplmn[i].mnc[OFONO_MAX_MNC_LENGTH] = '\0';
+
+			DBG("fplmn[%d] mcc %s, mnc %s\n", i, sim->fplmn[i].mcc, sim->fplmn[i].mnc);
+		}
+	}
+}
+
 static void sim_ready(enum ofono_sim_state new_state, void *user)
 {
 	struct ofono_sim *sim = user;
@@ -1752,6 +1809,9 @@ static void sim_ready(enum ofono_sim_state new_state, void *user)
 			OFONO_SIM_FILE_STRUCTURE_FIXED, sim_efimg_read_cb, sim);
 	ofono_sim_add_file_watch(sim->context, SIM_EFIMG_FILEID,
 					sim_efimg_changed, sim, NULL);
+
+	sim->driver->read_file_transparent(sim, SIM_EF_PLMN_FILEID, 0, 12,
+						NULL, 0, sim_fplmn_cb, sim);
 }
 
 static void sim_set_ready(struct ofono_sim *sim)
diff --git a/src/simutil.h b/src/simutil.h
index 556412c4eaa089789092caa72fc3d8dd7ad5b00f..43767595e0898a5178186cdf55a65e8870cb7203 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -10,6 +10,7 @@
 
 #define SIM_EFSPN_DC_HOME_PLMN_BIT 0x1
 #define SIM_EFSPN_DC_ROAMING_SPN_BIT 0x2
+#define SIM_MAX_FPLMN 4
 
 enum sim_fileid {
 	SIM_EFPL_FILEID =			0x2F05,

-- 
2.49.0

