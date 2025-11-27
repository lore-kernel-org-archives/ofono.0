Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283511E4AB
	for <ofono@lists.linux.dev>; Thu, 27 Nov 2025 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764265816; cv=none; b=rluWqeNNIaheSRk99I5kLaGk4jc9sVOpOvcm6/2hetMa/uVlUKiQSWMOOpB/t3XNQn0Dl2HjnKQiWQAz+vPRsjbaQGIi7bGlZZvJXhrDv3RDWHfRuytKQhnVQg8n70ctKSG/vbTURkXIL8EPgcQbc4jVTKLZRaiRDjmFaxht2Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764265816; c=relaxed/simple;
	bh=rtSXVgJi8ZndPeUIr4bFOIf8gSPP5s4R0W7aIxZG5hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ea7Z0WhzGUYiZz941E4gMDmpW4/7QmWwZvlMAHEm09yjxWAA/UER5OJc+YDW2TXj8zlzynIjVnQ+TZ9FKm9X3BUCe74K6lOpdM6NHFMYNgyeRtA8F1TM6s2ynQ2mdykjAsamqbdHwtfyPPwrMl36KOf0K1oDYBVUWrqYtdUnG+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=cyES1FbB; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="cyES1FbB"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=cyES1FbBYWTqLUU4UVCY4fEUqzIAyYs1ryGdYVW8BoKASLg7cSYLBDQ3TDIyShDh5bZtxGrLT50Vrztk5F3W1TDj7/0C7jIdnVhNITsBxpLklRDH6kdgpEdLeaeXzTk2vqmPLpRfwr848VNh6QiGKFx0LA+G0CygP94mR7cIYvyy7S98uJPdBoqZ9PhSZmmoCRhKTUBOPQhTd4rTKOAoVseMVKJMfS5+X3hC5Vu7yBbPdumtA1TeIC4ffexhBCLyTLj0t440Rq5oD6lPIdhlSETLNXF5xlTXrqs3Z7vG+D57BPBSc4j9x3UzzTX5sTWyphDCXiEte4xrBMBOb4wB8w==; s=purelymail2; d=purelymail.com; v=1; bh=rtSXVgJi8ZndPeUIr4bFOIf8gSPP5s4R0W7aIxZG5hE=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 62202782;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 27 Nov 2025 17:50:12 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono <ofono@lists.linux.dev>
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v5 05/10] mbimmodem: sim: add support for querying IMSI with MBIMEx 3 This commit adds the ability to query IMSI with newer modems that use the MBIMEx 3 protocol.
Date: Thu, 27 Nov 2025 22:49:39 +0500
Message-ID: <20251127174946.89981-6-thevancedgamer@mentallysanemainliners.org>
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
 drivers/mbimmodem/sim.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/mbimmodem/sim.c b/drivers/mbimmodem/sim.c
index fb23609a..1046c535 100644
--- a/drivers/mbimmodem/sim.c
+++ b/drivers/mbimmodem/sim.c
@@ -392,12 +392,22 @@ static void mbim_subscriber_ready_status_changed(stru=
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
@@ -422,6 +432,7 @@ static void mbim_subscriber_ready_status_cb(struct mbim=
_message *message,
 =09char *imsi;
 =09char *iccid;
 =09uint32_t ready_info;
+=09uint32_t ready_flags;
 =09bool r;
=20
 =09DBG("");
@@ -430,9 +441,16 @@ static void mbim_subscriber_ready_status_cb(struct mbi=
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
2.52.0

