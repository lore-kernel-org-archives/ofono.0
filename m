Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862D61E5711
	for <ofono@lists.linux.dev>; Thu,  3 Jul 2025 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751543328; cv=none; b=kpIRulmBQlGL4kEWbSNkmxMHm/MC587vh7R4Oje8vFpmpPjHAJaByUwT7mQigg+J/b0fXttU5wLR0hA0FON0l8YNik6/p1FGZQrP4V6bJb8V37fbCdoGAYFiX9IM4Srgkuqp2EJ5pQQW14UJ4Q+RvA4g6wk5lwtiRtTFVck9HCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751543328; c=relaxed/simple;
	bh=I2Ht8rXS87FONaDrfaM/X5Zm44aSvNK0J00c9/c3w8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=pR47Kj/L5hX/ruiqp/o8MQd2AHvIpLDBdirVJV012cRFSrFJD0/65CjoGut0TGr+JnqBIX7iAfFj24VWxFXT+sxitDi2x+nHcs5zqPGKn4Bwt8tHA4oxsSWbJz2FV6wcm+5HOmtsQJAQm8xLQGfflYwbBQOe3ypqFwTYV5Bwh04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=JYWqmlPb; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="JYWqmlPb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1751543317; x=1751802517;
	bh=n9YlTYvHIBUIMEov7LdaVqVKLrn/jnRMuaHvpF6QN9g=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:From:To:Cc:
	 Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=JYWqmlPbQzR1dd/xzABNgawOg4EQIoVfoXq4/J6GP8Hc69eJEwlP+dMMWFXlPGU07
	 SvM3gCCdm1oCTG+N1fqTKY7gCZkEXcAc8ztlqXlGuDGWy78Jo4YhvRNYr7Y9dIAXym
	 etXMyW0J0tPisL/pSD2c3gAI7Fj6vSKL13huj4qiemGFaTAA2SVyJN0z9z3bkNm9Ka
	 4JJ80oGvV+c3++gAZf/t7GiUKE4VA4By4HDZKa6odO3VSVdjyAyFHqZflojyJ9pdyz
	 +WMbjmHfcaxQw2yV7Ma2iZeJ06vraX3vBVuOOKKDCS4fhuEOzsn4bl89m0vi/0yucY
	 mcCkaxDTKbWLg==
X-Pm-Submission-Id: 4bXw5J08Bkz1DDWt
From: Sean Nyekjaer <sean@geanix.com>
Date: Thu, 03 Jul 2025 13:48:20 +0200
Subject: [PATCH v2 2/3] sim: Create new dbus method to clear the forbidden
 network operator list
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-fplmn-v2-2-6eb6335a7b8c@geanix.com>
References: <20250703-fplmn-v2-0-6eb6335a7b8c@geanix.com>
In-Reply-To: <20250703-fplmn-v2-0-6eb6335a7b8c@geanix.com>
To: denkenz@gmail.com, ofono@lists.linux.dev
X-Mailer: b4 0.14.2

To clear the list:
busctl call org.ofono /sim76xx_0 org.ofono.SimManager
ClearForbiddenNetworkOperators
---
 src/sim.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/src/sim.c b/src/sim.c
index 7d9a180abd0c5b7adedebfe7026125dbada9752e..4f72bd9ac1abf484fed77008c03cae9186b63c9e 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -143,6 +143,11 @@ struct msisdn_set_request {
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
@@ -649,6 +654,41 @@ static gboolean set_own_numbers(struct ofono_sim *sim,
 	return TRUE;
 }
 
+static void sim_efplmn_cb(const struct ofono_error *error, void *data)
+{
+	struct ofono_sim *sim = data;
+	DBusMessage *reply;
+
+	if (error->type != OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_error("Unable to clear Forbidden PLMN");
+		reply = __ofono_error_failed(sim->pending);
+	} else {
+		reply = dbus_message_new_method_return(sim->pending);
+	}
+
+	__ofono_dbus_pending_reply(&sim->pending, reply);
+}
+
+static DBusMessage *sim_clear_forbidden_plmn(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct ofono_sim *sim = data;
+	DBusMessageIter iter;
+	DBusMessageIter var;
+	static uint8_t plmn_list[12] = {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+					0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF};
+
+	if (sim->pending)
+		return __ofono_error_busy(msg);
+
+	sim->pending = dbus_message_ref(msg);
+
+	sim->driver->write_file_transparent(sim, SIM_EF_PLMN_FILEID, 0, 12,
+					plmn_list, NULL, 0, sim_efplmn_cb, sim);
+
+	return NULL;
+}
+
 static void sim_set_slot_callback(const struct ofono_error *error, void *data)
 {
 	struct ofono_sim *sim = data;
@@ -687,6 +727,7 @@ static DBusMessage *sim_set_property(DBusConnection *conn, DBusMessage *msg,
 	DBusMessageIter var;
 	DBusMessageIter var_elem;
 	const char *name, *value;
+	ofono_bool_t clear_fplmn;
 
 	if (!dbus_message_iter_init(msg, &iter))
 		return __ofono_error_invalid_args(msg);
@@ -1297,6 +1338,8 @@ static const GDBusMethodTable sim_methods[] = {
 	{ GDBUS_ASYNC_METHOD("SetProperty",
 			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
 			NULL, sim_set_property) },
+	{ GDBUS_ASYNC_METHOD("ClearForbiddenNetworkOperators",
+			NULL, NULL, sim_clear_forbidden_plmn) },
 	{ GDBUS_ASYNC_METHOD("ChangePin",
 			GDBUS_ARGS({ "type", "s" }, { "oldpin", "s" },
 						{ "newpin", "s" }), NULL,

-- 
2.49.0

