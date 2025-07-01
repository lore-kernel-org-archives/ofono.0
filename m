Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6B626E6E4
	for <ofono@lists.linux.dev>; Tue,  1 Jul 2025 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751362203; cv=none; b=aVK/vePudnw4XTHwg0UyByeejHZco9a+RVS0wIJ+p1AbiMI1BydammFoiM2kLa/RNf3PA6R2qsnu+3M6XVchf/PcS5JZcFke0nCQZ7aAzvlhom4970UyNWId8pPNd9Emb85StTVcaVGCDeGzD7nUKO7FOdzdFi9FJBvyCADJCEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751362203; c=relaxed/simple;
	bh=BvjIpbCNvtbH70i3J48sCSBVimtRo4bS3ozn4jU8HuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=Lgw61HHnptZLiaD+vsIiyWS168j3mIyy4d6PFhlmjp8fJs7kxpqjsY7Zu1mf2GlE5ke7rWB2jqylQ+Pkh1G1atRgofrqcKq7b4mHEdEE5YKA+GCfork7BxuUtj5/4bjNEY/E2q6NiV02y6X7lXK3n4pdsCk09ZRkcXZhZBTGcZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=rJWrIV7H; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="rJWrIV7H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1751362190; x=1751621390;
	bh=GihPgXfbwMx8aHULhTKzr4CnujKTWqWmgzoWOuqhm2A=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:From:To:Cc:
	 Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=rJWrIV7HZiHiIBsk4rmLFO/thfsc/YqKy6052RgRs2fo6jVeUvzaz22pM61zrHZJn
	 oSQ0QBrJ/N5+Vlg/kfrbRJxak8c2h9LO+52Gpl4qz/3e6+yQI6gLpMERstv0lge+N7
	 TYbFsGe2OxYKMTDrDHVxf4Kv3VQRliDi5ZvPoQqdHWAqZytpOhuS0Flr1fLjFDiGPQ
	 8mLxQsp29YQBzTBs4+39Kj9f1Ij0C2IV1xCC2Kp2wUXtkXZvfAUZb4QRJLi2Epw5iM
	 I2RNXU2ph1jMtXRV7dHH/LqwngimQzlNFDBrmjIogS/qRL7zMcLpeGGx/tg/bix+dD
	 /VBo/qjtBXveA==
X-Pm-Submission-Id: 4bWd651FXjz1DDrL
From: Sean Nyekjaer <sean@geanix.com>
Date: Tue, 01 Jul 2025 11:29:30 +0200
Subject: [PATCH 3/4] sim: Allow SetProperties to set forbidden operator
 list(PLMN)
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-fplmn-v1-3-d7fe9c901b57@geanix.com>
References: <20250701-fplmn-v1-0-d7fe9c901b57@geanix.com>
In-Reply-To: <20250701-fplmn-v1-0-d7fe9c901b57@geanix.com>
To: denkenz@gmail.com, ofono@lists.linux.dev
X-Mailer: b4 0.14.2

ForbiddenPLMN allows to set a maximum of 4 PLMN's.
---
 src/sim.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/src/sim.c b/src/sim.c
index c33ee27058a0f1624d1f8f162cf7624bf3305da4..80d20dd9474d6357f54c35f63ee9adade0cede53 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -150,6 +150,11 @@ struct msisdn_set_request {
 	DBusMessage *msg;
 };
 
+struct fplmn_set_request {
+	struct ofono_sim *sim;
+	DBusMessage *msg;
+};
+
 struct service_number {
 	char *id;
 	struct ofono_phone_number ph;
@@ -683,6 +688,37 @@ static gboolean set_own_numbers(struct ofono_sim *sim,
 	return TRUE;
 }
 
+static void sim_efplmn_cb(const struct ofono_error *error, void *data)
+{
+	DBusMessage *reply;
+	struct fplmn_set_request *req = data;
+
+	if (error->type != OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_error("Unable to clear Forbidden PLMN");
+		reply = __ofono_error_failed(req->msg);
+	} else {
+		reply = dbus_message_new_method_return(req->msg);
+	}
+
+	__ofono_dbus_pending_reply(&req->msg, reply);
+
+	l_free(req);
+}
+
+static void sim_set_forbidden_plmn(struct ofono_sim *sim,
+				   const uint8_t *plmn_list, DBusMessage *msg)
+{
+	struct fplmn_set_request *req;
+
+	req = l_new(struct fplmn_set_request, 1);
+
+	req->sim = sim;
+	req->msg = dbus_message_ref(msg);
+
+	sim->driver->write_file_transparent(sim, SIM_EF_PLMN_FILEID, 0, 12,
+					plmn_list, NULL, 0, sim_efplmn_cb, req);
+}
+
 static void sim_set_slot_callback(const struct ofono_error *error, void *data)
 {
 	struct ofono_sim *sim = data;
@@ -721,6 +757,7 @@ static DBusMessage *sim_set_property(DBusConnection *conn, DBusMessage *msg,
 	DBusMessageIter var;
 	DBusMessageIter var_elem;
 	const char *name, *value;
+	uint8_t plmn_list[12], i;
 
 	if (!dbus_message_iter_init(msg, &iter))
 		return __ofono_error_invalid_args(msg);
@@ -811,6 +848,51 @@ error:
 							sim_set_slot_callback,
 							sim);
 		return NULL;
+	} else if (!strcmp(name, "ForbiddenPLMN")) {
+		dbus_message_iter_next(&iter);
+
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_recurse(&iter, &var);
+
+		if (dbus_message_iter_get_arg_type(&var) != DBUS_TYPE_ARRAY ||
+				dbus_message_iter_get_element_type(&var) !=
+				DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_recurse(&var, &var_elem);
+
+		i = 0;
+		memset(plmn_list, 0xFF, sizeof(plmn_list));
+
+		/* Empty lists are supported */
+		while (dbus_message_iter_get_arg_type(&var_elem) !=
+				DBUS_TYPE_INVALID) {
+			if (dbus_message_iter_get_arg_type(&var_elem) !=
+					DBUS_TYPE_STRING)
+				return __ofono_error_invalid_args(msg);
+
+			if (i > 3)
+				return __ofono_error_invalid_args(msg);
+
+			dbus_message_iter_get_basic(&var_elem, &value);
+
+			DBG("%s %d", value, strlen(value));
+
+			if (!(strlen(value) == 5 || strlen(value) == 6))
+				return __ofono_error_invalid_args(msg);
+
+			sim_encode_mcc_mnc(plmn_list + i * 3, value, value + 3);
+
+			i++;
+
+			dbus_message_iter_next(&var_elem);
+		}
+
+		sim_set_forbidden_plmn(sim, plmn_list, msg);
+
+		return NULL;
 	}
 
 	return __ofono_error_invalid_args(msg);

-- 
2.49.0

