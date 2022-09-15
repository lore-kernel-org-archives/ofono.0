Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB144403
	for <ofono@lists.linux.dev>; Thu, 15 Sep 2022 20:55:01 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id x94so11456056ede.11
        for <ofono@lists.linux.dev>; Thu, 15 Sep 2022 13:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=IrpXA5RXNipldqHnkA51XPBWA7aASMRBkC7Q5UC7yjA=;
        b=V/vEpLpSgwMSHMawysFEBdCC5BCSs2De7Z/2ksaKxL+isBXMWHqjj/x2h+CwpYSKaJ
         9Cf6h/YKqRM+0FG8Fxdwtxr9wS31fFhUy3NtDj2HKNrhvM8au+GIOOLskm3OyAbSeee6
         My4DJD6Mhn2k+H1poviN5jcO4ka0x9VexjRdKzKz0KhwYClJwwf1CDBPTvFwcv8/aPFx
         NLIeBHKffmrSBl8n5/918A+8K84OP95dVo1mAS3lJnbw+MdXfdgplAM2CfpwIYKQWqR+
         3xRey28nKNg1c8AtAM8oE05WJOH+26YGYg1L5GT0ACicGWZQYu6ZEANr533iv/89y9zc
         x3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IrpXA5RXNipldqHnkA51XPBWA7aASMRBkC7Q5UC7yjA=;
        b=MoHGbqq2S40rDc0D/O6ciicn4TpjjU5UDZokjLBgVCAacOFG1OnHswx+Fbe/Pp85dU
         Jvq3fZInK65BpUN9sVNpJ8xWu1QnJo1daxVUZIP/jANTom4JRO5p776qfYVKN09DUCS2
         94lTRrKxKWD0ctpIldl+6D6EtG9RTPRA77INl9uUUIzRQBIbr3s+EY590Brp8l9f01s3
         cbkBzKr2G6spv5w7pUN9BJQkPp5wIvJ6mAi/VZOQ7KDI9zHTDFu/LAA5kOACMO//+W+7
         n4nDHmUqdE4h/F8LGm8WJmy6g40Z4WUg8aiTMF5wOS3vWIyWw2Iwek3Rtp4QfTYB1JCX
         sEfA==
X-Gm-Message-State: ACrzQf3guHtwEqixyVpZVkliyTRKvyXSXf2GKSI2Kg95uFpt99bs/w55
	hz4S21sSQe3IDbkyT8NMDH/4Bn5G+upPMA==
X-Google-Smtp-Source: AMsMyM5RgfLQaanU9N3g9PbaYPN6VGEnN3CKN2BDYADLtYld3zk3ojexIXCpz7sUpwtgUTAHY4NB1Q==
X-Received: by 2002:aa7:df8b:0:b0:44e:882f:7c5c with SMTP id b11-20020aa7df8b000000b0044e882f7c5cmr1411240edy.418.1663275299577;
        Thu, 15 Sep 2022 13:54:59 -0700 (PDT)
Received: from localhost.localdomain ([46.249.74.23])
        by smtp.gmail.com with ESMTPSA id b18-20020a1709063cb200b0074182109623sm9519424ejh.39.2022.09.15.13.54.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Sep 2022 13:54:59 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: ofono@lists.linux.dev
Cc: merlijn@wizzup.org,
	tony@atomide.com,
	pavel@ucw.cz
Subject: qmimodem: Service creation fixes
Date: Thu, 15 Sep 2022 23:54:33 +0300
Message-Id: <1663275275-19800-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>

This series fixes several issues found in qmimodem service handling logic

