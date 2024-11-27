Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CAF322E
	for <ofono@lists.linux.dev>; Wed, 27 Nov 2024 21:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732743126; cv=none; b=coLCp97TY4KHt4+3wmCueb5QCz3MgZITcfF69kBVzQ1fkqVEznJgJSGx4z4Ggs+GrcgUkXr4m9KVZnkYXzdSOCMkue8Rq2Aftn0pE4ujhrILWadmtfVrWnAVhql4Thkp4hr89vM3r7O4Y53wvb8MPlSyZkqeC2W2buDXPEvSoFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732743126; c=relaxed/simple;
	bh=ueKfNAB0UPPS79VSnZQMs81BzvVgtXsNHuPCaigc/gY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uqaU66LdUY10cPASF9/6/Aw1Vz5Y7vyg79GxJ76xDnT74z0bcFm4iJatl0KlUbp4f4BjpZde8JSBBlosDkUK3jeojwupPGkRnWowhQWEwOsIGwEj39G4I/9r6f0dFqYGdDhn4W+ATswec9lF6+EPhxfUPCqZ1fvauhu+Mg0+W3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8mE5uu3; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8mE5uu3"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2973b53ec02so175097fac.1
        for <ofono@lists.linux.dev>; Wed, 27 Nov 2024 13:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732743124; x=1733347924; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qjoH1IgYA6E/twIawgveTEBf+PsTyraRvZNOlYoF4S0=;
        b=C8mE5uu3nfhLbKFvwASp91vXBaHDXWUxbzOXPmmvpx5q1LGcaC28giosyNKKb32EpD
         CyV3WzSEJnMR6l+ho0ZZ4OIGIFEMUKOo/XmdVdIdNnH3xyD4GPt9dmhiOOkOBPY4PeAN
         X64W7yW//EKT9qpauFnXruvKG+WH+EVXaeRIskoHxLC90zhQLqwwLWqYVUERgBH5+Eii
         mP4+rdrdcLU/y8qMGKNxamKU8QzY6NvS3T3IWRcqnUZw8QKMRHDwdIN0vzJbby9KFets
         l0sagJ2dlF3LRr8XELnbjfvJ9ppsbwlFKYosG31WI+R5q3Vf0dUnUJh/YaBvnP6edjli
         fcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732743124; x=1733347924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qjoH1IgYA6E/twIawgveTEBf+PsTyraRvZNOlYoF4S0=;
        b=QUKsjyVAFbUesk148FSX2Jv7h6DudP8+1ZcAv7P4r40CO2tLCbBpUPyKijq5rc6I2e
         Yt/dvDZH5ZCyGk4mK1sQ9xO2xL0WRDVWcs3pkygEkQiYG6bfXV6H3Yric/MV7NvZRZ/G
         UyWAFgaDDhJgctBhH8t8nzisjsW2Qic+cBsPDtoYpI3szbnrdQFYRS08/Im5+AdHamAC
         BS32nJp/fuuCZPqlYsdmp4OT0id4f3n2/fertEGKdiKxNTp7FO2g9i6jGEvJ2y7jFl1/
         6t3MXOjmh4FycRMHr2Gz/W4AxIqT/uaWxFE+GnfoaVlqKg1RUgxCu17mSY9l7H7D3HP9
         b/UQ==
X-Gm-Message-State: AOJu0Yy+dErvgQRi9DbyP/wzbaeod8921ozgqVSCMSTPfapS1q4oX3j9
	HeoOWCTaQTum3xM7jaYMZzXU/SiN4Ro9cISkp4RoUvaChwY5PfYP3fAsdg==
X-Gm-Gg: ASbGncu09nacrnQkTdH+3xGcL9vQan/65ZnIGYM7eGgIzK/mcc29eAN/kMvkt8yQo59
	HkEnx4eAfiZwzEXwzb8Pr/EsJ3G8ZSLKoW6buOuAaXqkkddOFIbfVWszA8lHoDhd4bxWiOgEt5f
	24CaJYdX+YtND4ZzgWiOJWzGmTVeAuv4i1qy9WSU/Zz682wFua4DHlB7lvOhv3c4zyErT715nwb
	AF2+JsM1NU1b9Krs6EQ0+nvgQF0455t/iVW7jia2/3Xk7tzLHm6ypgQwtpXv0zjSAfphgvTxw9d
	1LgzWcOED5uO+o1mKVo3czQl
X-Google-Smtp-Source: AGHT+IED8tA6olW6Ogy2AFMr6QX/nRK4zHPM91B4o7AyuhzplnaELIWD8cXY964SPv7CpGtmXdQIhg==
X-Received: by 2002:a05:6870:e86:b0:295:51e0:9241 with SMTP id 586e51a60fabf-29dc4385da4mr4461856fac.37.1732743123751;
        Wed, 27 Nov 2024 13:32:03 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29de9ba6bbfsm29114fac.48.2024.11.27.13.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 13:32:03 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 1/4] provision: Add 311 270 MCC/MNC as Verizon
Date: Wed, 27 Nov 2024 15:31:48 -0600
Message-ID: <20241127213200.202536-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 data/provision.json | 1 +
 1 file changed, 1 insertion(+)

diff --git a/data/provision.json b/data/provision.json
index 434bfd8d8f7b..50319cf33a51 100644
--- a/data/provision.json
+++ b/data/provision.json
@@ -14266,6 +14266,7 @@
       "310010",
       "310011",
       "310012",
+      "311270",
       "311480",
       "311481",
       "311482",
-- 
2.47.0

