Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DACD17BED0
	for <ofono@lists.linux.dev>; Sun,  4 May 2025 19:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746386435; cv=none; b=e9krzyuQ0iU401VmSnS+SL+RuSsIYOz3BgOCPRVLPtTWwA7liQcPkc+T4eIYzgqHoWstlxQh3paCNA6X7n+uh6vPwPT5lDrx98rfuBGPxTQ+5sNuCMzvv0/0z1hGYE5TWYlWYceNugaprhdL6lo2m4iCCakP/KDboaqLwJougFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746386435; c=relaxed/simple;
	bh=XLAsmJd8BqV0Qyk7+wn4lo7U+1nGM0PMn0FAiioAL/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K0WF9avfr0DIDwlFdVCMoDfokaeWghjppErQIk9G+UpykhOXzdaKSm01a7pE/n65aAs9vaQOqJzW5mIdOYA0xzkW6Ox0j+l97iZlmXBPi+G1xjKz+6n8smdT3eGCfBW8s5i+wD5aAKaR9juOiYBZKEUSa+v6vwVRnIpFkM7sr8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=wQ2h6R3j; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="wQ2h6R3j"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=wQ2h6R3jDuDsBMfynsR8YPHkmk1Pdri/8c312ls/tmRDfe5W5ogfMYtjs2eIE7A3pmR8TCBglmzjcjLCe81pGzYDn7DYLuEHjhTjlPq3H9hDKej/JUvRbKNaNJn1tFjlEPNbJYg6QgsDjT1oPtj2QIy/UvO/GD6JKaXCikNWwX+goKPWk8IyGJj6IiUVq5boVAoeTwYSpra9RF3BfpgC3vsLZt/xrw66wlhtCBtQ9hPjEsKmzgx3K0PwZp7OZY6FX+snFbGmMZtp1reftV4fkVHGClMMhqlmM7FTzTFpAw22z8CyvkQ6FtGjA9QEgZVXsBwyi+K6w9aR6e+OB5cYdA==; s=purelymail2; d=purelymail.com; v=1; bh=XLAsmJd8BqV0Qyk7+wn4lo7U+1nGM0PMn0FAiioAL/A=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1694754991;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 04 May 2025 19:20:27 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono@lists.linux.dev
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v4 6/6] mbimmodem: sim: add support for querying ICCID This implements the required functions to query file info and read file info from the modem. Currently the other file IDs haven't been implemented, but they will be tackled later.
Date: Mon,  5 May 2025 00:19:31 +0500
Message-ID: <20250504191931.7078-7-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250504191931.7078-1-thevancedgamer@mentallysanemainliners.org>
References: <20250504191931.7078-1-thevancedgamer@mentallysanemainliners.org>
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
index 8f9998a7..c5bd2049 100644
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
+=09=09case SIM_EF_ICCID_FILEID:
+=09=09=09CALLBACK_WITH_SUCCESS(cb, 10, 0, 0, access, 1, user_data);
+=09=09=09break;
+=09=09default:
+=09=09=09CALLBACK_WITH_FAILURE(cb, -1, -1, -1, NULL, 0, user_data);
+=09=09=09break;
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
+=09=09case SIM_EF_ICCID_FILEID:
+=09=09=09CALLBACK_WITH_SUCCESS(cb, iccid, iccid_len, user_data);
+=09=09=09break;
+=09=09default:
+=09=09=09CALLBACK_WITH_FAILURE(cb, NULL, 0, user_data);
+=09=09=09break;
+=09}
+}
+
 static enum ofono_sim_password_type mbim_pin_type_to_sim_password(
 =09=09=09=09=09=09=09uint32_t pin_type)
 {
@@ -453,6 +495,7 @@ static void mbim_subscriber_ready_status_cb(struct mbim=
_message *message,
 =09sd->iccid =3D iccid;
 =09sd->imsi =3D imsi;
=20
+=09DBG("Got ICCID! %s", iccid);
 =09if (!mbim_device_register(sd->device, SIM_GROUP,
 =09=09=09=09=09mbim_uuid_basic_connect,
 =09=09=09=09=09MBIM_CID_SUBSCRIBER_READY_STATUS,
@@ -516,6 +559,8 @@ static void mbim_sim_remove(struct ofono_sim *sim)
 static const struct ofono_sim_driver driver =3D {
 =09.probe=09=09=09=3D mbim_sim_probe,
 =09.remove=09=09=09=3D mbim_sim_remove,
+=09.read_file_info =09=3D mbim_read_file_info,
+=09.read_file_transparent =09=3D mbim_read_file_transparent,
 =09.read_imsi=09=09=3D mbim_read_imsi,
 =09.query_passwd_state=09=3D mbim_pin_query,
 =09.query_pin_retries=09=3D mbim_pin_retries_query,
--=20
2.49.0

