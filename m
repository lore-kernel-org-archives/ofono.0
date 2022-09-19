Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CB96AA2
	for <ofono@lists.linux.dev>; Mon, 19 Sep 2022 17:02:51 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id j17-20020a9d7f11000000b0065a20212349so1041047otq.12
        for <ofono@lists.linux.dev>; Mon, 19 Sep 2022 10:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=i/Yrx4VMBrylLbpHeECFkDpqy2LOibCBStiT8mXmKH4=;
        b=j/FOw+5nOuW+qUs4q6svEi9U9kj80pQ5gUoIwENMsmjyG5j9BsuYmYn2HuPcsW6572
         5tbkS/sln3Sn41Dx8sDJzG/Jfx+7karQW/asRK6Sz5QVEqh3qsX0likx+4OlhFgPPmJ/
         25icRU70Yoiz3qEjLJw5/gC+V4FLCZsagEhzUyimx7LMQUhWgQn7jzoAiu5u74kEKW0A
         UOZOUsYrK/8sKFbvbTNDNmu/u4f3nmFjzNf0fGaB0JnYjpWS6vcV9AWSuZvWcVXfgkuo
         mdP7RDfTnN0hXMVgpO0l97xvLzYkOm36aVumrcbFcGYByMAEp0Gh0k7jVvK5KEWMSbiJ
         HU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=i/Yrx4VMBrylLbpHeECFkDpqy2LOibCBStiT8mXmKH4=;
        b=7TcCw17eWl7E1Z2qgn2Euo15G1h2tfBGw3/jMuSL4s+lOydhpM46CltQFFiebqrHMu
         LDi6iVa6zlq48a9A9Yx0wR6/6cPYXEE8pGgAdbP44hSes6JvLS4j224uNCNU+G1OVLbU
         0zXGdJKveAf6dpB/nQvS/K1NJTNxjbwyll5jTqwZMgMx6/Sqpu1jmhPkvuNUVx2DsBSa
         dIs5xDZOkWHQyQrT6jmDMl53cvBmuEGtPFmT86p8Ypf9LapcN/nvynU8y91Q8Nq6h+zv
         DBnzB/JqCiCd0hrgudZlhSxDLlcNDWORxX9GqmFzI/UuEGxJGX2LCXz2TLBO55Gba5WZ
         jt+A==
X-Gm-Message-State: ACrzQf2yXZP8XSbd9P2sHjxbzcv/S4rCk9Rn0Z5C80YcMjakR4qAatSc
	XgNxMbgi9KDqk75C24foEObAI5dCxU8=
X-Google-Smtp-Source: AMsMyM6IjNfudGXhn5DI7x1Ku3Zvpq5mCBoBSrI48+hMGTD7jZ7x7yvhI0hKJDlZzbeDYJop3tubwg==
X-Received: by 2002:a05:6830:6289:b0:656:f6ff:6825 with SMTP id ce9-20020a056830628900b00656f6ff6825mr8399621otb.170.1663606970691;
        Mon, 19 Sep 2022 10:02:50 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id n133-20020acabd8b000000b0035028730c90sm6927478oif.1.2022.09.19.10.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 10:02:50 -0700 (PDT)
Message-ID: <94afcbe8-5d10-2719-17c2-780dbf230c54@gmail.com>
Date: Mon, 19 Sep 2022 11:47:35 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/2] qmimodem: Service creation fixes
Content-Language: en-US
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, ofono@lists.linux.dev
Cc: merlijn@wizzup.org, tony@atomide.com, pavel@ucw.cz
References: <1663320663-26277-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <1663320663-26277-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ivaylo,

On 9/16/22 04:31, Ivaylo Dimitrov wrote:
> This series fixes several issues found in qmimodem service handling logic
> 
> Changes from v1:
> 
> [PATCH 1/2] qmimodem: Remove service create request on timeout
>      none
> 
> [PATCH v2 2/2] qmimodem: Fix shared service creation logic
>      Some bool fuctions were returning NULL, fixed.
> 

Both applied, thanks.

Regards,
-Denis
