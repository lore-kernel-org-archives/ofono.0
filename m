Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99794E545
	for <ofono@lists.linux.dev>; Sun, 18 Feb 2024 07:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708243168; cv=none; b=QeoVKHifpXIn7Uw18zIk5qwUwM/Bb6LKYPl/M/P8xdcoX3qAKEFtgEjbPC4DaOfT4zRu67ku3/2rxvPtbOPgqfwLWdyV4K06GHgWbSsbTit9hmxQlutcu/wQ9fjDm6X6N7xP8I59HJOLAvgvQUth6hyosqgEKej549a4r6CZnSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708243168; c=relaxed/simple;
	bh=ZPLt+wORgOGNmJPGiRNMYq09Yv/8AVHpuAzTsBvGuEc=;
	h=To:From:Subject:Cc:Message-ID:Date:MIME-Version:Content-Type; b=Z7lA4IK1bz4yiYfxPj8VeL5Pgajf/vO06USlCy3QPGkz/iIZsui+IvPjdwreRRmoiQ1LlPqsgpf+LomHa5naboqZI4ZwUNW4UxryLsuFfN56Q/6RvO7wzGqsw2DI1Lv/BWqn3svNm+WqqhEb87ey0YBPjRt5kthGTEfFDCU0LHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoXY6n99; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoXY6n99"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5646c8bcb93so46655a12.0
        for <ofono@lists.linux.dev>; Sat, 17 Feb 2024 23:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708243165; x=1708847965; darn=lists.linux.dev;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:cc:subject:from:to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mh+Mcr0cUfQxy6yf8LBA8V3aqrikftVJuSxRmPcOQ8=;
        b=UoXY6n99bCsNcUJO+yYWQY/WCQENZCaXfk0+mIaou533l8EJ5Emklv6leN8cjNL7QA
         f/nwcAe4DJq+4okySLh64/+ZLONgnqldqwAsRSR3N4xzORIsVHGvmSrOVCxIA2CSq6io
         3yKtBoidb/efTkwbiuQSV9KpmLW/TA0K0Xx3LjUXW6thwY1ab9qybeK2JXENt7YlzMXo
         ysnckLlxdRHEf7CgqOPp4QSr8x13jczlx9izFefULrm8gf13SJALucw15gk/9uSrFjpG
         8DfYHQl+CbVlLvO7RbOiNb9tum/W37M80/CDA41L3NJGur7bNrUav+PnzpfW+WMwKFFB
         UZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708243165; x=1708847965;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:cc:subject:from:to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mh+Mcr0cUfQxy6yf8LBA8V3aqrikftVJuSxRmPcOQ8=;
        b=olcCFs/WqJl17YAyHgsemWekzJLXRpBIjnEdIdAFyFFs+MJtTQ6UV5ztvBZ0sCl+lq
         T0JlpdecJt0XiaKQuPYKNWmzzeoiEOsKcbgWzjwLyxWJYp579dpnaKXOU33NC2MTaIV6
         NeToi2VZ2U/VlNyS9fhskrs0ZOz+5FBXQdYU4qdITqFuPbn0ypl7gcWjKMF/w/2z/4jA
         +Mvo5vPFcVLkLo0U7GGR23fbBEU4YVPCJXV05OhT0pAql86xMhvNscNnZqIVDiR/O4Cn
         /CTlTcGHg3K6NXoOAbc7eEFy1hNJ0WRl1ByYgKlMgaMa3SLlIYLHGIna9cUMc/X+Y1dm
         Xrww==
X-Gm-Message-State: AOJu0YyXbU0rW+wf7K5m4ndbCErVzrcn5os0+rRvsDARhcoDoIDBkJtY
	YpspEaA/6cPyfzWuhfV1geeX6hVpIdODeThl/PkpmXeYthvaNhPA
X-Google-Smtp-Source: AGHT+IFyaxCZkbDZ+ZpgA31yV56QFzLhr8c6nX04eD9eRSjcUO9EkqHbCp4lVwvYm5tROte7GdaWsg==
X-Received: by 2002:a17:906:2b88:b0:a3e:34b2:a2fc with SMTP id m8-20020a1709062b8800b00a3e34b2a2fcmr1463133ejg.1.1708243164757;
        Sat, 17 Feb 2024 23:59:24 -0800 (PST)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id wb15-20020a170907d50f00b00a3de52ce260sm1705380ejc.200.2024.02.17.23.59.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Feb 2024 23:59:24 -0800 (PST)
To: Pavel Machek <pavel@ucw.cz>
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Droid4 ofono support
Cc: ofono@lists.linux.dev, Tony Lindgren <tony@atomide.com>,
 Carl Philipp Klemm <philipp@uvos.xyz>, Merlijn Wajer <merlijn@wizzup.org>
Message-ID: <30d8cac7-15bd-f0ed-0472-44923fac8870@gmail.com>
Date: Sun, 18 Feb 2024 09:59:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Pavel,

Recently I started working on submitting ofono patches for qmimodem, 
hoping that eventually we'll get motorolla modems supported in upstream 
through QMI interface, but to my surprise I saw that you already 
upstreamed droid driver based on AT commands set. In that regard, could 
you elaborate on few topics:

- what is the issue with QMI interface in regards to 
https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/plugins/droid.c?id=07e00b7215cd98aa033f2ebc4ff169662d95d34c#n197 


- what is broken in AT commands set on droid modems(according to the 
same note). Like, is it just buggy or it lacks functionality or ...?

- is voice supported through AT commands/events

- what is the best direction I shall take for droid - shall I try to 
extend it to full functionality by using AT commands set or shall I 
migrate to QMI or something else. Keep in mind we want modem to be 
usable from within leste, not as external modem connected to PC.

Perhaps you are aware, but still - in leste ofono we have more or less 
working driver, but to my understanding it uses mostly QMI interface, 
see 
https://github.com/maemo-leste-upstream-forks/ofono/blob/maemo/chimaera-devel/plugins/motmdm.c 
, so I am a bit confused now :)

FYI, this is what I recently implemented in qmimodem, voice calls 
support is next, though it will take some time as I want to discuss with 
the author of QMI voice calls support in PMOS:

https://git.kernel.org/pub/scm/network/ofono/ofono.git/commit/?id=e6fd9a2cba54f597099dc5b13de64d1a83cba574

https://git.kernel.org/pub/scm/network/ofono/ofono.git/commit/?id=a6119e6b2594e4721219484512a5cc413828116c

https://git.kernel.org/pub/scm/network/ofono/ofono.git/commit/?id=8af8136f61742be963b67b88f18e85c12509e0f9

Best regards,
Ivo



