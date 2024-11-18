Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B42B18B47E
	for <ofono@lists.linux.dev>; Mon, 18 Nov 2024 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731949284; cv=none; b=ZnImbGycy3Q0F+cbRaDS17SWCJZPR7aV0v3oiio2/JRaeQNmdgj2z8MjTIlHFIfaTw7uZBTF82YvDJOTv1CZMVJ4kMQd1Kg4EqCqRSvSZ7JuxijjxFbtNKRXnE8EOGCfeo5NK/e8fbZRKcnbpu2KWwF84iikc9905Ri1H8woHoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731949284; c=relaxed/simple;
	bh=MAHs8px5hGi2ymf8rd3ORsKHx0Op2VAD3iv/ZX3SyWg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ipbmkZ+bhk45HWz8IqO0jwDP6rySNRWA68MVwgF8P50Dixq99PAZN882mBK01LXsEFRrIN1QfE4IkfjYvUOx7LwT+XPZ/Nl2kNOYHWtbDSb/pmcWLuBdXArD12vDKPaz9tMqoJyHw2ln2ZAhD3KFuV55honXNKwSfcAEboc5HJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpIiI7MA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpIiI7MA"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so20670655e9.1
        for <ofono@lists.linux.dev>; Mon, 18 Nov 2024 09:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731949281; x=1732554081; darn=lists.linux.dev;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=454AAeKGBfTgEaN2JIOn4hxd1j+5PrZa/9FQKertM20=;
        b=dpIiI7MAm+U5di3pfLEFNSJbgkIDO+j4VcB0aR3aon3lxdWdevgJy6SZDIdDsDAXNG
         oPBn8c0dYFHTZTCsdVBVKakL1KS/pZM6pgteBD84i0PtgtnatXFWNbjaYMlM5aHeZZL7
         I81GXHn3XH+sfH2cY2VLyxJ1vilYXDwwwni3YbAua6vGF4uX9aM8wi+64UDaFxLvys10
         mCJ/8n258z8EQql29BlYpg+ztbqVIQyWXXcWC1dBfhtI6d184NztUB0zb5sso/Gkl1i7
         dICbOyhJfnYK1T9tnw/hfLxhDhs9Y1X6US4l+TqogThiMzs+EL7RcncTsCAJYJMlcp5i
         ttPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731949281; x=1732554081;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=454AAeKGBfTgEaN2JIOn4hxd1j+5PrZa/9FQKertM20=;
        b=hXiyCKfI2ce++ezlr8S/TBswkSg0CsCD9VDiWBZhJJ6KhdERAEQaeRGc7AvdBFjfIL
         qppvhBLYnMlURrrXXEddJk9vvl8hYIzDt+Jin/uB0iDCy1qhclmHlz7KvX7YeV7DoQPC
         oowuDRgpGu2h4G9NYIB60qsLd5v8QHmrGGwRhb51M0tzT49bS6RdC4SrHuM/tGXMqVaa
         plNbwq9OQOVPcBh6sWaTu2UlqJvvUDbUU4cTiE+C8GJnEA4wLZ0dHBKA8G3uuRhdBT52
         oqCBPoBnyxZNVmN2HOCxFoH9RSwPlm+HbiGY5ybGJJkLQ0TMh4iCn4EjhIwXvNPx9onL
         WPzw==
X-Forwarded-Encrypted: i=1; AJvYcCXFZRZAABvpkWYukz2luFWHVvhTv9t2dgP6KIOO0UBEsQ589NeyXJao9SrFLUcqcBObGFEu0w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7swuydq247Ww0O8hpJOKwI7eUWRx9gh8iVDBXOyLf65Rd1myl
	4Q+eSGG81OYgwNSsGgyo6uA7/B4AWdKM+phrwydB+wc+jYJvMapm8pdOfg==
X-Google-Smtp-Source: AGHT+IFyygL2BHW8gn1MhnTYDP+0NQ1qvfg/imYVgPx/anGyXJF0P2iKCygKoMwIC7Jrn5MncTCyOQ==
X-Received: by 2002:a05:600c:510b:b0:431:5e3c:2ff0 with SMTP id 5b1f17b1804b1-432df72cf45mr114259725e9.8.1731949281064;
        Mon, 18 Nov 2024 09:01:21 -0800 (PST)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432da29978dsm163718985e9.41.2024.11.18.09.01.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2024 09:01:20 -0800 (PST)
Subject: Re: [PATCH] qmi: sim: Implement query_facility_lock(LockedPins
 property)
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
Cc: absicsz@gmail.com, merlijn@wizzup.org
References: <1731841478-10479-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <908f9eab-6dbb-429c-b35f-f81cdda2088c@gmail.com>
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <82438d23-e666-a480-e79a-ba62a3d70504@gmail.com>
Date: Mon, 18 Nov 2024 19:01:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <908f9eab-6dbb-429c-b35f-f81cdda2088c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Denis,

On 18.11.24 г. 18:43 ч., Denis Kenzior wrote:
> Hi Ivo,
> 
> On 11/17/24 5:04 AM, Ivaylo Dimitrov wrote:
>> ---
>>   drivers/qmimodem/sim.c | 93 
>> ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 93 insertions(+)
>>
>> diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
>> index 1fffae2..b1d8f22 100644
>> --- a/drivers/qmimodem/sim.c
>> +++ b/drivers/qmimodem/sim.c
>> @@ -41,6 +41,8 @@ struct sim_status {
>>       uint8_t app_type;
>>       uint8_t passwd_state;
>>       int retries[OFONO_SIM_PASSWORD_INVALID];
>> +    uint8_t pin1_state;
>> +    uint8_t pin2_state;
>>   };
>>   struct sim_data {
>> @@ -52,6 +54,20 @@ struct sim_data {
>>       struct l_timeout *retry_timer;
>>   };
>> +struct query_locked_data {
>> +    enum ofono_sim_password_type passwd_type;
>> +};
> 
> Why is this structure needed?  Can't you simply stuff this into 
> cb_data::user using L_UINT_TO_PTR and L_PTR_TO_UINT?
> 

I was wondering what is GUINT_TO_POINTER() replacement in ell, however...

>> +
>> +static inline void cb_user_data_unref(void *user_data)
>> +{
>> +    struct cb_data *cbd = user_data;
>> +
>> +    if (cbd->ref == 1 && cbd->user)
>> +        l_free(cbd->user);
>> +
>> +    cb_data_unref(user_data);
>> +}
>> +
> 
> That way this could also be dropped
> 

I introduced that for the future (sim pin change functionality), 
however, looking now at the code, I wonder why I decided it will be needed.

Will drop and resend.

Thanks and regards,
Ivo
