Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0401345C70B
	for <ofono@lists.linux.dev>; Thu,  3 Sep 2026 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425622; cv=none; b=QGKQEZGwntJ0owEubdd/6d9GzT9P1rLYeeL5JV9oCUM1MGDUrHYYs18ogxbqAvFIdwbuw2NEUJVmKaxyn0hUmpxAIuB40kDnrdeIxj+H2vOTfadjdTbxaSB/xsS2N2/C7NIs5ZlpygTFg6nWrsJAorQytuBkZYp4g6n0UbEBl68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425622; c=relaxed/simple;
	bh=+sNuDdkH7vC+QxV3Y36bLSU0bcncjvJaZf656AO8ghg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RpBnAmALbOjDPsOxr255NwuRyq4sB8elIaWuBfOkv6MBv4JSxe6mfXFDDkLOGQl2ZcfN0jBH4C0ctKgPvQuJI/alA5hcQkVHmezNgnapoVl/5N56ZZ5wq1PFYDNLndV45js1WSW7XHNnh8VjrOvmlKp/b3UD4Z2AAH7NMsomucc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ioqooRx8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dCVXevBM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ioqooRx8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dCVXevBM"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6838l0mi3578007
	for <ofono@lists.linux.dev>; Thu, 3 Sep 2026 08:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z3yqwegkAd5xqQtcb/0dgCXbkBUJdBWQTVk7wX5DjSg=; b=ioqooRx8YuUcprVq
	NMrVfo6O0v9OUzbZobASrq6pTb39mpKjrm721H2mdJzns0OKhhBJahtg6v1scHBq
	eR5yqw9axs878ES9ln6V5Vx76UVNTOaEh5qmeSqdtMTqoXpa2bWBYhyC/g3E66qO
	3Vk2Y9XjdFTw2h6GWsKdqcw2gb2Jfj11TcVE90NYh+lQ7cDWYiazX/tn7uiw+ViH
	EgdxcLHDPIaNcbvF7okh7ghtuRWddMBxfCM+LYBY6nnsQntTOcpu56EqrzxP8XxL
	J3QrOj6benaeIW6FTs+3661X0ugPBK6WWFunWBRWZ+ejYIugd5uact8W7jxbjbIn
	Ee6hLA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf5pdr0uv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Thu, 03 Sep 2026 08:53:39 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39af92138f9so1427162a91.0
        for <ofono@lists.linux.dev>; Thu, 03 Sep 2026 01:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788425618; x=1789030418; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z3yqwegkAd5xqQtcb/0dgCXbkBUJdBWQTVk7wX5DjSg=;
        b=dCVXevBMBlCFVQHT2pivOVO7AtXExSLkkbrDI+zSvZHbeV60S9/PuUWsHeAQJaGrPt
         GVGdUx17n+V1cwFU6xZi3Gz9Np/mCe3Fg8wgzZpvFz0l+5eH+Ciq+XySD8BEmLiOPuzt
         JfmCtghRt76f8Yw6XxKHt4uF/IV2Hf8JkRbVyk2HQtcjSc+GaIv8SKpEKSKPQhquIm61
         E+xZYSj2XXxH/5E+QnW9kDZKYy4dC/MzkEdjHdUVDAHVgAsZbkWOyI2ST2bMn7oOltlJ
         +FzGrYSgKvzF9eSx4PFiSoLQCQKCsixOsAK50N0e+yqYj6GADtMo2t3N1nAH+1F28TG9
         1Vog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788425618; x=1789030418;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z3yqwegkAd5xqQtcb/0dgCXbkBUJdBWQTVk7wX5DjSg=;
        b=S2kF4MrGoVFa0B+5sD4CBWY2B3vENsVXeC0jhk3t82rrkHsjn2+EytFkcQMctfL/zK
         77YAT8aapD8Ma+8HGXf4VmjRef9jGHb2wixFpSX0At4piCXGjiEFZCNAMdkjDhQu4TmG
         d5nAeo/FsvtpzedflhHSW0LUKcKnN5Va2SdmKl2kX80VKJIqSvU7KBB7ibFsI+epWrvR
         vKmW98FPVNaDpqRferHlVCAEdljZa0JKvu16hsLqVIxPPL1WiLHh89JqET9AMx7D8m92
         8+L2JwyWisiP9O7TAWZuQvWWg7BxEYglOgxV2UegKsBd9G8CiAiLdIqk0qCA5h4qnoJz
         hYXg==
X-Gm-Message-State: AFuF++laUp/E3/hN4AuMrodQWcW/0ZMPJdoI49OPhbeEEh/HyNS1r4fG
	SWckokYaFy4V0BNhPLix09YTjHVTQpZoIqwrp2yUQKCBlZ4oTwr1ZCxGmSnUM+QT7IBJUwmF+jD
	WfLxBmzWyzscdv8chYlgH/JMHlwgKYHt44kBf0hx6ib8ZsU0/uQv3pJQn+evxmpJong==
X-Gm-Gg: AYBFou2TRFpG/vRksnov2KUo4II3QuSMMMnscbQ79g4Qq/j7BUOJQIsAA8Vft0G+/P+
	QwnxKn0c78Plkoyk6EJ37YILso8yK1GhIsAnoJLjPve3xaYB6ZKCIVF4caDB9O+owo+zU3p0BlS
	AjbafGBE2xlVkrloo1c+OsmM1VF4EUH2XKTkMtGYnvIR9wzfN9agBZfLqzbue1SaHYvdA7Gd/iX
	vOmu2f+/aALfgCVrFPhdVsCF6ShHs5SiMw8Omk4fNVpfs72Y5EYmCRZPihsTlLKiN2IlDwMtwld
	FUE5AiqbM7gnDlILPSmlnY3DdLWhC82sWUpxvxhTgEroIINQ4IC8iiI0Gd0JnZN6ILf1ipXSl6C
	GKhcjkTEvtUZ2kHjKNCssPPvtXDY=
X-Received: by 2002:a17:90a:149:b0:38e:42f5:d096 with SMTP id 98e67ed59e1d1-39b12fccb47mr1126686a91.0.1788425618567;
        Thu, 03 Sep 2026 01:53:38 -0700 (PDT)
X-Received: by 2002:a17:90a:149:b0:38e:42f5:d096 with SMTP id 98e67ed59e1d1-39b12fccb47mr1126677a91.0.1788425617995;
        Thu, 03 Sep 2026 01:53:37 -0700 (PDT)
Received: from [10.239.97.158] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm4121629a91.1.2026.09.03.01.53.36
        for <ofono@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 01:53:37 -0700 (PDT)
Message-ID: <f0835373-da4d-4c9d-a953-428657fbb5d7@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 16:53:35 +0800
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] test: Add optional modem path argument to volume
 scripts
To: ofono@lists.linux.dev
References: <20260717080605.3876414-1-shuai.zhang@oss.qualcomm.com>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <20260717080605.3876414-1-shuai.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA3NiBTYWx0ZWRfX32b9fQ4KUi7n
 3A1CdCXmlxVcKw2/+Z+Irw4J3uxyuUBQ5oGDO2vnJWcVDoJTWakvhqZl0E2jxc/qsWxbgJ/Wteh
 X/wHTssDSIwOFHdigWuSUNIflWHPECg=
X-Proofpoint-ORIG-GUID: _HHiMYEHf9nPCl-cHURJoI-e0TGFZsWb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA3NiBTYWx0ZWRfXy82EHypNQ8Qk
 vzp9MRIasd2ZiIFI6EE907tLaCIGXz5UQswEhEGDTvKKpRcrQtGWtzIoZDryvw0sLmNLVRym46n
 kVmoI/NedRx/mdPXUqdCR2tudntUkupOhPF66KQG8QgwH/noqTIPkfFMH4YaEUfu2pvT5ZjM8Li
 lNCX9CEGLanT7w1JOLzBhx4oc8fCwcx2404DNAwBdImRgBvnkh3RLPSYdF/cpGal/KhOtx3uLX3
 BaEA8E2EEehciqNSRN+FPQmYWmaWvrYE8a6QtyRKXHH7+eiTRbEmv9Qqi1WRUjxKtYn/TW4fAWC
 cLoiaF5HF0UEFtR0s7VkCS2K6QHLt566d0b34HWPbKIvUrpowh0TQhf7nPuTHaSofutKQDVTLfT
 AjcYhPSeqaXzkjktJ6aKzoTWF3zjxs0gJFPOufLoYQmo9FcPD6S6VMINmBgw9oXoVXwUHRq5m3H
 kuLlRC6EfViIb2Tkkxg==
X-Authority-Analysis: v=2.4 cv=RsL16imK c=1 sm=1 tr=0 ts=6a993593 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=t1GSApx7oizSpk-wZuYA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: _HHiMYEHf9nPCl-cHURJoI-e0TGFZsWb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030076

Hi maintainers,

On 7/17/2026 4:06 PM, Shuai Zhang wrote:
> set-mic-volume and set-speaker-volume scripts hardcode the call
> path to modems[0][0], the first modem in the list. When the DUT is
> paired with multiple devices and the active call is not on
> modem[0], the scripts fail to target the correct modem.
>
> Add an optional modem path first argument to both scripts,
> following the same pattern already used in hangup-all, allowing
> the caller to explicitly specify the target modem path.
> ---
>   test/set-mic-volume     | 8 +++++++-
>   test/set-speaker-volume | 8 +++++++-
>   2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/test/set-mic-volume b/test/set-mic-volume
> index cd6c73fa..4cdf2c99 100755
> --- a/test/set-mic-volume
> +++ b/test/set-mic-volume
> @@ -11,7 +11,13 @@ manager = dbus.Interface(bus.get_object('org.ofono', '/'),
>   modems = manager.GetModems()
>   path = modems[0][0]
>   
> +if (len(sys.argv) == 3):
> +	path = sys.argv[1]
> +	volume = sys.argv[2]
> +else:
> +	volume = sys.argv[1]
> +
>   cv = dbus.Interface(bus.get_object('org.ofono', path),
>   						'org.ofono.CallVolume')
>   
> -cv.SetProperty("MicrophoneVolume", dbus.Byte(int(sys.argv[1])))
> +cv.SetProperty("MicrophoneVolume", dbus.Byte(int(volume)))
> diff --git a/test/set-speaker-volume b/test/set-speaker-volume
> index 6d4e3019..3f468da0 100755
> --- a/test/set-speaker-volume
> +++ b/test/set-speaker-volume
> @@ -11,7 +11,13 @@ manager = dbus.Interface(bus.get_object('org.ofono', '/'),
>   modems = manager.GetModems()
>   path = modems[0][0]
>   
> +if (len(sys.argv) == 3):
> +	path = sys.argv[1]
> +	volume = sys.argv[2]
> +else:
> +	volume = sys.argv[1]
> +
>   cv = dbus.Interface(bus.get_object('org.ofono', path),
>   						'org.ofono.CallVolume')
>   
> -cv.SetProperty("SpeakerVolume", dbus.Byte(int(sys.argv[1])))
> +cv.SetProperty("SpeakerVolume", dbus.Byte(int(volume)))


This is a gentle reminder for this patch.
Any comments or feedback would be greatly appreciated.

Thanks,
Shuai

