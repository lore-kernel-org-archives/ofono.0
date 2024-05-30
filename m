Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85630186E57
	for <ofono@lists.linux.dev>; Thu, 30 May 2024 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717079805; cv=none; b=SBPoEMo+swYQUVCNlyb7A/1SRZW3Bw0tgPG/zuHcTuuf4HURNUZ4MGRJxDKH6tmbvjGxZ9X8WF9wu1syJj8ctrEJoz9Lpjv8lzeWAYlFjgYfDhpfJMl6I3OFLghEb6SEDc5w4jrBu1ZSmDeBaSXyj3+zgmQuHAveCFTgSSMQlek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717079805; c=relaxed/simple;
	bh=jqqgiUc9g7NS8gbuYWMtadMxdXIX36YfzJ5onnCLNpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iAvFKPk3pGSM/irUat9Jj14ZtZP55Mh6gSPbr+MrdcmtxQZiI3tIC0vR0nTae40uLj6MpnCLyhqxfVOVJsW5j/AA/0vja+tMrvS7VgvPfN5Tz3exn5BL8zjn/giKn0yCgLGd69Yktdd15+5QO11De9U5jbPOEA4wVT8s7V64p7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQU31Xdy; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQU31Xdy"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-24c9f628e71so491857fac.1
        for <ofono@lists.linux.dev>; Thu, 30 May 2024 07:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717079803; x=1717684603; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PTtt46La3cNGRU6NTfDQnHqY3AqBKRoS3xUUchwdgI8=;
        b=nQU31XdyeGWQUJElDHDjIvVFkUhI4+uXDUadFoKCUtBaxKQZQXsvcoPk6YTdoTyITG
         pG7DUdWsvu5jbXg77dIVbT1vmoyn3PW3P4FGlScy37df4fUg1K2+i0aL2rV2Q0vWkXKp
         5/GTt5s3jUBcrZvjA1Ect9Etn1jbkRW6+qq3Of8Flunfhtjcn/07T1f/gazaX6x85Atn
         fLBZnqJS0v7qutPf/zDoFzEEY7pmJ3zI538KSpgGMYp5vICi3w4Wmxuysce/1dD9eCV5
         axnadsYR2ZTICmCaOhri4ocogffnVEilwYiw9gy0zzxiWmz5cV/Ly9QdjsblnEIXucFn
         V9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717079803; x=1717684603;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PTtt46La3cNGRU6NTfDQnHqY3AqBKRoS3xUUchwdgI8=;
        b=Jx32qkDyJgOiuB9DYLi/qhjdcsAu477+cVsXN1Te/+00ju1ruJkXuIkgEvXK9qSSqB
         HVhLss06qPAKu8QmpVSAHnaTrgRTY+RhLbJp2Z8DarMJ+UgtWaSDw3XgiK7oGzEy0QNA
         RsMB9Q3b7fYhB6BEA+mfFTcR9t2bJ8PBUGtdn2loFkYgrayuco7Y4+/69LbahMdhqW1W
         +P0chFNxzhAH4COoYYbjxUhKKDdlnzQQCkcQS8IXHHFeqVHXXB+0kyTKdd2bnwU+/vso
         ewynEJiBhCdEqOQxB6huL2AjzujbVnc3K8N6CYAQ6ei3C4dCiUodn/0kBD9et8KpkDkF
         l2Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXNxlpcESO38J/nz4q59nqK/sqjM3IighfaLL6/9482p/9ACXxCgKXjwCk32mbg7+o3GS7dt50/roOD6LzwH5tnCFGqKos=
X-Gm-Message-State: AOJu0Yz8vOnGFSzsgrzcE4dSJUv9yofkbl6MaUARYPCypKZRkKfM3Wpx
	QmoUHjkFEH1qoh0mPg2EGUw+dPsYhWLVhYTkmzNADW40b3IlOYPn+7pHUw==
X-Google-Smtp-Source: AGHT+IFzs7sAoE2CC2XjTdP+CdZ9HWhrtHwNTFP4fhxZ/RtixGEzFgwVRraFOImJ8Gw/2aUL8GyVfA==
X-Received: by 2002:a05:6870:5593:b0:24f:d9b2:b4a with SMTP id 586e51a60fabf-25060b009c3mr2367159fac.10.1717079803431;
        Thu, 30 May 2024 07:36:43 -0700 (PDT)
Received: from [192.168.1.21] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-25053d550f6sm589279fac.15.2024.05.30.07.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 07:36:42 -0700 (PDT)
Message-ID: <28ba4a6b-bb91-4599-9c12-ab897dcd4f3f@gmail.com>
Date: Thu, 30 May 2024 09:36:41 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] quectel: fix use after free
To: =?UTF-8?Q?Martin_Hundeb=C3=B8ll?= <martin@geanix.com>,
 ofono@lists.linux.dev
References: <20240528082648.2010586-1-martin@geanix.com>
 <79f5b88a-d625-4c5c-addd-13727f8516c3@gmail.com>
 <037fc1e0e1dfbb816dcde6f66bccae95520fbb70.camel@geanix.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <037fc1e0e1dfbb816dcde6f66bccae95520fbb70.camel@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Martin,

> 
> I've tested the patch, and it fixes the issue.

Awesome.  Thanks for testing.  I added you in the Reported-By and Tested-By tags 
to that commit and pushed it out.

Regards,
-Denis

