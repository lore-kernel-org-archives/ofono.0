Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526852D63EC
	for <ofono@lists.linux.dev>; Fri,  4 Jul 2025 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751631809; cv=none; b=T9sFojOecoyrCs6Mu3stHGR7YgcRRLDceFMhG1HC4kHa7bBre8f5Rep+Sf5/4Jr9PofmZZ1a0aZfYYqCUU+ryWDTwM5yo5fwZldcfOCNOlJG0kOBmx7BpW5pvGtrIx9yErp4wbhsdLQxiM/OEB7dUilqduQpHTE/8GyS2WRme1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751631809; c=relaxed/simple;
	bh=BZ8rDB3lhjVUmp16/lBCR7xpVgDmWf1OjnLZuROwa3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=D0nJHnPlz9g3zLkDgiR49dXRx+9iabMhTgNIKrZzuKkpFleAaxyQPGcqOwt81Vp30x8zRkbS2yd9tfDtfWA5mOV84Wylygc/lBiVnbr0qsG94CV9/qCURcv3nE8WIrZ9mV441QEXGxoXUFAqdhHeCgYXMXy/D5eCP+i30NQzFR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=pZXcZ0ra; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="pZXcZ0ra"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1751631797; x=1751890997;
	bh=1LdruV5YcU7t7xDbu7ULHStY4z1f7rqPIQENnikw4W0=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:From:To:Cc:
	 Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=pZXcZ0raxKoUDpxTjm41w+GPxNkB02rPb/wYm436dPQo7nu5LL3VA2TcZqqO93Nj1
	 mkrMO4sXwmGlPX/kjOcPhBjhljTwuueB/VsydifRAi6KFc8N47r1MpXuK5q1MXMPWr
	 vb2Rg5Knll2Z+3eTQ0W7SKUCtbME9UvD/uqW3axas1y4jWROximqdDClCei31qmADF
	 zzEGttZ7z6GObswZiII35oYgkBUpUyPK4loLXTT5RHztuiW4srxqX7RoG5QtIahhXd
	 ijfEzomjjYsJqgCmXMO7/hp6I13kyRAlLQhaViDX04EUmhCIKe7MlR25jNsvwcQH4k
	 na4bUc0lOdEIw==
X-Pm-Submission-Id: 4bYXps1t23zP8
From: Sean Nyekjaer <sean@geanix.com>
Date: Fri, 04 Jul 2025 14:23:14 +0200
Subject: [PATCH v3 2/3] sim: Create new dbus method to clear the forbidden
 network operator list
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250704-fplmn-v3-2-dbba340d6cfa@geanix.com>
References: <20250704-fplmn-v3-0-dbba340d6cfa@geanix.com>
In-Reply-To: <20250704-fplmn-v3-0-dbba340d6cfa@geanix.com>
To: denkenz@gmail.com, ofono@lists.linux.dev
X-Mailer: b4 0.14.2

To clear the list:
busctl call org.ofono /sim76xx_0 org.ofono.SimManager
ClearForbiddenNetworkOperators
---
 src/sim.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/src/sim.c b/src/sim.c
index 7d9a180abd0c5b7adedebfe7026125dbada9752e..dedb7d8d29407321ca842c614fa3c4a46c1096ed 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -649,6 +649,83 @@ static gboolean set_own_numbers(struct ofono_sim *sim,
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
+static void sim_fplmn_info_read_cb(int ok, unsigned char file_status,
+					int total_length, int record_length,
+					void *userdata)
+{
+	struct ofono_sim *sim = userdata;
+	uint8_t *plmn_list;
+	DBusMessage *reply;
+
+	if (!ok) {
+		reply = __ofono_error_failed(sim->pending);
+		goto out;
+	}
+
+	if (!(file_status & SIM_FILE_STATUS_VALID)) {
+		reply = __ofono_error_failed(sim->pending);
+		goto out;
+	}
+
+	if (sim->driver->write_file_transparent == NULL) {
+		reply = __ofono_error_not_implemented(sim->pending);
+		goto out;
+	}
+
+	DBG("total_length %d", total_length);
+
+	/* Minimum size according TS 31.102, Section 4.2.16 is 3n bytes, (n≥ 4) */
+	if (total_length < 12 || total_length % 3 != 0) {
+		reply = __ofono_error_failed(sim->pending);
+		goto out;
+	}
+
+	plmn_list = l_malloc(total_length);
+	memset(plmn_list, 0xFF, total_length);
+
+	sim->driver->write_file_transparent(sim, SIM_EF_FPLMN_FILEID, 0, total_length,
+					plmn_list, NULL, 0, sim_efplmn_cb, sim);
+
+	l_free(plmn_list);
+
+	return;
+
+out:
+	__ofono_dbus_pending_reply(&sim->pending, reply);
+}
+
+static DBusMessage *sim_clear_forbidden_plmn(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct ofono_sim *sim = data;
+
+	if (sim->pending)
+		return __ofono_error_busy(msg);
+
+	sim->pending = dbus_message_ref(msg);
+
+	sim_fs_read_info(sim->context, SIM_EF_FPLMN_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+			sim_fplmn_info_read_cb, sim);
+
+	return NULL;
+}
+
 static void sim_set_slot_callback(const struct ofono_error *error, void *data)
 {
 	struct ofono_sim *sim = data;
@@ -1297,6 +1374,8 @@ static const GDBusMethodTable sim_methods[] = {
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

