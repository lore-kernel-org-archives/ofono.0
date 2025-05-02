Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8635A1E04AC
	for <ofono@lists.linux.dev>; Fri,  2 May 2025 18:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746212085; cv=none; b=Gn7hWcmlifkYavgK6bFr7tGEuEIdZ9aXGNQ0ZN2i4TCm2StqT0k4Qo3tgE76JrNHlFDbALqRq9khpGGQaS3pqmIS6V4Gomns4lwfHObve+10LAwTi5RipVMvdQcXVOcjhmG6CEo291IEiPjCWxZgPsNL9R/wjuZcmisMm+lk3UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746212085; c=relaxed/simple;
	bh=eO83+HZTlwZr8GjgMsdj4UawbsWoKrsSU4LSIAKLyjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MRFh0DtB25Z1qDy/0pY/tZVK5+AoDfrQ+U+cDGGX+hOlUmFopaOtUksKW396WuDO0Di4iHtVpmpFSdMdG1KznQ7Iumo0zRj1bVaMG/y8X/HA4TBRK8rV1a4DZvdTthbbqYqg99+VznB9aGZk17RWEY8tUYHIBSz294tFKMVorxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=TEIrDq7j; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="TEIrDq7j"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=TEIrDq7j0Qa0U7zq8aDXyt5eyKmIe/fyTC5iKlN2ei49mL7gme2diF5SlaVHObSVI2RO+FzKQ/GgKD5pP/mpPtxNuj3XUUvwsionS8dU1tKvFntEOhQZZuhdYj6+D96OEW+FFfMv1pPp901HXWFgdsSgLMLARIpziEUwHpTVqgF+g8SRH2qRVzfNGCjHRmcfaP2/kXSQ2xuR4IxPj4VUCVsrcmz7uZLsPkbei2wwnUVxu8TnO83L/6FHwiCr7bXgtfVgTXfrezmbDmVCT2jymRUM8ddhUruAgebwQB0oKHTxEtoMmPHRGfJxupvArfMxsyYSjzX5duhnuNPOhLKexw==; s=purelymail2; d=purelymail.com; v=1; bh=eO83+HZTlwZr8GjgMsdj4UawbsWoKrsSU4LSIAKLyjQ=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -220201744;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 02 May 2025 18:54:40 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono@lists.linux.dev
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v2 5/5] mbimmodem: sim: add support for querying IMSI with MBIMEx 3
Date: Fri,  2 May 2025 23:53:26 +0500
Message-ID: <20250502185326.19134-6-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502185326.19134-1-thevancedgamer@mentallysanemainliners.org>
References: <20250502185326.19134-1-thevancedgamer@mentallysanemainliners.org>
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

