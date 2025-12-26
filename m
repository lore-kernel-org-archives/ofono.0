Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774A431ED9C
	for <ofono@lists.linux.dev>; Fri, 26 Dec 2025 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766758474; cv=none; b=N58YrOC8WmeAJvzVJyuKZW9c0ATIu2GYW7TYzff6czhhL0OKhmU0ccJXUiHQD+ZoX+jpVhIAgAd2Ml9zEx/AW4m5L8mvTo3AD6gp0QBJDNYiX94eoGr8UL56Dl1w/cyZx6TTJ1bxqN179fQn/H5tD5ygrUe32HIjAu/RGHPAFoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766758474; c=relaxed/simple;
	bh=9xtQMIeN3x7p4P6Yu4wKlEj3KHA719pKtwSbARukqe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGZf8QFXl8DsjFn6EsUAUnftCh3gv1900+mGnN7sBY941V5VVvyAkPrxX7zJ0dcQVyLblKFIVHtsCj5izBeRe59I6yjbI3VBAxTtXr+BGOy45YS1WKHlChxWH7ViC+fDddB/VFiOTnBCsIXjo9Qd/MZT8YiDyCMc2FfQNhxL9Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=aiyhvJmx; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="aiyhvJmx"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=aiyhvJmxpdC8p/FCo9uXTj2czT9KjhLFTnrmRrl1r4DOXD692O8Ss0PYN5b90qeJjYVhzmQ/4xIMAg+Skl9FlhztQTnStip5Mw3N6iPbVaT1LoN/xJTtRsPW4+n45iKmxmqO9PQ8yaES6U+bvobFuH94q4suJ5Fz+0fwlM49tNfHuvIo4lcNaxCJuCHL3Pn1jBDOFkmdqPKWeMJFXCuxngR2NpwRgVkMfIjedNs9eGu20fN8DIajPCT3jFm5MoUjvKlTDFmTD751xYhpk8PYu93gVjRVj1TtpMdJrvzfBsv8w55CRILaHvuY14j0+CsWl53azUoBAhw4/ugn6hvlMQ==; s=purelymail3; d=purelymail.com; v=1; bh=9xtQMIeN3x7p4P6Yu4wKlEj3KHA719pKtwSbARukqe8=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -2072196880;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 26 Dec 2025 14:14:29 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono@lists.linux.dev
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v9 10/10] mbim: introduce a new radio-settings driver
Date: Fri, 26 Dec 2025 19:13:10 +0500
Message-ID: <20251226141310.41856-11-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251226141310.41856-1-thevancedgamer@mentallysanemainliners.org>
References: <20251226141310.41856-1-thevancedgamer@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Depends on the REGISTER_STATE CID that is also used by
network-registration, but netreg can't report RAT changes.
---
 Makefile.am                        |   3 +-
 drivers/mbimmodem/mbimmodem.h      |   1 +
 drivers/mbimmodem/radio-settings.c | 198 +++++++++++++++++++++++++++++
 plugins/mbim.c                     |   3 +
 4 files changed, 204 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mbimmodem/radio-settings.c

diff --git a/Makefile.am b/Makefile.am
index cf51cdf1..d2df5dd5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -413,7 +413,8 @@ builtin_sources +=3D $(mbim_sources) \
 =09=09=09drivers/mbimmodem/network-registration.c \
 =09=09=09drivers/mbimmodem/sms.c \
 =09=09=09drivers/mbimmodem/gprs.c \
-=09=09=09drivers/mbimmodem/gprs-context.c
+=09=09=09drivers/mbimmodem/gprs-context.c \
+=09=09=09drivers/mbimmodem/radio-settings.c
=20
 builtin_sources +=3D plugins/mbim.c
 endif
diff --git a/drivers/mbimmodem/mbimmodem.h b/drivers/mbimmodem/mbimmodem.h
index 96432738..30d0928b 100644
--- a/drivers/mbimmodem/mbimmodem.h
+++ b/drivers/mbimmodem/mbimmodem.h
@@ -12,5 +12,6 @@ enum MBIM_GROUP {
 =09NETREG_GROUP =3D 2,
 =09SMS_GROUP =3D 3,
 =09GPRS_GROUP =3D 4,
+=09RADIO_SETTINGS_GROUP =3D 5,
 =09GPRS_CONTEXT_GROUP =3D 101,
 };
diff --git a/drivers/mbimmodem/radio-settings.c b/drivers/mbimmodem/radio-s=
ettings.c
new file mode 100644
index 00000000..92aa7aad
--- /dev/null
+++ b/drivers/mbimmodem/radio-settings.c
@@ -0,0 +1,198 @@
+/*
+ * oFono - Open Source Telephony
+ * Copyright (C) 2017  Intel Corporation
+ *
+ * SPDX-License-Identifier: GPL-2.0-only
+ */
+
+#include <stdint.h>
+#include <stdlib.h>
+#include <errno.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/radio-settings.h>
+
+#include "drivers/mbimmodem/mbim.h"
+#include "drivers/mbimmodem/mbim-message.h"
+#include "drivers/mbimmodem/mbimmodem.h"
+
+struct rat_data {
+=09struct mbim_device *device;
+=09struct l_idle *delayed_register;
+};
+
+
+static void query_rat_mode_cb(struct mbim_message *message, void *user)
+{
+=09struct cb_data *cbd =3D user;
+=09ofono_radio_settings_rat_mode_query_cb_t cb =3D cbd->cb;
+=09uint32_t dummy;
+=09uint32_t rat_mode =3D 0;
+=09L_AUTO_FREE_VAR(char *, dummy_str) =3D NULL;
+=09L_AUTO_FREE_VAR(char *, dummy_str2) =3D NULL;
+=09L_AUTO_FREE_VAR(char *, dummy_str3) =3D NULL;
+
+=09DBG("");
+
+=09if (mbim_message_get_error(message) !=3D 0)
+=09=09goto error;
+
+=09if (!mbim_message_get_arguments(message, "uuuuusssuu", &dummy, &dummy,
+=09=09=09=09=09&dummy, &dummy, &dummy, &dummy_str,
+=09=09=09=09=09&dummy_str2, &dummy_str3, &dummy, &rat_mode))
+=09=09goto error;
+
+=09if (rat_mode & MBIM_DATA_CLASS_LTE)
+=09=09rat_mode =3D OFONO_RADIO_ACCESS_MODE_LTE;
+=09else if (rat_mode & MBIM_DATA_CLASS_UMTS)
+=09=09rat_mode =3D OFONO_RADIO_ACCESS_MODE_UMTS;
+=09else if (rat_mode & (MBIM_DATA_CLASS_GPRS | MBIM_DATA_CLASS_EDGE))
+=09=09rat_mode =3D OFONO_RADIO_ACCESS_MODE_GSM;
+=09else
+=09=09rat_mode =3D OFONO_RADIO_ACCESS_MODE_ANY;
+
+=09CALLBACK_WITH_SUCCESS(cb, rat_mode, cbd->data);
+=09return;
+
+error:
+=09CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+}
+
+static void mbim_query_rat_mode(struct ofono_radio_settings *rs,
+=09=09ofono_radio_settings_rat_mode_query_cb_t cb,
+=09=09void *user_data)
+{
+=09struct rat_data *rd =3D ofono_radio_settings_get_data(rs);
+=09struct cb_data *cbd =3D cb_data_new(cb, user_data);
+=09uint16_t mbimex_version =3D ofono_modem_get_integer(ofono_radio_setting=
s_get_modem(rs),
+=09=09=09=09=09=09=09"MBIMExVersion");
+=09struct mbim_message *message;
+
+=09DBG("");
+
+=09if (!mbim_device_mbimex_version_at_least(mbimex_version, 2, 0)) {
+=09=09/* MBIMEx version < 2.0 does not support RAT mode querying */
+=09=09CALLBACK_WITH_FAILURE(cb, -1, user_data);
+=09=09return;
+=09}
+
+=09message =3D mbim_message_new(mbim_uuid_basic_connect,
+=09=09=09=09=09MBIM_CID_REGISTER_STATE,
+=09=09=09=09=09MBIM_COMMAND_TYPE_QUERY);
+=09mbim_message_set_arguments(message, "");
+
+=09if (mbim_device_send(rd->device, RADIO_SETTINGS_GROUP, message,
+=09=09=09=09query_rat_mode_cb, cbd, l_free) > 0)
+=09=09return;
+
+=09l_free(cbd);
+=09mbim_message_unref(message);
+=09CALLBACK_WITH_FAILURE(cb, -1, user_data);
+}
+
+static void query_available_rats_cb(struct mbim_message *message, void *us=
er)
+{
+=09struct cb_data *cbd =3D user;
+=09ofono_radio_settings_available_rats_query_cb_t cb =3D cbd->cb;
+=09uint32_t dummy;
+=09uint32_t cellular_class;
+=09uint32_t available_rats;
+=09uint32_t ofono_rats =3D 0;
+
+=09DBG("");
+
+=09if (mbim_message_get_error(message) !=3D 0)
+=09=09goto error;
+
+=09if (!mbim_message_get_arguments(message, "uuuuu", &dummy, &cellular_cla=
ss,
+=09=09=09=09=09&dummy, &dummy, &available_rats))
+=09=09goto error;
+
+=09if (cellular_class & 1) /* MbimCellularClassGsm */
+=09=09ofono_rats |=3D OFONO_RADIO_ACCESS_MODE_GSM;
+
+=09if (available_rats & MBIM_DATA_CLASS_LTE)
+=09=09ofono_rats |=3D OFONO_RADIO_ACCESS_MODE_LTE;
+
+=09if (available_rats & MBIM_DATA_CLASS_UMTS)
+=09=09ofono_rats |=3D OFONO_RADIO_ACCESS_MODE_UMTS;
+
+=09if (available_rats & (MBIM_DATA_CLASS_GPRS | MBIM_DATA_CLASS_EDGE))
+=09=09ofono_rats |=3D OFONO_RADIO_ACCESS_MODE_GSM;
+
+=09CALLBACK_WITH_SUCCESS(cb, ofono_rats, cbd->data);
+=09return;
+
+error:
+=09CALLBACK_WITH_FAILURE(cb, 0, cbd->data);
+}
+
+static void mbim_query_available_rats(struct ofono_radio_settings *rs,
+=09=09ofono_radio_settings_available_rats_query_cb_t cb,
+=09=09void *user_data)
+{
+=09struct rat_data *rd =3D ofono_radio_settings_get_data(rs);
+=09struct cb_data *cbd =3D cb_data_new(cb, user_data);
+=09struct mbim_message *message;
+
+=09DBG("");
+
+=09message =3D mbim_message_new(mbim_uuid_basic_connect,
+=09=09=09=09=09MBIM_CID_DEVICE_CAPS,
+=09=09=09=09=09MBIM_COMMAND_TYPE_QUERY);
+=09mbim_message_set_arguments(message, "");
+
+=09if (mbim_device_send(rd->device, RADIO_SETTINGS_GROUP, message,
+=09=09=09query_available_rats_cb, cbd, l_free) > 0)
+=09=09return;
+
+=09l_free(cbd);
+=09mbim_message_unref(message);
+=09CALLBACK_WITH_FAILURE(cb, 0, user_data);
+}
+
+static void delayed_register(struct l_idle *idle, void *user_data)
+{
+=09struct ofono_radio_settings *rs =3D user_data;
+=09struct rat_data *rd =3D ofono_radio_settings_get_data(rs);
+
+=09l_idle_remove(rd->delayed_register);
+=09rd->delayed_register =3D NULL;
+=09ofono_radio_settings_register(rs);
+}
+
+static int mbim_radio_settings_probe(struct ofono_radio_settings *rs,
+=09=09=09unsigned int vendor,
+=09=09=09void *data)
+{
+=09struct mbim_device *device =3D data;
+=09struct rat_data *rd =3D l_new(struct rat_data, 1);
+
+=09rd->device =3D mbim_device_ref(device);
+=09rd->delayed_register =3D l_idle_create(delayed_register, rs, NULL);
+
+=09ofono_radio_settings_set_data(rs, rd);
+
+=09return 0;
+}
+
+static void mbim_radio_settings_remove(struct ofono_radio_settings *rs)
+{
+=09struct rat_data *rd =3D ofono_radio_settings_get_data(rs);
+
+=09ofono_radio_settings_set_data(rs, NULL);
+=09l_idle_remove(rd->delayed_register);
+=09mbim_device_unref(rd->device);
+=09rd->device =3D NULL;
+=09l_free(rd);
+}
+
+static const struct ofono_radio_settings_driver driver =3D {
+=09.probe=09=09=09=3D mbim_radio_settings_probe,
+=09.remove=09=09=09=3D mbim_radio_settings_remove,
+=09.query_rat_mode=09=09=3D mbim_query_rat_mode,
+=09.query_available_rats=09=3D mbim_query_available_rats,
+};
+
+OFONO_ATOM_DRIVER_BUILTIN(radio_settings, mbim, &driver)
diff --git a/plugins/mbim.c b/plugins/mbim.c
index b5641cb6..736a545d 100644
--- a/plugins/mbim.c
+++ b/plugins/mbim.c
@@ -28,6 +28,7 @@
 #include <ofono/sms.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
+#include <ofono/radio-settings.h>
=20
 #include <ell/ell.h>
=20
@@ -256,6 +257,7 @@ static void mbim_device_caps_query_cb(struct mbim_messa=
ge *message, void *user)
=20
 =09md->max_sessions =3D max_sessions;
=20
+=09DBG("DataClass: %d", data_class);
 =09DBG("DeviceId: %s", device_id);
 =09DBG("FirmwareInfo: %s", firmware_info);
 =09DBG("HardwareInfo: %s", hardware_info);
@@ -474,6 +476,7 @@ static void mbim_post_online(struct ofono_modem *modem)
 =09DBG("%p", modem);
=20
 =09ofono_netreg_create(modem, 0, "mbim", md->device);
+=09ofono_radio_settings_create(modem, 0, "mbim", md->device);
 }
=20
 static struct ofono_modem_driver mbim_driver =3D {
--=20
2.52.0

