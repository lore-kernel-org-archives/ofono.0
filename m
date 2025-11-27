Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9640C2E22A6
	for <ofono@lists.linux.dev>; Thu, 27 Nov 2025 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764265817; cv=none; b=WQvfaOrSQeK6HOjFVWfM45crVsbFKgBmptw8+3r0QJhKcvxSx4y5kVjhcA3z/Xwk5rpj38lscXPmZrIkjvXnPDVuBHoZuVEpGWopdYwbOXMxe5/tQDdSq0XVze4LALhjY3avCS11jS8eZ1vUkG6nAeN69wYLbbHoLLShxqFuGJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764265817; c=relaxed/simple;
	bh=+m0wj6Ok5gcdcX01KJzGwfdMp7TuS8qyx5ccVemWykc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hdBKNm6oFWb0ECgZ/BQSA2+djrbgSHvw6C53y6Pv+0hdgh8iYo8Umv1qHo49IQjqLZQXLKTKO4vsr0Fj8gUaYhcmU2WdtrhQ801dmd7kQftR2aQ+P4x17mVxurQ+fRCusvaC29f0B2ZIU44QUb2clTU4aotRJgJDCytAuf9ALgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=mNq7dcE7; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="mNq7dcE7"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=mNq7dcE73/Qi83w9bOEcTHg2//B/tkp0oPh/GRATIcyHyMsLCNJTb+JdAzF+TrdLa2QTIH48aHuDBjgyIkmeMC0+vBzcC7W3Pzl0J7/aLsyYv8IXlwRU7jZaABZ0DX2oU2Lfxp+1y4wFXnEGzvUhF96DyANG9lOf1J5g7cx5tFdpRbDL5Kz5knvmn1Z6MZkCFIm7qP5TPncYOWR14YF8Jxtp89Oi3n+EZY3l+FFP1chcmA3X0xm1fuY1AZqQEg2XDQ1uwS9a9DthcIdUTvdoFiPgdivB9uwk1UBo5XJYVN8H7xnY4ZxHsoDLxEG1HcIRrIYXr1vmX7yQbXi+cnd7fA==; s=purelymail2; d=purelymail.com; v=1; bh=+m0wj6Ok5gcdcX01KJzGwfdMp7TuS8qyx5ccVemWykc=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 62202782;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 27 Nov 2025 17:50:13 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono <ofono@lists.linux.dev>
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v5 06/10] mbimmodem: sim: add support for querying ICCID This implements the required functions to query file info and read file info from the modem. Currently the other file IDs haven't been implemented, but they will be tackled later.
Date: Thu, 27 Nov 2025 22:49:40 +0500
Message-ID: <20251127174946.89981-7-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127174946.89981-1-thevancedgamer@mentallysanemainliners.org>
References: <20251127174946.89981-1-thevancedgamer@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

---
 drivers/mbimmodem/sim.c | 45 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/mbimmodem/sim.c b/drivers/mbimmodem/sim.c
index 1046c535..c74967d5 100644
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
+=09.read_file_info=09=3D mbim_read_file_info,
+=09.read_file_transparent=09=3D mbim_read_file_transparent,
 =09.read_imsi=09=09=3D mbim_read_imsi,
 =09.query_passwd_state=09=3D mbim_pin_query,
 =09.query_pin_retries=09=3D mbim_pin_retries_query,
--=20
2.52.0

