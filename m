Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5728013DB92
	for <ofono@lists.linux.dev>; Tue, 28 May 2024 22:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716934415; cv=none; b=d1ji5Hu/8z5hRRo14xtPp9Qwkr8iKCXmT5cNqHBhztORLIHGF9cQHiyiaLF82c91DZlnhDMYJ3XhP6sounDtZFdoRZmM+lswBruDGO17Lq+1x2Xxp2qWB4jancxTFuNGarsiYpZmVmPqkGQe3FBNwgmSl9JCJpO+aP1Daws5wHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716934415; c=relaxed/simple;
	bh=jrjFnTsJxzuSesgK2eDzrYDlsoVC4pwgRFzarOwa3a8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XHMfaww+y23qD99/n2utUJSfobTlU8HCa+898FlYlstwjugJN3PNFCtCKK/75DO/eE62KjQ4NoM+IlGf+RsG/FQgCgxktcvjh+hPFfYyTcidgX3PyleIeLhEe/QGtpbBgmGPW6lTh78STL+3CXKgJDf161tEDfVJ3X2Z3kUVhis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7G7/749; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7G7/749"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f12171523eso649174a34.1
        for <ofono@lists.linux.dev>; Tue, 28 May 2024 15:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716934413; x=1717539213; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xzFjJqXDuOhbA5a5tG6cX/xpFAiRW8q7FMn9HH1txrM=;
        b=i7G7/749bU1Ie67nzKa0fC7Pde3rghLb8fOQp9aPrIbKTE412Ls/jaftm9NxUiYARu
         WM9Unso0UzzKnNmArP/JKAxELp7AIF+czZN3LxtPXwT2bzb+dU+g2Ab4C/xTHuKS6Ggs
         9icjxgxipIxhFBTk4TwYYADwSfn0KdVBH0q3oVriC+7wk6qUMa5o/C5TYIIng+PPT6Sf
         Fnu+CvLfZ+w/ChK7+BwNousuhC1diwux9qGhZvMT71vR9BxNYxBO4VL+XrPOrjtjsycb
         SH5C+65Ekj2W4TDJ3dNtKF129+SxDN220T7mB6GEca6w/NnIO/tIbO+v6lE7iNu9FLxU
         AZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716934413; x=1717539213;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xzFjJqXDuOhbA5a5tG6cX/xpFAiRW8q7FMn9HH1txrM=;
        b=e30sxOUp0pYOVq7rjl55qs15ZV4HJVzUbQimlkWqwC86MHOE9YnXD2T6TLot53hhCX
         9hBL7HnihPybqyRozd3RFhlQusA/TZg4k7uhRGe/cyo6V4dqrDX7QxGuDr1kzMp425io
         uSXn5ypbY9FYvvuUnAoOUYukLGKFCDrKEX97WZvTiOKPlZKcsZ49mNYzZPFRILef03SZ
         d7YtPJkAsVfw7lHGc5l3D1L82GivYCBBFpL6hDuCZb1kWEfyJxB/gl7jXYYZx/Tgt6dQ
         XGFeX/5+jduHeINqRXmKGd5riwIAR8JQl+YQYPqkcx4Ca4BgYGeAbDWE3teJI38mqmaq
         wI7w==
X-Forwarded-Encrypted: i=1; AJvYcCWgV8/IOIzIvA1f+7UXA0lewEk/qPFAyJVlcuQ08acqoKgmTZ0vkze+wqv4m5HCYw4vA9aKsilb8L8/EnoOKoPrO2RnBwk=
X-Gm-Message-State: AOJu0YyZqf+fBZYlG3Cj0p84aZCOlJzAQOzvfaqskd13yKnKDeY1ZvY4
	9il/5q9yYTXXRbzkxDONAthax3rkLkdhxXCKDwTUl58ffBJdH1nkyz0MZQ==
X-Google-Smtp-Source: AGHT+IGC7pRY6c1pxrPYftNNHieT/QAs9v467PplM0sEH1LNN7RUSCHm/P8Hi4RtbgD/3+ZoX5mdWQ==
X-Received: by 2002:a05:6830:2b2a:b0:6f1:18da:603 with SMTP id 46e09a7af769-6f8d0a7e430mr16661437a34.4.1716934413158;
        Tue, 28 May 2024 15:13:33 -0700 (PDT)
Received: from [192.168.1.21] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-6f8d0e6136asm2084586a34.53.2024.05.28.15.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 15:13:32 -0700 (PDT)
Message-ID: <79f5b88a-d625-4c5c-addd-13727f8516c3@gmail.com>
Date: Tue, 28 May 2024 17:13:32 -0500
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
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240528082648.2010586-1-martin@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Martin,

On 5/28/24 3:26 AM, Martin Hundebøll wrote:
> Exitting ofono before going online with a quectel modem procudes the
> following use-after-free error:
> 
> ^Cofonod[776]: Terminating
> =================================================================
> ==776==ERROR: AddressSanitizer: heap-use-after-free on address 0xb4150734 at pc 0x005ad063 bp 0xbefa26c0 sp 0xbefa26c4
> READ of size 4 at 0xb4150734 thread T0
>      #0 0x5ad060 in ofono_sim_remove_file_watch ../git/src/sim.c:2621
>      #1 0x5ad060 in unwatch_sim_ecc_numbers ../git/src/voicecall.c:2820
>      #2 0x5ad060 in voicecall_unregister ../git/src/voicecall.c:2849
>      #3 0x57f910 in __ofono_atom_unregister ../git/src/modem.c:336
>      #4 0x57f910 in __ofono_atom_unregister ../git/src/modem.c:329
>      #5 0x57f910 in flush_atoms ../git/src/modem.c:492
>      #6 0x57f910 in modem_change_state ../git/src/modem.c:586
>      #7 0x58013e in set_powered ../git/src/modem.c:974
>      #8 0x58054a in __ofono_modem_shutdown ../git/src/modem.c:2279
>      #9 0x58054a in signal_handler ../git/src/main.c:85
> 
> 0xb4150734 is located 4 bytes inside of 8-byte region [0xb4150730,0xb4150738)
> freed by thread T0 here:
>      #0 0xb6a88110  (/lib/libasan.so.8+0x97110) (BuildId: 1374acedfadbe21a32d37a0a1f15e27d16516851)
>      #1 0x641216 in sim_fs_free ../git/src/simfs.c:123
>      #2 0x641216 in sim_fs_free ../git/src/simfs.c:103
>      #3 0x5de12c in sim_remove ../git/src/sim.c:3239
>      #4 0x57f95a in flush_atoms ../git/src/modem.c:495
>      #5 0x57f95a in modem_change_state ../git/src/modem.c:586
>      #6 0x58013e in set_powered ../git/src/modem.c:974
>      #7 0x58054a in __ofono_modem_shutdown ../git/src/modem.c:2279
>      #8 0x58054a in signal_handler ../git/src/main.c:85
> 
> previously allocated by thread T0 here:
>      #0 0xb6a8891c in __interceptor_calloc (/lib/libasan.so.8+0x9791c) (BuildId: 1374acedfadbe21a32d37a0a1f15e27d16516851)
>      #1 0x597b3e in sim_fs_context_new ../git/src/simfs.c:155
>      #2 0x597b3e in ofono_sim_context_create ../git/src/sim.c:2549
>      #3 0x597b3e in watch_sim_ecc_numbers ../git/src/voicecall.c:2925
>      #4 0x57f506 in call_watches ../git/src/modem.c:314
>      #5 0x4977be in at_clck_query_cb ../git/drivers/atmodem/sim.c:1612
>      #6 0x556cf4 in at_chat_finish_command ../git/gatchat/gatchat.c:465
>      #7 0x5583ae in at_chat_handle_command_response ../git/gatchat/gatchat.c:527
>      #8 0x5583ae in have_line ../git/gatchat/gatchat.c:606
>      #9 0x5583ae in new_bytes ../git/gatchat/gatchat.c:765
>      #10 0x559ef6 in received_data ../git/gatchat/gatio.c:122
>      #11 0x563400 in dispatch_sources ../git/gatchat/gatmux.c:184
>      #12 0x56402c in received_data ../git/gatchat/gatmux.c:272
> 
> The reason is the voicecall atom holding a reference to the sim atom,
> which is read in the voicecall_unregister() path. Avoid the error by
> simply instantiating the sim atom before the voicecall atom, which makes
> the latter being unregistered first.

Thanks for the reported.  This should really be fixed in the core.  Can you try 
the following patch:

https://patchwork.kernel.org/project/ofono/patch/20240528220642.251435-1-denkenz@gmail.com/

> ---
>   plugins/quectel.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Regards,
-Denis

