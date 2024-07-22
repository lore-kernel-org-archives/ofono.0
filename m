Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF383134B6
	for <ofono@lists.linux.dev>; Mon, 22 Jul 2024 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721663727; cv=none; b=ksqPK/b5C9jG4k4gvRnOPfRnHpHaXvSr8YWJZWFYQk+AX5Vhc41xYJaIpM6ewvjm91nLlghGKPpVogfSp5FoeYCFDsxu4IgAOQJYGwdb7QjenSBCd28apkNDrOamVwJVDBG7rh/S7oDWtB1muR6KVG90faCnTQWhy+BFpFC48YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721663727; c=relaxed/simple;
	bh=FEB4Kfesql+l9uVId7hsuaHLZTI3agfW0QgCG2pBuhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nceXZsEZqTwhybXOmfqUprrfxMNaY0oB4HxEKpg8BQprJk1fqiP+ART0GZBoBv5O2ZsAlqQ/VBwrkDMCgJ/ofg5KXrLqSFJV8uPn4t2Md7iyfu/ZS+i/okgkn7dTH3ju0024fRcFEuZwf8MyjG9PhOb/fh311PDFJtqiP5c9etc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBSqnx3W; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBSqnx3W"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5ce74defe43so2375579eaf.2
        for <ofono@lists.linux.dev>; Mon, 22 Jul 2024 08:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721663725; x=1722268525; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K3b3oavg64TsImh2a37HEjH9FaIGMAWph+t8GSj5ykM=;
        b=TBSqnx3W+Oveu7AKPgsmBEPzPm/CBSDas3uun535erq31jeP3vwD6uiVIyHEGqMr9W
         nL2k8iTL7qRhZHSvfVAZlUsVhgkOgibL17nmwyo4QFaprFLD8RXLVYU+BQph6xupEm3a
         La2KrbMRbz/R1lhRpogFBiVctM/dKyUQ0cfM+4YcoguB5YVNa0y8t0E06r2QULVqWScd
         UINP3ZEcsHfJ8bQtHawWYrwbuWPdfvln5eWwBVfq0B8YtEO8uNBMDnjEXD535dIVXKNB
         PZIrXxIpUHBsNHVCV1owtsBe1lcaCTZehQxWY8KSYUg9C301TB65va6JiAgIvTAkFwen
         X4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721663725; x=1722268525;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K3b3oavg64TsImh2a37HEjH9FaIGMAWph+t8GSj5ykM=;
        b=uINEHBd7JwxAQ7sn5FbEe0EifUyHG0MiDIPk7gV+d5/7wnIFguBvoy5u6I3I/a1QJd
         YCeOhKXz59OrmARzXJ2EK6Cc+i+DVJuCnFoaneV74R6igB6zvqb2ViBi1a6Hu7G/ASiD
         XbUIZC+borCjq2iQAUghLxFw1NP+6DW09e7oyYbw4Jdy2LRTBh7s5HiSa787rBYizcqG
         fq6rLpMQcfYTMy7ZCn3Scp3+0Gx5AoJ3PdBLkm26gN0wq0aLtabKwTNoPv0M8CYNWvX8
         jHCX5ZYcNJORv+lPsH885wPx6Gv0mTVLVPy0j1FyBmUePwEpVBx2l6YjPasWMkhmgQGL
         h8sg==
X-Forwarded-Encrypted: i=1; AJvYcCW7v1DH6ejWlRpNTxmK5ZQCPaU29L7XNRoBcTCrMqKXvOlRtt7odAYn4IggrB6C2f0hlQzoCapSnGp7pE67X+YaoBv+FgI=
X-Gm-Message-State: AOJu0YzXUhO0UCUJLMWuLeIZ2bUnfBYBzZAhdGZDIY6sTb+GhMiVnZqg
	zT+N2330EyZ4CgdBmhaZR/Er/Uox0ipWaNxUVz4Xv+asQLSsGopN
X-Google-Smtp-Source: AGHT+IFHQYPQ8SCbpZMlMafn1Na0sWyPQ/zaUzqHYc01Gjkca2Xi9vdgCaGCvVf1JM4ykhujIUAcxw==
X-Received: by 2002:a05:6870:d24e:b0:25e:14f0:62c2 with SMTP id 586e51a60fabf-26468feea2fmr89582fac.3.1721663724801;
        Mon, 22 Jul 2024 08:55:24 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2610cb15b15sm1708424fac.52.2024.07.22.08.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 08:55:24 -0700 (PDT)
Message-ID: <0b06f3d4-c509-465e-bceb-574d900fed6d@gmail.com>
Date: Mon, 22 Jul 2024 10:55:23 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linker errors with external ELL
To: Adam Pigg <piggz1@gmail.com>, ofono@lists.linux.dev
References: <2705084.vuYhMxLoTh@adam-laptop-hp>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <2705084.vuYhMxLoTh@adam-laptop-hp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adam,

On 7/21/24 6:14 AM, Adam Pigg wrote:
> Hi Dennnis
> 
> Just to let you know, I have to patch Makefile.am when building with external
> ELL as a few of the unit tests fail to link due to missing l_basename.

None of the unit tests listed in your Makefile.am patch are upstream.  I suspect 
they're present only in the Sailfish ofono fork you're using?

Regards,
-Denis
