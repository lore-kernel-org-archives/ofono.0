Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283C22EC095
	for <ofono@lists.linux.dev>; Thu, 27 Nov 2025 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764265817; cv=none; b=u3exbhfeemzc08qQjUSrefrgU+MBiw5xJlQbYfIclZyLaBOOBHbN/L39YA3QmnnplgkDOicnI6MQ4U2wcjAQD71Jf9GHlZxTbwZeHeMi9Abz6TBAMyOnHVMWqby5E1jv6SYpl6WBqfvrtqMZn0rpxgSR3lM7v41hry32E7Jf37c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764265817; c=relaxed/simple;
	bh=yVDhIyDAVRKcy2GE3C+iekEW4ft2liKeD6tCpwv88fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HTzDAWORehpcUGxOm9D9H86MYITl5g+zZpAR/q7a0VgitT6HKo/wHd8+z1mOEswG58f9yZZUgRIvnqGBWK+CZ1Tr/li5Wc71pR+z9I+qgbmMDV3ugLWZlSb5+G9RuHd3E+egdkXT1Lq9Dd2EMOPnI2/FVmZZoCiyR8Abcp7Y5II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=XOSmmQQ/; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="XOSmmQQ/"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=XOSmmQQ/utVdxCBLZlNzb8OuU7cXzJAXf5wTjnvuubsBmVORRFGKtAva3lSS0qu+RqcJxRBr0CETNi0gkUeM0llccrK6NI/hLjw6IfH3avUo2SmdolWwp/angvMMi1+KFw20/VECMw6IKsLsEjX8I0SFU8ONtFJxB71fpb9bWZ184+tO4HO+G1l4/E3MATRvM5lEwFiEvCEY2GTswTteANEe78PoSKWE8omVaQ5ZafIwfCla53GBstoESXHKVVt4EgTITluMscuPQT99mrZylIF3ZHQdItM006Rv7XpRZAwpYwOlTEQTDGr8/wKZiMMHcoIG3C/7XuFztM+0u7ZSFg==; s=purelymail2; d=purelymail.com; v=1; bh=yVDhIyDAVRKcy2GE3C+iekEW4ft2liKeD6tCpwv88fk=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 62202782;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 27 Nov 2025 17:49:58 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono <ofono@lists.linux.dev>
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v5 01/10] sim: add ofono_sim_get_modem method Align with the other ofono structures for fetching ofono_modem from atoms
Date: Thu, 27 Nov 2025 22:49:35 +0500
Message-ID: <20251127174946.89981-2-thevancedgamer@mentallysanemainliners.org>
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

