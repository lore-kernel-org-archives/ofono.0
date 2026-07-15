Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE3D175A9C
	for <ofono@lists.linux.dev>; Wed, 15 Jul 2026 06:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784098040; cv=none; b=iplF4zNfHFdowQIwO8rk+cc6g7a3MX0HtVU7mbV4PZqTzp+VxUGaQii2SuUUTrohaPPLAQ4MwEj3QnYq4l1GxLkrbpRrjjZh3w8Cm9er0DjUjonhjZBwRerrmEXs6D5Wyu0RKh6e9iZ5xkV7wHCJ+BzQbPjJPVtYs8EjFdVAp08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784098040; c=relaxed/simple;
	bh=aHtVZGuSWyoK81RGuLgdz/9/QTFtgQ2kD+oFLXMY/LU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uiMCyBZkfyiE9a5GKDchvjkbIjeutcxRxA+qiMq9DFy+aA+o5Je4sIyOEIEq1CglPXLcRttlCIzigGzzt3yJIP4EICkv6sT3nc37du5fWoXsTEk+53DrPsGuQeMhjUTQCbigLyfbQS1cGqdRIpqWN0gOZ8LlIvKFqA1nKpBRqN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hi9Alklg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G8Jew4Hu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hi9Alklg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G8Jew4Hu"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F3lLvi2555549
	for <ofono@lists.linux.dev>; Wed, 15 Jul 2026 06:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZvcNJq1RZLS8mx5/YnQHfAZHawktMugM17L8pldIFus=; b=hi9AlklgxCcJcZ9f
	yfzZ6dKKb6Ks4Vs4CikMT3Neah1k8SUuxlttszPKX9CGqQzD8y96MxfB2458jXdS
	3BQSJe+xkzrgPMczO9SSBlmX/MghKIO4ObiF4SHbt7kQhFYQSAmOv/7KRE9YKJ23
	B7qnDvVVexedMwahrugJWayY8Va1yDt1aX7yAKe3E6U49Tm142YHvIW8OSPeQi1H
	U2XBQmvVl1wp6QL2pRM6DEe+T4HtgLS5aVj8nuJcVPp8Ax701HmTgqMREy4GU79b
	2qsLBXxYk9t0//E68iVydJH0I+N7RoGlZ5ww5WhfpsACnWev29gXohAYcti7pbD4
	Q400fg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fds9ktc8d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Wed, 15 Jul 2026 06:47:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e606e8f3eso638441185a.3
        for <ofono@lists.linux.dev>; Tue, 14 Jul 2026 23:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784098036; x=1784702836; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZvcNJq1RZLS8mx5/YnQHfAZHawktMugM17L8pldIFus=;
        b=G8Jew4HuUklXaRF+ygTMO/MsrQuNCFcu2HsLBOm5iYsC3O9vd7svUfX2/C04kgKaKX
         K2AUE5HJRk4dhIkQlKazCFpjfTHsHFXXfggRf+JamRV+tus1/VIjwaRwscwM2HpBYPkc
         LA38sSPjteJHMwSp/ZdytI8unLkwKNdrx0b0ZBcS9U6rbKyUHD9i0TVSfahaHqI49k/v
         t7DkzSyVoZz3qvSxfdkwRljX0XlojpAESvhz8/RymlRJyRKQEfyNGNyYjCFTWelWbjIp
         k3mVqadupBbxZOMawe04N4hnmPd6o9LMzimRLCGIFsWPmTJ6KWiHWmjJcceLwvYXJdjY
         Wa0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784098036; x=1784702836;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZvcNJq1RZLS8mx5/YnQHfAZHawktMugM17L8pldIFus=;
        b=awz3OdHVFB9kF71sWUrMdD1gMTdZ3pzwwavDRa6Y9yGHhTVnedvZD6s/R4SjiUqPOz
         gwJaz/PBte5GIUavRFsNcChoyFjuQTRynLe6T3gdJcR5NI4FhJeccthD4yw/zD9iksg3
         FdD7/vSm2d84A2HNba2O6+5BQ5zuuBT897OLHh9yVh1zMHAwe5kKcgYL1si/iriXvLTe
         zPZQltH3MG+ErwY+OqpxvX/3V84XHNtHbj4gWihvlz1LH7cIIjthaswQLE6HYy/rtCrR
         u2wgp4bsn76OdjzFyZarnToyW2iO80Nnhdh2egrrVsI4v5WxA0bsQfRYsT2LdD12h009
         XWZA==
X-Forwarded-Encrypted: i=1; AHgh+Ro/y+To6K+TfXT/ahYicoR8PS4SrH9ExyHgFh+XvgUhQEx8eEfoMgihCGqbSX21IcOGjeXlaQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzAeYNYZhC62JGIX2KYFj5sCt8pE9jfH6WF83g4Xwyu5frdde+J
	avMUvGcvnK1U67KKOGt2zIzw1BhwEssEURUspRM+tb4Rb9jBQB8G2H+CyS3bUcDWtmBUfDT+8HP
	VcwdSdEAd3b48/Wag4y6sLTqpuBijwJb5+nm+NVKN1MMlQeX343T8XUU7rQ==
X-Gm-Gg: AfdE7ckI8d6t1nBlf8QENJot9YROMSKjUyWJtxeqWRln7dCmtCugAhij0Yvh1X3cXIT
	6j+PXZrRAYonht2uqAbBzq2rmgviszdBl7nB+hduj3d2lbekDh6axI9kk8AtEQaDCvTmnh7GpAw
	kJLMA84pgbaDV5T+Lo13fcx8LKiTDmwNISQak1LytF6tvsZLN6LZ5Mpr1cyRH9KlSIbGy2Rn9lt
	Rv0aFfMiKBnij1Oe8drJXlc5iuj9zTH1yi1ZbQZYFP8gz7Oh9fenJ+S4KY6uzdzTR497PWQ1AMq
	0xzzcRWq33/izOnnid+pCUAiO3RNEkq/q2kkBaGUAI0g8jBPYY894ATd47gzNbwApcUONWIFgMn
	qqbVvP7NF/Z+jycAmOGF+VfmeXKTluD6Vx3eb+kc=
X-Received: by 2002:a05:620a:bd3:b0:930:91d9:a813 with SMTP id af79cd13be357-93091d9a88bmr331902685a.84.1784098036003;
        Tue, 14 Jul 2026 23:47:16 -0700 (PDT)
X-Received: by 2002:a05:620a:bd3:b0:930:91d9:a813 with SMTP id af79cd13be357-93091d9a88bmr331900685a.84.1784098035291;
        Tue, 14 Jul 2026 23:47:15 -0700 (PDT)
Received: from [10.239.96.184] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5bb3542sm1597566485a.20.2026.07.14.23.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 23:47:14 -0700 (PDT)
Message-ID: <ae6c5920-1005-448a-9524-b220a2da872e@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 14:47:08 +0800
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] gdbus: Skip BLE random-address devices and remove
 broad match rule
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: denkenz@gmail.com, ofono@lists.linux.dev, linux-bluetooth@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com
References: <20260710075548.1072741-1-xiuzhuo.shang@oss.qualcomm.com>
 <CABBYNZJrrQO5XU1yC-HOry1eEaF8fBKV_jK4g3A+qJTAtw0Qqg@mail.gmail.com>
 <0b6a3ae6-d8a8-409d-844b-be4be14917d3@oss.qualcomm.com>
 <CABBYNZ+-ybGUPPtQ3xuwHfewt4w6C4CTf0cYXbo3AZ9+vqDGxA@mail.gmail.com>
 <81ef5f5e-8be5-4736-9d48-d4b3f6611e44@oss.qualcomm.com>
 <CABBYNZK8M-mRXvA5eMWwC9r4mBgxSH_6sU06EsVgxKoSWaVsJw@mail.gmail.com>
Content-Language: en-US
From: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
In-Reply-To: <CABBYNZK8M-mRXvA5eMWwC9r4mBgxSH_6sU06EsVgxKoSWaVsJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Q63iJY2a c=1 sm=1 tr=0 ts=6a572cf5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=LHhCsYTOd1_JG7rcKsAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: PympeKP-i30BZy5IbnZGc0tOs00p-ato
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA2MiBTYWx0ZWRfX51Gqr8q83Gpa
 d8d0A70aJLC5/NcZKuCW9HfaOBXA/5OWHOlSnMeFgS/ta3+15wuX9Xg6wPX5CCltcT/WPMuSa5C
 ZU44kI1feefDX8dkJYtuhmUr6F2IjFU=
X-Proofpoint-GUID: PympeKP-i30BZy5IbnZGc0tOs00p-ato
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA2MiBTYWx0ZWRfXzSrnIDBi/xI1
 7D+ecM4YngSxGIW64cUKAk3tqzj4xMm/MIwTt5MUFuy6SxZsaGGYxvFmzNTO0B17ncIwFZvty7+
 XibK/Do68T0jfz3MSYsCXx7z9lAIOEDGuCAAV/Kujbd7LuzTYFL3t2LKi7ZOlf0mKAPhyJ5fbn8
 E6aYi4dXzgYmNGm9lrxO8f1bBnvyunkds1/3L9gCWB4d+DSiPPylteimKscnpm5TthQ1mdmg5Oy
 i7SQPaddMRIuLY1xDr5Dd2RJzP+/raDtPT115xAif/7KVz2bZtbmCtTeYZCjQ3VbPCysvfFJPlR
 aOfyXXSV6npS8gFytisY7RnNobX6+8AIJHKcioRwwA+gZEf6YGgElHOe0bqQvBVVXC4TpzbwcKq
 k1Y3bpK8hOqhHV7BTe1KWTf47TOzr5WhnmyNLTg+eUVUxEEDM52iOTmNmh6ikUOzZ7VmFHNZigo
 lna/oRCBJ5zTM1h5BRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150062



On 7/14/2026 10:01 PM, Luiz Augusto von Dentz wrote:
> Hi Xiuzhuo,
> 
> On Tue, Jul 14, 2026 at 7:04 AM Xiuzhuo Shang
> <xiuzhuo.shang@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 7/13/2026 10:00 PM, Luiz Augusto von Dentz wrote:
>>> Hi Xiuzhuo,
>>>
>>> On Mon, Jul 13, 2026 at 3:03 AM Xiuzhuo Shang
>>> <xiuzhuo.shang@oss.qualcomm.com> wrote:
>>>>
>>>>
>>>>
>>>> On 7/10/2026 10:12 PM, Luiz Augusto von Dentz wrote:
>>>>> Hi Xiuzhuo,
>>>>>
>>>>> On Fri, Jul 10, 2026 at 3:55 AM Xiuzhuo Shang
>>>>> <xiuzhuo.shang@oss.qualcomm.com> wrote:
>>>>>>
>>>>>> Two related changes to reduce dbus-daemon load caused by high-rate
>>>>>> BLE advertising signals:
>>>>>>
>>>>>> 1. In parse_properties(), skip creating a GDBusProxy for Device1
>>>>>>    objects whose AddressType is 'random' (BLE-only devices). Each
>>>>>>    proxy registers a per-device PropertiesChanged watch via
>>>>>>    g_dbus_add_properties_watch(); with hundreds of BLE peripherals
>>>>>>    advertising simultaneously, this results in hundreds of match rules
>>>>>>    and dbus-daemon routing thousands of RSSI PropertiesChanged signals
>>>>>>    per second to ofono, none of which ofono processes. The
>>>>>>    AddressType property is available in the InterfacesAdded dict at
>>>>>>    the time parse_properties() is called, so the check is reliable
>>>>>>    and race-free.
>>>>>>
>>>>>>    BR/EDR devices (AddressType='public') are unaffected: their proxies
>>>>>>    are created as before, and the property_changed callback continues
>>>>>>    to receive Paired and ServicesResolved updates needed for HFP/HSP.
>>>>>>
>>>>>> 2. In g_dbus_client_new_full(), remove the broad
>>>>>>    type='signal',sender=<service>,path_namespace=<path> match rule.
>>>>>>    This rule was the sole feeder for the signal_func path in
>>>>>>    message_filter(). ofono never calls g_dbus_client_set_signal_watch()
>>>>>>    so signal_func is always NULL; the broad rule therefore served no
>>>>>>    purpose and caused dbus-daemon to route every bluetoothd signal
>>>>>>    (including all BLE PropertiesChanged) to ofono.
>>>>>>
>>>>>>    InterfacesAdded and InterfacesRemoved are already covered by the
>>>>>>    precise watches registered via g_dbus_add_signal_watch() earlier in
>>>>>>    g_dbus_client_new_full(), so no functionality is lost.
>>>>>
>>>>> Looks like this is on ofono though, why are you chaning the BlueZ side?
>>>>
>>>> Regarding your suggestion to move the BLE filter to hfp_hf_bluez5.c: filtering in proxy_added()
>>>> would only prevent ofono from processing BLE devices at the application level. The per-device
>>>> PropertiesChanged watch is registered inside proxy_new(), which is called before proxy_added(). So
>>>> dbus-daemon would still route all RSSI signals to the process — the D-Bus pressure problem would
>>>> remain unchanged.
>>>>
>>>> I will drop the change from the gdbus patch per your feedback
>>>>
>>>>>
>>>>>> Together these two changes prevent dbus-daemon from routing BLE
>>>>>> advertising PropertiesChanged signals to ofono entirely, eliminating
>>>>>> the dbus-daemon memory growth and bluetoothd socket backpressure seen
>>>>>> after hours of BLE scanning.
>>>>>>
>>>>>> Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
>>>>>> ---
>>>>>>  gdbus/client.c | 46 ++++++++++++++++++++++++++++++++++++++--------
>>>>>>  1 file changed, 38 insertions(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/gdbus/client.c b/gdbus/client.c
>>>>>> index 48711ae8..dd3c17f9 100644
>>>>>> --- a/gdbus/client.c
>>>>>> +++ b/gdbus/client.c
>>>>>> @@ -937,6 +937,44 @@ static void parse_properties(GDBusClient *client, const char *path,
>>>>>>         if (g_str_equal(interface, DBUS_INTERFACE_PROPERTIES) == TRUE)
>>>>>>                 return;
>>>>>>
>>>>>> +       /*
>>>>>> +        * Skip BLE devices (AddressType='random') to avoid registering a
>>>>>> +        * per-device PropertiesChanged watch for every advertising BLE
>>>>>> +        * peripheral. ofono only needs BR/EDR devices for HFP/HSP; the
>>>>>> +        * high-rate RSSI PropertiesChanged signals from BLE scanners cause
>>>>>> +        * dbus-daemon memory bloat and socket backpressure in bluetoothd.
>>>>>> +        *
>>>>>> +        * The AddressType property is present in the InterfacesAdded dict
>>>>>> +        * (iter) at this point, so it can be checked before proxy_new().
>>>>>> +        */
>>>>>> +       if (g_str_equal(interface, "org.bluez.Device1") == TRUE) {
>>>>>> +               DBusMessageIter props, entry;
>>>>>> +               DBusMessageIter copy = *iter;
>>>>>> +
>>>>>> +               if (dbus_message_iter_get_arg_type(&copy) == DBUS_TYPE_ARRAY) {
>>>>>> +                       dbus_message_iter_recurse(&copy, &props);
>>>>>> +                       while (dbus_message_iter_get_arg_type(&props) ==
>>>>>> +                                               DBUS_TYPE_DICT_ENTRY) {
>>>>>> +                               const char *key;
>>>>>> +                               dbus_message_iter_recurse(&props, &entry);
>>>>>> +                               dbus_message_iter_get_basic(&entry, &key);
>>>>>> +                               if (g_str_equal(key, "AddressType") == TRUE) {
>>>>>> +                                       DBusMessageIter var;
>>>>>> +                                       const char *addr_type;
>>>>>> +                                       dbus_message_iter_next(&entry);
>>>>>> +                                       dbus_message_iter_recurse(&entry, &var);
>>>>>> +                                       dbus_message_iter_get_basic(&var,
>>>>>> +                                                               &addr_type);
>>>>>> +                                       if (g_str_equal(addr_type,
>>>>>> +                                                       "random") == TRUE)
>>>>>> +                                               return;
>>>>>> +                                       break;
>>>>>> +                               }
>>>>>> +                               dbus_message_iter_next(&props);
>>>>>> +                       }
>>>>>> +               }
>>>>>> +       }
>>>>>
>>>>> Nack, not going to introduce BlueZ specific logic into gdbus like
>>>>> this. If we need to rate limit the RSSI notification then it means
>>>>> it's not suitable to be a property, but I believe we have a threshold
>>>>> logic in the likes of device_set_rssi_with_delta so perhaps we shall
>>>>> check why it is not working in your case.
>>>>
>>>> I investigated why device_set_rssi_with_delta is not working in our case.
>>>>
>>>> Root cause in BlueZ
>>>>
>>>>   The customer scans with the following bluetoothctl sequence:
>>>>
>>>>   menu scan → transport le → duplicate-data off → back → scan le
>>>
>>> Ok, that is 1 not the default behavior and 2 if they are setting
>>> duplicate-data off that means they want to see all advertisements, so
>>> this is working as intended.
>>
>> Hi Luiz,
>>
>> Thank you for the clarification. I need to correct some points
>> regarding duplicate-data off and the actual signal rate.
>>
>> What DuplicateData does in BlueZ vs. the controller
>>
>> BlueZ's DuplicateData parameter in SetDiscoveryFilter and the
>> controller's hardware duplicate filter are two independent mechanisms:
>>
>> - The controller hardware duplicate filter (filter_dup in
>>   hci_le_set_scan_enable) is controlled by the kernel (hci_sync.c),
>>   defaulting to LE_SCAN_FILTER_DUP_ENABLE. It is only disabled for
>>   specific cases (AdvMonitor, Mesh, or
>>   HCI_QUIRK_STRICT_DUPLICATE_FILTER).
>>   SetDiscoveryFilter.DuplicateData does NOT directly control this.
>>
>> - BlueZ's DuplicateData=true flag (parse_duplicate_data() in
>>   src/adapter.c:2680) controls only whether device EIR data
>>   (manufacturer data, service data) is updated on duplicate
>>   advertisements at the application layer
>>   (device_set_manufacturer_data(), device_set_service_data(),
>>   src/adapter.c:7392).
>>
>> duplicate-data off has no effect
>>
>> In bluetoothctl, duplicate-data off sets filter.duplicate = false
>> (client/main.c:1449). In set_discovery_filter_setup()
>> (client/main.c:1251):
>>
>>   if (args->duplicate)    /* false -> DuplicateData is NOT sent */
>>       g_dbus_dict_append_entry(&dict, "DuplicateData", ...);
>>
>> Since false is the default, DuplicateData is never included in the
>> SetDiscoveryFilter call. The customer's duplicate-data off step has
>> no effect — the controller hardware duplicate filter remains enabled
>> throughout.
>>
>> Why RSSI delta=0 occurs
>>
>> The root cause is Transport=le on a dual-mode adapter
>> (src/adapter.c:85):
>>
>>   #define SCAN_TYPE_LE   ((1 << BDADDR_LE_PUBLIC) |
>>                           (1 << BDADDR_LE_RANDOM))  /* = 6 */
>>   #define SCAN_TYPE_DUAL (SCAN_TYPE_BREDR | SCAN_TYPE_LE) /* = 7 */
>>
>> get_scan_type(adapter) returns 7 (DUAL) since the adapter supports
>> both BR/EDR and LE. When Transport=le is set, filter->type = 6. In
>> merge_discovery_filters() (src/adapter.c:2254):
>>
>>   item->type == adapter_scan_type    /* 6 != 7 -> condition fails */
>>
>> This triggers has_filtered_discovery = true -> filtered_discovery =
>> true -> device_set_rssi_with_delta(dev, rssi, 0)
>> (src/adapter.c:7362). With delta_threshold=0, every advertisement
>> emits PropertiesChanged(RSSI) regardless of RSSI change.
>>
>> We have captured a bluetoothd debug log (QCS6490 board, BlueZ 5.72)
>> that directly confirms this sequence. The following lines are from
>> the log with the customer's exact scan sequence
>> (menu scan -> transport le -> duplicate-data off -> back -> scan le):
>>
>>   # SetDiscoveryFilter called with Transport=le only, no RSSI/pathloss
>>   adapter.c:parse_discovery_filter_dict() filtered discovery params:
>>       transport: 6  rssi: 32767  pathloss: 32767
>>       duplicate data: false  discoverable false  pattern (null)
>>
>>   # current_discovery_filter is non-NULL — confirms filtered_discovery
>>   # will be set to true in start_discovery_complete()
>>   adapter.c:start_discovery_timeout() adapter->current_discovery_filter == 1
>>
>>   # filtered_discovery=1 directly confirmed by our added debug print
>>   adapter.c:start_discovery_complete() filtered_discovery=1 (current_discovery_filter=set)
>>
>>   # delta_threshold=0 directly confirmed — every advertisement emits
>>   # PropertiesChanged(RSSI) regardless of whether RSSI changed
>>   device.c:device_set_rssi_with_delta() rssi=-86 delta_threshold=0
>>   device.c:device_set_rssi_with_delta() rssi=-79 delta_threshold=0
>>   device.c:device_set_rssi_with_delta() rssi=-72 delta_threshold=0
>>   ...
>>
>> The log shows delta_threshold=0 on every single call. With hundreds
>> of BLE devices advertising, this produces an unthrottled stream of
>> PropertiesChanged(RSSI) signals.
>>
>>
>>>
>>>>   scan le calls SetDiscoveryFilter({'Transport': 'le'}) — a transport-only filter with no RSSI or
>>>>   pathloss condition. In btd_adapter_device_found() (src/adapter.c):
>>>>
>>>>   if (adapter->filtered_discovery)
>>>>       device_set_rssi_with_delta(dev, rssi, 0);   /* delta forced to 0 */
>>>>   else
>>>>       device_set_rssi(dev, rssi);                  /* delta = RSSI_THRESHOLD = 8 */
>>>>
>>>>   filtered_discovery is set true whenever current_discovery_filter is non-NULL (adapter.c:1872), which
>>>>    happens for any SetDiscoveryFilter() call — including a transport-only filter. With
>>>>   delta_threshold=0, the condition delta < 0 is never true, so g_dbus_emit_property_changed("RSSI")
>>>>   fires on every BLE advertisement regardless of whether the RSSI value changed. With 280+ BLE devices
>>>>    advertising continuously, this produces ~95 PropertiesChanged(RSSI) signals per second that flood
>>>>   dbus-daemon.
>>>
>>> Yeah, that is what you get to set duplicate-data off, that said ~95
>>> PropertiesChanged per seconds in not a lot of data, perhaps you are
>>> hitting a process that don't consume the events immediately as it
>>> should then the D-Bus daemon have to queue more and more memory?
>>
>>
>> Actual signal rate from the captured log
>>
>> The log (30_Jun_2026/bluetooth.log.gz) shows duplicate data: true
>> with Transport=le. The device_found_callback distribution over 1200
>> active seconds is:
>>
>>     0-99  events/s :   69 seconds  (6%)
>>   100-199 events/s :  187 seconds (16%)
>>   200-299 events/s :   75 seconds  (6%)
>>   300+    events/s :  869 seconds (72%)  <- burst, peak 392/s
>>
>> The average is ~95/s but that conceals the burst pattern: 72% of the
>> time the rate exceeds 300/s. With 280+ BLE devices advertising,
>> delta=0 means every single device_found_callback unconditionally
>> emits a PropertiesChanged(RSSI) signal — including during bursts at
>> 392/s.
> 
> Are we talking about an embedded device here? How come it takes
> seconds to process hundreds of events, or is it simply running out of
> memory and lacking swap space? If this were a general problem we would
> have seen this before. Even with hundreds of devices in the vicinity,
> it never took this much time to process.
> 
Yes, this is QCS6490/QCS8300 — ARM64 automotive embedded platforms
(Snapdragon Ride). The following memory snapshots were captured from
the actual hung logs at the time bluetoothd stalled:

  btd_stuck_20260703 (ofono running, dbus-daemon at 457 MB):
    Mem:  7378 MB total,  5270 MB free,  5975 MB available
    Swap: 5404 MB total,     0 MB used
    PSI memory: avg10=0.00 avg60=0.00 avg300=0.00

  btd_stuck_20260707 (WirePlumber running, dbus-daemon at 357 MB):
    Mem:  7378 MB total,  3636 MB free,  4385 MB available
    Swap: 5404 MB total,     0 MB used
    PSI memory: avg10=0.00 avg60=0.00 avg300=0.00

In both cases PSI memory stall is zero and swap is unused. The system
had 3.5–5.9 GB of free RAM even while the hang was active. The
problem is a D-Bus socket backpressure cascade, not memory shortage


>> The actual bottleneck
>>
>> As you pointed out, ~95/s average may not seem large. The real
>> bottleneck is that WirePlumber and ofono both register a broad
>> path_namespace='/' match rule, causing dbus-daemon to route all
>> these signals to processes that immediately discard them
>> (message_filter() drops PropertiesChanged silently). Over 8 hours,
>> dbus-daemon's routing table grows to 357 MB, making routing
>> progressively slower until bluetoothd's socket fills and its
>> GMainLoop stalls.
> 
> That sounds like a process that is not dropping its messages; even if
> we generate fewer messages, it will eventually stop working because
> too many messages are cached or something similar.
> 
The full backpressure chain is:

  1. Transport=le-only filter triggers filtered_discovery=true and
     delta_threshold=0 in bluetoothd, producing an unthrottled
     PropertiesChanged(RSSI) stream (bursts up to 392/s).

  2. ofono's broad path_namespace='/' match rule causes dbus-daemon
     to route every signal to ofono. But ofono's signal_func is NULL
     (g_dbus_client_set_signal_watch() is never called), so
     message_filter() silently discards them — yet dbus-daemon still
     queues each message for delivery.

  3. Undelivered messages accumulate in dbus-daemon. After ~3 hours
     of scanning, dbus-daemon VmRSS reaches 457 MB.

  4. dbus-daemon, busy draining its write queue toward ofono, can no
     longer read from bluetoothd's socket promptly. bluetoothd's
     kernel send buffer fills up.

  5. bluetoothd's sendmsg() starts returning EAGAIN. strace on the
     hung bluetoothd shows this repeating pattern:

       sendmsg(7, {org.bluez.Device1 PropertiesChanged})
           = -1 EAGAIN (Resource temporarily unavailable)
       ppoll([{fd=7, events=POLLOUT}], 1, {tv_sec=0, tv_nsec=0})
           = 0 (Timeout)

     fd=7 never becomes writable. With POLLOUT registered on fd=7,
     bluetoothd's GMainLoop stalls and can no longer dispatch any
     D-Bus replies or signals — the daemon appears hung and
     unresponsive to commands including bluetoothctl.


>> How do you think the logic of bluez about delta_threshold = 0
>> when just Transport=le?
> 
> It sounds like another problem is at hand—not just too many signals
> but them not being consumed. Over time, this issue will recur if not
> fixed properly.

How do you think of these two fix? 

Fix 1 — subscriber side (this patch, Change 2):
    Remove the broad path_namespace='/' match rule from
    g_dbus_client_new_full(). This stops dbus-daemon from routing
    bluetoothd signals to ofono through that rule. Since signal_func
    is always NULL in ofono's usage, no functionality is lost.
    InterfacesAdded/InterfacesRemoved remain covered by the precise
    watches already registered. This directly breaks the backpressure
    chain regardless of signal volume.

  Fix 2 — signal generation side (BlueZ):
    Only apply delta_threshold=0 when the discovery filter contains
    an actual proximity condition (RSSI or pathloss). A transport-only
    filter (Transport=le, no RSSI/pathloss) should use the default
    delta (RSSI_THRESHOLD=8) rather than 0. We have an internal patch
    for this and can submit it upstream if appropriate.


I will send a v2 of the ofono patch containing only Change 2.

For Fix 2, should I submit the BlueZ delta_threshold fix as a
separate patch to linux-bluetooth?
