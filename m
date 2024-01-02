Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5A91549A
	for <ofono@lists.linux.dev>; Tue,  2 Jan 2024 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0ieSPpx"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-203fe0e3fefso5071876fac.2
        for <ofono@lists.linux.dev>; Tue, 02 Jan 2024 09:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704215918; x=1704820718; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xFhQ7EplByPQgTPwpYVFeppgiO9ynLintoKtiPNnJD8=;
        b=T0ieSPpxrOUq23dTO2MtTJpnJBkNkLObO+MSHSLb/+KWl+BNFyvyvPscY6JW7TUrtC
         xiXhpdRk8Yt2jKF5Te+GkDgoJZc8KBHGe/kzWvV9n39a9rcdJNe+0UwSFShXfN2n3wKs
         DQ73EKjX/GxQ3urNailvrvFB6d74Uj5hD39Rix/09ESiUkW2u0HcTMdkMqljVjIP1Q9G
         maV38ELqqkIguI2rUTLtJFcES+NQWk+VsmDn8OyWE+3vNKAcS/bJ9FF5dLAwDIv9KVW0
         wf2hROoqUGoETsXo3NCKMB9kCV1jChhVojgkHKeT1/AjYTJxggq072bZobNO2KNzcjew
         A7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704215918; x=1704820718;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xFhQ7EplByPQgTPwpYVFeppgiO9ynLintoKtiPNnJD8=;
        b=l05yA1SX5RhpowHQVFv9aUwUHSaBPIsFmP1JXlCa+lmdsCxjyT75dPmo9T+Kf0f40B
         ZhwVjk4xkM+l33M/O3GHG8338vJQrDxus1RSIO9+gSrxSs89sVf/O5XvDm7deYfCsfeU
         cXIJ8EJdA0hhJRH2p26srRjOvxeViLjDFi5RDefr4aeXyHkjt2FCuSHGkmb01L85hP7z
         6efSDdL8Pr3GLepx/aHXJ2pnmJOx+dTPABo9vI7V8C+ghRMFDlb+MZoel1gW0oKLKi3r
         7ATF3iPh7cfUjw9BfmbDcs64+TMBZaZPfzhqdgsuX21E+T6LelKiW33YlA/IrdIdQl61
         e1mQ==
X-Gm-Message-State: AOJu0YzwsngB970VBoyOxed5SRT+qc10aIfzdOpfaE1CKMjxa7iKhGSj
	3Q3hGkrX6ws2TYrSPYNTdOEq4YjaFBc=
X-Google-Smtp-Source: AGHT+IGAUt4AgXfKbroOMvH4r9pBr60frBSpFo5rlze3aj2muBA5ul2jsPNry6byUNJ+JjWuNwCOtg==
X-Received: by 2002:a05:6871:b13:b0:1fb:3700:ee1b with SMTP id fq19-20020a0568710b1300b001fb3700ee1bmr14482269oab.47.1704215918116;
        Tue, 02 Jan 2024 09:18:38 -0800 (PST)
Received: from [172.16.49.130] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id ti10-20020a056871890a00b0020316ca60a6sm5689927oab.1.2024.01.02.09.18.37
        for <ofono@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 09:18:37 -0800 (PST)
Message-ID: <b0600c2c-79ef-443e-bcf3-235ff99ab4f0@gmail.com>
Date: Tue, 2 Jan 2024 11:18:37 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/15] build: Fix typo that breaks --fsanitize=leak
 check
Content-Language: en-US
To: ofono@lists.linux.dev
References: <20231219184016.420116-1-denkenz@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231219184016.420116-1-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/23 12:36, Denis Kenzior wrote:
> ---
>   acinclude.m4 | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 

I went ahead and applied this build patch from this series

Regards,
-Denis

