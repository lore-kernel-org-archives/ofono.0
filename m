Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A732134D3
	for <ofono@lists.linux.dev>; Fri, 10 Nov 2023 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKJNLRss"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9bf86b77a2aso310741866b.0
        for <ofono@lists.linux.dev>; Fri, 10 Nov 2023 02:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699611618; x=1700216418; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1DfSHPougute44Z8mdYKRUzIrZw/mWGEcvWBAJa3wKs=;
        b=iKJNLRssx1MrC2I9jW6Lp3DPiG1QQMCIqutr7maLE0kj03GY4bsatTjj9Qlzd+nROu
         ePFinX9RkkxUUnmVqUEmCMpoYC8uOFBLr2QJ0Ldr8Dp7PeiLeroUzxKMJ6CVE0RcKW3C
         aYBqmnbSfq1LLfM/4ogKCKVKG+nFNPsvB8qxG4bZVcw+x1a9AY48FA0tliHfge3f6XxW
         ou3HatopSywqppcULRkcdsRcM2EKtxiWTfErmxNzoS96TOWL7arbRGUU/eG+g1QpBZ8r
         43tAjU6G6qkLeYweM2KhAWezWdVoj6KUaGKn3bEtlY/oqiiLQTfPIScuWpan6zXNEYSa
         w9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699611618; x=1700216418;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1DfSHPougute44Z8mdYKRUzIrZw/mWGEcvWBAJa3wKs=;
        b=rbFkSRHPUodowvkEKgflnL4DugpJnYJdBEgU6ddD16KMV7tUT153oiC2O3fopaJNXx
         r5oP/KIeoG1zD3l2j7yv80B2/0gHt83tgdsw/tZsnh+F+5JvESBIOg8YmWcNeHeB7iDO
         4on1xilaKrNXtPFiRG605/XRZA1W/doEhp1csy1Oy0QwR+/1DSHTV2w24we7Z7O06eGH
         PoM3eFP7YJNmfilQuHb/7/+urH8Y7nbTDo2PpzX5dpFiQOowYk2HrUmW/wBVSP6yLIti
         DLkS8srM2KDiQcF2VDCvMe8JN1J3pxXXxfbkiy8UUKhbfVv/2+cD4sjoQljwJarpopXH
         6eKQ==
X-Gm-Message-State: AOJu0YwAAdTov0iWdQh08krc3amE2sFM+01hFVWCLVhgQ3yVUOJLu27k
	I60ZeXGz2w+O1DzYZ59x9uodo+Bv47uglw==
X-Google-Smtp-Source: AGHT+IFVib7H5r2qmphclEtMLw2+NaD4oV5tmOlofRs4vGZzpzggLXpW0b0IjRHygQV4XTZNKZveaQ==
X-Received: by 2002:a17:906:4f12:b0:9e6:4156:af4e with SMTP id t18-20020a1709064f1200b009e64156af4emr670639eju.22.1699611618389;
        Fri, 10 Nov 2023 02:20:18 -0800 (PST)
Received: from tp440p.steeds.sam ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id qt19-20020a170906ecf300b009a1be9c29d7sm3746150ejb.179.2023.11.10.02.20.17
        for <ofono@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 02:20:18 -0800 (PST)
Date: Fri, 10 Nov 2023 12:20:14 +0200
From: Sicelo <absicsz@gmail.com>
To: ofono@lists.linux.dev
Subject: Improper Handling for Messages That Do Not Specify Source/Address
 Port 
Message-ID: <ZU4D3kXFAvCHs55i@tp440p.steeds.sam>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

While running ofono in debug mode, I discovered that there are certain
types of sms-like messages that arrive in ofono core, but are discarded
without being sent to the client. For these, the ofono log shows a lot
of:

  ofonod[3424627]: Got an 8-bit encoded message, however no valid src/address port, ignore

These messages are valid, and ofono should not discard them. In my case,
for example, the messages come in while connected to mobile data. They
are sent by the carrier periodically to notify me about the credit that
has been deducted from my prepaid plan.

At first, I thought the issue was on the isimodem driver, but I later
found the same log on my laptop, whose modem uses plugin/ericsson-mbm.

I am currently working on other issues that I have with ofono on my
platform (isimodem), otherwise I would try to work on it.

Hope the report is clear enough. I can provide more information if
needed.

Sincerely
Sicelo

