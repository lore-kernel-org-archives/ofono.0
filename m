Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A01B12C810
	for <ofono@lists.linux.dev>; Fri,  2 Feb 2024 22:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706914509; cv=none; b=Iv9AzSUZArhU59YEc9Jz8b0037AsU6QpymxbABSAbKxo5rKmOvCIklsq2KulggzjpkNRherI/SvHSKiOzJjMRerWTGRLoEVcnRzbezweJ7BhIe9i55rIzEbWoOkMcmVF0tdqBY21KQV7fN6ukYitfnF4EbUXoqkvslCIasiOVmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706914509; c=relaxed/simple;
	bh=Rvf1wt3DL1gF68gWo0UPhRqEBRVsnomfRS7T6APvh24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXeDTIocvW3LfUU/RjXJT8Zh26BY8u3ttM/RgRRRaWZzLYNyhDL3YhpJFOm5sUxa0NUTh2TBpxu8f1rode9yciWeMCkWGTH6IsesTio7t94cq9ayayQD+xu62F+rRb5oK0+ANDUo0KZ8fNAGc1GzUVq3ZRJCEYZq6JfYnEz9fjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJq7N4Vt; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJq7N4Vt"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e118b528aeso1310390a34.1
        for <ofono@lists.linux.dev>; Fri, 02 Feb 2024 14:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706914506; x=1707519306; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KYQimDqzavqIfuniZATZ7O2xCetUFdJmq2iH0KiZLg=;
        b=KJq7N4Vt9DmA76dXer9yei8ceY7Ze1kvhHym82pYE9NRSinY+EEWi8B2aTd8YqNd3N
         IUEfbgPjjb2RC3e3MqA5tlPpCOdcHhKKQAxBPUPah2LZoqlYBRIPGKSlz/x/yiMvZLXe
         S+VnGWPLruqds5CCWRo9A6ViY2Q5WloslSPPuIuzn6+qGV0J/v0ypKvBtGC8+sVOCDg2
         K1w1KK0vdwXcDezpPZHWRdrdulh3Yl6+NkArfuvowymFvBp13dfD3knEn61H93owNwM7
         EHBwsh4zHZ7/7cwjUNKtdHixN+cbj/KCU4lxS9+3xEgKZXEOda/7vMM/H6s7/FpaBHtc
         hAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706914506; x=1707519306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KYQimDqzavqIfuniZATZ7O2xCetUFdJmq2iH0KiZLg=;
        b=ibl4PLVZZfIS/1ZAnpNZW+hA7Trbw9XfX166D/y4R1fNiM9yQMwHnB7/tPwl0v2feC
         atlE8agYs33zaxZM2g2HKFi1j8gBUxg/Tg9wuWfk10+HykOIDR0bxCRNIZOIpV8m88fI
         KOaTCrWDzfWM04MzIjAhXujDbEJwFz2NFTlDJwig7AG7GwlN+6ISGR1ileYifrKiXa60
         GaSgfxhpPCeYilmGAoa3o27WeswWmbgD44PTtKYzPv5u2oTGPvLBfu+sCI2DdDhVCgN0
         bZSmpFUlN7cEcAYQKqks7AVK/XEbV5YnOh2kbJ5JXPt2z15s5nQ1DYL2kveVvaSKiJnr
         54/A==
X-Gm-Message-State: AOJu0YzxE5gYR3QB22/PZk3cIqTMbJu6+DJnBb/kjsfSskIZTq5/7Y0i
	zVjS5r1ITq8ssl4dc9EkvKLgXVapZvBDYGFbChCh5LbECVq3FI1MIf7tBLRX
X-Google-Smtp-Source: AGHT+IFaHa7FMbc4h+KluSkxLV6S5PRR4+mSL9xk56ei3uTpDLPaVZg+tdkNvUpLc7qr737/8L9Ctw==
X-Received: by 2002:a05:6830:157:b0:6e1:7b4:833c with SMTP id j23-20020a056830015700b006e107b4833cmr7995738otp.15.1706914506064;
        Fri, 02 Feb 2024 14:55:06 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id j20-20020a9d7d94000000b006e1424847d2sm563485otn.12.2024.02.02.14.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:55:05 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 16/18] lte: Add provisioning support
Date: Fri,  2 Feb 2024 16:53:48 -0600
Message-ID: <20240202225405.993792-16-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202225405.993792-1-denkenz@gmail.com>
References: <20240202225405.993792-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If settings do not exist on disk, try to obtain them from the
provisioning database.  This requires for lte atom to wait until the
EFspn has been read from the SIM.  This is accomplished by creating a
sim spn watch and providing a callback.

When the callback is invoked, try to provision settings with the
MCC/MNC/SPN.  If provisioning succeeds, set the settings into the
currently active default_attach_info.  In all cases, forward the
settings to the driver and register the interface with D-Bus.
---
 src/lte.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 82 insertions(+), 4 deletions(-)

diff --git a/src/lte.c b/src/lte.c
index 158c8e9c2b17..706d596b59b2 100644
--- a/src/lte.c
+++ b/src/lte.c
@@ -36,6 +36,7 @@
 
 #include "ofono.h"
 
+#include "provisiondb.h"
 #include "common.h"
 #include "storage.h"
 
@@ -55,8 +56,54 @@ struct ofono_lte {
 	DBusMessage *pending;
 	struct ofono_lte_default_attach_info pending_info;
 	struct ofono_lte_default_attach_info info;
+	unsigned int spn_watch;
 };
 
+static bool provision_default_attach_info(struct ofono_lte *lte,
+						const char *mcc, const char *mnc,
+						const char *spn)
+{
+	struct provision_db_entry *settings;
+	_auto_(l_free) const struct provision_db_entry *ap = NULL;
+	size_t count;
+	size_t i;
+
+	DBG("Provisioning default bearer info with mcc:'%s', mnc:'%s', spn:'%s'",
+			mcc, mnc, spn);
+
+	if (!__ofono_provision_get_settings(mcc, mnc, spn, &settings, &count))
+		return false;
+
+	DBG("Obtained %zu candidates", count);
+
+	for (i = 0; i < count; i++) {
+		if (settings[i].type & OFONO_GPRS_CONTEXT_TYPE_IA) {
+			ap = &settings[i];
+			break;
+		}
+	}
+
+	if (!is_valid_apn(ap->apn))
+		return false;
+
+	if (ap->username && strlen(ap->username) >
+			OFONO_GPRS_MAX_USERNAME_LENGTH)
+		return false;
+
+	if (ap->password && strlen(ap->password) >
+			OFONO_GPRS_MAX_PASSWORD_LENGTH)
+		return false;
+
+	l_strlcpy(lte->info.apn, ap->apn, sizeof(lte->info.apn));
+	l_strlcpy(lte->info.username, ap->username, sizeof(lte->info.username));
+	l_strlcpy(lte->info.password, ap->password, sizeof(lte->info.password));
+	lte->info.proto = ap->proto;
+	lte->info.auth_method = ap->auth_method;
+
+	DBG("Provisioned successfully");
+	return true;
+}
+
 static int lte_load_settings(struct ofono_lte *lte)
 {
 	struct ofono_modem *modem = __ofono_atom_get_modem(lte->atom);
@@ -360,6 +407,11 @@ static void lte_atom_unregister(struct ofono_atom *atom)
 	DBusConnection *conn = ofono_dbus_get_connection();
 	struct ofono_modem *modem = __ofono_atom_get_modem(atom);
 	const char *path = __ofono_atom_get_path(atom);
+	struct ofono_lte *lte = __ofono_atom_get_data(atom);
+	struct ofono_sim *sim = __ofono_atom_find(OFONO_ATOM_TYPE_SIM, modem);
+
+	if (lte->spn_watch)
+		ofono_sim_remove_spn_watch(sim, &lte->spn_watch);
 
 	ofono_modem_remove_interface(modem, OFONO_LTE_INTERFACE);
 	g_dbus_unregister_interface(conn, path, OFONO_LTE_INTERFACE);
@@ -393,11 +445,38 @@ static void lte_init_default_attach_info_cb(const struct ofono_error *error,
 	ofono_lte_finish_register(lte);
 }
 
+static void spn_read_cb(const char *spn, const char *dc, void *data)
+{
+	struct ofono_lte *lte = data;
+	struct ofono_modem *modem = __ofono_atom_get_modem(lte->atom);
+	struct ofono_sim *sim = __ofono_atom_find(OFONO_ATOM_TYPE_SIM, modem);
+
+	ofono_sim_remove_spn_watch(sim, &lte->spn_watch);
+
+	provision_default_attach_info(lte, ofono_sim_get_mcc(sim),
+					ofono_sim_get_mnc(sim), spn);
+
+	if (lte->driver->set_default_attach_info) {
+		lte->driver->set_default_attach_info(lte, &lte->info,
+					lte_init_default_attach_info_cb, lte);
+		return;
+	}
+
+	ofono_lte_finish_register(lte);
+}
+
 void ofono_lte_register(struct ofono_lte *lte)
 {
-	/* No settings, go straight to registering the interface on D-Bus */
-	if (lte_load_settings(lte) < 0)
-		goto finish_register;
+	/* Wait for SPN to be read in order to try provisioning */
+	if (lte_load_settings(lte) < 0) {
+		struct ofono_modem *modem = __ofono_atom_get_modem(lte->atom);
+		struct ofono_sim *sim = __ofono_atom_find(OFONO_ATOM_TYPE_SIM,
+								modem);
+
+		ofono_sim_add_spn_watch(sim, &lte->spn_watch,
+						spn_read_cb, lte, NULL);
+		return;
+	}
 
 	if (lte->driver->set_default_attach_info) {
 		lte->driver->set_default_attach_info(lte, &lte->info,
@@ -405,7 +484,6 @@ void ofono_lte_register(struct ofono_lte *lte)
 		return;
 	}
 
-finish_register:
 	ofono_lte_finish_register(lte);
 }
 
-- 
2.43.0

