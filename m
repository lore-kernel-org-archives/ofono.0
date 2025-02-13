Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BE02C190
	for <ofono@lists.linux.dev>; Thu, 13 Feb 2025 00:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739404842; cv=none; b=kC6lKm5cUfCBW9Ma5KOdhMeYr+Oq8VCfrzrEs6OUu53wPBDWPNmXNv9NycQtqmlJbFwKTgP8AAnupPpRzYXDbchUMGeXo2EI1ax2LA7YKnPzMiWeZvSt6qZf21MmetGlZ/eG46U78BLjhqFANRuyYOLYnXPU+H+WPpNg6TUvTrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739404842; c=relaxed/simple;
	bh=Ye4ujEDHMLMk8Yd8e+ccnHviaxBm7BcUSWyqGOs+6us=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JkeaHQVHCaVjJy1VYB6OArnP1nJv/yEO7/7FayJp+yzl8Iihkdo4rXSGciaW6q8IaSUPqDHqAJTa4GV4hCtBsUz3dD6jvh6pOql3cZPI3rV/EATiync4iaX8KScZs2iRC7S+Rig0d2nIjcIeZm0O0h3TK+u89U6j41qwvp5j0PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=sBqTIV+M; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="sBqTIV+M"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 96E31164922;
	Wed, 12 Feb 2025 19:00:39 -0500 (EST)
Received: from smtpclient.apple (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 4C3E4124FD3;
	Wed, 12 Feb 2025 19:00:39 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH 01/10] qmi: Added minimum service request period property
 string.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <d2b9a654-790e-4629-b1c3-53409ca694e8@gmail.com>
Date: Wed, 12 Feb 2025 16:00:28 -0800
Cc: ofono@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <99653208-7699-4721-8769-CFB7B036D749@nuovations.com>
References: <cover.1739339173.git.gerickson@nuovations.com>
 <78fcde63abae5551db9893dbfbaca842e4d38b32.1739339173.git.gerickson@nuovations.com>
 <d2b9a654-790e-4629-b1c3-53409ca694e8@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=502IN5sJqaBeXKhm8AIAalrEIeZ5l8/FhNO0X/ndwnY=; b=sBqTIV+MxAOrDsTcnUatbDbhfXlx5tGhe9i/h8wCKUBGthhOj4rOnQzAXJ2lW+kgoGnMevFbSMg0DtvkJLXrPmS/6s5dCGRI5w8sUMEYW33iU4yxB53rTPAn8FOl9drJzgjiUA8p2z46vFflBaVe3Gs3jZH2J6Og24OURFUhS1kN4g9fMEaUyJHRgv7KptTh5r8c9Kr5Fw+dopkA7Rbsqp4PbczxYcmEZhhSpU36uqx6g1iMPEfNDTr4xZuD0gr/kuF5AgwiWZS/xrUoRfDJ4TJ32tCvYC+BkYNZdpnwsSvdFTExOhR2k2EU8rmsTDZzaZQJ++skBEf0J+unBo+dwg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Feb 12, 2025, at 11:15=E2=80=AFAM, Denis Kenzior <denkenz@gmail.com> =
wrote:
> On 2/11/25 11:52 PM, Grant Erickson wrote:
>> This may be used by ofono_modem_{g,s}et_integer to get or set the QMI
>> minimum service request period, in microseconds, modem property.
>> ---
>>  drivers/qmimodem/qmi.h | 2 ++
>>  1 file changed, 2 insertions(+)
>> diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
>> index 69698ee049c6..0c786ed065a3 100644
>> --- a/drivers/qmimodem/qmi.h
>> +++ b/drivers/qmimodem/qmi.h
>> @@ -43,6 +43,8 @@
>>  #define QMI_SERVICE_RMS 225 /* Remote management service */
>>  #define QMI_SERVICE_OMA 226 /* OMA device management service */
>>  +#define QMI_PROP_MIN_REQ_PERIOD_US "QMIMinReqPeriodUs"
>> +
>=20
> This doesn't really belong here.  Properties that are communicated =
between udevng and gobi/qrtrqmi are documented above the probe() method =
implementation. Also, maybe 'RequestThrottleTimeUs'?

Noted, will change this in a v2 patch set.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/

