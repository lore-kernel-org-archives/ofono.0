Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD6813D29A
	for <ofono@lists.linux.dev>; Mon, 16 Dec 2024 20:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734380911; cv=none; b=ub0cYdvWp9ANp20ML+OZjzo6VqZgd1moReY0dpnj6kAm0LBGNVYz4O45BKfGHImbDrjWw5oH1Uqsp8XreWl4haaWCdLKdaB4X+SYysMGS7sMAlXr8C2jo+w0zuir3vRR09D00Kau9zYcJ9svC29Ii99QK0GjezB2TCaAaWiFVpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734380911; c=relaxed/simple;
	bh=ngWj5a80B6BpgaUXcZIAokhOhz37rh54/IIi8z1aar8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RRV5xyAVKVBgKBNpCGp9ImyNZF+OD4zKWz+k9RceCKqVMyeXqP/P36ZfIMexpRl0ZPZDpWgy+O15FTXXRP/bvYZx7STcoaOa8TvCDjKnvrotEvelrxmba8Upf40j7jaC2TMTlkVe8PUiDWFXIpsgTArfpXwlMMU+bVKRBBPA7ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJt399R8; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJt399R8"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-844d67eb693so326834639f.3
        for <ofono@lists.linux.dev>; Mon, 16 Dec 2024 12:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734380909; x=1734985709; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tm2acXhtzbz0KBWd5pCLwwOkiJmhQXO+Y7DqQHnCHYw=;
        b=aJt399R88dRnK5Ik14q/N/00RwD0iQGZoXi5seiDMLS4gej5DXoESGRmTBih/v61Oi
         Qn6grXq1SHDvzM4xWQ9MhzwZ7SUsTtNk+nAle49s1yAIkbOYer/PCYbCMy5fqjYlKdVI
         gVl3IaJVL5QLiGAOPE0MMKA47GSVQhWfwW4CTI1q3Dgy9VHwCw8NZVkrCSDAafyuiWkk
         EDmu5NW32jvAWP3snpmyfk/C/OR6AsYfSGdFGO+zLgpDVkZO+EEpZypTg8OtQpLnNQtC
         bHnxQBl7IOgLm1xowzNr7OOzw9S3JrStFE56pwGI3fjK6oLpEgpGjyGqFPdup3KPzCrh
         bZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734380909; x=1734985709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tm2acXhtzbz0KBWd5pCLwwOkiJmhQXO+Y7DqQHnCHYw=;
        b=m5N+80lOH3Qh5vkmkBay5dwl8Shr5B/yAO9EfOhHEkSb1WidDFxIYgQjMoO34HuDUU
         tQ40082p2uJocspZrK+cq3Yc4iPIY4/gZgbHjxgHeWECtTem1H9Cr6Vwxv0/SgQoDq04
         vuOeRaQGgo75Zz2LJJ+RU14qf5rG7CRTT7bS0fMuLZiFGfkfGczGztuiRzQBrdmOwQ5x
         cbO/IjhN7+gtpDnj8UjsmZF4tV4qoLr5+HAjeeR9sF2e+MZsIHOjkBKy/rth7d8APz9x
         Q3v91RSjTAlep8mkzhCqtOlrsOTJalSNSItrF/qnZm+6ZAnwMn69xtFbZ6/upR7lUTU5
         NYtg==
X-Forwarded-Encrypted: i=1; AJvYcCX7caGdVpdvaFuB5pUqrAkGgBgLz80nLbHMxnxgAaxf34JmNJIwwTvsF0Lxagt+VNM/OnW11w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKyW/E6PAQB2l/cqBQZVTdfELN8fDTFDvy7qO+DSVHoWUEdsBS
	QiOonI5u64iogxgtBiv5Vuj7K0AD9uTt7v4ob2458wzZEVERhBBkxURmBQ==
X-Gm-Gg: ASbGncsPB2UbU9a7uJPjV0Nk4h7lRuHu5U34zfTikl5ocZ7L4LcVis1NOMo1LGnWgCX
	9r3Hdh/hRU9H8dai5MJlQvWrvncgZLiZwCaRZg48qm3f9yp/wdBFhNqK6l/CnTD7jcEiXeOVPI8
	SFP0Rb+SCT96gzwHNKYy4GM9g7NNX85iqTAO6HM6KUZ39udDN1QU5NYypx/mmFn4KPyuhTy0kn8
	uWEvHcqogIggbUfMTQfJuKyCzxHY1s1NiPlzcGYUPTvUvn4LALLI7pkvA==
X-Google-Smtp-Source: AGHT+IF2GLsP/43u9jFZZKGNKQo/SHB6DpG3Vd8VhJigQlpAMU+nFgOU23Ml00GxQOKnHPTrNEdjHA==
X-Received: by 2002:a92:cd83:0:b0:3a7:6e97:9877 with SMTP id e9e14a558f8ab-3aff1303cd1mr148113365ab.24.1734380909259;
        Mon, 16 Dec 2024 12:28:29 -0800 (PST)
Received: from [192.168.1.184] ([136.35.146.47])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4e5e378ceb9sm1346225173.136.2024.12.16.12.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 12:28:28 -0800 (PST)
Message-ID: <d23bba82-77f7-4d5a-abf9-aaa745bb6061@gmail.com>
Date: Mon, 16 Dec 2024 14:26:12 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] util: ensure decode_hex_own_buf is passed a valid
 buffer
To: "Sicelo A. Mhlongo" <absicsz@gmail.com>, ofono@lists.linux.dev
References: <20241216102021.345566-1-absicsz@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20241216102021.345566-1-absicsz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/24 4:19 AM, Sicelo A. Mhlongo wrote:
> ---
>   src/util.c | 3 +++
>   1 file changed, 3 insertions(+)
> 

This set fails to compile:

Fedora (glibc) clang debug+sanitizers
=====================================
Configure: PASS
Build: FAIL
     drivers/atmodem/ussd.c:126:3: error: misleading indentation; statement is 
not part of the previous 'if' [-Werror,-Wmisleading-indentation]
       126 |                 goto out;
           |                 ^
     drivers/atmodem/ussd.c:124:2: note: previous statement is here
       124 |         if (strlen(content) > sizeof(msg) * 2)
           |         ^
     drivers/atmodem/ussd.c:97:23: error: unused variable 'msg_ptr' 
[-Werror,-Wunused-variable]
        97 |         const unsigned char *msg_ptr = NULL;
           |                              ^~~~~~~
     drivers/atmodem/ussd.c:98:7: error: unused variable 'msg_len' 
[-Werror,-Wunused-variable]
        98 |         long msg_len;
           |              ^~~~~~~
     drivers/atmodem/ussd.c:110:8: error: use of undeclared label 'out'
       110 |                 goto out;
           |                      ^
     drivers/atmodem/ussd.c:129:2: error: expected identifier or '('
       129 |         switch (charset) {
           |         ^
     drivers/atmodem/ussd.c:159:2: error: expected identifier or '('
       159 |         DBG("msg ptr %p msg len %ld", msg_ptr, msg_len);
           |         ^
     ./include/ofono/log.h:46:26: note: expanded from macro 'DBG'
        46 | #define DBG(fmt, arg...) do { \
           |                          ^
     drivers/atmodem/ussd.c:159:2: error: while loop outside of a function
     ./include/ofono/log.h:54:3: note: expanded from macro 'DBG'
        54 | } while (0)
           |   ^
     drivers/atmodem/ussd.c:161:1: error: type specifier missing, defaults to 
'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
       161 | out:
           | ^
           | int
     drivers/atmodem/ussd.c:161:4: error: expected ';' after top level declarator
       161 | out:
           |    ^
           |    ;
     drivers/atmodem/ussd.c:162:48: error: redefinition of parameter 'msg_ptr'
       162 |         ofono_ussd_notify(ussd, status, dcs, msg_ptr, msg_ptr ? 
msg_len : 0);
           |                                                       ^
     drivers/atmodem/ussd.c:162:56: error: expected ')'
       162 |         ofono_ussd_notify(ussd, status, dcs, msg_ptr, msg_ptr ? 
msg_len : 0);
           |                                                               ^
     drivers/atmodem/ussd.c:162:19: note: to match this '('
       162 |         ofono_ussd_notify(ussd, status, dcs, msg_ptr, msg_ptr ? 
msg_len : 0);
           |                          ^
     drivers/atmodem/ussd.c:162:2: error: type specifier missing, defaults to 
'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
       162 |         ofono_ussd_notify(ussd, status, dcs, msg_ptr, msg_ptr ? 
msg_len : 0);
           |         ^
           |         int
     drivers/atmodem/ussd.c:162:20: error: a parameter list without types is 
only allowed in a function definition
       162 |         ofono_ussd_notify(ussd, status, dcs, msg_ptr, msg_ptr ? 
msg_len : 0);
           |                           ^
     drivers/atmodem/ussd.c:163:1: error: extraneous closing brace ('}')
       163 | }
           | ^
     14 errors generated.
     make[1]: *** [Makefile:4083: drivers/atmodem/ussd.o] Error 1
     make[1]: Target 'all-am' not remade because of errors.
     make: *** [Makefile:2388: all] Error 2
