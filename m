Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ECE15BF
	for <ofono@lists.linux.dev>; Sat, 28 Oct 2023 06:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqtwNn5y"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40837ebba42so18972645e9.0
        for <ofono@lists.linux.dev>; Fri, 27 Oct 2023 23:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698474373; x=1699079173; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qzpwv7MJNqLMtUeBVWGBjy6TzLgIGNVAJN6qEzkYNj4=;
        b=kqtwNn5yG9tnsIXEeFtOXam7T+3MziKo4Vy0L9wU1JEDcscJra/99IeGFxuxNMh2OC
         V8yZ5M+EiKdcCkKqLG2lCKFj5nmMHdJPN4g3DxL9Uh9uNxVVAznxGpl/auoYV1fhqsYf
         qIeAs07xsFpiolywWfdY83qrOAQfK6dhraFMKm9UWevx9lmPPr3Q8K/HZ8zUvBCRmLOE
         PdZwzAT2yWOI2cDssocw0N7Z9HjM2jhilFgihREQ4fpjoIBI3QfRcTZYu549xwKy20zP
         fCJi7DeiqubjRsNX2d0VFx3UfQCB540zRgn53NLDnGa0xkLMZjD0zqwJPwB+Xol9SXBP
         cBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698474373; x=1699079173;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qzpwv7MJNqLMtUeBVWGBjy6TzLgIGNVAJN6qEzkYNj4=;
        b=Qzlw4NZN3vaXU//hxdWWpROK3OR3muN9FP6Uu/bkGOPZc8dO9gKdR4thp1z82SOO2c
         OZGk5T9pzwvlAnFI3ZVn8hyNz73eHowqKI7tB30xKlDCz+SwKrRynUivDjXCna0ya0B9
         bcETvWe7Ojx0PBcejSTa4LnhN5kY2JwO/nseWz3a90eByk4FxOQZaIEzMs7DzObxjg9I
         WLqqi/uHOnnDnj2InqAL8+0r+H+10SkKr8NDGXzcQ+J7aL3MkkCVfsGZd7adEmeUsYwL
         LhvR+mHgjtlB5M5IEKjq2DFx8bz2nzo5NZIhVybXgAZaYINkua1j6gT9/baQK/7XP6dn
         EWug==
X-Gm-Message-State: AOJu0YyJA8mlfhgIzlw/JPytNjmtSyIuTsA5i/RU1xbqmlavuM5TdnRA
	D9ihr+Yn3sUIhI8AxRXTvzGPIs+Y8SBp/A==
X-Google-Smtp-Source: AGHT+IGVvFVtVOonz/UfO5biH2ixGyk0PRLMx/RQvesuwD3VYN7JTvsKKWk2yMF90TQGVDgdNzk8AA==
X-Received: by 2002:a05:600c:1f8c:b0:405:92f9:b090 with SMTP id je12-20020a05600c1f8c00b0040592f9b090mr3884651wmb.14.1698474372849;
        Fri, 27 Oct 2023 23:26:12 -0700 (PDT)
Received: from tp440p.steeds.sam ([2602:fbf6:10:a::2])
        by smtp.gmail.com with ESMTPSA id dl19-20020a05600c669300b003fee6e170f9sm3194861wmb.45.2023.10.27.23.26.10
        for <ofono@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 23:26:12 -0700 (PDT)
Date: Sat, 28 Oct 2023 08:26:06 +0200
From: Sicelo <absicsz@gmail.com>
To: ofono@lists.linux.dev
Subject: Re: isimodem/n900: CLIP and list-operators not working under Alpine
 Linux
Message-ID: <ZTypfrSeWHBxtRnM@tp440p.steeds.sam>
References: <ZS0fnIsQP9t8V-kY@tp440p.steeds.sam>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZS0fnIsQP9t8V-kY@tp440p.steeds.sam>

Hi

On Mon, Oct 16, 2023 at 01:33:48PM +0200, Sicelo wrote:
> Hi
> 
> Since a number of versions ago, the Nokia N900 modem does not return
> anything to the `list-operators` command under Alpine/PostmarketOS [1].
> With recent testing, it was found that even the CLIP is not displayed on
> an incoming call.
> 
> However, both `list-operators` and CLIP are working fine in Maemo Leste,
> a distribution derived from Debian.
> 
> The major difference between Maemo Leste and PostmarketOS is that the
> former is a glibc distro, while the latter uses musl. I am mentioning
> this in case it is useful, otherwise I have not yet found anything
> specific between the two libraries that could cause the observed
> differences.

The patch below fixes both issues (tested against ofono 1.34).
Should I submit it as a real patch, or there is a possibility that it
would negatively affect other systems?

The documentation for `g_convert` states "Using extensions such as
“//TRANSLIT” may not work (or may not work well) on many platforms.
Consider using g_str_to_ascii() instead."

Thanks for help.

Sincerely
Sicelo



diff --git a/gisi/iter.c b/gisi/iter.c
index 3cc1ae37..f36d38a9 100644
--- a/gisi/iter.c
+++ b/gisi/iter.c
@@ -257,7 +257,7 @@ gboolean g_isi_sb_iter_get_alpha_tag(const GIsiSubBlockIter *restrict iter,
        if (ucs2 + len > iter->end)
                return FALSE;

-       *utf8 = g_convert((const char *) ucs2, len, "UTF-8//TRANSLIT",
+       *utf8 = g_convert((const char *) ucs2, len, "UTF-8",
                                "UCS-2BE", NULL, NULL, NULL);
        return *utf8 != NULL;
 }



