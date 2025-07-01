Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DED18E1A
	for <ofono@lists.linux.dev>; Tue,  1 Jul 2025 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751381152; cv=none; b=SrFN8sYhLN8g1ktIcXfFI0j/WcFBc4CugjZdJjW+vXGEQPYXNxe9wMQcKK2pR09GGDOoicQTgvYj3AHdkyUPTZYMpn/JJS81YWeF4REFlZMDPv9rkH6uwTmL+ibySXOY/FIkjW1d086D5HQeV2NRx8XK9se74SVREQdsAYzv7LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751381152; c=relaxed/simple;
	bh=TtiwGvssmY+ohn0lXSlVImNb0r6Pl6ye68+AwwdycGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HEYBP3gcfyl9S/hEnJ1Lk1TdOlBp2L6t3PhkgtDUvKFYpV4UPrkScUCcYJS/pu7tw6oXOBoDMPfzzJTKSNH3YVqL3mJmfwwFdKzsw7Cf4VfiFoz4DVb29dx9moD6OB/gSXHtFkou4qRqoRvvpv4sCcto9j6YivJcmb/okEht8ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9Te71Y3; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9Te71Y3"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4079f80ff0fso3904731b6e.1
        for <ofono@lists.linux.dev>; Tue, 01 Jul 2025 07:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751381150; x=1751985950; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dcnoi8C2WXBb5TOGZQhqWtf2tEZepGkjKWczIYiby7I=;
        b=Y9Te71Y3F8I9RxUo0P1g751cYyjhcausbia/oVM+IumiHydvF9gd36IeUYN5sM05EV
         OfOasG/0RbbGj/vulLjNZ8GWjmYb2TqK+ASn9J+aPenSTEqQBnepvovkHpRTDAQOoBlr
         9c1GKxNK3uj8Uw4BsboKMhZk58M8F2B7EQbQFp9IurOlDO++asIQlhaIbYEwAgSBPJmY
         JHrDk62ymw+BA2gCzRhPQ4XoVy/An8ky7Qcz3pMYT3D2LugY5YRaq2qFgr7nmZT2Cziu
         54ydp+SspvmMKaXCGYe6c/OEZQu8YC16uyI65fi2rkQuzSZPTsCjIPZ47oZskc8sTaZZ
         XeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751381150; x=1751985950;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcnoi8C2WXBb5TOGZQhqWtf2tEZepGkjKWczIYiby7I=;
        b=R7wsA9Bk7xJTX4E73BcpKMAEQ4VSeFmok4oec/952FpOBHi1TnzTmiZIlpJ2XxxGMM
         IJcVlr1gaf3qGZ7Kvf5A4POwFTG1wS7UM0JUGxrPKMqsqs94WScUzn2iYEB8rrA4WKah
         iKu26D/dIvzhcWq5GKUW50fpZ+icXr18Dp97I3WGlfw8VdWA4PHK6Bj/rNXmbsogmzzf
         yAWKm321nRCl6J8B+6pU9Piwo7VH5/GuS8VneExBjS7gnnwys1FB6ie76vLGOrrEbrMg
         2A58/1zGrmyGGU9hvezlFd8UNrOMkxO5huqcbC4UlTc1Y5zaZbknMBX+inyUbbKmSaBJ
         4U1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWoXKdBu7tTGpN8+QuSnn5GXQpfGkA0VjKzutTDgnX9cRt54GTU4zNw/OA/81TnyuW67uCNLw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFKQ4kuR+mSi3omRiX2KmI62SGrLWmgbrKjd0XEMCB4x+MGqLq
	dTZro1O2yEcv7xkFpKYnNS2IXbsg2zfcX7gdz5EFq/48hn9VHchuY1hk/4/VQw==
X-Gm-Gg: ASbGncuZyWaM9DH/xr55AgZhuPQcQH2sdIcBXLCFf8uCoNy4m+dJKYJ31PDff/w+lg7
	H/Lg8s80cELiL3ODUqCqvRPX7zVQRERK06EMMO47FBeRbSEzRkvE4NAa+/cMt4vj0bNs/0MIujf
	G6RwBw1mONW3PRdYG/vHxE1wqq2adAGeP+D5K8gNgBwkqGeEXyy/AOzzJK+5C2Wr/MSkVU48Jky
	3+ogueiAqHQ+hbBcIqHp9hYlFBnh+7JpKP+MIhVGkgubfN3DuseZc83eJb2sckZuBB516EH/eOI
	ZOGpMWR1Sirbcei39PHBS3hkPqJjmu7qAS7auRiOl6AeVezAA+fisGZoKuRJR5Dm3tTqbq2H3IP
	KSrsiPSji2I8VkNqzaDDRDZhPn1s=
X-Google-Smtp-Source: AGHT+IFdTnS7piRQG5SFL5caGEjWpoPs21mkfCRaGeYj7YNd3TmCeNjRO5GHhBSsalSD/5voUQ7AeQ==
X-Received: by 2002:a05:6808:d52:b0:407:a0ea:a233 with SMTP id 5614622812f47-40b7a1d2f1emr3275984b6e.10.1751381149637;
        Tue, 01 Jul 2025 07:45:49 -0700 (PDT)
Received: from [192.168.1.21] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-40b322892b1sm2143392b6e.4.2025.07.01.07.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 07:45:49 -0700 (PDT)
Message-ID: <a8d225a5-edce-4c9c-af3c-f9b6c9a73f56@gmail.com>
Date: Tue, 1 Jul 2025 09:45:48 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Get/Set forbidden operator list via SimManager
To: Sean Nyekjaer <sean@geanix.com>, ofono@lists.linux.dev
References: <20250701-fplmn-v1-0-d7fe9c901b57@geanix.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250701-fplmn-v1-0-d7fe9c901b57@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sean,

On 7/1/25 4:29 AM, Sean Nyekjaer wrote:
> IoT providers allow for enabling and disabling of operators.
> If the modem have detected an forbiddel operator it will block
> connections to that network.
> This will allow controlling software to clear that list.
> (Our IoT provider recommends to clear the list everytime we power off
> the modem).
> 
> Get:
> $ busctl call org.ofono /sim76xx_0 org.ofono.SimManager GetProperties
> [...]
> "PreferredLanguages" as 4 "da" "en" "de" "fr" "PinRequired" s "none"
> "Retries" a{sy} 4 "pin" 3 "pin2" 3 "puk"
>   10 "puk2" 10 "CardSlotCount" u 1 "ActiveCardSlot" u 1 "ForbiddenPLMN"
>   as 4 "23802" "23902" "32431" "331022"
> 
> $ busctl call org.ofono /sim76xx_0 org.ofono.SimManager SetProperty sv
> ForbiddenPLMN as 1 "23802"
> 
> Todo:
> I'm still missing to do continious updates of the list.
> Any idea to update it periodically?
> 
> Would also really like some feedback on the dbus interface
> 

FYI:

Fedora (glibc) clang debug+sanitizers
=====================================
Configure: PASS
Build: FAIL
     src/sim.c:881:24: error: format specifies type 'int' but the argument has 
type 'unsigned long' [-Werror,-Wformat]
       881 |                         DBG("%s %d", value, strlen(value));
           |                                 ~~          ^~~~~~~~~~~~~
           |                                 %lu
     ./include/ofono/log.h:53:34: note: expanded from macro 'DBG'
        52 |                 ofono_debug("%s:%s() " fmt, \
           |                                        ~~~
        53 |                                         __FILE__, __FUNCTION__ , ## 
arg); \
           |                                                                     ^~~
     1 error generated.
     make[1]: *** [Makefile:4090: src/sim.o] Error 1
     make[1]: Target 'all-am' not remade because of errors.
     make: *** [Makefile:2405: all] Error 2

Checkpatch Output
=================
0001-simutil-Add-Forbidden-operatator-list-PLMN-fileid.patch:4: WARNING: 
'operatator' may be misspelled - perhaps 'operator'?
0001-simutil-Add-Forbidden-operatator-list-PLMN-fileid.patch:7: WARNING: Missing 
commit description - Add an appropriate one
total: 0 errors, 2 warnings, 7 lines checked
0002-sim-Show-forbidden-operator-list-PLMN-with-GetProper.patch:8: WARNING: 
Missing commit description - Add an appropriate one
total: 0 errors, 1 warnings, 109 lines checked
0004-doc-sim-api-document-ForbiddenPLMN.patch:7: WARNING: Missing commit 
description - Add an appropriate one
total: 0 errors, 1 warnings, 10 lines checked

Regards,
-Denis
