Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517421DF26E
	for <ofono@lists.linux.dev>; Mon, 28 Oct 2024 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730140334; cv=none; b=eA0xos5GORXONMZ4WEsDvFa3sAag5mJKS73goz9fSarLq0G9oRx9s043WFnIW63hWeutTqCqZjommD1ahikq9ox5uE/aWH/uZ05CQCYAfthq6LHEOrd+OFoCfafqQScTGfv+EMXptfTSiUVd3mPBd/ipW43L4c/5qSO7jcyq2HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730140334; c=relaxed/simple;
	bh=brCaU0t65IJMnuZqJQLR1zjfVXk4U9AMQh6kKyye7/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KITKmvpwmS9MjaW7dIDq6CNMWvyOKpO7ztmj98axCsJ7ojfF4JZt3Zgjf/vtuJEQGWgnWbOKuKaF8VleMInr4rd1mH8ClhyjiKhqbxvZY3Ve9JwDrHMi3EqiX5XvxlRfCflKLSJiUImCGeHIl5sdZdwPQVNynBfsQP5558bGcrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUIiHypo; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUIiHypo"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5eb67d926c4so2057472eaf.0
        for <ofono@lists.linux.dev>; Mon, 28 Oct 2024 11:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730140331; x=1730745131; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GkqnKK62Jfjsx9kLzmrJJhrCbQMPEfELMHFyA63XibA=;
        b=jUIiHypoP+SPT4C46bvNVmgm6uZquhYzcKDxxI/5JmNZRcuii+3t0vzXBBfZnNIvLe
         wiCHdUAeGVGc1TvJ8UPTr6HOiU6/rYuwZzH1FIK4Vc9DMf3fX4rsnfrz5C0UA35lgapz
         56mKNyoBafEF/2BQ9HWKuskgUw10DWzhqerfBDWpRXb5LTtCh1lMkwV0pMfIawv/dh4c
         ZqL+xSCu/0t5eQOQFSNAXTa9FF4lXI3zGRr1hEhj520TRZrljzo9TA/ielH3YI4jOnH/
         01vAwBgdY46L167wkE6ppq1uRsDvGVqzvnnJQik7Ve6m2tss1RE7CLUPRsEMGo3rWnDI
         UtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730140331; x=1730745131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GkqnKK62Jfjsx9kLzmrJJhrCbQMPEfELMHFyA63XibA=;
        b=C4ce6PnlVDYMZ0Z1XThm5W3fP0hVVDDAo3KZRp4UEMcFfrIuMFzrF1EAOXqvyhOEdb
         Q4JZCDKEFYnH3LDuadcjfwtStv3S8dIyB5aXMHSRDlx/h6b/YMRpDeLvsZKF9mgzC+c9
         ZWY6Tvf9WIed8TkYWQfEkhQYEBrZt3xgRC9XNFHlg+RbIHNE5akPGGpL0j7RBYWjFaps
         DrFEWQSrxVWkLwD4rrzJLdbivMJBvvBiDhZ8FvY0JNP+eg/k5t8W4j2ov5iqV7WOUtGW
         q9IgEZEJXxn/LLIt+mXL3JY7YP/5o+e3DWgJ0EyHbxQHkI/acEvpgQ0AA43GowEdyrz+
         0wpw==
X-Forwarded-Encrypted: i=1; AJvYcCV+X8tb+REK6thrj2KJjKN6NLKVEEzQsKh5ROrrBqrayPe2sW3oZ90oIrfqVBP7FWKhw4L2rw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGH1LcgYSZ5alUoQPTmULBtqH1XTQdNLvkjJg/yRZs+Lp6cgV4
	1XZ/daN/GVim1xaF1uWBh8Y31wU6fwRE6OY4BfX5fAC9d+kXYM8g
X-Google-Smtp-Source: AGHT+IGfUgTbjizeB/AG6+gjFHbeQ139MPMu2UkD0Bivj1+hC0lcS+93f6oW5GJPRuGUnXk2rqUXLQ==
X-Received: by 2002:a4a:d0ad:0:b0:5eb:5eff:afbb with SMTP id 006d021491bc7-5ec4fb0980amr383935eaf.1.1730140331246;
        Mon, 28 Oct 2024 11:32:11 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5ec1859b627sm1832002eaf.18.2024.10.28.11.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 11:32:10 -0700 (PDT)
Message-ID: <bb6e9097-65b8-45c0-9738-f376e21f5e2e@gmail.com>
Date: Mon, 28 Oct 2024 13:32:09 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Improper Handling for Messages That Do Not Specify Source/Address
 Port
To: Sicelo <absicsz@gmail.com>, ofono@lists.linux.dev
References: <ZU4D3kXFAvCHs55i@tp440p.steeds.sam>
 <e48fe212-7a30-4bae-a892-f22d3495e169@gmail.com>
 <ZVE1lIgh8uJg9amK@tp440p.steeds.sam> <Zxzl8Z6UJbvjG9kA@tp440p.steeds.sam>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <Zxzl8Z6UJbvjG9kA@tp440p.steeds.sam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sicelo,

> 
> Today I got a sample, while working on the phonet patch:
> 
> ofonod[3912]: PN_SMS (0x02): SMS_PP_ROUTING_NTF [id=0x08 utid=0x03 len=136]:
> ofonod[3912]:     * 03 08 00 01 11 84 00 02 82 0C 02 08 07 91 62 78 : ...............bx
> ofonod[3912]:     * 09 00 00 F5 80 74 6D 00 04 14 D0 C5 F9 1D 04 6A : .....tm........j
> ofonod[3912]:     * BE C5 69 76 19 00 14 42 01 62 41 51 81 80 56 48 : ..iv...B.bAQ..VH
> ofonod[3912]:     * 65 6C 6C 6F 20 32 36 38 37 39 39 30 30 34 35 32 : ello.26879900452
> ofonod[3912]:     * 20 79 6F 75 20 68 61 76 65 20 62 65 65 6E 20 63 : .you.have.been.c
> ofonod[3912]:     * 68 61 72 67 65 64 20 45 30 20 66 6F 72 20 30 20 : harged.E0.for.0.
> ofonod[3912]:     * 4D 42 2E 47 65 74 20 6D 6F 72 65 20 66 72 6F 6D : MB.Get.more.from
> ofonod[3912]:     * 20 6F 75 72 20 62 75 6E 64 6C 65 73 20 6F 6E 20 : .our.bundles.on.
> ofonod[3912]:     * 6F 66 66 65 72 00 00 00                         : offer...
> ofonod[3912]: gisi: No error information NTF to 0x63fa40 [res=0x02, id=0x08, utid=0x03]
> ofonod[3912]: src/sms.c:ofono_sms_deliver_notify() len 117 tpdu len 109
> ofonod[3912]: src/sms.c:handle_deliver()
> ofonod[3912]: src/sms.c:sms_dispatch()
> ofonod[3912]: src/sms.c:sms_dispatch() dst -1 src -1
> ofonod[3912]: Got an 8-bit encoded message, however no valid src/address port, ignore
> ofonod[3912]: PN_SMS (0x02): SMS_GSM_RECEIVED_PP_REPORT_REQ [id=0x09 utid=0x05 len=16]:
> ofonod[3912]:     * 05 09 00 00 00 00 00 01 06 08 00 00 00 00 00 00 : .................
> ofonod[3912]: PN_SMS (0x02): SMS_GSM_RECEIVED_PP_REPORT_RESP [id=0x0A utid=0x05 len=4]:
> ofonod[3912]:     * 05 0A 00 00                                     : .....
> ofonod[3912]: gisi: normal RESP to 0xb6d106e0 [res=0x02, id=0x0A, utid=0x05]
> 
> So yes, this particular message is ASCII

Do you want to send a patch?  I'm still not sure how oFono would know that this 
is a flash message?  I suppose we can check whether it is valid utf8 and treat 
it as a text message.

Regards,
-Denis

