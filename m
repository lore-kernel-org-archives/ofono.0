Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B1F7C
	for <ofono@lists.linux.dev>; Mon, 19 Sep 2022 16:21:16 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id j17-20020a9d7f11000000b0065a20212349so961821otq.12
        for <ofono@lists.linux.dev>; Mon, 19 Sep 2022 09:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Tysj0S5yObq/cRgc0yquf6BRTJx0ZgEQkFHr1OMs33Q=;
        b=ThM5fRHgdneyQJdeHZboQdFSEJairbKYAsEYO9K46+spuvlAW4Dopi0MsBWLiUaC+q
         y4p0BM6eK2czGDP9tAhYJcTs4v9dQaTBQ8MA9KsMfI1N9hc5nvj6FatO3lO9Vaj8Iiok
         0zVnOoCSbNtDT76DBnFcOQgogyep8vfW358OfCmv7+EF33V/wwy668nd52i2/uPXz875
         iLaIyCwiqC3+SAjn4jYAyL1mVhtzQqMduFkg8vB+P8FGCXeo3uCNpASeR7IczNJu4Ypb
         Y10XzoU3cgu/cbmjJKx5AVPBTsHZCCsaHJXG8hTaz/I5X/ludiCxQh6WYlKtMV717gUg
         a25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Tysj0S5yObq/cRgc0yquf6BRTJx0ZgEQkFHr1OMs33Q=;
        b=c+D/pa1ihcp6vlLDwkUx9qKjOu/2y4gN5rPu88HJYPCDQh5Y4XkYewfPzTeaGNSb/V
         9nj94xhV98ffqOT7KQ6ViHJj2GfkqtXn5nkZlvtaFAaGakPuiMzlS1Jzrnji1hOnyDBS
         gLx3qm2Oa8RFNrrddFr+Md9iVRzJSTCTMTKHWO4cZbnEINj6+FxnevgKBho7K7c+xDtu
         T+Yy7Bd1EIddnAzl4tZfBt/s4kdNkma2PC9tK5CCU3903rSh602SsVrPB6P9Ht4NvHmC
         1hTE2YT9iPlmP5VvTRnLdwgOsrdTijhcM+4Fj5am7iuD6qdNDhWbrgqslRfqQRH4ISJo
         f+Mw==
X-Gm-Message-State: ACrzQf0L/0b9kTM6h3cGMD+L/jnztZ3J6CbGxfhZY9y6/j+ir/aEdGyt
	ctxqv/0djzyxPmPN3N6Gvo0=
X-Google-Smtp-Source: AMsMyM7kOZon1ttb6CpKCd4aAe8GLzyoQ4Ae8ima9IluDixiVO3WJ07bMpMmAzZghIrccoq94zh6oQ==
X-Received: by 2002:a9d:189:0:b0:655:d9e9:cd38 with SMTP id e9-20020a9d0189000000b00655d9e9cd38mr8040870ote.258.1663604475721;
        Mon, 19 Sep 2022 09:21:15 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id be36-20020a05687058a400b000f5e89a9c60sm8455921oab.3.2022.09.19.09.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 09:21:15 -0700 (PDT)
Message-ID: <1d13423c-322b-6ed7-b438-7d27ed1e15f0@gmail.com>
Date: Mon, 19 Sep 2022 11:06:54 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] voicecall: Make sure SIM ecc numbers are always read
Content-Language: en-US
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, ofono@lists.linux.dev
Cc: merlijn@wizzup.org, tony@atomide.com, pavel@ucw.cz
References: <1663275065-19685-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <1663275065-19685-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ivaylo,

On 9/15/22 15:51, Ivaylo Dimitrov wrote:
> It might happen that by the time ofono_voicecall_register() is called, SIM
> is already in OFONO_SIM_STATE_READY state so SIM emergency numbers are
> never read.
> 
> Fix that by adding code that reads emergency numbers even in the above
> case. Also, make sure ECC file watch is properly removed and sim_context is
> free()-ed.
> ---
>   src/voicecall.c | 40 ++++++++++++++++++++++++++++------------
>   1 file changed, 28 insertions(+), 12 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

