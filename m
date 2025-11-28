Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30B1288537
	for <ofono@lists.linux.dev>; Fri, 28 Nov 2025 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764351442; cv=none; b=l5WPsc/LPsvbRKr7wQiqba5lnwSoKqH5uAaOfIHpWPgsBBzfWu8b0M0MXE5jL0+vjytallQnRBjnEOa2zKB5/hxhpSiqc9nqPdQ1FJKU6hVnvMnykZkO3f/2Kbp+4nTIHWdaW6wFzyheQL9PMWVkz4e5cOxqEeR/5fNuKJ6eCvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764351442; c=relaxed/simple;
	bh=4z7ni1OjEMur9cEDJnt0y4fedmGLfsAJ62Ohra59c18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XXGZzl+BR7Yy9tjBIbsD90B5dUTtnEyeCbFwxU0gu+87C3VvO5mZGK40tGAkBKyN+qiwrWCyI/Xyw9OGi2LhHaXSmma6vl5ts5pkLgxiC9akgmvGvjZ+AtAX88lH+XxxivrbC9lQhsL+KcyS3SUKzVdkXnJx8TyETTwaEF6+nk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=zx1b7Gog; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="zx1b7Gog"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=zx1b7GogZu5n+LupH0/+avV3usR10o688/YSxCXlPb0CGhubtEIRux2YnaFmKC2lG6X/mt2zFq7xaOIYKxw7ZV+cnn/bGsiDXmRhwYwWvdb2OZCz9Gd7BtyDbsGsWvIpx85/LOwfssfTaSM19qjJvE4+vl0f0ye5TItD3gv41PFDbApp88jRJIEWy08SHC/+Awzqe4hanR31eB7PVUCUpVXSHjNbGSKZY/yVT8G5IzbUC8MuV9mIRFU0Dw7J8MNhRt81m2JEVf+Ph4wdYDlhIBKUF7dQnbWzWu7lFLbo/ri0GWZmHJLlXkZz7wISE6wBbnHDXFb3BgyIRCq4KVHtkQ==; s=purelymail2; d=purelymail.com; v=1; bh=4z7ni1OjEMur9cEDJnt0y4fedmGLfsAJ62Ohra59c18=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1079628981;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 28 Nov 2025 17:37:18 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono <ofono@lists.linux.dev>
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v7 06/10] mbimmodem: sim: add support for querying ICCID
Date: Fri, 28 Nov 2025 22:36:52 +0500
Message-ID: <20251128173656.55692-7-thevancedgamer@mentallysanemainliners.org>
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

This implements the required functions to query file info and read file
info from the modem. Currently the other file IDs haven't been
implemented, but they will be tackled later.
---
 drivers/mbimmodem/sim.c | 45 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/mbimmodem/sim.c b/drivers/mbimmodem/sim.c
index 9df34121..15b5c91c 100644
--- a/drivers/mbimmodem/sim.c
+++ b/drivers/mbimmodem/sim.c
@@ -18,6 +18,9 @@
 #include <ofono/modem.h>
 #include <ofono/sim.h>
=20
+#include <glib.h>
+#include "simutil.h"
+
 #include "drivers/mbimmodem/mbim.h"
 #include "drivers/mbimmodem/mbim-message.h"
 #include "drivers/mbimmodem/mbimmodem.h"
@@ -76,6 +79,45 @@ static void mbim_read_imsi(struct ofono_sim *sim,
 =09CALLBACK_WITH_SUCCESS(cb, sd->imsi, user_data);
 }
=20
+static void mbim_read_file_info(struct ofono_sim *sim,
+=09=09=09=09=09int fileid, const unsigned char *path,
+=09=09=09=09=09unsigned int path_len,
+=09=09=09=09=09ofono_sim_file_info_cb_t cb, void *user_data)
+{
+=09unsigned char access[3] =3D {0x0f, 0xff, 0xff};
+
+=09switch (fileid) {
+=09case SIM_EF_ICCID_FILEID:
+=09=09CALLBACK_WITH_SUCCESS(cb, 10, 0, 0, access, 1, user_data);
+=09=09break;
+=09default:
+=09=09CALLBACK_WITH_FAILURE(cb, -1, -1, -1, NULL, 0, user_data);
+=09=09break;
+=09}
+}
+
+static void mbim_read_file_transparent(struct ofono_sim *sim,
+=09=09=09=09=09int fileid,=09int start, int length,
+=09=09=09=09=09const unsigned char *path, unsigned int path_len,
+=09=09=09=09=09ofono_sim_read_cb_t cb, void *user_data)
+{
+=09struct sim_data *sd =3D ofono_sim_get_data(sim);
+=09unsigned char iccid[10];
+=09int iccid_len, len =3D strlen(sd->imsi);
+
+=09sim_encode_bcd_number(sd->iccid, iccid);
+=09iccid_len =3D len / 2;
+
+=09switch (fileid) {
+=09case SIM_EF_ICCID_FILEID:
+=09=09CALLBACK_WITH_SUCCESS(cb, iccid, iccid_len, user_data);
+=09=09break;
+=09default:
+=09=09CALLBACK_WITH_FAILURE(cb, NULL, 0, user_data);
+=09=09break;
+=09}
+}
+
 static enum ofono_sim_password_type mbim_pin_type_to_sim_password(
 =09=09=09=09=09=09=09uint32_t pin_type)
 {
@@ -457,6 +499,7 @@ static void mbim_subscriber_ready_status_cb(struct mbim=
_message *message,
 =09sd->iccid =3D iccid;
 =09sd->imsi =3D imsi;
=20
+=09DBG("Got ICCID! %s", iccid);
 =09if (!mbim_device_register(sd->device, SIM_GROUP,
 =09=09=09=09=09mbim_uuid_basic_connect,
 =09=09=09=09=09MBIM_CID_SUBSCRIBER_READY_STATUS,
@@ -520,6 +563,8 @@ static void mbim_sim_remove(struct ofono_sim *sim)
 static const struct ofono_sim_driver driver =3D {
 =09.probe=09=09=09=3D mbim_sim_probe,
 =09.remove=09=09=09=3D mbim_sim_remove,
+=09.read_file_info=09=09=3D mbim_read_file_info,
+=09.read_file_transparent=09=3D mbim_read_file_transparent,
 =09.read_imsi=09=09=3D mbim_read_imsi,
 =09.query_passwd_state=09=3D mbim_pin_query,
 =09.query_pin_retries=09=3D mbim_pin_retries_query,
--=20
2.52.0

