Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E2530F7F3
	for <ofono@lists.linux.dev>; Fri, 28 Nov 2025 17:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764350304; cv=none; b=oitQ9scs1LQcSTZ4LsSdPgLwq2knb3Lt5CswH7KXdEYVIAsVlUG3W7ILj0MJKN0CVOJTlmvRhjurb1vdwVdRvr7PglmTqqS7GWfSN0ASJa/FUiUZHXdctwXXEOi+EbuzmtAoJrXOIc84ydpPfcJJkGIB30BJmUbR2ggCsNbOe7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764350304; c=relaxed/simple;
	bh=KVIZpwoiMWYuPFQo5Xhx65ey3fa6IpVGIS36fjnShGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JxW6xM3l0KtPYGHNjFhbkCTyJ7dfxu3rGhVBI2ZfXYS9M0oXP6mTnDQoqsW4hX7BWr7m5gadHNv6Gzs8SNcNWAGZMJ5TvIKAFnpmLSMYitiVjzkkNuKfVD/7zoMoSEFJiTL3hk61d8Y38+rZOz5nBnpwUF/GSIUu4VXoqrUyi3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=LvzanbtX; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="LvzanbtX"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=LvzanbtXBgTZxW9GXjjA7++REYrYS/kQL787BKK5GJ1m4MHXviFiEC0qVMUqesyzaF4aNdCYlYqtBWmYp84FxQbgyVHIPNgdks+UWkyLEWCxJtSO9WxBQ+Wckk84jKJecTh8T7itPYWkd3ZED4X0anSa0N66ROyi7RzDZpP1cWoB2vQMZsw5UUHDGMfsNIt/Urpp2GWXyCVbsYjLhWD0iwyyPRN1CZWjcjRPeD3lpZE3xGfOxX461IFEPvvCNZftl4MRwQLWfV+zAGPooMOSNa8qHeM+BwuzC7q5T4aJf4XD6VUtMDl2NH+97uTVbnXHDcOtThzFvCEFqt/+BVWKIg==; s=purelymail2; d=purelymail.com; v=1; bh=KVIZpwoiMWYuPFQo5Xhx65ey3fa6IpVGIS36fjnShGc=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -2023556145;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 28 Nov 2025 17:18:19 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono <ofono@lists.linux.dev>
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v6 1/9] sim: add ofono_sim_get_modem method
Date: Fri, 28 Nov 2025 22:17:39 +0500
Message-ID: <20251128171747.32679-2-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251128171747.32679-1-thevancedgamer@mentallysanemainliners.org>
References: <20251128171747.32679-1-thevancedgamer@mentallysanemainliners.org>
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

