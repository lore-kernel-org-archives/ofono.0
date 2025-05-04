Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334F718A959
	for <ofono@lists.linux.dev>; Sun,  4 May 2025 19:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746386431; cv=none; b=fskon6Pp4h4woTQk2/H81Vz4j9a9IeeYXegIciC9uCr799d1nSp1Gb+MpuRB1zNzZA6VrypfdY0uECHhQfgcZDkZvk77eDRXC5cpE0W4j+6XEqrHVQwTdvaFat0ltV/I4iTS7TKwQUT4WYGRfVj5zY+N8GwYdyDINxRX8Qr8myU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746386431; c=relaxed/simple;
	bh=eO83+HZTlwZr8GjgMsdj4UawbsWoKrsSU4LSIAKLyjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZmIJpUt0xVvmgYpMpJ5eA7IpPwECsdWNZzJEj9DiMvD6UHjYqrFPvuGvsGl+aK2LhSNSaRL7CPA3Q15wqQx71cP1nLsBkY+jyLDl/GCS5WUhnMOSyLcosJgr9zhNoCz+nx+M9uJbX6vjGRZETxVzh7R3lUNJ6/mt6G47cxFrc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=yv1s5nyu; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="yv1s5nyu"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=yv1s5nyuyWCD2Iuvj+fyQ3z/+UYB0tfBYpKBJ92mPSwAZHLpIP2rJY+IjdDuKCGkJ/M/NRCwgNItcSF9MdVBCY8rZEaxLC2NYURWX/AVHYP3e/z8Il3U/w6Tl27uD6ZOvUpEPMoT+vJnwJOT4rM+9cHLWXdGHNskrlCKGh7YRDmFSGfBIzCQ3BU4ASan/qnlKYXAxWKuKR86hVdkVimuRY/mSWGpz6FZtfmZGThK3/jqaKHsWl0HezMdylGff1fepIFXHhNlui7wFqDndBq7/KX6J0M5RB3sixA1RUe1bceeLpUzJmNwgI+Uayh/I+oYVRhRheUZA7E71M5UhcVpSw==; s=purelymail2; d=purelymail.com; v=1; bh=eO83+HZTlwZr8GjgMsdj4UawbsWoKrsSU4LSIAKLyjQ=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1694754991;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 04 May 2025 19:20:25 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono@lists.linux.dev
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v4 5/6] mbimmodem: sim: add support for querying IMSI with MBIMEx 3 This commit adds the ability to query IMSI with newer modems that use the MBIMEx 3 protocol.
Date: Mon,  5 May 2025 00:19:30 +0500
Message-ID: <20250504191931.7078-6-thevancedgamer@mentallysanemainliners.org>
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
 drivers/mbimmodem/sim.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/mbimmodem/sim.c b/drivers/mbimmodem/sim.c
index df8d73ce..8f9998a7 100644
--- a/drivers/mbimmodem/sim.c
+++ b/drivers/mbimmodem/sim.c
@@ -390,12 +390,22 @@ static void mbim_subscriber_ready_status_changed(stru=
ct mbim_message *message,
 =09char *imsi;
 =09char *iccid;
 =09uint32_t ready_info;
+=09uint32_t ready_flags;
+=09bool r;
=20
 =09DBG("");
=20
-=09if (!mbim_message_get_arguments(message, "ussu",
-=09=09=09=09=09&ready_state, &imsi,
-=09=09=09=09=09&iccid, &ready_info))
+=09if (mbim_device_check_mbimex_version(sd->device, 3, 0)) {
+=09=09r =3D mbim_message_get_arguments(message, "uussu",
+=09=09=09=09=09=09&ready_state, &ready_flags, &imsi,
+=09=09=09=09=09=09&iccid, &ready_info);
+=09} else {
+=09=09r =3D mbim_message_get_arguments(message, "ussu",
+=09=09=09=09=09=09&ready_state, &imsi,
+=09=09=09=09=09=09&iccid, &ready_info);
+=09}
+
+=09if (!r)
 =09=09return;
=20
 =09l_free(sd->iccid);
@@ -418,6 +428,7 @@ static void mbim_subscriber_ready_status_cb(struct mbim=
_message *message,
 =09char *imsi;
 =09char *iccid;
 =09uint32_t ready_info;
+=09uint32_t ready_flags;
 =09bool r;
=20
 =09DBG("");
@@ -426,9 +437,16 @@ static void mbim_subscriber_ready_status_cb(struct mbi=
m_message *message,
 =09=09goto error;
=20
 =09/* We don't bother parsing MSISDN/MDN array */
-=09r =3D mbim_message_get_arguments(message, "ussu",
-=09=09=09=09=09&ready_state, &imsi,
-=09=09=09=09=09&iccid, &ready_info);
+=09if (mbim_device_check_mbimex_version(sd->device, 3, 0)) {
+=09=09r =3D mbim_message_get_arguments(message, "uussu",
+=09=09=09=09=09=09&ready_state, &ready_flags, &imsi,
+=09=09=09=09=09=09&iccid, &ready_info);
+=09} else {
+=09=09r =3D mbim_message_get_arguments(message, "ussu",
+=09=09=09=09=09=09&ready_state, &imsi,
+=09=09=09=09=09=09&iccid, &ready_info);
+=09}
+
 =09if (!r)
 =09=09goto error;
=20
--=20
2.49.0

