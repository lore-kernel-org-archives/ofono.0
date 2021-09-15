Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EB53FF7
	for <ofono@lists.linux.dev>; Wed, 15 Sep 2021 18:23:31 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id b64so4571242qkg.0
        for <ofono@lists.linux.dev>; Wed, 15 Sep 2021 11:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=i/6SXmnPx/4H06ZOneSjjMdEetFDq77tIeWZ0qt6hsk=;
        b=Qt14nuhDwL0HMzU13kTqk7n8yKDeQO4JzemLd4efUGVfjF6wUY5TUho60+DbBgyn9Z
         EulDPqxLbvW+4zsjA24WZOftEPhTs06yBdelspcyMf5V/aYDJXrySB7Cm7RXTeypa/wl
         bvlwSPBgUKQ9rskTbggRzVnv6XjCjUG5PfcXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=i/6SXmnPx/4H06ZOneSjjMdEetFDq77tIeWZ0qt6hsk=;
        b=23Gk4VEORbOVbdmkLNjZaB5hOiXt5z5lOHTVy03INd4iD78JPnCooug+rkVuTHoJSh
         6ZPq2PaX16jeo+eTOdCw1o3e+RBkMfFEAXINob5yjN2Rw0QLLCNhSOvYqUBo8qiSUw9p
         Liew1JzOaCYPRQrL7cR+dMHE2lrFXo6SR7p1HsndF/D1EyQcRhBhES1uNtgyKLF1/q6t
         keRjCf689nA/WmLDXTFeNu7aKCb/uzGanM8rtZCe5xLzSE2kUa8MwqhQmbsy4nxass/r
         PbCDNB0jf8BuUJLLXNJMV1LaeF1NlkhFQF57aO+ttJL28hfhocjXbhQFZw1P+Rm8g7Ti
         DqTA==
X-Gm-Message-State: AOAM532Dofnja4pPmdmbOqqwS1S8jvgqShYLeG2SLjFT1D0lZV9chXOB
	u+2KHxftwrW+x6JICtqUHUoOrdbLikbTFw==
X-Google-Smtp-Source: ABdhPJw+WSrdrs0cZqlXyhk5JgxpC8DZE6yoX8p8QPBwrKEKV+92EhJmvEmg51SuSCG8N227eSGNAg==
X-Received: by 2002:a37:506:: with SMTP id 6mr1292473qkf.15.1631730209951;
        Wed, 15 Sep 2021 11:23:29 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id a189sm529571qkf.114.2021.09.15.11.23.29
        for <ofono@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 11:23:29 -0700 (PDT)
Date: Wed, 15 Sep 2021 14:23:28 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: ofono@lists.linux.dev
Subject: Test delivery to ofono@lists.linux.dev
Message-ID: <20210915182328.li2sikzxzkn525dr@meerkat.local>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Testing new list archiving. Please ignore.

-K
