Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1C51EBA14
	for <ofono@lists.linux.dev>; Fri,  2 May 2025 19:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746212660; cv=none; b=tZkhASBfVpwBj0/AlbxcUxbZS4oX+owBoBcS5b6qFNs5rXUXSwSIN1WJYyc1gERFGoafzPliaUjhb/LAhRR/zczLUHpr8d4Ve8CGEeZ1YnrD2Uf3Rmzs7X62GLEtyJDN2AlA1g52qjvnvG4J1MItwPNOHCID+SIEcfda3lsLsQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746212660; c=relaxed/simple;
	bh=jM1W1G2gjGMoZTjRTS2N7QAiUf9pDKagHuJX+XG+cMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lq8ULCR5hx5P7kscP5eD0O1/YYcG/NAWNJsWSsfacOQOTHu5xNV8oiHJLEnvEC4ZLSXB6bpMHB+pYrNAb48NMSdbB4y8NUgIX+F1bV5t6uyWFvOh8oDakdXJghUtTgANcz4Ql7diyFfrwOQANg+qn5mdL3JLld6LZx9S8Byo38k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=RIdFzVrK; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="RIdFzVrK"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=RIdFzVrKU0i/NkexLddM807qDISxJK/8pNOn6QtLTCcBHeF/3E46yKVql4rC9NtUcN7Pw3CWlCzRmzXGq8qM7cLHvbdD/8Gi0pC4cJ/BLAWETvoYfQtXleDqauDYAox/PLxFw+Y6i08V8YnQmuywo318Cw8xapxd4x4KvonfbonCeg7lchDtV2bwE2pzlMrD3GG8MmtBcxP/jBh2i0XKii07vO3d/QZ6OyKSxwLO1ud8poSYanphC0yMneUh2LUa6tnzltmgSVtSAVanGa47EgQC5dJ0znuqEhiggPTz2ZlAqZNLxWAILX7StCpbtyiMCsO95hSo3kzkDuNOEE/VEA==; s=purelymail2; d=purelymail.com; v=1; bh=jM1W1G2gjGMoZTjRTS2N7QAiUf9pDKagHuJX+XG+cMw=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1492705212;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 02 May 2025 19:04:00 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono@lists.linux.dev
Cc: Muhammad <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v3 5/5] mbimmodem: sim: add support for querying IMSI with MBIMEx 3
Date: Sat,  3 May 2025 00:03:18 +0500
Message-ID: <20250502190318.41366-6-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502190318.41366-1-thevancedgamer@mentallysanemainliners.org>
References: <20250502190318.41366-1-thevancedgamer@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

From: Muhammad <thevancedgamer@mentallysanemainliners.org>

Signed-off-by: Muhammad <thevancedgamer@mentallysanemainliners.org>
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

