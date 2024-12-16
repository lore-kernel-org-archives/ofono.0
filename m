Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B0A1CDA15
	for <ofono@lists.linux.dev>; Mon, 16 Dec 2024 20:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734380912; cv=none; b=d/3Lxc1CBj5EmCnT8PUx7kq5tTY2HN6sy5uw62xQK26iuONC1DBymLQeEFrwu/THpSEE7gkGvFv+2ngGQJ7PW/FiGDRhWT7uVOkXKUkdBeSFFeUIaY9+/HCwkTX6rKDVfLswIh0kc/kyOgU9vsBHaXEKzAULwnVdxqVhxh3wA5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734380912; c=relaxed/simple;
	bh=yCEamxUQtB4a/Ybldkuq9m/WcxQU3BtFKy+PH2L9dBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oNitzti7te+v4dCVS5Smp2nVrVid1DQuhiqzq1pm8kqVXW3TXjrC8LT4DtAnQmJbZpc8VP0UoRcIUmFMxRS2NYkgLps2xfGG8RuJ7pLPjq1A3qZQauD4btGUWwRMgiLa89zdh+c+fPcObMtkoF0KPOYQB++ZjtD8s7iyAo0fioA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThoZpXZ9; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThoZpXZ9"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a777958043so15371125ab.2
        for <ofono@lists.linux.dev>; Mon, 16 Dec 2024 12:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734380910; x=1734985710; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6u/OHuiGGYEHosvLnXAjhTy1RD9qCxylmSpKBiZw6fg=;
        b=ThoZpXZ9TqjyCv0fhamD4+tff3V6OvUxtlj+UgPgHKJr9glTVEmU0OWxgeb3/CgJsQ
         miUwxQv3fIlConWgln1WOdVSmV7/Z6mmyq54WFgG1CU8NBeMwhWXickz0syEdu4Yv5GQ
         R52VVOwwiOmR5wpS1AjPEolO3nG2QGeZ3hoqsqmOS/QVRtn4uVgU4pI2lXtbfuOsoq6K
         +PwoONVuwEK2Yt00ZarDCC+DXjjNyYTUON3n4S39Bx6pGT+xpKeyOvbtsEKYmOwBgfOO
         aA69OEUu+QuowjCmOpYBtE3IATY8yLCFXX/on0DZauha9QjJLvGM8lHXzUcYwdOY+tyR
         az7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734380910; x=1734985710;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6u/OHuiGGYEHosvLnXAjhTy1RD9qCxylmSpKBiZw6fg=;
        b=pbONPGQfkdKLlk3n7xh8J0UgIykbsULZDD4Y34yznWqqLj+oWw1tlxK/GXRHWHS7SV
         Hg9ocuIoS+s7IzjOesolM7jf73lTPwfKlJgxQTAarn5Fomfy6FIfFPH+fBdZJ/TwuWMw
         N1oUwyiMa15vCNOtDG0tz02j07xjNjbXCnLmr5BCsuVVe0CPaSnG8UWZHzxABOiSrZvF
         RoyBhudidOyorOJc4/7B8y8XBCTxykSEbsM5JxXOZ9Q3sj4iU+Grk9+nskEVL9Ei9o2K
         RvnWRYqjqes1jHibj+RAdamW1QAriHDLU6VyrBmcdm8ejT2yVlwX/tykiIlVWCy76Si4
         MWzw==
X-Forwarded-Encrypted: i=1; AJvYcCWwU05YCI78MjMiDQEWAisOgne4b7BOPFunD3hLFdCMS16fCEGQ2U1eIAmBOylF29Ac+U0ciQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyR/0LkJOISP6xYDjdkRmAzhczKLZtXJEMThzhZhmfpVEzbd87n
	u5wxzUN8yFL4sheCFbRAvWZEpcRcXgzUVQc5VgJz3ggmPXyrmH/00shxug==
X-Gm-Gg: ASbGnct7Skjdf5D4SmdBtH62k/56nrKz4PoSvICZ33yCBIESqOrQVGT7XKcAEbifrZV
	ObwPIX2UhFNKxzZbJ2MkyGmF5rc4RqClecqtmN+Ja2GfjWvj6UF5qoIu4VQUWCZ5A5UuStnN5BP
	vvWKwTFmjIHAr9ACC9FO/gXsUOaGVNCJaxI7II7LcsqlqtuxOvhQErAtkqLf1KOo5gq/LOdU4W9
	yDtR/FpMdY16bfOjzwNyPfcNxoYZvm6nIdJJitelMuO7Vkzc17/bqAcVg==
X-Google-Smtp-Source: AGHT+IFEvWIGvq890WGAF8V+iysE470o3lDFhntgaJmb203usCSAb9I4GUaCI9m5Fm575zCayOy6sw==
X-Received: by 2002:a92:c266:0:b0:3a8:1195:f1f9 with SMTP id e9e14a558f8ab-3aff50b324fmr147993695ab.6.1734380910218;
        Mon, 16 Dec 2024 12:28:30 -0800 (PST)
Received: from [192.168.1.184] ([136.35.146.47])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4e5e378ceb9sm1346225173.136.2024.12.16.12.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 12:28:29 -0800 (PST)
Message-ID: <bfcb6c2f-ee25-4dd9-b40d-a52b149c02fb@gmail.com>
Date: Mon, 16 Dec 2024 14:27:40 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] speedupmodem: ussd: ensure ussd content fits in
 buffer
To: "Sicelo A. Mhlongo" <absicsz@gmail.com>, ofono@lists.linux.dev
References: <20241216110106.567830-1-absicsz@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20241216110106.567830-1-absicsz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/24 5:00 AM, Sicelo A. Mhlongo wrote:
> Additional fix for CVE-2024-7539
> ---
>   drivers/speedupmodem/ussd.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 

This set also fails to compile:

Fedora (glibc) clang debug+sanitizers
=====================================
Configure: PASS
Build: FAIL
     drivers/huaweimodem/ussd.c:42:23: error: unused variable 'msg_ptr' 
[-Werror,-Wunused-variable]
        42 |         const unsigned char *msg_ptr = NULL;
           |                              ^~~~~~~
     drivers/huaweimodem/ussd.c:43:7: error: unused variable 'msg_len' 
[-Werror,-Wunused-variable]
        43 |         long msg_len;
           |              ^~~~~~~
     drivers/huaweimodem/ussd.c:54:8: error: use of undeclared label 'out'
        54 |                 goto out;
           |                      ^
     drivers/huaweimodem/ussd.c:62:2: error: type specifier missing, defaults to 
'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
        62 |         msg_ptr = decode_hex_own_buf(content, -1, &msg_len, 0, msg);
           |         ^
           |         int
     drivers/huaweimodem/ussd.c:62:31: error: use of undeclared identifier 'content'
        62 |         msg_ptr = decode_hex_own_buf(content, -1, &msg_len, 0, msg);
           |                                      ^
     drivers/huaweimodem/ussd.c:62:45: error: use of undeclared identifier 'msg_len'
        62 |         msg_ptr = decode_hex_own_buf(content, -1, &msg_len, 0, msg);
           |                                                    ^
     drivers/huaweimodem/ussd.c:62:57: error: use of undeclared identifier 'msg'
        62 |         msg_ptr = decode_hex_own_buf(content, -1, &msg_len, 0, msg);
           |                                                                ^
     drivers/huaweimodem/ussd.c:64:1: error: type specifier missing, defaults to 
'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
        64 | out:
           | ^
           | int
     drivers/huaweimodem/ussd.c:64:4: error: expected ';' after top level declarator
        64 | out:
           |    ^
           |    ;
     drivers/huaweimodem/ussd.c:65:48: error: redefinition of parameter 'msg_ptr'
        65 |         ofono_ussd_notify(ussd, status, dcs, msg_ptr, msg_ptr ? 
msg_len : 0);
           |                                                       ^
     drivers/huaweimodem/ussd.c:65:56: error: expected ')'
        65 |         ofono_ussd_notify(ussd, status, dcs, msg_ptr, msg_ptr ? 
msg_len : 0);
           |                                                               ^
     drivers/huaweimodem/ussd.c:65:19: note: to match this '('
        65 |         ofono_ussd_notify(ussd, status, dcs, msg_ptr, msg_ptr ? 
msg_len : 0);
           |                          ^
     drivers/huaweimodem/ussd.c:65:2: error: type specifier missing, defaults to 
'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
        65 |         ofono_ussd_notify(ussd, status, dcs, msg_ptr, msg_ptr ? 
msg_len : 0);
           |         ^
           |         int
     drivers/huaweimodem/ussd.c:65:20: error: a parameter list without types is 
only allowed in a function definition
        65 |         ofono_ussd_notify(ussd, status, dcs, msg_ptr, msg_ptr ? 
msg_len : 0);
           |                           ^
     drivers/huaweimodem/ussd.c:66:1: error: extraneous closing brace ('}')
        66 | }
           | ^
     14 errors generated.
     make[1]: *** [Makefile:4083: drivers/huaweimodem/ussd.o] Error 1
     drivers/speedupmodem/ussd.c:41:23: error: unused variable 'msg_ptr' 
[-Werror,-Wunused-variable]
        41 |         const unsigned char *msg_ptr = NULL;
           |                              ^~~~~~~
     drivers/speedupmodem/ussd.c:42:7: error: unused variable 'msg_len' 
[-Werror,-Wunused-variable]
        42 |         long msg_len;
           |              ^~~~~~~
     drivers/speedupmodem/ussd.c:53:8: error: use of undeclared label 'out'
        53 |                 goto out;
           |                      ^
     drivers/speedupmodem/ussd.c:61:2: error: type specifier missing, defaults 
to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
        61 |         msg_ptr = decode_hex_own_buf(content, -1, &msg_len, 0, msg);
           |         ^
           |         int
     drivers/speedupmodem/ussd.c:61:31: error: use of undeclared identifier 
'content'
        61 |         msg_ptr = decode_hex_own_buf(content, -1, &msg_len, 0, msg);
           |                                      ^
     drivers/speedupmodem/ussd.c:61:45: error: use of undeclared identifier 
'msg_len'
        61 |         msg_ptr = decode_hex_own_buf(content, -1, &msg_len, 0, msg);
           |                                                    ^
     drivers/speedupmodem/ussd.c:61:57: error: use of undeclared identifier 'msg'
        61 |         msg_ptr = decode_hex_own_buf(content, -1, &msg_len, 0, msg);
           |                                                                ^
     drivers/speedupmodem/ussd.c:63:1: error: type specifier missing, defaults 
to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
        63 | out:
           | ^
           | int
     drivers/speedupmodem/ussd.c:63:4: error: expected ';' after top level 
declarator
        63 | out:
           |    ^
           |    ;
     drivers/speedupmodem/ussd.c:64:48: error: redefinition of parameter 'msg_ptr'
        64 |         ofono_ussd_notify(ussd, status, dcs, msg_ptr, msg_ptr ? 
msg_len : 0);
           |                                                       ^
     drivers/speedupmodem/ussd.c:64:56: error: expected ')'
        64 |         ofono_ussd_notify(ussd, status, dcs, msg_ptr, msg_ptr ? 
msg_len : 0);
           |                                                               ^
     drivers/speedupmodem/ussd.c:64:19: note: to match this '('
        64 |         ofono_ussd_notify(ussd, status, dcs, msg_ptr, msg_ptr ? 
msg_len : 0);
           |                          ^
     drivers/speedupmodem/ussd.c:64:2: error: type specifier missing, defaults 
to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
        64 |         ofono_ussd_notify(ussd, status, dcs, msg_ptr, msg_ptr ? 
msg_len : 0);
           |         ^
           |         int
     drivers/speedupmodem/ussd.c:64:20: error: a parameter list without types is 
only allowed in a function definition
        64 |         ofono_ussd_notify(ussd, status, dcs, msg_ptr, msg_ptr ? 
msg_len : 0);
           |                           ^
     drivers/speedupmodem/ussd.c:65:1: error: extraneous closing brace ('}')
        65 | }
           | ^
     14 errors generated.
     make[1]: *** [Makefile:4083: drivers/speedupmodem/ussd.o] Error 1
     make[1]: Target 'all-am' not remade because of errors.
     make: *** [Makefile:2388: all] Error 2

