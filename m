Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D8B2F27
	for <ofono@lists.linux.dev>; Fri, 16 Sep 2022 09:31:25 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id lc7so48187584ejb.0
        for <ofono@lists.linux.dev>; Fri, 16 Sep 2022 02:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=cczbia5HZ50V2hAXjOqxyX1tr9btvrE5AetlLGG/248=;
        b=jmq3Og8DvrPS7sKwpJcm80lLzUpTGTky3RP+b+DEY3lU7chb/Ia24lM8K9YiiB5l/P
         yofkebIGBqilmZQpg73/CKDvxbWG9PnGg5u6LjKlfqr7TJOCwpAPYnRRAPjb0oRVCyqz
         Lhuib6TGnV8HNsgVK9dYCLaiVBfk/5JAi+pXCln6r3G8PyVhVHtCISxHwmXY1ro/qjvP
         ANmor4Ou1TtOVFJgmDBqSuv7hH0MzFY2S4My84IiSmVdwedd3/MOl0X91nJxGOvTqgNV
         ANttCJNF6OpU8B3HknLvAUv6cTm9/wtAIc+GzA/5woAAc6gkgFfVgzj+ENvRMFJ4zOTN
         ZmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cczbia5HZ50V2hAXjOqxyX1tr9btvrE5AetlLGG/248=;
        b=FZEUHwnB36CqLm6VgGel5K2le75pKRa1sqNj/MB3ki64LsHheQXed1lrHjyi9+XNZv
         mX3sHXuCnT9a/yqsYKlHk0h8GMvo4/Xp0jXrITf4oXgf1AwH02nxudvOYPUkn34emDcv
         hIrcQQxPK10Ph2DaViV0UCA53PsjhhheIo2Kl6rqi/jNrgaFnIbiiN+BUfEOLhh98prb
         3tJyu9tvqF/MyeEs3JniYVG4fvCWZpAdHE1unoF+5RwfkXH76BWPCeM4JOn6ainuS27e
         87trMRHfGRHa2uNVI3ZGdyVQHgIcYg7o3xM3XyajtbIV8gUOqtIlKLAonfQ5tX1zP+DY
         ZOKA==
X-Gm-Message-State: ACrzQf0rDQVtZTauUvFDnCW9n5NTefns8jgIj8mcocHa3LLUXCDkGFFR
	6LZmLtewt12IVahExlqtbZLXVUz02oRRdQ==
X-Google-Smtp-Source: AMsMyM6cANnr0aa1peQUVGMupQYxr5C4oFdgEkH5nve/msC9DudHd8OJX1P53k7t/ZWHfAOh0hKZNQ==
X-Received: by 2002:a17:906:b106:b0:780:83a8:773 with SMTP id u6-20020a170906b10600b0078083a80773mr2907866ejy.758.1663320683779;
        Fri, 16 Sep 2022 02:31:23 -0700 (PDT)
Received: from localhost.localdomain ([46.249.74.23])
        by smtp.gmail.com with ESMTPSA id w15-20020a50fa8f000000b00452bea2a0bfsm4611434edr.44.2022.09.16.02.31.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Sep 2022 02:31:23 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: merlijn@wizzup.org,
	tony@atomide.com,
	pavel@ucw.cz
Subject: [PATCH v2 0/2] qmimodem: Service creation fixes
Date: Fri, 16 Sep 2022 12:31:01 +0300
Message-Id: <1663320663-26277-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>

This series fixes several issues found in qmimodem service handling logic

Changes from v1:

[PATCH 1/2] qmimodem: Remove service create request on timeout
    none

[PATCH v2 2/2] qmimodem: Fix shared service creation logic
    Some bool fuctions were returning NULL, fixed.
