Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA33F2AF1D
	for <ofono@lists.linux.dev>; Fri, 26 Dec 2025 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766758465; cv=none; b=dwUGMaNyl8JqEV0ElMCMHoiJchuE8NX6TErjj3LEHGX9tSyPoXnCVHxjDvRsKWCg74JKEVx7y+oemQGo3KqhwnGigtt0qXARtju4GtRaYk2BPZCie3AhGsCyQ3qCo32YmMUTbwiA2+8/4L/Eb+d7NEofKqw0Azg0qF28jXHBngw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766758465; c=relaxed/simple;
	bh=RNuFvJv6M21+zlpgLEW0IQaJWzU3MXWyjblEvBRKIU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IPlj57qd9JiqhdOhhgHPY9KpVVQgEFXN7RNzsV2ldsTd29F09i9UrNB7ztiA3JI3i0YYNEcUnQWVrKKyqLmYvl92sdYa0SJUnF8keF4HnctOKgoxZ+5DNmkilsDlPLk5ceH3nvQGXi0sxUvPicuAvZUdqM/WpwrUmIq5CzZ0v3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=dviTk0nk; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="dviTk0nk"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=dviTk0nkNA991rSlhrhcmTZ4xevyKakP7oH349WZx3alN3/cUQc0nM71ZRCY0iZinkQMFY8a36AXh/8cY8plRjRnkhIj09VDtPaW55gnCkSVuLLlRpmDG/IOECNbHEAy99MvJFJnS2krpGmXZQcaIEeYpeqFbDiFhV0Nda/IPedRcEWJCBAxvONMMHPDHOsnIjK6pUHm9bIVW/+MhInDxmWoF0Rv5JqKLNCXzHK65efnRRoVt4PEAKX4JcWEJspPchmUfz3DyZkislrrdZZwmB18xZ86L8A4xGme9d8S8pVuJrLV08RXyQvf6mhLMYj3hTdmhj4/eifyecFjbRyBoQ==; s=purelymail3; d=purelymail.com; v=1; bh=RNuFvJv6M21+zlpgLEW0IQaJWzU3MXWyjblEvBRKIU0=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -2072196880;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 26 Dec 2025 14:14:09 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono@lists.linux.dev
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v9 01/10] sim: add ofono_sim_get_modem method
Date: Fri, 26 Dec 2025 19:13:01 +0500
Message-ID: <20251226141310.41856-2-thevancedgamer@mentallysanemainliners.org>
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

Align with the other ofono structures for fetching ofono_modem from atoms
---
 include/sim.h | 2 ++
 src/sim.c     | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/sim.h b/include/sim.h
index 84592fc9..c0fc364f 100644
--- a/include/sim.h
+++ b/include/sim.h
@@ -211,6 +211,8 @@ void ofono_sim_remove(struct ofono_sim *sim);
=20
 void ofono_sim_set_data(struct ofono_sim *sim, void *data);
 void *ofono_sim_get_data(struct ofono_sim *sim);
+struct ofono_modem *ofono_sim_get_modem(struct ofono_sim *sim);
+
 void ofono_sim_set_card_slot_count(struct ofono_sim *sim, unsigned int val=
);
 void ofono_sim_set_active_card_slot(struct ofono_sim *sim,
 =09=09=09=09=09unsigned int val);
diff --git a/src/sim.c b/src/sim.c
index dedb7d8d..cc33e864 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -3423,6 +3423,11 @@ void *ofono_sim_get_data(struct ofono_sim *sim)
 =09return sim->driver_data;
 }
=20
+struct ofono_modem *ofono_sim_get_modem(struct ofono_sim *sim)
+{
+=09return __ofono_atom_get_modem(sim->atom);
+}
+
 static ofono_bool_t is_valid_pin(const char *pin, unsigned int min,
 =09=09=09=09=09unsigned int max)
 {
--=20
2.52.0

