Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6961ABEAD
	for <ofono@lists.linux.dev>; Mon, 14 Oct 2024 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728921441; cv=none; b=Bb1qkDwQ54u6AoPxZpcAGMRL54twulwNeDsEKjJS5U3rZhXV5MS0D0sMP3lBvgdLsQeaSlBJsRrK2MlIqiG2HR6v0vuWs4SmgDTFDYH6kLUR/MfazZ/tmW8A4ux6q4ugQaoYZsiPWukoqNWAihAt7Hv2N0ibwLwFu3/nyyHdh1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728921441; c=relaxed/simple;
	bh=8Zz9Qe6I0LoVzJX/+RtEmlvOg8Q1LtngvqIhJrf3LY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Rfr+lhObUdhgJByl/nIvWQy3Lggcflc4XHRsOuKTEuX5aY53PeWlKlU5V9WD7RfpBjVxU3dAx10yTIDG1ZE6gWtSop2SM8UBRAX+mSkbW4HVQBhdo2FtDgfYwPpMOG98AY3iRdp+cz6+1Bda9+tMVjzyh+GFNg2VvVM7GR7nnms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKkja5Hn; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKkja5Hn"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5e800d4e462so2736711eaf.1
        for <ofono@lists.linux.dev>; Mon, 14 Oct 2024 08:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728921438; x=1729526238; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qqXx0CcktVgfzyuTxDqnxuIKylLSbNF6KuCWZpyxKsw=;
        b=gKkja5HneXefSHOOOp4cS27xii3DQLHq0U80LkN/HxcVmhwRkw223jkoTddxV3shOL
         3miIDeBrskog5MZVvmhXGbf1bTvXyt7D9R2GfXiUjYrb0PjENyhSvWd/WlphKXjJSpC8
         zybYZE/hwRNA99aKMayi3XGzKOG6IDedOp1ljAyQLHLMoiqqLmoj7aYBSnIqXkZBJJyg
         W2UYzNSU/wK7IQ8yLbIGMwpWZMYebMwqTOFbk7uAn2YgYiKZJ3+wL+dOYogCiifagM8f
         NTaTVVnBsQorsYX4+WaOmHRNDyfCzcmfcmUmcdFnoBSQLMZOVgyxOBPSqjvqDE2sEtVB
         UkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728921438; x=1729526238;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qqXx0CcktVgfzyuTxDqnxuIKylLSbNF6KuCWZpyxKsw=;
        b=DUs0R5FveB4MmCf6PqClsoIOodqN3Lac73pOO/B2fyRBIkvyLbGO0hR1le+AzmM0Mi
         9k/PyUIrgXyuCO4wG5JzebOkdR3qHV0c2hHkkApBx5cMTE1vT3jTEvw1dV3FgmzFvqZ7
         j+ucq6HeR2zdiLtS8nHg/KP6o8jWeSsTlbAg95eqd7uRapkksbMmradmmxNpRZyzN68F
         q8YzMWQB8m4rKbbcvzUNUXoB8AaL4AIvGRdehQ2yQeO4pYXCKjXo74tp4RJUXddpphT1
         hNyJgympBNBub+u8SoAOxc0sEKlh8NzcKE+WjCEk8aZt3jbfOjpR67sD+pVqGNCyBrzI
         j1+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgah5LCu/NC87oZ7sPI9aPG+TA5eFffRNQ3TCJC7qD0WUsij10xP/RIqakm1zaUxT/TDjD0A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZdFeVrVh3UwXvLONfkle6b1TBZqa0ZUgcrgD/1wdmgT7BjUdK
	6cG3aBBWelzBIzV0+itlFgV2KI8e7Iz9e4drnHEhFqPFxlF6DsmK
X-Google-Smtp-Source: AGHT+IFScwS9PCnVguiTI+coZYemN6dveaOvBZ+kP67EtD8+rx4bmrJx/D48tIQhWxTowepckOoXOA==
X-Received: by 2002:a05:6820:1c87:b0:5e1:ebf1:816d with SMTP id 006d021491bc7-5eb1a19ccc1mr5896412eaf.4.1728921438247;
        Mon, 14 Oct 2024 08:57:18 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5eb11aab7d9sm1359890eaf.46.2024.10.14.08.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 08:57:17 -0700 (PDT)
Message-ID: <1628f99d-cb19-4711-b2af-c8ea67f6caaa@gmail.com>
Date: Mon, 14 Oct 2024 10:57:16 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drivers: simcommodem: create rat to
 radio_access_mode function
To: Sean Nyekjaer <sean@geanix.com>, ofono@lists.linux.dev
References: <20241011101839.3646442-1-sean@geanix.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20241011101839.3646442-1-sean@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sean,

On 10/11/24 5:18 AM, Sean Nyekjaer wrote:
> This is done in preparation for querying available rat modes
> ---
> Changes since v1:
>   - fixed function name
>   - changed mode variable to int, to allow negative numbers
> 
>   drivers/simcommodem/radio-settings.c | 47 +++++++++++++++++-----------
>   1 file changed, 28 insertions(+), 19 deletions(-)
> 

Applied with a couple amends in patches 2 & 3 to comply with the 80 character / 
line limit.  See doc/coding-style.txt for more details.

Regards,
-Denis

