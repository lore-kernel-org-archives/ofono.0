Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8922332EB2
	for <ofono@lists.linux.dev>; Fri, 28 Nov 2025 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764351450; cv=none; b=JmbocSrAk3phmWRjXemuV3v8wwaSC2oxa+QXuhHiPvTHm85RSzJOwNNlqGKqtdWsDZjbd+9u/mP2j5C2OSkjNcs0u0qnUAPE8ZvWG76PrSDf5UbjZUeNVcn92x52q954ZH1twT7G/7W7FlvaPKlqJv8H06E5rr8KikFFoK++Jd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764351450; c=relaxed/simple;
	bh=RP1yo7B3p6fFkdgpYv6osGo30mJnzcaSQVyua7+vYW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b6Os+vWNWP78IxRvBNUKeOqtshXgjoTSzJ3sIXtOSiA6qdUZxXtFOajwvqpsHpyjOpi5ilIVRcGd1uY0r4I3Px7dAY9dp5TXmi8Ji9s2HbFMUNGzUqrwkWG+kQN6+d6ZoQNodnCyCTW4CW9qXfo5dAx91Zi9+9EnNnGfTUseqJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Sw/kxZyy; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Sw/kxZyy"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=Sw/kxZyy0G38fehkFC1Y6WvPD9D8R1bmNAcXdi6oTPS78vySsca8/2Nlrog/mVfQ2U9GQ8mzUF9S8MWFgHfWZg7y48lm0y8zIavsOBNVkawAP7JC2kplMFji8MIBJcsEIcmwCOoBPBcG3QS62UhJJwXCvBZoFLJWwpBwdo2Dri7T/i5yimW3eV5K6U1fZuV4Hfg8xDbGz7VJGGj6fHouzOksTu/RSH4QGPb+0OVZ9y8SWkHvi+vA1hTgLxJ2Rxa6KiQOf7beSkvT3hpmLh5hdn+BNk6dRb7WGRGsbbj3noI8LLn0Nkw8/9xKf/TbD3GZTD85gmaAWqOPBMBLCVmKVg==; s=purelymail2; d=purelymail.com; v=1; bh=RP1yo7B3p6fFkdgpYv6osGo30mJnzcaSQVyua7+vYW8=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1079628981;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 28 Nov 2025 17:37:25 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono <ofono@lists.linux.dev>
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v7 10/10] mbim/network-registration: add support for manual registration
Date: Fri, 28 Nov 2025 22:36:56 +0500
Message-ID: <20251128173656.55692-11-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251128173656.55692-1-thevancedgamer@mentallysanemainliners.org>
References: <20251128173656.55692-1-thevancedgamer@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Adds support for scanning available operators, and manually registering
to a selected network.
---
 drivers/mbimmodem/mbim.h                 |  15 ++++
 drivers/mbimmodem/network-registration.c | 103 ++++++++++++++++++++++-
 drivers/mbimmodem/util.c                 |  20 +++++
 drivers/mbimmodem/util.h                 |   1 +
 4 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/drivers/mbimmodem/mbim.h b/drivers/mbimmodem/mbim.h
index 70142cc9..b0825060 100644
--- a/drivers/mbimmodem/mbim.h
+++ b/drivers/mbimmodem/mbim.h
@@ -80,6 +80,21 @@ enum mbim_data_class {
 =09MBIM_DATA_CLASS_CUSTOM=09=09=3D 0x80000000,
 };
=20
+enum mbim_provider_state {
+=09MBIM_PROVIDER_STATE_UNKNOWN                =3D 0,
+=09MBIM_PROVIDER_STATE_HOME                   =3D 1 << 0,
+=09MBIM_PROVIDER_STATE_FORBIDDEN              =3D 1 << 1,
+=09MBIM_PROVIDER_STATE_PREFERRED              =3D 1 << 2,
+=09MBIM_PROVIDER_STATE_VISIBLE                =3D 1 << 3,
+=09MBIM_PROVIDER_STATE_REGISTERED             =3D 1 << 4,
+=09MBIM_PROVIDER_STATE_PREFERRED_MULTICARRIER =3D 1 << 5
+};
+
+enum mbim_register_type {
+=09MBIM_REGISTER_TYPE_AUTOMATIC    =3D 0,
+=09MBIM_REGISTER_TYPE_MANUAL       =3D 1,
+};
+
 enum mbim_app_type {
 =09MBIM_APP_UNKNOWN,
 =09MBIM_APP_MF,
diff --git a/drivers/mbimmodem/network-registration.c b/drivers/mbimmodem/n=
etwork-registration.c
index ded1bf69..e95dd73a 100644
--- a/drivers/mbimmodem/network-registration.c
+++ b/drivers/mbimmodem/network-registration.c
@@ -204,6 +204,70 @@ static void mbim_current_operator(struct ofono_netreg =
*netreg,
 =09CALLBACK_WITH_FAILURE(cb, NULL, data);
 }
=20
+static void mbim_list_operators_cb(struct mbim_message *message,
+=09=09=09=09=09=09void *user)
+{
+=09struct cb_data *cb =3D user;
+=09ofono_netreg_operator_list_cb_t cb_func =3D cb->cb;
+=09struct ofono_network_operator *list =3D NULL;
+
+=09uint32_t providers_count, provider_state, cellular_class;
+=09uint32_t rssi, error_rate;
+=09char *provider_id, *provider_name;
+=09struct mbim_message_iter iter;
+=09int i =3D 0;
+
+=09if (!mbim_message_get_arguments(message, "ua(susuuu)", &providers_count=
, &iter)) {
+=09=09CALLBACK_WITH_FAILURE(cb_func, 0, NULL, cb->data);
+=09=09return;
+=09}
+
+=09list =3D l_new(struct ofono_network_operator, providers_count);
+
+=09while (mbim_message_iter_next_entry(&iter, &provider_id, &provider_stat=
e,
+=09=09=09=09=09&provider_name, &cellular_class, &rssi, &error_rate)) {
+
+=09=09strcpy(list[i].name, provider_name);
+=09=09strncpy(list[i].mcc, provider_id, OFONO_MAX_MCC_LENGTH);
+=09=09list[i].mcc[OFONO_MAX_MCC_LENGTH] =3D '\0';
+
+=09=09strncpy(list[i].mnc, provider_id + OFONO_MAX_MCC_LENGTH, OFONO_MAX_M=
NC_LENGTH);
+=09=09list[i].mnc[OFONO_MAX_MNC_LENGTH] =3D '\0';
+
+=09=09list[i].status =3D mbim_provider_state_to_status(provider_state);
+=09=09list[i].tech =3D -1;
+
+=09=09i++;
+=09}
+
+=09if (list)
+=09=09CALLBACK_WITH_SUCCESS(cb_func, providers_count, list, cb->data);
+=09else
+=09=09CALLBACK_WITH_FAILURE(cb_func, 0, NULL, cb->data);
+}
+
+static void mbim_list_operators(struct ofono_netreg *netreg,
+=09=09=09=09=09ofono_netreg_operator_list_cb_t cb, void *user_data)
+{
+=09struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+=09struct cb_data *cbd =3D cb_data_new(cb, user_data);
+=09struct mbim_message *message;
+
+=09message =3D mbim_message_new(mbim_uuid_basic_connect,
+=09=09=09=09=09=09MBIM_CID_VISIBLE_PROVIDERS,
+=09=09=09=09=09=09MBIM_COMMAND_TYPE_QUERY);
+=09/* "0" is a full scan, whereas "1" means a restricted scan */
+=09mbim_message_set_arguments(message, "u", 0);
+
+=09if (mbim_device_send(nd->device, NETREG_GROUP, message,
+=09=09=09=09=09=09mbim_list_operators_cb, cbd, l_free) > 0)
+=09=09return;
+
+=09l_free(cbd);
+=09mbim_message_unref(message);
+=09CALLBACK_WITH_FAILURE(cb, 0, NULL, user_data);
+}
+
 static void mbim_register_state_set_cb(struct mbim_message *message, void =
*user)
 {
 =09struct cb_data *cbd =3D user;
@@ -233,7 +297,42 @@ static void mbim_register_auto(struct ofono_netreg *ne=
treg,
 =09message =3D mbim_message_new(mbim_uuid_basic_connect,
 =09=09=09=09=09MBIM_CID_REGISTER_STATE,
 =09=09=09=09=09MBIM_COMMAND_TYPE_SET);
-=09mbim_message_set_arguments(message, "suu", NULL, 0, data_class);
+=09mbim_message_set_arguments(message, "suu", NULL,
+=09=09=09=09=09MBIM_REGISTER_TYPE_AUTOMATIC, data_class);
+
+=09if (mbim_device_send(nd->device, NETREG_GROUP, message,
+=09=09=09=09mbim_register_state_set_cb, cbd, l_free) > 0)
+=09=09return;
+
+=09l_free(cbd);
+=09mbim_message_unref(message);
+=09CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void mbim_register_manual(struct ofono_netreg *netreg,
+=09=09=09=09const char *mcc, const char *mnc,
+=09=09=09=09ofono_netreg_register_cb_t cb, void *data)
+{
+=09static const uint32_t data_class =3D MBIM_DATA_CLASS_GPRS |
+=09=09=09=09=09=09MBIM_DATA_CLASS_EDGE |
+=09=09=09=09=09=09MBIM_DATA_CLASS_UMTS |
+=09=09=09=09=09=09MBIM_DATA_CLASS_HSDPA |
+=09=09=09=09=09=09MBIM_DATA_CLASS_HSUPA |
+=09=09=09=09=09=09MBIM_DATA_CLASS_LTE;
+=09struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+=09struct cb_data *cbd =3D cb_data_new(cb, data);
+=09struct mbim_message *message;
+=09L_AUTO_FREE_VAR(char *, provider_id) =3D NULL;
+
+=09DBG("");
+
+=09provider_id =3D l_strdup_printf("%s%s", mcc, mnc);
+
+=09message =3D mbim_message_new(mbim_uuid_basic_connect,
+=09=09=09=09=09MBIM_CID_REGISTER_STATE,
+=09=09=09=09=09MBIM_COMMAND_TYPE_SET);
+=09mbim_message_set_arguments(message, "suu", provider_id,
+=09=09=09=09=09MBIM_REGISTER_TYPE_MANUAL, data_class);
=20
 =09if (mbim_device_send(nd->device, NETREG_GROUP, message,
 =09=09=09=09mbim_register_state_set_cb, cbd, l_free) > 0)
@@ -385,7 +484,9 @@ static const struct ofono_netreg_driver driver =3D {
 =09.remove=09=09=09=09=3D mbim_netreg_remove,
 =09.registration_status=09=09=3D mbim_registration_status,
 =09.current_operator=09=09=3D mbim_current_operator,
+=09.list_operators=09=09=09=3D mbim_list_operators,
 =09.register_auto=09=09=09=3D mbim_register_auto,
+=09.register_manual=09=09=3D mbim_register_manual,
 =09.strength=09=09=09=3D mbim_signal_strength,
 };
=20
diff --git a/drivers/mbimmodem/util.c b/drivers/mbimmodem/util.c
index 731764fc..45b7af9b 100644
--- a/drivers/mbimmodem/util.c
+++ b/drivers/mbimmodem/util.c
@@ -39,6 +39,26 @@ int mbim_data_class_to_tech(uint32_t n)
 =09return -1;
 }
=20
+int mbim_provider_state_to_status(uint32_t state)
+{
+=09switch (state) {
+=09case MBIM_PROVIDER_STATE_REGISTERED:
+=09=09return OPERATOR_STATUS_CURRENT;
+
+=09case MBIM_PROVIDER_STATE_VISIBLE:
+=09case MBIM_PROVIDER_STATE_HOME:
+=09case MBIM_PROVIDER_STATE_PREFERRED:
+=09case MBIM_PROVIDER_STATE_PREFERRED_MULTICARRIER:
+=09=09return OPERATOR_STATUS_AVAILABLE;
+
+=09case MBIM_PROVIDER_STATE_FORBIDDEN:
+=09=09return OPERATOR_STATUS_FORBIDDEN;
+
+=09default:
+=09=09return OPERATOR_STATUS_UNKNOWN;
+=09}
+}
+
 uint8_t *mbim_get_fileid(uint32_t fileid)
 {
 =09/* TODO: Handle MF paths for different app types */
diff --git a/drivers/mbimmodem/util.h b/drivers/mbimmodem/util.h
index 2d260fd5..c58a0ec7 100644
--- a/drivers/mbimmodem/util.h
+++ b/drivers/mbimmodem/util.h
@@ -43,5 +43,6 @@ static inline struct cb_data *cb_data_new(void *cb, void =
*data)
 =09} while (0)
=20
 int mbim_data_class_to_tech(uint32_t n);
+int mbim_provider_state_to_status(uint32_t state);
 uint8_t *mbim_get_fileid(uint32_t fileid);
=20
--=20
2.52.0

