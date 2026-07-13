Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348372D9ECD
	for <ofono@lists.linux.dev>; Mon, 13 Jul 2026 06:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783922616; cv=none; b=Aj22Fxphw1QUwAMEpjvBeQF4M179CEJReifOTco6lqW7a8HSYK812UH0178y4mJmT80E8tA4Zx8/XGpWrRGdrmcceOCK4sYLpEISUiNEDECZ79epfzf4MNWgZveGHqlUjWWsav646HQjz22y7sBZ7/Ucgu60GMbEF3O9UWF0feg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783922616; c=relaxed/simple;
	bh=bhunzRmgtvpRKkSAdFlBj2YT82SgunjBbyZXy9Eawls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWlXDb2RFGtiV8IXHw/J7123MRtWTyjc/PwohtFM4FQf62HgqSx8LOqiAJ5JmRVC+n/hPgk0fX16mmZi2zCC7FoNtW7/l9TBHjTde2TMeg7cWe0LHft8b4XPfK/NLqh7blprhNgoHmtxsauFOeOPbKk9ByDiJUF6eilk0ypLHvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B9jmG0Gp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YYazp7KZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B9jmG0Gp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YYazp7KZ"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D3A6WG216982
	for <ofono@lists.linux.dev>; Mon, 13 Jul 2026 06:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JxV1ex9gWO41TXoa5YnMeT+gzioLYckXw3TY+laatYM=; b=B9jmG0GpS9QS3gxv
	5UuDr4Dx+ZK2G0IprBuhpsQTpw8jhfwyBHrU9l5I3NulYzDdyGvhO8G9QBu4f6F9
	GKzIQGlAz+TAeDcxOrFgKKj2cWjkHoM/0my/QRoctnoLjTen2AWrVc37Wi7QEYdp
	DGcsIKqpfV2gsl3gLmkC6WL/x4MDz5xr3od3bEgRHY8XQ7lKtUJcYtSdD6BTXcgk
	M0A1IMJ82QYEk/wRW9UHayTFE392QVg9Zwdh8PqU3xbpWjNpUTSn7zQQ+SnrzZ54
	tkDlCVoa+FoCvxcR6oddhmWT6c2lQwbAS5G9CyRrI1O34NIRCWzV347HrfavThHp
	Oej74A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbebr4gc3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Mon, 13 Jul 2026 06:03:34 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84a251c2e3eso1126408b3a.1
        for <ofono@lists.linux.dev>; Sun, 12 Jul 2026 23:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783922614; x=1784527414; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JxV1ex9gWO41TXoa5YnMeT+gzioLYckXw3TY+laatYM=;
        b=YYazp7KZeQFo/TUspb+ugjmWmBQzcFKZApuaKjQES+wXAgoP37tDQXK/Olz+5Knuoe
         48NRMW7ZNsAz5MrrcVV4Nih1o/HUtxAaTLchioSho663jDPx2jNVuZ4ZVd07O4korsyQ
         P3BcqemzicCX95/76AqttU/nMk8abtHc27V5mzJGttEs+a9YzoBNUz+eecoESYZMwlRx
         0Cl4loZJCIwpaZsELxV7iCQrJfvru8AWif7GtYnPmlIycRkeZOopai19CWQLL/M8K+yN
         DhbPx7t+M0t+SKyRY14Fqbao2q39p3ZtjSea7l75JIo5+S+KUJyA+C08xOE0wlbGfmJt
         jh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783922614; x=1784527414;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JxV1ex9gWO41TXoa5YnMeT+gzioLYckXw3TY+laatYM=;
        b=gH0q564ZDXpsw3+wi09igNteeOSiFsthm8M8p9xFpVMeuewgeSrJIYplr8c/0obIcW
         1o53Pz3u635rK5FMJ+ilPDYZDAxnuvU/DqDgbHF2wcX3MirzKdbU0tRO6IQqGFIRJKKA
         LDNylYtR2VLAHisGbxKkEBJEPNHBaw5VpTsz30EnE9HtBO4tQg3AIfJyH/CRBSwY+KwP
         tkfyM/wNDrRP2dUEM06aRqwO+KP5aFt/aOMo926fp3P0vzCtg2JWNh5Kb2Cpheb8BABd
         ppwJIautQ/xkN8F+UtbYg76cvnoz/SBzZ3MZrIVv9Ubjz5hR92Pwp6TdiJmFQgcW2r1u
         koOA==
X-Forwarded-Encrypted: i=1; AHgh+Roa/wu5SSr5EMsZdGraX0VjxE2r5KSvRwZ8W+VOg2YS4yG6rl4UWgkHVKfLDzmb3VuN8jmTwg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/Iea/Js2rgriTn69hX11ItVxmZ5KWZBbSpvBY3MNTB6FLgVse
	7BLo8E8AAunMitBC8HBtNzBzM9Wxgu+RnOauz/Dlm+h3C+w1fNAxYhJ4F9jpif7fgEOTigAYcVU
	pd84s1LB318s4tMTsPSN4vd4bsmAaYbx0RV+xUYRRRU3WauXHQua+Y8aweg==
X-Gm-Gg: AfdE7cn+JGRxolddW57PA8lx+ar8W03oeL2QpnocVL/DUTovqdtTCvthbczr3Zn3uVU
	NBB98Bbbq0g1XT7MBugJvcMHA8i0CiWz+/894YV2f6FChLFyidpNehPurEDt9c7eedSwElrZ/A2
	VfjLAaucc/qdrJlw9wpW+Rti2DxKRW+1kBw1OjHflKbLT1DVsB0gPViE0vN3VkZ7iiyrJny2bsk
	9U/poFi6NA9gVo2EmuuOQe6vje+mnFBeJhqc/aXsnrSs3CtAq2LVrbRJES9riS0OEF9lk7Ek7hp
	ms8fkRmk4PCXwNqteQqRFMQxhR9ij0YId3M3u1i2vexsKzIbtWRhpvwDPrU3xPaChkENHcY36RH
	ypvEkwgc40hSpLfOJI1DlfFlfBmmeJCvSTRjDmQMw
X-Received: by 2002:a05:6a00:2d03:b0:82f:684a:84ea with SMTP id d2e1a72fcca58-8488abb3803mr6486613b3a.13.1783922613607;
        Sun, 12 Jul 2026 23:03:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d03:b0:82f:684a:84ea with SMTP id d2e1a72fcca58-8488abb3803mr6486593b3a.13.1783922613065;
        Sun, 12 Jul 2026 23:03:33 -0700 (PDT)
Received: from [10.239.28.244] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84887f27c26sm3201573b3a.28.2026.07.12.23.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 23:03:32 -0700 (PDT)
Message-ID: <0b6a3ae6-d8a8-409d-844b-be4be14917d3@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 14:03:26 +0800
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
Content-Language: en-US
From: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
In-Reply-To: <CABBYNZJrrQO5XU1yC-HOry1eEaF8fBKV_jK4g3A+qJTAtw0Qqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA2MCBTYWx0ZWRfX+HcFcQn25x9A
 dTHPJC+Nm8IROfCYyzBfxIzQec1mZ4GLQOaJqdHjpxNt6EhjoLQDD3hfQ4Vi59IuE3koJBJvtHm
 wS2oGxfY6kd15vJV/bZQ5EllUqEPRIc=
X-Authority-Analysis: v=2.4 cv=OK8XGyaB c=1 sm=1 tr=0 ts=6a547fb6 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=FjlVpDxWKAdULvZDhs8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: juXEJk3m0FsD22qgMwfbaVaf6D47LFNH
X-Proofpoint-ORIG-GUID: juXEJk3m0FsD22qgMwfbaVaf6D47LFNH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA2MCBTYWx0ZWRfX7jPUBYUFxP03
 E5toB9mRIUdKfSHOKCzy/AyycjoNRgTqi/MCpDfYJ0JdMH5nHECeWYGJFSDYTZ802NUPOsstBBN
 3PHuLREy4X1a2q7qiWmlFC4eXQrAFZs5eMEQQ4Gz9VdF9ZxcGUT/apRsGaAHJDObhAFY6rz9GIE
 ccirkWQ480hkjotFIIyYRrJihVqtH+M1ieDwJKsdEaKVGoY0p1wN/ioK/jotWSGYKmOblnoDJZA
 7wq51tTXiU7YGnHKs2WTwdn7gy45liG0eGn4RTven1O2Vck/hDKCOwIhx69PME2N7pJ4nrFlbGF
 9gmuBFYjvvMau1BelYRcx0wNODXlakuU+Ub4ALxEk/YObvek/F/4CQLyr8XOsU/sbgqk+NjhXwN
 zCKnZ3ZRvrGBaTTnFRF8P6OpUW/Px69NJ0jK5NAHSioZ8xJFfLkuMKAvhD+MOI/szcdt12AZH5l
 Jqjl86sLcNH8kaC8U8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130060



On 7/10/2026 10:12 PM, Luiz Augusto von Dentz wrote:
> Hi Xiuzhuo,
> 
> On Fri, Jul 10, 2026 at 3:55 AM Xiuzhuo Shang
> <xiuzhuo.shang@oss.qualcomm.com> wrote:
>>
>> Two related changes to reduce dbus-daemon load caused by high-rate
>> BLE advertising signals:
>>
>> 1. In parse_properties(), skip creating a GDBusProxy for Device1
>>    objects whose AddressType is 'random' (BLE-only devices). Each
>>    proxy registers a per-device PropertiesChanged watch via
>>    g_dbus_add_properties_watch(); with hundreds of BLE peripherals
>>    advertising simultaneously, this results in hundreds of match rules
>>    and dbus-daemon routing thousands of RSSI PropertiesChanged signals
>>    per second to ofono, none of which ofono processes. The
>>    AddressType property is available in the InterfacesAdded dict at
>>    the time parse_properties() is called, so the check is reliable
>>    and race-free.
>>
>>    BR/EDR devices (AddressType='public') are unaffected: their proxies
>>    are created as before, and the property_changed callback continues
>>    to receive Paired and ServicesResolved updates needed for HFP/HSP.
>>
>> 2. In g_dbus_client_new_full(), remove the broad
>>    type='signal',sender=<service>,path_namespace=<path> match rule.
>>    This rule was the sole feeder for the signal_func path in
>>    message_filter(). ofono never calls g_dbus_client_set_signal_watch()
>>    so signal_func is always NULL; the broad rule therefore served no
>>    purpose and caused dbus-daemon to route every bluetoothd signal
>>    (including all BLE PropertiesChanged) to ofono.
>>
>>    InterfacesAdded and InterfacesRemoved are already covered by the
>>    precise watches registered via g_dbus_add_signal_watch() earlier in
>>    g_dbus_client_new_full(), so no functionality is lost.
> 
> Looks like this is on ofono though, why are you chaning the BlueZ side?

Regarding your suggestion to move the BLE filter to hfp_hf_bluez5.c: filtering in proxy_added()
would only prevent ofono from processing BLE devices at the application level. The per-device
PropertiesChanged watch is registered inside proxy_new(), which is called before proxy_added(). So
dbus-daemon would still route all RSSI signals to the process — the D-Bus pressure problem would
remain unchanged.

I will drop the change from the gdbus patch per your feedback

> 
>> Together these two changes prevent dbus-daemon from routing BLE
>> advertising PropertiesChanged signals to ofono entirely, eliminating
>> the dbus-daemon memory growth and bluetoothd socket backpressure seen
>> after hours of BLE scanning.
>>
>> Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
>> ---
>>  gdbus/client.c | 46 ++++++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 38 insertions(+), 8 deletions(-)
>>
>> diff --git a/gdbus/client.c b/gdbus/client.c
>> index 48711ae8..dd3c17f9 100644
>> --- a/gdbus/client.c
>> +++ b/gdbus/client.c
>> @@ -937,6 +937,44 @@ static void parse_properties(GDBusClient *client, const char *path,
>>         if (g_str_equal(interface, DBUS_INTERFACE_PROPERTIES) == TRUE)
>>                 return;
>>
>> +       /*
>> +        * Skip BLE devices (AddressType='random') to avoid registering a
>> +        * per-device PropertiesChanged watch for every advertising BLE
>> +        * peripheral. ofono only needs BR/EDR devices for HFP/HSP; the
>> +        * high-rate RSSI PropertiesChanged signals from BLE scanners cause
>> +        * dbus-daemon memory bloat and socket backpressure in bluetoothd.
>> +        *
>> +        * The AddressType property is present in the InterfacesAdded dict
>> +        * (iter) at this point, so it can be checked before proxy_new().
>> +        */
>> +       if (g_str_equal(interface, "org.bluez.Device1") == TRUE) {
>> +               DBusMessageIter props, entry;
>> +               DBusMessageIter copy = *iter;
>> +
>> +               if (dbus_message_iter_get_arg_type(&copy) == DBUS_TYPE_ARRAY) {
>> +                       dbus_message_iter_recurse(&copy, &props);
>> +                       while (dbus_message_iter_get_arg_type(&props) ==
>> +                                               DBUS_TYPE_DICT_ENTRY) {
>> +                               const char *key;
>> +                               dbus_message_iter_recurse(&props, &entry);
>> +                               dbus_message_iter_get_basic(&entry, &key);
>> +                               if (g_str_equal(key, "AddressType") == TRUE) {
>> +                                       DBusMessageIter var;
>> +                                       const char *addr_type;
>> +                                       dbus_message_iter_next(&entry);
>> +                                       dbus_message_iter_recurse(&entry, &var);
>> +                                       dbus_message_iter_get_basic(&var,
>> +                                                               &addr_type);
>> +                                       if (g_str_equal(addr_type,
>> +                                                       "random") == TRUE)
>> +                                               return;
>> +                                       break;
>> +                               }
>> +                               dbus_message_iter_next(&props);
>> +                       }
>> +               }
>> +       }
> 
> Nack, not going to introduce BlueZ specific logic into gdbus like
> this. If we need to rate limit the RSSI notification then it means
> it's not suitable to be a property, but I believe we have a threshold
> logic in the likes of device_set_rssi_with_delta so perhaps we shall
> check why it is not working in your case.

I investigated why device_set_rssi_with_delta is not working in our case.

Root cause in BlueZ                                                                                 
                                                                                                      
  The customer scans with the following bluetoothctl sequence:                                        
                                                                                                      
  menu scan → transport le → duplicate-data off → back → scan le                                      
                                                                                                      
  scan le calls SetDiscoveryFilter({'Transport': 'le'}) — a transport-only filter with no RSSI or     
  pathloss condition. In btd_adapter_device_found() (src/adapter.c):                                  
                                                                                                      
  if (adapter->filtered_discovery)                                                                    
      device_set_rssi_with_delta(dev, rssi, 0);   /* delta forced to 0 */                             
  else                                                                                                
      device_set_rssi(dev, rssi);                  /* delta = RSSI_THRESHOLD = 8 */                   
                                                                                                      
  filtered_discovery is set true whenever current_discovery_filter is non-NULL (adapter.c:1872), which
   happens for any SetDiscoveryFilter() call — including a transport-only filter. With                
  delta_threshold=0, the condition delta < 0 is never true, so g_dbus_emit_property_changed("RSSI")   
  fires on every BLE advertisement regardless of whether the RSSI value changed. With 280+ BLE devices
   advertising continuously, this produces ~95 PropertiesChanged(RSSI) signals per second that flood  
  dbus-daemon.                                                                                        
                                                                                                      
  The delta=0 path was presumably intended for clients that set RSSI/pathloss proximity filters, so   
  that is_filter_match() gets precise RSSI tracking. A transport-only filter does not involve any     
  proximity condition, so forcing delta=0 is unnecessary in that case.                                
                                                                                                      
Proposed BlueZ fix direction    

  Only apply delta=0 when at least one active client filter has a real proximity condition (RSSI or   
  pathloss):                                                                                          
                                                                                                      
  static bool discovery_filter_has_proximity(struct btd_adapter *adapter)                             
  {                                                                                                   
      GSList *l;                                                                                      
      for (l = adapter->discovery_list; l; l = g_slist_next(l)) {                                     
          struct discovery_client *client = l->data;                                                  
          struct discovery_filter *item = client->discovery_filter;                                   
          if (item && (item->rssi != DISTANCE_VAL_INVALID ||
                       item->pathloss != DISTANCE_VAL_INVALID))
              return true;                          
      }
      return false;                                 
  }

  /* in btd_adapter_device_found() */               
  if (adapter->filtered_discovery &&
      discovery_filter_has_proximity(adapter))
      device_set_rssi_with_delta(dev, rssi, 0);
  else                                              
      device_set_rssi(dev, rssi);

  Could you advise whether this is the right approach, or if there is a better place to fix this?

  then I will Submit a separate BlueZ patch for the delta=0 fix once we agree on the approach.

> 
>>         proxy = proxy_lookup(client, path, interface);
>>         if (proxy) {
>>                 update_properties(proxy, iter, FALSE);
>> @@ -1255,14 +1293,6 @@ GDBusClient *g_dbus_client_new_full(DBusConnection *connection,
>>                                                 "InterfacesRemoved",
>>                                                 interfaces_removed,
>>                                                 client, NULL);
>> -       g_ptr_array_add(client->match_rules, g_strdup_printf("type='signal',"
>> -                               "sender='%s',path_namespace='%s'",
>> -                               client->service_name, client->base_path));
>> -
>> -       for (i = 0; i < client->match_rules->len; i++) {
>> -               modify_match(client->dbus_conn, "AddMatch",
>> -                               g_ptr_array_index(client->match_rules, i));
>> -       }
> 
> This perhaps has a merit, but I can't recall what this watch was for.
> Is it matching every signal from the sender? It seems it was introduce
> before the watch infra existed, so if we can safely remove it we can
> perhaps remove the whole client-->match_rules.
> 
>>         return g_dbus_client_ref(client);
>>  }
>> --
>> 2.43.0
>>
> 
> 

