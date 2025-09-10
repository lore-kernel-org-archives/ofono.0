Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A07824469E
	for <ofono@lists.linux.dev>; Wed, 10 Sep 2025 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532565; cv=none; b=Jtp89DVal4lUN+Dfu3+Q9Jk/pXqtqXz64/rJJo0ox0W5pJfoMxs74Bv6ixM7AaOu8yN7eQJpJ+eQzQncUsN5owx4vjZythV4T4dep/mN1xqFPv1i1bbS+iFXmpmy2bzs6RVoD/xw3lFNsmtKJDrv90ZdFRMQYTpUb5xYtGXD028=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532565; c=relaxed/simple;
	bh=6cRPNe1NbXh629QI4nW3kEB9s30tvyjR7SCWrQIYy+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BKT2bhK7Xhr1wW/AMVHWmBoQTGZ9Ef8qyPM7eT9BISf7I9EpZMi+qlmB939GKcuP206rcbVMCnI1YEvHqT5INr/OxuDRpIaKhKz2319ppeHL3xPK2DPxsqOw1KsphKiTeWGTagf4yBoDeQABznzS3qDZgc4iO/3OfEtI9gIlhhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxXDL7hw; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxXDL7hw"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-74572fb94b3so6296976a34.2
        for <ofono@lists.linux.dev>; Wed, 10 Sep 2025 12:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757532563; x=1758137363; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rLpFHR4D+YqsNocuJ+XSc4uk6sxsievpkdvKyFUHFYE=;
        b=GxXDL7hw52DKKjvDyvV984uvBSSAacTisGDglpkkApNYUbdQsDAqQOMVmNUs7dvR4T
         9yZinhnVo0yzj9mlcbKpanCbd0YEYAxs9C+UvHcb+QGnUqmK9I/3FS5CZUlUfJ2Hkl1n
         tze2wqX7q3ISTD4fNqBrQ8xW640quokguHMZtRkSa2hXslyYgMp35hxP2lRStrbDq9/n
         SgU+rRZZdQBQIR0CsMGTyMJ5vUSx/3vsMP6dFeIJ5QtX4h2YLkTdhc58JU5GzDUULexR
         okpSLCa5lmwhLYipHNz4Q4/Za9MJpUIWOJQ84i//6OBin2dMdCI9W8R07HPGdWLZF/c9
         yf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757532563; x=1758137363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rLpFHR4D+YqsNocuJ+XSc4uk6sxsievpkdvKyFUHFYE=;
        b=Y02zvN5DwbC9sBNM7GOXd02TSMan3UFoPFvgA+ixVhdoai24FYhx44Y/4hZ5D6X478
         EEOCV5h/fIuwBp0oDR8h1l7nJr27hb+6Fz0zQpuLF4bydibLEm9ruhJufhoCro93a3o3
         aig7Cj9rVWWk9JJDhwGl39MYg5zUvis1a81AvbqkSikqQMExPVznoXt26v6cLEUNUep8
         0wlAr1ueNM6cYqeNyUDr+gOZHWooeEHBZ/z/JL7we9DxrRtGG9/O4sjK7uu1N6bCvIgA
         UZ//x4niWioknXXoFFBIgjShAcrgmvAgBvXORNxD2Vs0EjQFWD4kkloTBPRuTuT3uCGV
         548Q==
X-Forwarded-Encrypted: i=1; AJvYcCXk3DHsY/X7/FXkKN1y7mHpjDUhIY188mpW4DJ5nvQsqboNKHFu9obz9tE55Y8vCYeggwXtbg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkqVbpfK1rZ0NO9NVb886AzbqWTZl7Tad5HgrnXzEstwdIhy1W
	Qt23+BLIZzYyPli0i3v7J/RGWw0moFHVrhEgm0KV37p0JldKUcHw6gNScknIKQ==
X-Gm-Gg: ASbGnctw2jd2mzCE3ALT24ZsnPaLDA9ahM+q2jv/eHJxPAgb+ZGwcKH4oIHTJ5Fd/JH
	wxBQ0czuiHn7pJy55EURERjVgBSbyybYK6FX5p4/yhLKT3PLSqu1pE9ZDosQoa/ELVl5LFoHr2l
	1x8fS7H6Jpo+tbk7k7cB1rJ0DzmUlC3PUvtShG49+CHMtpw5jHqGBrS4Il55DxBquXfHzr2raDj
	13Easoee7QkoLvMC7FL517g9KVsgbXX0Pzy1A2jcOvEIMxh/HhLFrmHp80gflteYx/RgTn1UQ8u
	DOVDEOUgLgN3Jqgupn4Z5kyADyjJVexWSPTl2jeEwJTPQQwUYFbrFuR5EXKMBWsiRtKsEWOfdf+
	8b00NvrscvJL0JuSI90G67/whOju4rzrt9cWIeNiFgN+9U6E7kKb26DZ/xx6ZZE64P8g6MmfGJk
	XKaFemsZg/zg==
X-Google-Smtp-Source: AGHT+IGg+uC9tfNj+34BBXcrE9+kw4b5aymfB8rE7syXp5XU0VkEsTl/Zp81AwqAnEuZ21HIGIlzaA==
X-Received: by 2002:a05:6808:a550:20b0:43b:35de:29c5 with SMTP id 5614622812f47-43b35de4e59mr6413452b6e.30.1757532562811;
        Wed, 10 Sep 2025 12:29:22 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4380007b0b6sm6842892b6e.25.2025.09.10.12.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 12:29:22 -0700 (PDT)
Message-ID: <227cf577-b226-41b9-9d5f-1120a849f80a@gmail.com>
Date: Wed, 10 Sep 2025 14:29:21 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Quectel modem ceases working
To: Timo Ketola <timo.ketola@exertus.fi>, ofono@lists.linux.dev
References: <3be9ef7c-fb1b-4caa-802b-93f02eaad1d6@exertus.fi>
 <e87a92d3-3e5b-4e5c-aab7-2310697b9fa7@gmail.com>
 <e400c04f-1550-4263-9f21-ce1476e12c80@exertus.fi>
 <379c6d32-28be-40ac-a055-0ebcf13613ea@gmail.com>
 <d7c6986e-7337-49d5-ad00-c6f1f8901898@exertus.fi>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <d7c6986e-7337-49d5-ad00-c6f1f8901898@exertus.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Timo,

On 9/10/25 12:49 PM, Timo Ketola wrote:
> Hi Denis,
> 
> On 10.9.2025 18.31, Denis Kenzior wrote:
>> Ugh.  I really have no desire to support kernels pre-5.15 when the
>> passthrough capability was introduced...
> 
> Are you saying that if we had 5.15 kernel or later, latest ofono should
> have been working out of the box?

I'm not saying that.  It would likely still be broken since the firmware doesn't 
support 802.3 mode.

Long term I want to drop support for the strange single 802.3 / raw IP interface 
setup that is being used here and only support multi-context setups.  qmiwwan's 
behavior in this area was quite different prior to 5.15 and I have no desire to 
support that legacy.

Regards,
-Denis
