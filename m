Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60E66FC3
	for <ofono@lists.linux.dev>; Thu, 18 Apr 2024 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452618; cv=none; b=o91Lek9BgCvRMB46Vrwo0NyprGiEGrzQ0B8TCggg14EtVmSDs17ZZ8Vbl0gdOe9lNAdCV7rUl0G8tlqOI0X8wBqJpFUvBSfiCyFxcCv/UZ3S6yA48YWAqu1SIfmYHH38pepEw0oa8hxjDzjbiHYDlpT1zTOCNCOqW+MaaaOI1l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452618; c=relaxed/simple;
	bh=oOF9nYMI+foodmMwHCVdySYjedSlDxozog6ptGnhj2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EDkJFJ5A7V57zoE7IFfxpzkyxDkIXILI8P0QdLfjeBkgp5UOjh3Vm9FGeE37Ipe9AmaZb8ZAI51J5x7+/Qq5gF4dv7NLvBTI0zl8ji80HcM0CAIr7HbQdSsfA/i8jzrkaCJU3wxtuQzI9aGIjjvmg5P2+GqXjStb2ZcwKichaS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbLUGnGj; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbLUGnGj"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6ea128e4079so459603a34.3
        for <ofono@lists.linux.dev>; Thu, 18 Apr 2024 08:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713452616; x=1714057416; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tWjxCgM2nTFzxv0rdr4oshpMGy/GdpXqt2C7zg0NqPM=;
        b=RbLUGnGjYeg4XsOgBhsNh9MuugHmMAW7pIz5cV604huqvWLErcKLo226rglXIM0oBc
         w8ViALnld/zqP7K7Cs5xy0JnzaQg1QnnrgABAaF/UPw8RcolrUuF5GbDftaGOVZzcV1e
         sHkGDJ9UGyzpjBdfVqrS6PhOkMDZMfHb0sYNf9eM9wMMUB0EClysIA5kH7E+m4Kc7aib
         njCAWP0vRNH/Ca+fdQqwaZL55AB6LEFW9gCNNtRYHXriwTGSxs6bK6QCeKsBixmD5G0e
         dKkCuMIOCgjD4aC0pDDDJeVaEGuYmnoW5zk/6B7pYkxj0qvO9uBg+yPigK41WPlZLYck
         CI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713452616; x=1714057416;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tWjxCgM2nTFzxv0rdr4oshpMGy/GdpXqt2C7zg0NqPM=;
        b=HAqZKNvzi3arXlptsQw5AU2VDlWZakfpZY5npDJOpdDvYmOjki6bMUN5AbpyFvVal3
         ZmlbqGkNrpxTbRcghbRLTxHukJmDPJ4SLL2jfyd5EGdLzdms2Xc/uok18w/gmvknRgxk
         +W7vfigMBcXJD2ppMvfHC5Dwl3Ji7TE19bklcgdUCmbFJOW08WsymIC3TxmY9fz+yIzG
         uFAVlbZF+K/YtoK5ufdoL/5gsy6KDyWHElqGv6/tt19zITVYC/r04Yxim71Q7HW21e9s
         DF0ZoHGMKyBa1EWTzkaLapd1s08VyAWzfuHoe1ZTzaoQ1fv4KcasUNPJhLEG6LycugPu
         yfJg==
X-Forwarded-Encrypted: i=1; AJvYcCV9cplYGgwvkRfNbqtD6+QvR5w0wcNnrThBlIb9eGnZo1c6+Af9Ufsyd0PuFMRz5WT0GXTeIMWdzUq3icCaDA9/qV4Buo4=
X-Gm-Message-State: AOJu0YwTErGA0DKeoqanC6LnsVL5N2nP4NG4KUkEuQMLPuGPJjq2XuaM
	lWbw1t1FZBSSVTOFEhkl5vD1wVzoPWYRbtIRMsNnvOa+Sq4g9I/E
X-Google-Smtp-Source: AGHT+IHULsAlYLLS9d09qvYApegruy1qDk4GvcTMRLWhdfZMqyJyxOEXKj7o4s85AXik8N4DyDU8Ig==
X-Received: by 2002:a9d:63d3:0:b0:6eb:7534:1693 with SMTP id e19-20020a9d63d3000000b006eb75341693mr3225785otl.26.1713452615917;
        Thu, 18 Apr 2024 08:03:35 -0700 (PDT)
Received: from [192.168.1.22] ([70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id m2-20020a9d6442000000b006ea1e0fec59sm352716otl.10.2024.04.18.08.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 08:03:35 -0700 (PDT)
Message-ID: <7075d0c8-dca1-40f0-9760-da115f4147fa@gmail.com>
Date: Thu, 18 Apr 2024 10:03:34 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] qmimodem: voicecall: Implement call dialing
Content-Language: en-US
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Adam Pigg <piggz1@gmail.com>, ofono@lists.linux.dev
References: <20240413215318.12236-1-adam@piggz.co.uk>
 <e17d9cdb-03ee-4f1e-b2d4-1a5c02040777@gmail.com>
 <2693964.vuYhMxLoTh@adam-laptop-hp>
 <c450908a-d42f-4d09-b90f-26cba9dfd495@gmail.com>
 <0E7F2740-A440-40EE-AD31-3FA355B6B17E@holtmann.org>
 <6a029dbd-76ff-4485-b37f-1a8ee97a9338@gmail.com>
 <9B293F2E-E5BC-47AF-AC4F-CD086909A8B7@holtmann.org>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <9B293F2E-E5BC-47AF-AC4F-CD086909A8B7@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

>> What is really needed is a function that takes both src and dst buffer sizes into consideration.  I'm not aware of one.
> 
> strncpy/stpncpy both set the dest to zero, but you are right, it will be
> still off by one. So best is to just zero out the dest buffer with memset
> first and then just copy dest size - 1 at max. Then you get your \0 in
> case of truncation.

Yes, strncpy can work.  You'd need to take a min(dest size - 1, source size), 
strncpy and null terminate.  Verbose and not super readable.

Regards,
-Denis
