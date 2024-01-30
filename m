Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D1E78B6B
	for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 21:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649756; cv=none; b=otUo9g6zyxHidFV822+n2vCuuqoDxRC4GdIW8QRG/jW+DeswtShAAatR8CdFyWanR8K0ir7QfrpuEWAszFHWehtUFX1i7lR6ImFCenVwQoZxcTz6modPIPHY5BrbPaFIJ5XLLEZzPcvnCiSCnWr+pBHZHJbBJuhiQABmrlX2U1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649756; c=relaxed/simple;
	bh=3QV3ma7/uzwM4oylamqffSp6Qw81djNiReXkbSzAgoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hoV+ZfdJm73h5Jk6kEFpI7T+BpT0NM0+AYiz+/vllwuxnA5M5nibOx+bPtgFo6YkCW+cBK9SipMS3nPW0H1dWOAKahnKARWx+Nr7DqYlMBaMTnwGyLEIYSXuYhkcGruYM3sY4BaeS/eIkhRLuImI1jVfdBf91dn6KotPCszevH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiGrltLv; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiGrltLv"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2185d5f4366so1587069fac.2
        for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 13:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706649754; x=1707254554; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yhlyj12NGSzJjxgnXEsxEUSdEARBAKn0LKDhQKEgKGA=;
        b=CiGrltLvFX/mJx4dwuzopX0PXa7ajViQLyCee8/nnvbyaXE57oM1EaGHBkqVg48eL4
         GdojKgo1ThfN9aXbJLcYCYg87Gmy89AVw9QNjrdZ1rQciDhaB6BZZAzm4OtLdiHFZomn
         bhtYuYwCsVrH7B+IBGZqQajwV94ec7rE8cDkFIo8zP08M+juSChWeJCurZ3Ngrp0X1Q6
         ffKtmgZfwvDoYT6HbMQUN1nqcsFjKaBqzDukB5EtQZd0VBKciU/UBChA0loq5LPd8Sbt
         Qn3J/xHuD6RAXA1O+N4vtgZSDorlidHzr40xypohf0lYgx2IJ2kJHJUrlqP3fFDn7snY
         ovEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706649754; x=1707254554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yhlyj12NGSzJjxgnXEsxEUSdEARBAKn0LKDhQKEgKGA=;
        b=hiEDaQKhy3MJrdqhN8kiY2ct1eduKxArYjl06oISie2FRCUvo/eb6kO6oWHFVrl274
         mc9N4607rVm5bRurr5BpXFghX6sNE3XXqbxMOR8C40OGxm/Q5PlqRKJUg2ZTr5ebUZv8
         SZglgfaTG/2gssERiDsSUnb+iG2H4gXsUERzVw00Sd16P334Z8I13xus5xl3q71+XN4p
         9HWjbFW1HpXsOBHdyZ1oWPX+B+xCk/jcCpCo/ARfiaMwpDWVo3bfoTJmRYGtqzjBTFsX
         RX2ANHgJGjWtQj9AiFt8V3Juw7WSBrWiP+V61ZjKrxp1cb5xdCp1IwFMMdDLkT2dB82d
         Rh/Q==
X-Gm-Message-State: AOJu0YyDeqgmJbke1Lm/Qoe2OZy51diHvjr9nlY6Vq/Yb4ZSWM468K3e
	h6lS52g6OzDujF/FU/z2QkonBZZb5ygLYS+8LsnY+evmkHatGas/F5OyQynD
X-Google-Smtp-Source: AGHT+IFKWAgcABMRh7293Sum85IiPt6KU1pco1qDz56PcW3tL/3GzAO4hYEtIXmt5boW9CwhFX+Xww==
X-Received: by 2002:a05:6870:c08a:b0:218:515f:a81c with SMTP id c10-20020a056870c08a00b00218515fa81cmr6376732oad.6.1706649754184;
        Tue, 30 Jan 2024 13:22:34 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id n1-20020a056870a44100b002185412083bsm2105786oal.0.2024.01.30.13.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:22:33 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 15/17] lte: Add provisioning support
Date: Tue, 30 Jan 2024 15:21:20 -0600
Message-ID: <20240130212137.814082-15-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130212137.814082-1-denkenz@gmail.com>
References: <20240130212137.814082-1-denkenz@gmail.com>
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
settings to the the driver and register the interface with D-Bus.
---
 src/lte.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 82 insertions(+), 4 deletions(-)

diff --git a/src/lte.c b/src/lte.c
index d412e15d90f9..433b18956468 100644
--- a/src/lte.c
+++ b/src/lte.c
@@ -37,6 +37,7 @@
 
 #include "ofono.h"
 
+#include "provisiondb.h"
 #include "common.h"
 #include "storage.h"
 
@@ -56,8 +57,54 @@ struct ofono_lte {
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
@@ -361,6 +408,11 @@ static void lte_atom_unregister(struct ofono_atom *atom)
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
@@ -394,11 +446,38 @@ static void lte_init_default_attach_info_cb(const struct ofono_error *error,
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
@@ -406,7 +485,6 @@ void ofono_lte_register(struct ofono_lte *lte)
 		return;
 	}
 
-finish_register:
 	ofono_lte_finish_register(lte);
 }
 
-- 
2.43.0

