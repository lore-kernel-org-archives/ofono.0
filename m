Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A902A23C1
	for <ofono@lists.linux.dev>; Thu, 16 Nov 2023 06:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ps25+Tnc"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4083ac51d8aso3808725e9.2
        for <ofono@lists.linux.dev>; Wed, 15 Nov 2023 22:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700116926; x=1700721726; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bvSYXXzG3BlKTtToenr68QFe8L3nLrLMs5plOrXjjjo=;
        b=Ps25+TncnAVwJrp3FlTUc480SjmM0gmWSY6U3Nv3+mAZouxF+s41FKaEArGPWXgPc/
         zwRIf4MO3AuIIPex23M1TL/NxfWChqyJbQjxNu2aT1vfVigSY+69N+izz68a45wAnSPE
         McLgwImZkHnbrCzEGabnnXa+x7haa/7teeR8YPiBXhBf7mEfcbvctKJ6RiuDf6D2lpb5
         6WdK+fGitb4kgVjYL2Xcd3VbbrKcSQsQ1b1SrsOTAIxIElhCxEsfL5TunSG3cC9Ox32o
         OsYC6UHsm+MkX+5/YqqnVi1Y0DLRzhOL3unnXJimvUauI5RluHE7y5YwwnUXVHtU74Xw
         IGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700116926; x=1700721726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvSYXXzG3BlKTtToenr68QFe8L3nLrLMs5plOrXjjjo=;
        b=N6/2e7eBbdhjKthGdIwzKalKu4k0H6fRoj6zku5ioH0+Z5ONqr11ANLzzMC56IxxJ8
         BdBjdhf3SFcfYGODIBltgYGGE+ml5tYLGATaxl+o67id0umdjD9dNqELF3D6DxdabNlM
         1SSL/y4hnkQfZ9j5bcboO9/Ep2R3+YP8iZEnFdjYBzvRIkEmdjs7BZARXi7jrri968Mh
         4bfSzcNiThdsr/l20NJ08RZUFF4TDndNvnCQ5Ocum2vSHCRukIxo0lIEgMU+hNETDb0B
         bRQWq0Dt+mIC5/ATuGB1e5xXILppJcNz50QaP/L0/JDUwvQBtRAGrtMQaQyrkeBu+bfb
         bsoQ==
X-Gm-Message-State: AOJu0Yy1AGXW0iej0R7SSu3wQraCxQ6hakmA3Kzf/lhkrQTvYn8AXe10
	qNhk0BREWSiCXHPEY7DVTBw=
X-Google-Smtp-Source: AGHT+IFAIHvwFwWNMob9ATVUKNeITfHe8CYRYay+VnyJYmqYAdNlrJXZhoxfFnJJ/7UgKLWDSadRKQ==
X-Received: by 2002:a05:600c:3ca2:b0:408:3c9e:44b7 with SMTP id bg34-20020a05600c3ca200b004083c9e44b7mr11567072wmb.3.1700116925442;
        Wed, 15 Nov 2023 22:42:05 -0800 (PST)
Received: from tp440p.steeds.sam ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c358600b0040a45fffd27sm2225595wmq.10.2023.11.15.22.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 22:42:05 -0800 (PST)
Date: Thu, 16 Nov 2023 08:42:01 +0200
From: Sicelo <absicsz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: isimodem: reporting operator name to core from unsolicited
 indications
Message-ID: <ZVW5uZWITkB372-O@tp440p.steeds.sam>
References: <ZUZqIXkQNnen4Bfv@tp440p.steeds.sam>
 <540c9645-cc9a-4eda-96b1-4ee710a21891@gmail.com>
 <ZUti7nteHmcie5a7@tp440p.steeds.sam>
 <13f52749-bc4f-4391-9447-5df660d3384b@gmail.com>
 <ZVE5pI_Eb8R8aKLk@tp440p.steeds.sam>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVE5pI_Eb8R8aKLk@tp440p.steeds.sam>

Hi

On Sun, Nov 12, 2023 at 10:46:28PM +0200, Sicelo wrote:
> I agree that I want to return nitz_name (or other variable that is
> suitable to use for caching the name) when the above check fails. The
> question I am still unable to answer for myself is:
> 
>  * in name_get_resp_cb, how can i make the populated nd->nitz_name
>    accessible/available for to use?
> 
> > Or better yet, fall back to returning the nitz name when name_get_resp_cb()
> > fails somewhere in check_response_status(msg, NET_OPER_NAME_READ_RESP).
> 
> This also has the same question - I will need the populated
> nd->nitz_name to be accessible in check_response_status, and I am not
> sure how, yet.
> 
> In passing, I now also extract MCC and MNC from the other parts of
> NET_MODEM_REG_STATUS_IND, so there are now two more pieces of
> information to be shuffled around. Updated patch attached at the end of
> this message.

It appears that I have found a way to achieve the goal, and will soon
post a patch for review.

Regards
Sicelo
