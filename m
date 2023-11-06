Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E9FEB8
	for <ofono@lists.linux.dev>; Mon,  6 Nov 2023 02:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S83uk2Bn"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3b2ea7cca04so2675942b6e.2
        for <ofono@lists.linux.dev>; Sun, 05 Nov 2023 18:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699237957; x=1699842757; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=umHNTJoggfkeFPloJrFwxSwnk4HKN1o1qNZtlH0NIrI=;
        b=S83uk2Bn7OYTYVOy1zGnkjvjGiatJ0lbk+Hy/ZGeAEJ7bFu6wWkiJSrq90caRCbNX4
         QQLtWUWWHS+ajZTOfMeHJUQscuyGSD8iZ9YOrmQw/w8I7PXk9B145/eMZmsRkCkKZ4rH
         JaShkjJuss02q+6yaSZf6jsPi4NfdwQml736v6g64WU7oMNMg05zjC6SnyAJE7OrO21d
         ZXO/wntyOHQeolWtHvx9XydiCKvDTRRMras0X0xPSDYrKs8BmkOihuh9JsgnX2VElVa7
         Q0zYxbFDoMLAbuEKDlCI7VhFzqgUnTUIFzHb20PFPK3PpiIQ/8Q4ReST8dHsYG9P81VY
         wyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699237957; x=1699842757;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=umHNTJoggfkeFPloJrFwxSwnk4HKN1o1qNZtlH0NIrI=;
        b=xI6PLS1a0X2JOeJI6WXVUvu3ywSPhTSSW9AE1eE6UnYrNFPRVIa9Pkd6U/LJxeZA34
         Hj+eADpg7h93RJ6WdpbJNxAzMh4w4t3RUAXN83hsEuKYFoarVW6W1i721ewwK29p1iXD
         OFVhZM7G+/glYdOAD2vtB5VR1/Nh/Xi0BaJczoPrDu+vIDRaxGvL3irwI3qP6ImJBvDg
         jKBPEqGBC+yHjTfuRP6lR5A5avbe6MKzZVDO4tEPw/4o59jHVkdu1zA8wm7T9lsJKGec
         GEVqOVUzomKFFlZRTu+SWusnj4M9Cs0IbiF6W06EZCEZHqpzVsMswNV1jEEYehAfH+ko
         boVw==
X-Gm-Message-State: AOJu0YxIZr0r3SI3xwndlpOJBWEwL/D+nhqyj1nqlFBqzKTb3dndi5so
	znwRLdoK7u6g+E84uwLqSV0=
X-Google-Smtp-Source: AGHT+IGSG9UX+SL0KBOppa0OAxT/0CU7JRf0Qqvk83s6YlIWz5edz2AqadhQOyPRkpXOTFimd7tFBw==
X-Received: by 2002:a05:6808:7c8:b0:3b2:ef9e:45af with SMTP id f8-20020a05680807c800b003b2ef9e45afmr30117704oij.13.1699237956808;
        Sun, 05 Nov 2023 18:32:36 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id dl11-20020a056808614b00b003af732a2054sm1091213oib.57.2023.11.05.18.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Nov 2023 18:32:36 -0800 (PST)
Message-ID: <48ca3a2f-f3e7-4437-aee7-aa11dd19cfe8@gmail.com>
Date: Sun, 5 Nov 2023 20:32:34 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gisi: switch to musl-safe character conversion
Content-Language: en-US
To: "Sicelo A. Mhlongo" <absicsz@gmail.com>, ofono@lists.linux.dev
References: <20231104085306.2834870-1-absicsz@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231104085306.2834870-1-absicsz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sicelo,

On 11/4/23 03:53, Sicelo A. Mhlongo wrote:
> Support isimodem (gisi) use on musl libc systems by dropping the use
> of the iconv TRANSLIT extension when converting from UCS2 to UTF-8 [1]
> 
> [1] https://wiki.musl-libc.org/functional-differences-from-glibc.html#iconv
> ---
>   gisi/iter.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Regards,
-Denis

