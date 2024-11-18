Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE17B197531
	for <ofono@lists.linux.dev>; Mon, 18 Nov 2024 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731951175; cv=none; b=Unc31wMzbPSJU/uZEmZVwI6oKkFv1z7rgDjTM3Cxw4n5b2ha8hkWeZiRjyk30Zdx6ue0p0MR3djom7qgnt/3E/XyEe2oVwwbgQRaFNxL6soo2YEzai5gKV+fp09m5PEQ1Cm5QBGX2zVjL8Qf3UupPqgCmbHkYFX5zrvsrk38jLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731951175; c=relaxed/simple;
	bh=QQlx+onuu/5Rg4HWZtKguEIH/TDRuvrCHgNuwAdPLCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rQiCWy/tdtxwvBdkOqeROgab33EMWjX7CgHPAqI+Ze1jZDL76I4yLPq9g3Y4NBphSHQDlJIQogjySoZj87wLtrGBjwULviAZgyK6RQ7pyFpA558m3mmRpNeBw9Ne99ybPB93i2cz1iawHT5gr3r5mJ9XOV3f+XD4MdAwq6e1Ifg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbhPN+XO; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbhPN+XO"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2689e7a941fso1785222fac.3
        for <ofono@lists.linux.dev>; Mon, 18 Nov 2024 09:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731951173; x=1732555973; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1zdzlgo+wFLweFC5ryiKRRufrj0vx9+9/tIgVLxize4=;
        b=TbhPN+XOCwyZk2ztbQWlraWDsVGznGKoLfRAlaE3n8wdVY4X0wdbPORJJu9wTNeBrE
         +UL68uu4cfiWJk5Kdv9b8wCeF/djRMVW6RQn0ip9Bv06L/rLLM2cquxhERnHuxb5y/A+
         pECpakUINk1gY62MFhDDAf24CSsPA4LfipC7tMaXR2en4exKzpu4Au4bstsKEwX9tfFD
         Ps+PhYwXGvKqia/Jqzo+l5evfoN+3WFR4HbWqk5TjmbMjdJXbNpSZs9QhIGVdaW14+Zi
         uLcf4Vsr++uj1TX9bhdOnFikZ9vmsyLqlatfpPSyhC8cit9ccjdLwPisCVM9qxppxVsb
         RfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731951173; x=1732555973;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1zdzlgo+wFLweFC5ryiKRRufrj0vx9+9/tIgVLxize4=;
        b=XFejgsx3xAcfu8VHr1mkrRk0kGiNMOwTzhv2Y104y5PsnK3ungpuxLj57LsqTzotwG
         0cdtjc/iZR6ljuy9J6+M/H6ivAeU8Mmc+4X0iMFIn+RmkScoBMBRlELWb0A1vCM2FtbM
         fEdeP4d22jssSotfSGKdZ92p2lKfD+TyB/m6OP2jSXWaDD0X3Sc/dGVKuejOxL4OZf1o
         LU7Yk+sVLBZIE8pvaCzajqIaK6Kq+3ZO1eiWwZd7IS8G6Hxn/KTfU6/fN+1bC8trxM/A
         xx0LW94tZ2J6hm13zstewpQjJPEuxzB1TsUNFcUTMwSpvW5Eh8vaocgfQt37NevE9lin
         Tccw==
X-Forwarded-Encrypted: i=1; AJvYcCWlhmzkCbK8xwZRjQKM6octqZscqtAxcx/yUs9XgL1Am+sCtnk9dOzI3AVNDWfySak/w1W1VQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yznqa8BVHm4c2p22I1p5p8GFRmOJno1WdCrMjRoFUCpWOAfs2QC
	neqF/EP0rLSYHTzN6heVx+0fnARqcMe92z9aTszMcb58tmGQmPjsSkZYwg==
X-Google-Smtp-Source: AGHT+IHZHF7qy9FqWOR/Vzddcd7Hjjkse7Dgm9/tFBn1GL14F7+pZobeABxvzBXI/zjSx/t6OC1LQg==
X-Received: by 2002:a05:6870:b95:b0:277:e493:d7dc with SMTP id 586e51a60fabf-2962e029a94mr11872825fac.23.1731951173005;
        Mon, 18 Nov 2024 09:32:53 -0800 (PST)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-71a780faca4sm2815507a34.16.2024.11.18.09.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 09:32:52 -0800 (PST)
Message-ID: <ed54e8e4-aa12-4695-95ca-abc64fecf8c1@gmail.com>
Date: Mon, 18 Nov 2024 11:32:51 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qmi: sim: implement lock(LockPin method)
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, ofono@lists.linux.dev
Cc: absicsz@gmail.com, merlijn@wizzup.org
References: <1731845036-11874-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <fb513766-cec4-48c0-977a-a4457b6021cf@gmail.com>
 <49ee7849-1bc7-68e3-3498-ba9bfe27bc6d@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <49ee7849-1bc7-68e3-3498-ba9bfe27bc6d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ivo,

<snip>

 >>> +    passwd_len = strlen(passwd);
>>> +
>>> +    if (passwd_len <= 0 || passwd_len > 0xFF)
>>
>> strlen returns a size_t, so checking < 0 doesn't really make sense. Also, the 
>> core already performs validation of the pin using 'is_valid_pin'.  So I'm not 
>> really sure any of this validation is needed?
>>
> 
> I borrowed the code from qmi_pin_send(), shall I create another patch removing 
> the checks there too?

Yeah I think that would be okay.  Generally, the driver should trust that the 
core is performing the needed checks.  The driver should perform any additional 
checks that might be needed specifically for that driver, but these should be rare.

Regards,
-Denis
