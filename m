Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B07182DF
	for <ofono@lists.linux.dev>; Wed,  1 May 2024 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714587742; cv=none; b=lOAyrUZ9yjKQfKtB5amPQYxXpg99iIEy2Sg0e2n7Q73wvCzFlGG3Uhl5fqegcBxzOiErkUIDVXnw7ZJ+c46HY3Cw/MO6xMXjMT+1p4D1nXg98sEkZe0Ns4c4TvwFzneFWXG4FUWAOnaHH6QSjAeFJ3RWGljo6Ivc3ltF2FFVjIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714587742; c=relaxed/simple;
	bh=rwaVeHFe1qzkmT+MrLWyM3MxWP8hZ/AEIBvypTQ1TCY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IMjNuqrE9nGUWuK2RRZuWT8MW1vSuGNKH72Mee4Vkpvj6hJJTwxEwkRvWrOmP2DeWqHOxWqm7lATyBoZwepMOfravnaY2IpDs/w5xRqNib9ncSleO7t8U/0fE/UJIIm0OfeaxqxrOjASID09ASwgWSeXLeEYQFSFlgBKMBZMizs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFUQZ+v2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFUQZ+v2"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41b79451145so43227445e9.3
        for <ofono@lists.linux.dev>; Wed, 01 May 2024 11:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714587739; x=1715192539; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=scnpC3nb9CJZWi/mIVnvdGaapbILBiH3wiAkm+vtdzk=;
        b=NFUQZ+v2vArkpm9SuBvWtMKXIX0v9OQUz+KmvHSfvUV3Ig9VB+h//UAbCPQXphQJ16
         CfnZsk/ORO2FeR4Y2jS1NX3UZ32weWD0X9tyH7lGQh/aod3z1wiWn9VoFSupC38lXD2C
         T8wVmIC9jLpsuaomNYR2GXHlh85wAniUw0nIhveuxflzP9zhbCxWQMNBxLeqsuNVVbLx
         /pKPP9rQj7QGzCK1VEgxaUJW771vOiQup0tDmOM4wPKiWTvfBYGV5PWZhuNRNCiWrWWd
         mmajFQbL1+0ugQpf4/Irsu950499IN5MBtUQb6jP16IOElYeJqBEq2B2o2Xoh6OE2CMI
         LSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714587739; x=1715192539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=scnpC3nb9CJZWi/mIVnvdGaapbILBiH3wiAkm+vtdzk=;
        b=TXi41lEAB4mzhmaBVszoeMGY7nzSo53qlDziBMWTCQbCt371cBPUTOd+lrQH3AOmXz
         KionONWXMhtSTP79vHQW4ULVjTOBEfxT06k4mfYEyPZ+1282dvN8//KCAxrXn47B2kwh
         9plo4knAO8DTdqmnqcfPYvXWNW+JvENvsPWT5h9ihVWPiHw8hokXCZuV7YQrZtJXmr9u
         pgzSW/76A4iQWLYDRGxsCX6WTj/zt7wjAGwXiZNe1TroEK/G0P6cppNFbSpW5ZLQbkDr
         0c7iAH4hPA36U2TY5gCqyfqu68S/3IFLw1TsIZ7F1sESBswVSnUm3M0JY7dGA2xOQxpq
         If6w==
X-Gm-Message-State: AOJu0YzD/3N+3BR8WOprpSGxTGVvJN0SPhZlCgNtlIaVuNO0DBbHWnxp
	IHHaANOXgX9D+5CWoxiKtqcCLSsDlFrc9q5rGnqRqk5vZAxMYuhb1TTmnw==
X-Google-Smtp-Source: AGHT+IGrw+uAkx67AkBKnHNTeruh5VMIUso1B5Z7s7b8rM1QXp2kFe64eQNRjVkKFdg2GUa7/KMbiw==
X-Received: by 2002:a05:600c:1986:b0:41b:6cf6:61f8 with SMTP id t6-20020a05600c198600b0041b6cf661f8mr2153168wmq.11.1714587738686;
        Wed, 01 May 2024 11:22:18 -0700 (PDT)
Received: from adam-laptop-hp.localnet ([90.243.134.17])
        by smtp.gmail.com with ESMTPSA id je16-20020a05600c1f9000b0041c012ca327sm2958662wmb.45.2024.05.01.11.22.18
        for <ofono@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 11:22:18 -0700 (PDT)
From: Adam Pigg <piggz1@gmail.com>
To: ofono@lists.linux.dev
Subject: RFC - Add AT interface to qmi device
Date: Tue, 30 Apr 2024 22:43:12 +0100
Message-ID: <2146730.9o76ZdvQCi@adam-laptop-hp>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi

I would like some feedback on this patch I need for the Pinephone.  I do not 
expect this to be part of ofono, but I would appreciate ideas about any other 
options for how to implement this, and maybe there is part of it that can be 
upstreamed?

What this does is add a GAtChat to the qmi_device via the gobi plugin for the 
Aux interface of the device.  T


