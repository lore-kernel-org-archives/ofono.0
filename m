Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1F28479
	for <ofono@lists.linux.dev>; Wed, 10 Sep 2025 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518269; cv=none; b=YeNiZfbJ2qDaNmFgxvEjo0ohwejCMhudHLJ9dxqvIW/EdrWTyD2QkqOaFiRAAUiLAYyDh0sPNEQnSS9JyYRP+RPsWYIHtweaiagAjNslJSaMz1VSwNyPagO/EsyniRY/TR0LzDefKWpKwxG3kWFxSur3vYKcbeu2XEshDsjKAwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518269; c=relaxed/simple;
	bh=VVbL3RIkgSNsGPriKa60yC3EsxiZ90Cs67znYZLmu6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YUNlU6vrIW4wkBqfPjV84M7KKW3s8d1mKydlC0e2BpiKZeEVFqRMmq7oBdnNs15QCTNcKRFBdmxhkGk9aP89UYQb+zHvj0VKXjVE+2Qs2xldbfxQbIb5dxv0QemW07aCHSVwgroKRENHlQzvHqiWdIsFetWr9+G77uMkyueFPao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMGu4AKW; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMGu4AKW"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-74526ca79beso5905179a34.0
        for <ofono@lists.linux.dev>; Wed, 10 Sep 2025 08:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757518267; x=1758123067; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A88RxMd9H41O33MC4Cw3/7WvZNfuuKDXBib+E2p0OM8=;
        b=HMGu4AKWNhD3zDWkaVwY5pMMJLDbz4CDFzOiYFZbfHqp52tV9ovmuS57sngdluU7Il
         jTFiwBZikT1lZ+fkP57HrtQO9kC1645WgvUhjsKv8y1CwKABp9KWew/HMQSmuLNc2pBm
         KrzkPdA/xlRxNocL+XPN60uhvaRDeQDw480SQ6Ek4K6Qloq4KjeKxmcWu5kUqXZFz+8K
         6N/Z/5cn9HqgBsebRnMj5Ayclsqzc3JAMnUmVk7bE/Cg+7CUsNtdnt5IIN+Pw1RGVmQa
         jzDYqpS+dvE1g2LeOQk9nuIGppuJD59byJDp4UJgXRONl4JbtcS5fA8Zy4qusKlusRdj
         5rMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757518267; x=1758123067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A88RxMd9H41O33MC4Cw3/7WvZNfuuKDXBib+E2p0OM8=;
        b=QB8/nuf/RmewEytInYTCFuVW0mIQqBx7N/CvNUwZ8y/LgNwAnYPEjCzLIjXhfI9ura
         uzMqJ0MFUztDhat9yk5BlYRRf4wrMEnpsGNoJZrsjRdbY4sYkozr7cerXsNfto6ELpFU
         QTlF9RLH6pX41qKnl9ImAEDT09FRLaOPmnDanJKq3KmWIVb8Csg0I138ZIZrtLA0WCGK
         e7Gzq4e185SeOcGouE3dbYxJejeWbOJwqFdVh4KmjvXwKSRmiuObnZJ3vzWsplJrFfO0
         dz113d+0ei//VWQ7BOILVjdAZ8SLYCoBBmIvXIFxd2QJvLN1VlbYiZtJxE4wOYpkkE+W
         DbCw==
X-Forwarded-Encrypted: i=1; AJvYcCVpCYGEl5li6KN6XnOfj2sW3qJGlqZ9herasIynHXw6IZg0LeJ4EOhwmF/ILSX+C37jrBEhBg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzY0TdwrJbR2ux/QvC9z653SYr3meErKgM9BFlMQtPKJqmVAX2Q
	Vk+IQj+7k22X6n0g2uOu+S952YeLAFMLVRGyyEwzIpqShVEONmJ4Gl/YGFpUhg==
X-Gm-Gg: ASbGncvyg/1gk5CJmgKo8MlobVi88WHONLZLowUsyizm+xhPjpZhkZdsIQ4+L7JsTuM
	4QCRB+zGOIp2qc/gR3kY9XUcpig2mbc5v6g4pXW0szS+M05i2OG5RPzvLYe5uBhJvH33NEIvzia
	gquNYuiMz4mJrIBuAZedmY3YWwj5FAq5uGATQzTKiGLnMtmoXDtJtAUk8gDB2v5jVinZsE7R4G9
	tkAIR2xTMI5ekxYhZk8pcSLODSGwHb3lmSMcOYASHCCW8TXV7Q/aAwKw6ClKTM5Sb/tL0JJcPUv
	/wMQtlcNo4VybTS3PjFCtsTIWGv4FGxpLWPeaNb8OJJr39Qb5zoQ61viO9aFHpAGvfAgpTf6BGP
	IViaiYEdoTx1qls+6hz8cmubYXzLU4WT1t3FLZPxboG5XUAgG8qSQVW7LYnz8JpAjMu1wEi49gh
	tkNWJ/vnm8Gg==
X-Google-Smtp-Source: AGHT+IED5NstLQaZWSZAz0fpWKUrOqS1LwwuEqDtdcHNOeZ0cnKn6j9x8E8tkbewKSnB5zPDIwksTg==
X-Received: by 2002:a05:6830:7105:b0:742:29a0:1c20 with SMTP id 46e09a7af769-74c76be9610mr9718229a34.28.1757518266694;
        Wed, 10 Sep 2025 08:31:06 -0700 (PDT)
Received: from [172.16.49.130] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7459a657c0csm6331156a34.5.2025.09.10.08.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 08:31:06 -0700 (PDT)
Message-ID: <379c6d32-28be-40ac-a055-0ebcf13613ea@gmail.com>
Date: Wed, 10 Sep 2025 10:31:05 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Quectel modem ceases working
To: Timo Ketola <timo.ketola@exertus.fi>, ofono@lists.linux.dev
References: <3be9ef7c-fb1b-4caa-802b-93f02eaad1d6@exertus.fi>
 <e87a92d3-3e5b-4e5c-aab7-2310697b9fa7@gmail.com>
 <e400c04f-1550-4263-9f21-ce1476e12c80@exertus.fi>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <e400c04f-1550-4263-9f21-ce1476e12c80@exertus.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Timo,

On 9/10/25 5:59 AM, Timo Ketola wrote:
> Hi Denis,
> 
> Thanks for looking at this!
> 
> My further testing unsurprisingly shows that my hack does not really
> work. list-modems looks better and the IF gets IP address but actual
> traffic does not work.

Yeah, looks like the raw_ip setting isn't being reset back to what is expected.

> 
>> What kernel are you running?
> 
> 5.4.78 with RT patch.

Ugh.  I really have no desire to support kernels pre-5.15 when the passthrough 
capability was introduced.  I also have no hardware that is not 802.3 mode 
capable.  You can try the following patch though and see if things work again.

Regards,
-Denis

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 52ead377de7f..1b77e5e32ed6 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -665,10 +665,21 @@ static void set_data_format_cb(struct qmi_result *result, 
void *user_data)
  	DBG("");

  	if (!qmi_result_set_error(result, NULL)) {
+		struct qmi_wda_data_format actual;
+
  		if (!compare_data_format(data, result))
  			goto done;

  		ofono_error("Setting Data Format had no effect");
+
+		if (!qmi_wda_parse_data_format(result, &actual) &&
+				data->data_format == WDA_DATA_FORMAT_802_3 &&
+				actual.ll_protocol ==
+				QMI_WDA_DATA_LINK_PROTOCOL_RAW_IP) {
+			ofono_warn("Modem seems to only work in raw-ip mode");
+			data->data_format = WDA_DATA_FORMAT_RAW_IP;
+			goto done;
+		}
  	}

  	if (data->data_format == WDA_DATA_FORMAT_802_3)

