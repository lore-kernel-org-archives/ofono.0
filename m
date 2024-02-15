Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E9DD29E
	for <ofono@lists.linux.dev>; Thu, 15 Feb 2024 07:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707981488; cv=none; b=FHq7n2Ys/zgIFaG+3dUOtIHvpT5UGsJz1MKekOyb+48Ajdmqfe8TcPf1YkSELr2RQMW780RIUYQXl6bVtCYDVGWRVxshyX53hasDG8rN4gK6H6mTVMASJrhEJwaRkDxRKxFuur085H4FHXAY54/7819BVAVJDUH0qqiaQ7eUNIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707981488; c=relaxed/simple;
	bh=qoLAuaIT8Pm8BRTdeoK/W0w0hYRhG+tyfSIeXqyQrmQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=YIwxWu0f4ea4Pe5Y+DHNhldZqxKfpG2yqANM6/IkkU5J4hvbPyOeabz9cBMv/VUDWek+isRTM+CALSQoYD0K4A1C5DV9TKx1X5l7jQVBczbMEqOoPA5kWM/Cy0eysddL9NzOx1r6W13EIf+gMNCVDr5Ioe536DMuMjynLYvh5oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aa8ruXEI; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aa8ruXEI"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-563ba83734fso139406a12.3
        for <ofono@lists.linux.dev>; Wed, 14 Feb 2024 23:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707981485; x=1708586285; darn=lists.linux.dev;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoLAuaIT8Pm8BRTdeoK/W0w0hYRhG+tyfSIeXqyQrmQ=;
        b=aa8ruXEIbhsbg1+L1W6NGZwtKYAhS1bQHL0MqPxhdavfdjvJO/geUIY6ZMDQrOfkqb
         MLS/w2sK5poWphSRXUgA7Bs3FoS5gODR9rjFIn/+0xGE5j7OgXJ6zzq1sVPIWE8vhA+d
         Xteu0rnR4VX4LiWhwoHrKADeiiP0LjB6Tt/TxUW8xIZ5xrCPcplZhVzxSRGdMhrMMSiu
         m6Hu52nNZuhyTRRvNHYBE2LB1P4jbHKPl+dMwJ4oEFI9p6YRGjKP1qa/5+9ns9WhLKFI
         fcAQT93gmqT/J2MZCM+RxBc4WAMFGceQ2rC3Dgg5sGikdVSGPL5hl5MBCvzU8R74Zdtz
         bMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707981485; x=1708586285;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoLAuaIT8Pm8BRTdeoK/W0w0hYRhG+tyfSIeXqyQrmQ=;
        b=OYABiqrQIVmdXMjlOWvoZ+5pcC8sUN+TK9qeHK3Lt9mp8BECaDJBdXKKvg5u7vjlt/
         /Sg7afnNnqfv4wESwaZ2nPM5KNjtnnT0zKokv9gZNr8Rg1bf3u4Z10W328Yl9y4jMrnE
         Gl/3kQ+RUy6Uej3Oxjp2/jE9A35UXAEe84XG4VV67O/NJyGM5Zl8nj+wlLjsIt5f4i+X
         fiieyI2OuT8CdOaYyKVvLEg+2y1SKQJQuBE6MElfhZbgw0vw9rwceo99TgVSQnf0GZIL
         MkbDZYmt2lvy9px+IR3cVAqfpJ4XqqohJkoWR4XypRsGBzHVLIlJkPGd7BazzH+rVOpJ
         ZvyQ==
X-Gm-Message-State: AOJu0YzqW41BUaX5WcgUERX++M8YrJRur0Nq0/oOhW15ixDFBeoLzndh
	VhdcCTVu901Jd6Q8boxpUUEKJYoxKKRDjsYMyO90bLMS0f9TYJ5+nG1HgqfP
X-Google-Smtp-Source: AGHT+IFAgAe8n8iKOKEK4sqJ4oWlQpoDerkpbj9jltXjAucpscYARzXgjaRkI5jrgd0XXyTO1AuUVg==
X-Received: by 2002:a05:6402:120c:b0:560:cae:53f7 with SMTP id c12-20020a056402120c00b005600cae53f7mr662732edw.35.1707981484594;
        Wed, 14 Feb 2024 23:18:04 -0800 (PST)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id v28-20020a50955c000000b0056003b75400sm293671eda.44.2024.02.14.23.18.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Feb 2024 23:18:04 -0800 (PST)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: denkenz@gmail.com,
	absicsz@gmail.com,
	merlijn@wizzup.org
Subject: [0/2] qmimodem: add more drivers
Date: Thu, 15 Feb 2024 09:17:45 +0200
Message-Id: <1707981467-2955-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>

Lets add call-barring and call-forwarding before jumping to voice calls.
