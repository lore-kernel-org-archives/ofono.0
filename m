Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365DA37FF75
	for <ofono@lists.linux.dev>; Tue, 14 Jul 2026 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784027053; cv=none; b=V2Oqi/QwlwoTNzGUM0SK3/Qje5ug807fDCXbk/UxrGf0ZpNspyxOjyr81aiF6FsfJ5MdGsUT+L6GROjhKgzv2hHzYaaIN32Qs3m3dV82lbRilEELfc84sD6V3dOVao+YgEo6EEOc+WPMM8pZHzo2Ctwktc/MerWftx7bwRuK4ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784027053; c=relaxed/simple;
	bh=fXOOM1qe56iDKeKPka8Og9Rh+LTr7V1lMjRrihUBa8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rc43Fc+IgR2bJIrwRZ1DEDhDV4NKyWBSpFctGtL9/SbMouZCNt/glpM168dz4aOQkxxM+2d5rAZRGTvZgGMNgoLyGL7UZrg/ORyJbmwNsgdRDCXK/CehC7qf0fNYw4rGfWlQKBZvN3wHL1MY5QGAOKcK5VMTsegitYiesGTckzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yrl4ooMn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K8mfx84l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yrl4ooMn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K8mfx84l"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E6SO4H3625102
	for <ofono@lists.linux.dev>; Tue, 14 Jul 2026 11:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EZXdwRTyUFZDLxMOcUjuicbV4WoKXeLLJkSK3NJZ81U=; b=Yrl4ooMnd6yrjw4n
	L5B/1bbtZTGkR8+EuGUSVFNU/4P1rg81JhtPx631Kp2Qu4KYscDpDJCgZUqPPDEs
	U+0qdEw8dwM77p8joYFwllka3pc45LU9dDGHtGe3/tO3coqDbNvFXrJvkvTE80hF
	k9pzfcmiu3/kbkjI4DLMcmtGN4ycZrPpUv7rcIytZq3dyLzVcE/0dXvCxP5s00CY
	ENyF7viPb5mXXq1vBd1INENngHNW60KcwtnL+WdZxL7mTqZLfI8QFNKlLFHss68e
	FisGBjBgjw7mgmKah1KHwISpoPXCXDDXDL7gkzvEaH53CCxPGk4nIkKzRbNzvU0O
	Z+MI4g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdesa99cy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Tue, 14 Jul 2026 11:04:10 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e663c29f2so102144585a.0
        for <ofono@lists.linux.dev>; Tue, 14 Jul 2026 04:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784027049; x=1784631849; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EZXdwRTyUFZDLxMOcUjuicbV4WoKXeLLJkSK3NJZ81U=;
        b=K8mfx84lw/T5nr+uzGP84jUENUm0j85ZpmjDo3rZVMp4toip0y/b955Rq+9RbhFb0e
         Kej7Us3Zq3pxZqbCEdg4cy7P/wNE+I1mivLXqfXZi0FdLTNl1hFjiZ7IxaNnv/TBd6cE
         CHTc8nwScr5NIMZbXxhvLZdvqhww6sG1dpP0tnD2+z8gmcWVdE8R0OeUyNZoGEwgwgIN
         LCxhczx/KCrdOMsI6iIuMmlZ0gheuMl/AZDnXevx6wZKr3d/yj4kDoGCbC6X8BcHPv3M
         iPBp4TECoCJwvHHbxv+n+rMMJv3qhal3f3icratPJcj6RYerNgV1eCw4attsMChQsdCy
         +Ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784027049; x=1784631849;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EZXdwRTyUFZDLxMOcUjuicbV4WoKXeLLJkSK3NJZ81U=;
        b=HTq0Xex3sXNPY/PBXQrji2tAPeRlYMEv3ydPSvd6BZOnatY1UgPNSLsFtC0LYa54Gk
         U6wiodWLs92uJHaiUHSsh3q4zk0qxzzv80toFnGoLAncS/gCC7EVwzeyPy1C2bAGHmOc
         P3HgiuLC25r4gQPWjsf1S9FXZVrKCP88Rw8KglFGnufs9O0TdMCyJGjGLAIo6zrMgePm
         UQ9Kj9Rg7y+UBXeYL1UdX4D7+YfDkgb5UlaxsU9zrnaEy07svdEjSXW6f1QW7wPUqtwO
         2yB/5Nkj2F6ls09Q9OOyrbN/helEIhF3tBGSittad2SdfS96daZv2fXUE9woInlfsrPa
         kmhA==
X-Forwarded-Encrypted: i=1; AHgh+RrIxqkzQItmGR+5KEax60CDmcpINnuNdMuIbUHm8O8qihm3w74SyjRxoCJffWULO10rDmETVA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxBw3PRaj07+iuK9jV3UN5aJstC3CAWaEiE/659JTg53t8o6QWj
	9tLLUsnz88/0QC6csijEqL/9ZfudS6RrFcCNlIkzx3l4zVJjE5aDd47/GwYrYIIGObGjAEGiiRX
	fyxR93ZK84vOAbXJ9HgB+oYJ3C9qoaB6FaV5d3ex0ofdvaC0oq9/0gPnHeQ==
X-Gm-Gg: AfdE7cmhwl2wX+UWcQV6cPA6q5Ye520tvWpInvpemJ0bhShbbYiDMIh8hTNPaj6gPBG
	FM4ByN4jdlnbYE34sx1FbYq4a7tO2VcgDVO4yfIz/fQFlP3qytUFWrU65XqG8ZjKoRng2HN10FC
	uT3F1ubYiUeLa2gC81EpW/84EGcuVzreJz2APut5gwgzClF7UIja7RN3148kcEpe0jtioWP+u24
	EskYttkgsibU50czjLfPtJJw7AydnI4vnG7b0NRZuzIgFULOfJSFdSWshrJEH/mM5QsoTc8K+lo
	d6f342sXYB4qNf0W6WQo51UZ9BcpvCKtNm2PmAps4Gi8Y9D+/mbsMaYhTgHgL8hnyJsk8AaFNwJ
	Qm2EMi0L/7DMKjSRANkK+M+lgw5VXbVchhe8xeg==
X-Received: by 2002:a05:620a:44d4:b0:92e:e728:9d03 with SMTP id af79cd13be357-92ef3cc8072mr1181785885a.6.1784027048972;
        Tue, 14 Jul 2026 04:04:08 -0700 (PDT)
X-Received: by 2002:a05:620a:44d4:b0:92e:e728:9d03 with SMTP id af79cd13be357-92ef3cc8072mr1181778685a.6.1784027048104;
        Tue, 14 Jul 2026 04:04:08 -0700 (PDT)
Received: from [10.239.28.92] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b4920asm1377558185a.4.2026.07.14.04.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 04:04:07 -0700 (PDT)
Message-ID: <81ef5f5e-8be5-4736-9d48-d4b3f6611e44@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 19:04:01 +0800
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
Content-Language: en-US
From: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
In-Reply-To: <CABBYNZ+-ybGUPPtQ3xuwHfewt4w6C4CTf0cYXbo3AZ9+vqDGxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDExNSBTYWx0ZWRfXyCqBPtUx0781
 0RbO21mgvRa4IDHYdn/Bq+vi4iK9wmtMdZox1yWztX511ozsUj2OtHFkKEB+f/uBYPqbqpcxVpx
 sSrArHYND//cRT4d7kZqgcB7g8OAOfQ=
X-Proofpoint-GUID: E0aMY9PDKPgO2yQplP_2PLLHb9EIrzYP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDExNSBTYWx0ZWRfX8p5ltLFqKo5D
 MYHfSw2g0MmjBpPJrXCXOLS6aKoZ88L1Y+cStaiwejAAzFl8tlWd27e1GijX4ZrMWGjVctW9+Cr
 z8q71CqmqlIQrKOfKSpzY3v7329c41mMzVkUJUXBKXOW5hJHuLDfqGJD9EJmAAMnm77cORPVHeP
 hdYbIFau4uvnypuUOB5wrP26e7A3f7vzjQFua4xG0NL4ThEfoPB3DNhZtbx8DhHXjJI0kGOCCPh
 n9noZMQC6YWy7oR9idOlPcvcclKTz/zaRpJra0t6qsjWu/SPr7dHWTpyjygPvSPgfzNhlKlXvlk
 46zPbnxGQGUP2paPMsMLnq/dvrhkL6xOyANACa26Z2sPkQLljUPClNaaQ0mC9fPYQM0eSEyayzZ
 Tq5tQ7WuimpaICO4GSFyyCRb7aM1U23w/Ygm0u/T8f0XCO97ZCsMoQNFujsCpSyfbrAYwS7d/dx
 elj3rLGP+4aELOJOxcQ==
X-Authority-Analysis: v=2.4 cv=PZLPQChd c=1 sm=1 tr=0 ts=6a5617aa cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=PQfDPOl2sy-Uco5dPFsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: E0aMY9PDKPgO2yQplP_2PLLHb9EIrzYP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140115



On 7/13/2026 10:00 PM, Luiz Augusto von Dentz wrote:
> Hi Xiuzhuo,
> 
> On Mon, Jul 13, 2026 at 3:03 AM Xiuzhuo Shang
> <xiuzhuo.shang@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 7/10/2026 10:12 PM, Luiz Augusto von Dentz wrote:
>>> Hi Xiuzhuo,
>>>
>>> On Fri, Jul 10, 2026 at 3:55 AM Xiuzhuo Shang
>>> <xiuzhuo.shang@oss.qualcomm.com> wrote:
>>>>
>>>> Two related changes to reduce dbus-daemon load caused by high-rate
>>>> BLE advertising signals:
>>>>
>>>> 1. In parse_properties(), skip creating a GDBusProxy for Device1
>>>>    objects whose AddressType is 'random' (BLE-only devices). Each
>>>>    proxy registers a per-device PropertiesChanged watch via
>>>>    g_dbus_add_properties_watch(); with hundreds of BLE peripherals
>>>>    advertising simultaneously, this results in hundreds of match rules
>>>>    and dbus-daemon routing thousands of RSSI PropertiesChanged signals
>>>>    per second to ofono, none of which ofono processes. The
>>>>    AddressType property is available in the InterfacesAdded dict at
>>>>    the time parse_properties() is called, so the check is reliable
>>>>    and race-free.
>>>>
>>>>    BR/EDR devices (AddressType='public') are unaffected: their proxies
>>>>    are created as before, and the property_changed callback continues
>>>>    to receive Paired and ServicesResolved updates needed for HFP/HSP.
>>>>
>>>> 2. In g_dbus_client_new_full(), remove the broad
>>>>    type='signal',sender=<service>,path_namespace=<path> match rule.
>>>>    This rule was the sole feeder for the signal_func path in
>>>>    message_filter(). ofono never calls g_dbus_client_set_signal_watch()
>>>>    so signal_func is always NULL; the broad rule therefore served no
>>>>    purpose and caused dbus-daemon to route every bluetoothd signal
>>>>    (including all BLE PropertiesChanged) to ofono.
>>>>
>>>>    InterfacesAdded and InterfacesRemoved are already covered by the
>>>>    precise watches registered via g_dbus_add_signal_watch() earlier in
>>>>    g_dbus_client_new_full(), so no functionality is lost.
>>>
>>> Looks like this is on ofono though, why are you chaning the BlueZ side?
>>
>> Regarding your suggestion to move the BLE filter to hfp_hf_bluez5.c: filtering in proxy_added()
>> would only prevent ofono from processing BLE devices at the application level. The per-device
>> PropertiesChanged watch is registered inside proxy_new(), which is called before proxy_added(). So
>> dbus-daemon would still route all RSSI signals to the process — the D-Bus pressure problem would
>> remain unchanged.
>>
>> I will drop the change from the gdbus patch per your feedback
>>
>>>
>>>> Together these two changes prevent dbus-daemon from routing BLE
>>>> advertising PropertiesChanged signals to ofono entirely, eliminating
>>>> the dbus-daemon memory growth and bluetoothd socket backpressure seen
>>>> after hours of BLE scanning.
>>>>
>>>> Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
>>>> ---
>>>>  gdbus/client.c | 46 ++++++++++++++++++++++++++++++++++++++--------
>>>>  1 file changed, 38 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/gdbus/client.c b/gdbus/client.c
>>>> index 48711ae8..dd3c17f9 100644
>>>> --- a/gdbus/client.c
>>>> +++ b/gdbus/client.c
>>>> @@ -937,6 +937,44 @@ static void parse_properties(GDBusClient *client, const char *path,
>>>>         if (g_str_equal(interface, DBUS_INTERFACE_PROPERTIES) == TRUE)
>>>>                 return;
>>>>
>>>> +       /*
>>>> +        * Skip BLE devices (AddressType='random') to avoid registering a
>>>> +        * per-device PropertiesChanged watch for every advertising BLE
>>>> +        * peripheral. ofono only needs BR/EDR devices for HFP/HSP; the
>>>> +        * high-rate RSSI PropertiesChanged signals from BLE scanners cause
>>>> +        * dbus-daemon memory bloat and socket backpressure in bluetoothd.
>>>> +        *
>>>> +        * The AddressType property is present in the InterfacesAdded dict
>>>> +        * (iter) at this point, so it can be checked before proxy_new().
>>>> +        */
>>>> +       if (g_str_equal(interface, "org.bluez.Device1") == TRUE) {
>>>> +               DBusMessageIter props, entry;
>>>> +               DBusMessageIter copy = *iter;
>>>> +
>>>> +               if (dbus_message_iter_get_arg_type(&copy) == DBUS_TYPE_ARRAY) {
>>>> +                       dbus_message_iter_recurse(&copy, &props);
>>>> +                       while (dbus_message_iter_get_arg_type(&props) ==
>>>> +                                               DBUS_TYPE_DICT_ENTRY) {
>>>> +                               const char *key;
>>>> +                               dbus_message_iter_recurse(&props, &entry);
>>>> +                               dbus_message_iter_get_basic(&entry, &key);
>>>> +                               if (g_str_equal(key, "AddressType") == TRUE) {
>>>> +                                       DBusMessageIter var;
>>>> +                                       const char *addr_type;
>>>> +                                       dbus_message_iter_next(&entry);
>>>> +                                       dbus_message_iter_recurse(&entry, &var);
>>>> +                                       dbus_message_iter_get_basic(&var,
>>>> +                                                               &addr_type);
>>>> +                                       if (g_str_equal(addr_type,
>>>> +                                                       "random") == TRUE)
>>>> +                                               return;
>>>> +                                       break;
>>>> +                               }
>>>> +                               dbus_message_iter_next(&props);
>>>> +                       }
>>>> +               }
>>>> +       }
>>>
>>> Nack, not going to introduce BlueZ specific logic into gdbus like
>>> this. If we need to rate limit the RSSI notification then it means
>>> it's not suitable to be a property, but I believe we have a threshold
>>> logic in the likes of device_set_rssi_with_delta so perhaps we shall
>>> check why it is not working in your case.
>>
>> I investigated why device_set_rssi_with_delta is not working in our case.
>>
>> Root cause in BlueZ
>>
>>   The customer scans with the following bluetoothctl sequence:
>>
>>   menu scan → transport le → duplicate-data off → back → scan le
> 
> Ok, that is 1 not the default behavior and 2 if they are setting
> duplicate-data off that means they want to see all advertisements, so
> this is working as intended.

Hi Luiz,

Thank you for the clarification. I need to correct some points
regarding duplicate-data off and the actual signal rate.

What DuplicateData does in BlueZ vs. the controller

BlueZ's DuplicateData parameter in SetDiscoveryFilter and the
controller's hardware duplicate filter are two independent mechanisms:

- The controller hardware duplicate filter (filter_dup in
  hci_le_set_scan_enable) is controlled by the kernel (hci_sync.c),
  defaulting to LE_SCAN_FILTER_DUP_ENABLE. It is only disabled for
  specific cases (AdvMonitor, Mesh, or
  HCI_QUIRK_STRICT_DUPLICATE_FILTER).
  SetDiscoveryFilter.DuplicateData does NOT directly control this.

- BlueZ's DuplicateData=true flag (parse_duplicate_data() in
  src/adapter.c:2680) controls only whether device EIR data
  (manufacturer data, service data) is updated on duplicate
  advertisements at the application layer
  (device_set_manufacturer_data(), device_set_service_data(),
  src/adapter.c:7392).

duplicate-data off has no effect

In bluetoothctl, duplicate-data off sets filter.duplicate = false
(client/main.c:1449). In set_discovery_filter_setup()
(client/main.c:1251):

  if (args->duplicate)    /* false -> DuplicateData is NOT sent */
      g_dbus_dict_append_entry(&dict, "DuplicateData", ...);

Since false is the default, DuplicateData is never included in the
SetDiscoveryFilter call. The customer's duplicate-data off step has
no effect — the controller hardware duplicate filter remains enabled
throughout.

Why RSSI delta=0 occurs

The root cause is Transport=le on a dual-mode adapter
(src/adapter.c:85):

  #define SCAN_TYPE_LE   ((1 << BDADDR_LE_PUBLIC) |
                          (1 << BDADDR_LE_RANDOM))  /* = 6 */
  #define SCAN_TYPE_DUAL (SCAN_TYPE_BREDR | SCAN_TYPE_LE) /* = 7 */

get_scan_type(adapter) returns 7 (DUAL) since the adapter supports
both BR/EDR and LE. When Transport=le is set, filter->type = 6. In
merge_discovery_filters() (src/adapter.c:2254):

  item->type == adapter_scan_type    /* 6 != 7 -> condition fails */

This triggers has_filtered_discovery = true -> filtered_discovery =
true -> device_set_rssi_with_delta(dev, rssi, 0)
(src/adapter.c:7362). With delta_threshold=0, every advertisement
emits PropertiesChanged(RSSI) regardless of RSSI change.

We have captured a bluetoothd debug log (QCS6490 board, BlueZ 5.72)
that directly confirms this sequence. The following lines are from
the log with the customer's exact scan sequence
(menu scan -> transport le -> duplicate-data off -> back -> scan le):

  # SetDiscoveryFilter called with Transport=le only, no RSSI/pathloss
  adapter.c:parse_discovery_filter_dict() filtered discovery params:
      transport: 6  rssi: 32767  pathloss: 32767
      duplicate data: false  discoverable false  pattern (null)

  # current_discovery_filter is non-NULL — confirms filtered_discovery
  # will be set to true in start_discovery_complete()
  adapter.c:start_discovery_timeout() adapter->current_discovery_filter == 1

  # filtered_discovery=1 directly confirmed by our added debug print
  adapter.c:start_discovery_complete() filtered_discovery=1 (current_discovery_filter=set)

  # delta_threshold=0 directly confirmed — every advertisement emits
  # PropertiesChanged(RSSI) regardless of whether RSSI changed
  device.c:device_set_rssi_with_delta() rssi=-86 delta_threshold=0
  device.c:device_set_rssi_with_delta() rssi=-79 delta_threshold=0
  device.c:device_set_rssi_with_delta() rssi=-72 delta_threshold=0
  ...

The log shows delta_threshold=0 on every single call. With hundreds
of BLE devices advertising, this produces an unthrottled stream of
PropertiesChanged(RSSI) signals.


> 
>>   scan le calls SetDiscoveryFilter({'Transport': 'le'}) — a transport-only filter with no RSSI or
>>   pathloss condition. In btd_adapter_device_found() (src/adapter.c):
>>
>>   if (adapter->filtered_discovery)
>>       device_set_rssi_with_delta(dev, rssi, 0);   /* delta forced to 0 */
>>   else
>>       device_set_rssi(dev, rssi);                  /* delta = RSSI_THRESHOLD = 8 */
>>
>>   filtered_discovery is set true whenever current_discovery_filter is non-NULL (adapter.c:1872), which
>>    happens for any SetDiscoveryFilter() call — including a transport-only filter. With
>>   delta_threshold=0, the condition delta < 0 is never true, so g_dbus_emit_property_changed("RSSI")
>>   fires on every BLE advertisement regardless of whether the RSSI value changed. With 280+ BLE devices
>>    advertising continuously, this produces ~95 PropertiesChanged(RSSI) signals per second that flood
>>   dbus-daemon.
> 
> Yeah, that is what you get to set duplicate-data off, that said ~95
> PropertiesChanged per seconds in not a lot of data, perhaps you are
> hitting a process that don't consume the events immediately as it
> should then the D-Bus daemon have to queue more and more memory?


Actual signal rate from the captured log

The log (30_Jun_2026/bluetooth.log.gz) shows duplicate data: true
with Transport=le. The device_found_callback distribution over 1200
active seconds is:

    0-99  events/s :   69 seconds  (6%)
  100-199 events/s :  187 seconds (16%)
  200-299 events/s :   75 seconds  (6%)
  300+    events/s :  869 seconds (72%)  <- burst, peak 392/s

The average is ~95/s but that conceals the burst pattern: 72% of the
time the rate exceeds 300/s. With 280+ BLE devices advertising,
delta=0 means every single device_found_callback unconditionally
emits a PropertiesChanged(RSSI) signal — including during bursts at
392/s.

The actual bottleneck

As you pointed out, ~95/s average may not seem large. The real
bottleneck is that WirePlumber and ofono both register a broad
path_namespace='/' match rule, causing dbus-daemon to route all
these signals to processes that immediately discard them
(message_filter() drops PropertiesChanged silently). Over 8 hours,
dbus-daemon's routing table grows to 357 MB, making routing 
progressively slower until bluetoothd's socket fills and its 
GMainLoop stalls.

How do you think the logic of bluez about delta_threshold = 0 
when just Transport=le?

> 
>>   The delta=0 path was presumably intended for clients that set RSSI/pathloss proximity filters, so
>>   that is_filter_match() gets precise RSSI tracking. A transport-only filter does not involve any
>>   proximity condition, so forcing delta=0 is unnecessary in that case.
>>
>> Proposed BlueZ fix direction
>>
>>   Only apply delta=0 when at least one active client filter has a real proximity condition (RSSI or
>>   pathloss):
>>
>>   static bool discovery_filter_has_proximity(struct btd_adapter *adapter)
>>   {
>>       GSList *l;
>>       for (l = adapter->discovery_list; l; l = g_slist_next(l)) {
>>           struct discovery_client *client = l->data;
>>           struct discovery_filter *item = client->discovery_filter;
>>           if (item && (item->rssi != DISTANCE_VAL_INVALID ||
>>                        item->pathloss != DISTANCE_VAL_INVALID))
>>               return true;
>>       }
>>       return false;
>>   }
> 
> Duplicate data does consider RSSI as well, so the real problem seems
> to be why disabling duplicate filtering is required since that is what
> causes the RSSI threshold logic not to be used. Or perhaps you don't
> trust your controller to do duplicate filtering. If so, we've gone
> full circle because if something causes too much spamming, it's also
> bad at the HCI driver, into the mgmt interface, etc, until it reaches
> D-Bus, which is why BlueZ defaults to duplicate filtering.
> 
>>   /* in btd_adapter_device_found() */
>>   if (adapter->filtered_discovery &&
>>       discovery_filter_has_proximity(adapter))
>>       device_set_rssi_with_delta(dev, rssi, 0);
>>   else
>>       device_set_rssi(dev, rssi);
>>
>>   Could you advise whether this is the right approach, or if there is a better place to fix this?
>>
>>   then I will Submit a separate BlueZ patch for the delta=0 fix once we agree on the approach.
>>
>>>
>>>>         proxy = proxy_lookup(client, path, interface);
>>>>         if (proxy) {
>>>>                 update_properties(proxy, iter, FALSE);
>>>> @@ -1255,14 +1293,6 @@ GDBusClient *g_dbus_client_new_full(DBusConnection *connection,
>>>>                                                 "InterfacesRemoved",
>>>>                                                 interfaces_removed,
>>>>                                                 client, NULL);
>>>> -       g_ptr_array_add(client->match_rules, g_strdup_printf("type='signal',"
>>>> -                               "sender='%s',path_namespace='%s'",
>>>> -                               client->service_name, client->base_path));
>>>> -
>>>> -       for (i = 0; i < client->match_rules->len; i++) {
>>>> -               modify_match(client->dbus_conn, "AddMatch",
>>>> -                               g_ptr_array_index(client->match_rules, i));
>>>> -       }
>>>
>>> This perhaps has a merit, but I can't recall what this watch was for.
>>> Is it matching every signal from the sender? It seems it was introduce
>>> before the watch infra existed, so if we can safely remove it we can
>>> perhaps remove the whole client-->match_rules.
>>>
>>>>         return g_dbus_client_ref(client);
>>>>  }
>>>> --
>>>> 2.43.0
>>>>
>>>
>>>
>>
> 
> 

