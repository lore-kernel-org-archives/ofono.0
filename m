Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20063188A3A
	for <ofono@lists.linux.dev>; Fri, 12 Dec 2025 21:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765573412; cv=none; b=aHQev47eDC0NEf02Raughs1qx3MTeYd2Z8o9T84VW7+ES9zRoQiKw6bzxxp1nVMw97UiYngxNAl6GSNnhQKB/tkEpgTOAJpAyq976BuFvlzS6ee0wEO6fELcfJcmOBja7x7uzovlry/NZ+cme1YogYScHVQ3NYqtwQml0kAKhng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765573412; c=relaxed/simple;
	bh=zdJCq5c+8/PmBm9Rg3Sz/rrHV4qWIvzRkOAlZSTlGKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fg/2ovn/wNd/RJnzyn9nZJXknTl9lN9DsAVA8bfNfFffLbSm2cGCwpOwx+k+8LnD7IE/el5xHsaPw0vaqZQCG3ZZFLNP3n6iEBBLkUhbwEn8hifRhhRpMV9RXAlxDtyWWCa/clWTldACZIlKIRUZpxZVblBBr+RoqMXzQzl/MKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=mpwwiTj2; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="mpwwiTj2"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=mpwwiTj23u4Driw635zSMoMxS/Y5PYs2hMHHBdMWlmvKxbTKtjpLa3AA+LoWe4LVGwMRP8eFAfuwGnz3CyZYXEn1gjnD3vEloYOvBLtgqFPz/ehqXBCMnu12/7Y5sY2dQ6b6vECFdudkOJt/bJW61NA5kMKocWFPN3XtNDdrNiSLsOshlfeCX3qiPmGR6ZkQ4mFGsHInhFnvB5zahOcgUK4g+PnwAudCPZ+3d4DtsumAoWnMel7MxD4GhB5R63ZC8wqVrNDxT97c6Qd2uO3YjUKQfDOPr+nSTuByxCWE4WS585iIsarGK8E/zaX5YspIEtSYQO5ZfY0eCzC740DWIg==; s=purelymail1; d=purelymail.com; v=1; bh=zdJCq5c+8/PmBm9Rg3Sz/rrHV4qWIvzRkOAlZSTlGKw=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 511728581;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 12 Dec 2025 21:03:27 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono@lists.linux.dev
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v8 8/8] mbim/network-registration: add support for manual registration
Date: Sat, 13 Dec 2025 02:02:49 +0500
Message-ID: <20251212210249.95597-9-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251212210249.95597-1-thevancedgamer@mentallysanemainliners.org>
References: <20251212210249.95597-1-thevancedgamer@mentallysanemainliners.org>
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
 drivers/mbimmodem/network-registration.c | 108 +++++++++++++++++++++--
 drivers/mbimmodem/util.c                 |  20 +++++
 drivers/mbimmodem/util.h                 |   1 +
 4 files changed, 137 insertions(+), 7 deletions(-)

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
index ded1bf69..d56611d3 100644
--- a/drivers/mbimmodem/network-registration.c
+++ b/drivers/mbimmodem/network-registration.c
@@ -204,6 +204,72 @@ static void mbim_current_operator(struct ofono_netreg =
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
+=09=09strncpy(list[i].name, provider_name, OFONO_MAX_OPERATOR_NAME_LENGTH)=
;
+=09=09list[i].name[OFONO_MAX_OPERATOR_NAME_LENGTH] =3D '\0';
+
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
@@ -217,8 +283,8 @@ static void mbim_register_state_set_cb(struct mbim_mess=
age *message, void *user)
 =09=09CALLBACK_WITH_SUCCESS(cb, cbd->data);
 }
=20
-static void mbim_register_auto(struct ofono_netreg *netreg,
-=09=09=09=09ofono_netreg_register_cb_t cb, void *data)
+static void mbim_register(struct cb_data *cbd, enum mbim_register_type reg=
_type,
+=09=09=09=09const char *provider_id)
 {
 =09static const uint32_t data_class =3D MBIM_DATA_CLASS_GPRS |
 =09=09=09=09=09=09MBIM_DATA_CLASS_EDGE |
@@ -226,22 +292,48 @@ static void mbim_register_auto(struct ofono_netreg *n=
etreg,
 =09=09=09=09=09=09MBIM_DATA_CLASS_HSDPA |
 =09=09=09=09=09=09MBIM_DATA_CLASS_HSUPA |
 =09=09=09=09=09=09MBIM_DATA_CLASS_LTE;
-=09struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
-=09struct cb_data *cbd =3D cb_data_new(cb, data);
 =09struct mbim_message *message;
=20
 =09message =3D mbim_message_new(mbim_uuid_basic_connect,
 =09=09=09=09=09MBIM_CID_REGISTER_STATE,
 =09=09=09=09=09MBIM_COMMAND_TYPE_SET);
-=09mbim_message_set_arguments(message, "suu", NULL, 0, data_class);
=20
-=09if (mbim_device_send(nd->device, NETREG_GROUP, message,
+=09mbim_message_set_arguments(message, "suu", provider_id,
+=09=09=09=09=09reg_type, data_class);
+
+=09if (mbim_device_send(cbd->data, NETREG_GROUP, message,
 =09=09=09=09mbim_register_state_set_cb, cbd, l_free) > 0)
 =09=09return;
=20
 =09l_free(cbd);
 =09mbim_message_unref(message);
-=09CALLBACK_WITH_FAILURE(cb, data);
+=09CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
+static void mbim_register_auto(struct ofono_netreg *netreg,
+=09=09=09=09ofono_netreg_register_cb_t cb, void *data)
+{
+=09struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+=09struct cb_data *cbd =3D cb_data_new(cb, data);
+
+=09mbim_register(cbd, MBIM_REGISTER_TYPE_AUTOMATIC, NULL);
+}
+
+static void mbim_register_manual(struct ofono_netreg *netreg,
+=09=09=09=09const char *mcc, const char *mnc,
+=09=09=09=09ofono_netreg_register_cb_t cb, void *data)
+{
+=09struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+=09struct cb_data *cbd =3D cb_data_new(cb, data);
+=09L_AUTO_FREE_VAR(char *, provider_id) =3D NULL;
+
+=09DBG("");
+
+=09provider_id =3D l_strdup_printf("%s%s", mcc, mnc);
+
+=09mbim_register(cbd, MBIM_REGISTER_TYPE_MANUAL, provider_id);
+
+=09l_free(provider_id);
 }
=20
 static inline int convert_signal_strength(uint32_t strength)
@@ -385,7 +477,9 @@ static const struct ofono_netreg_driver driver =3D {
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
index 3280c863..35a236a3 100644
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
 uint8_t *mbim_get_fileid(enum mbim_app_type app_type, uint32_t fileid, int=
 *file_id_len)
 {
 =09uint8_t parent_path[6] =3D {0};
diff --git a/drivers/mbimmodem/util.h b/drivers/mbimmodem/util.h
index 55669450..e42851be 100644
--- a/drivers/mbimmodem/util.h
+++ b/drivers/mbimmodem/util.h
@@ -43,4 +43,5 @@ static inline struct cb_data *cb_data_new(void *cb, void =
*data)
 =09} while (0)
=20
 int mbim_data_class_to_tech(uint32_t n);
+int mbim_provider_state_to_status(uint32_t state);
 uint8_t *mbim_get_fileid(enum mbim_app_type app_type, uint32_t fileid, int=
 *file_id_len);
--=20
2.52.0

