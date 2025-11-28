Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3E52D3EDE
	for <ofono@lists.linux.dev>; Fri, 28 Nov 2025 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764351433; cv=none; b=EtL0MWYg7pVAAR60nygYvoX8q3nvhH7VLfG+dIXSZZlMQcHHia0hVvjPXgcw3kvo6qKzhjv+/we0WH2lcqozS7lUtjpj3mjeqETBCy8XQgyNBQn8XUgCGaKYVh6CITUrpb5d67xp8dfjUL54hhMYpXLr7M25byWEt90WsiB7E6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764351433; c=relaxed/simple;
	bh=KVIZpwoiMWYuPFQo5Xhx65ey3fa6IpVGIS36fjnShGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IdMqUN+ymgqiEUBoFSycgnCJL9I8ZfbkSLxE074ziLqItP4NGAYgueAX6EC8L49ZUuZpvC9gQok+msLqwPBo20vGyF/X3L8J6P3w3lUFuJMRvli8Av/pRiNAKHYrwF7G3mv2tu5Mm03yZaK8aKZNp6zHvhtRU9Wl5qZBYO181ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=g2S2EiLM; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="g2S2EiLM"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=g2S2EiLMMEDCISABGDKg2iQwxYpfRuHhN6cG1/Gh0yM7iGkeSM1bG8XKshM5WTl8UqWzyi9GHZl13HsYUol30+BUmrW3Hsd6/ZxJZcLhs/sP7hRX9XBf12CVhMZUb/vd3OFvwXAtMuvSZV/WQW4/MMEicuOdTRwMSVvVDYrmA0QO2d7wMO5t5C0tJvD2XzslR71KyVG7zOzDDbSw1b7GpV0321+pUIB1F/k/7eRdzZkrci1sPsxez46cgNSfUqCsqRrQwi3fsApCm8P5JS5+VTSQ9bzvmCeMiLaT6xMLJc2UmVShr95IXEakmCHgyNbTvTvDjRBO8D2Lykbw0YlaRg==; s=purelymail2; d=purelymail.com; v=1; bh=KVIZpwoiMWYuPFQo5Xhx65ey3fa6IpVGIS36fjnShGc=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1079628981;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 28 Nov 2025 17:37:09 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono <ofono@lists.linux.dev>
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v7 01/10] sim: add ofono_sim_get_modem method
Date: Fri, 28 Nov 2025 22:36:47 +0500
Message-ID: <20251128173656.55692-2-thevancedgamer@mentallysanemainliners.org>
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

Align with the other ofono structures for fetching ofono_modem from atoms

Signed-off-by: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
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

