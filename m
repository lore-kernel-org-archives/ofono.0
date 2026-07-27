Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CF41F91D6
	for <ofono@lists.linux.dev>; Mon, 27 Jul 2026 07:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785137985; cv=none; b=L4hsDJYVO1fdD/8Bhhi09UkI9NPoTder5hTe0j4+uvNdIee+0xLCkr0wkE0wiAK5+wsJfNZqqz07Zdn0CtNyCILDzqRR3sqMDrrZzlmsrHsGaVAhDTHJ1olu4wHYFlwlI2pN+Ge6xiA0vhUFtE9G01mRk+F1K377t7TpjT1Y/Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785137985; c=relaxed/simple;
	bh=FjctYSiwNpZ6vkrc2W+NIz72nK5lyIBBpoAX4LvPRio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYZLMFpFp64M6fkAwhS6Re/Cmw5TJBcTDFo1sbIAN+n3tm+4x4GFI6vPLh/ThiXpI+eFJO67axxD/gq/1uR/G3M6iFUChA5XrGYw/jJFsm9bIFrD+6BZ+RUwPQgN9bF1iVMyFWlvpfF6kJ3yhwZKtRbt3WrMKAwq4nLvofSITDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bFsb7b3u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GuR0GoML; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bFsb7b3u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GuR0GoML"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R7SNKk2532920
	for <ofono@lists.linux.dev>; Mon, 27 Jul 2026 07:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ONUQDAIF2HAL+ap4QjpIIKTQQ4z2q5UfysZwVZK7fmA=; b=bFsb7b3uEgHrq+y0
	2ncTmvWla3eEdlnO65ceH0Q+COJc4xJrwqU6HYqFQ+7bW473wxYZGvDtTGAcSAF9
	cXIqIRAZ6nIHF80uFqxHIHg0lBSjQSc5R2dSP5MpSH4/6G3vBy0P1coV4tukDnVF
	Rb7uiASY9TPQw0+K+wy09NC1BTGp4syuSNEyUjbH70PQvQULW4NcLxqIuXl8MTyV
	BNt/U0blsqO8rDc4QQqS8yU8twbKlmcnXcFDq+ffhn6JW6ysCgUhbutYFyrxKLse
	OQwN0czXeTLEuWzr+RVyDla9fUmPeUA49sThhHvDW7Z83/64ApBZ8Aw71aCQ6TXz
	0YSblQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmpajmud4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Mon, 27 Jul 2026 07:39:42 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c12e43b98so30924401cf.1
        for <ofono@lists.linux.dev>; Mon, 27 Jul 2026 00:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785137981; x=1785742781; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ONUQDAIF2HAL+ap4QjpIIKTQQ4z2q5UfysZwVZK7fmA=;
        b=GuR0GoMLVELm/IZLtukDdXv5voix8dZ93CBeyGWmS+6bH0kZBdJAea/KfYYbd//QEN
         wWB+OOqkB2U/NLx2EsSuWS2ohssSNMW4KRJ5fxXJopq1wLRIbM3k84Ealqp9JOtxp3Ym
         bNmCANzQGXd5YZ5vpw1olutVckY2rWBAXmp1kQKJoUSVg2vxo4j1ldY9xSpLW6CdOTqV
         dQJgYZECzon8XjVKA0ahxCZ2h8RsmTagLn9gmDdii75D1xB9QVbwRmZ7kEXdbxtHHnZh
         rMq+shi9Kfu0I/ukYamROEMVbzpq2F6kW4EUfjfbiZF1o7wH1PEiIV2GHzmBEkct852V
         Uphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785137981; x=1785742781;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ONUQDAIF2HAL+ap4QjpIIKTQQ4z2q5UfysZwVZK7fmA=;
        b=nrBQBPOp2gG2npzIsJjMxqy/m9qnncOowzKqRuJ+dpQU4G4YJyVAqds5MpSABUjMew
         sCsgn0ehg1Tujl+HBrnr2tpq3Frzbrj4ghaahCsUj26SRD/gTnqVJlx1J6mfKFsZfv1Y
         95vqUD5+zeC4s1PPzt5c759G2m6i85cj4H1ve54K11Zd1rZod0oaDqOer/tAxAVHwU5w
         rTejfnY/P2EfnKI1l/o6OEfZeEFe5yceJaXFiC/hXQiNIgl0cYefqfkUV4rYWqE7bUlh
         KwKrTw00WJcpKcdltZaenZl3n7NUUu8h5CIj2QU+/ssJXUY2IeW6kTlSb/AzhDBQbBNA
         P8/Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq4oRfCztEB83g8TtpAQOmTDKpLqj2dhPzn1ymp9wFC8Xbd8Mf+jxsWrE1PjlWYCW/n3Q3hhA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqsmtQcGJ+QHLu+2H3Jnk3v1LD0Q4Dlvhq8iXryAZjUG8KtVN4
	EDa1cXYY8KHvsgANYcQUc2wZKAbgFgTaJHus/0ceQ+KwyrO+0hFxvls1PQH39JTSUnyOfXTYF6j
	0szUxRhPo7E8KMfxLwcDD4SAowI4JBqpOYNi+vY/OQBGhDidIa2Dq3csCMA==
X-Gm-Gg: AR+sD11G+H0+k9s5Tw8USoWNd4F2E3DtlHJA7edh87abiP9yP6Y0eS1L7vDx16LR0Th
	yvc0kqejLwX6F1ZTG3xiBHscPTQ91j/9M9p7iiHCynkRD8vl9HnCHGy+RCrjZojhZ1Iqaq51dyB
	0XQVWdijuj6ktG42myr4K1TM8mEeG/NDldcHhQ9CR+R0HdB0POS04hW9NWYKmvZ6bGWhvY61pKv
	cHZi3dmxElkXmSQAT9Pb+46W2aeapF5oTzPvge9rWt1mcxNKs9gyPKmW+u4einiJ3vPViJjEONo
	Kc10ssWokUeE7JhFmitvz//cuByHWQmjfmgZ3E2aoB/U/4mCDuMwZjlfRzRwwctVjRei/ohibm7
	FTGLmqPcYmTKXJ8YyYehvfoR2LtLt
X-Received: by 2002:ac8:7fca:0:b0:528:3163:716b with SMTP id d75a77b69052e-529a836ff54mr76097501cf.3.1785137981308;
        Mon, 27 Jul 2026 00:39:41 -0700 (PDT)
X-Received: by 2002:ac8:7fca:0:b0:528:3163:716b with SMTP id d75a77b69052e-529a836ff54mr76097271cf.3.1785137980675;
        Mon, 27 Jul 2026 00:39:40 -0700 (PDT)
Received: from [10.239.96.184] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529a29883d5sm48020051cf.14.2026.07.27.00.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 00:39:40 -0700 (PDT)
Message-ID: <9481041d-6fbf-4637-bffe-2f186ad88b84@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 15:39:34 +0800
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gdbus: Remove broad match rule and add proxy filter
 support
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: denkenz@gmail.com, ofono@lists.linux.dev, linux-bluetooth@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com
References: <20260715085950.4079331-1-xiuzhuo.shang@oss.qualcomm.com>
 <CABBYNZ+D8BhV_-3n+JV3715CAfZcsteAD14xyVmjpvrvwouo_g@mail.gmail.com>
Content-Language: en-US
From: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
In-Reply-To: <CABBYNZ+D8BhV_-3n+JV3715CAfZcsteAD14xyVmjpvrvwouo_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0LKGu3XIbV9oRh6s1EFwYIfmcUkMnaFd
X-Authority-Analysis: v=2.4 cv=A8Bc+aWG c=1 sm=1 tr=0 ts=6a670b3e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=nDwD0dW3nI0lGoHJ3HEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 0LKGu3XIbV9oRh6s1EFwYIfmcUkMnaFd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA3NSBTYWx0ZWRfX6vSV9GNDw0KD
 MWjv5oX8Xdglcrvb/dszOMK3X5FuGr/DX0LxEV5AsDTp1lg6I8CJF1LdS3YGaO+Q0OKLhp91eRg
 JWNpazrUKWzFvdYThInLx2FsjLnEhXWYtDsAvp7f7LB6N1U1nsBoK/S5F1Nywq3W5A+58ZtHXny
 hmRS4mDuR1oAWn3Yf0aSTcCwMo4Mc3oZmZNV2rbbIohgFUKmwDjYARg4QzywVRS+2X9z55Q6KEH
 gW9WcLHvoz1FOTYimUNRrQXtJ1vZ2h2jAIFGwlHwDIiB0euf1M2tk+KKv/t7UNqdCr38rkjqmqn
 zk4JEadnkcK0/KHHsOk0ggac6f/Rn9FdR2hvYU1J7NJaEVShuquiKksd3hgYIr+aTl30DPuxnsV
 vadTlaH1LRSAUIx66fu545GKJvE5VLLAffmZEShSE/KP8yYYajV3Lkkb2qrvREDvDtNtQthfvNd
 rn9/lYSbN0Ob3nKHMrA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA3NSBTYWx0ZWRfX5KN9GsBkjrcg
 7wy/bJejLn1oLJZqMIncK2EFMd+L4+jZsS7loc21RXJF1NzvjtBKcMV/igMJbTnUE39/lBpdstH
 iCVLXitRg9/dand3ihIAGINtrvidd50=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270075



On 7/21/2026 2:42 AM, Luiz Augusto von Dentz wrote:
> Hi Xiuzhuo,
> 
> On Wed, Jul 15, 2026 at 4:59 AM Xiuzhuo Shang
> <xiuzhuo.shang@oss.qualcomm.com> wrote:
>>
>> Problem
>> -------
>> On embedded platforms running continuous BLE scanning, bluetoothd
>> eventually stalls with its D-Bus socket to dbus-daemon full. strace
>> on a hung bluetoothd shows a repeating pattern:
>>
>>   sendmsg(7, {org.bluez.Device1 PropertiesChanged}, MSG_NOSIGNAL)
>>       = -1 EAGAIN (Resource temporarily unavailable)
>>   ppoll([{fd=7, events=POLLOUT}], 1, {tv_sec=0, tv_nsec=0}) = 0 (Timeout)
>>
>> fd=7 never becomes writable; bluetoothd's GMainLoop remains stuck
>> waiting for POLLOUT and cannot dispatch any further D-Bus events,
>> making the daemon appear hung and unresponsive to commands.
>>
>> The backpressure chain that causes this:
>>   1. BLE scanning generates high-rate PropertiesChanged(RSSI) signals
>>      (~400/s with typical BLE traffic).
>>   2. ofono's broad path_namespace='/' match rule causes dbus-daemon to
>>      route all these signals to ofono even though ofono has no use for
>>      BLE RSSI data.
>>   3. ofono's single-threaded GLib loop cannot consume them fast enough;
>>      undelivered messages accumulate inside dbus-daemon (457 MB
>>      observed after ~3 hours of scanning).
>>   4. dbus-daemon, busy draining its write queue toward ofono, stops
>>      reading from bluetoothd's socket in time; bluetoothd's kernel
>>      send buffer fills up and sendmsg() returns EAGAIN.
>>   5. With POLLOUT registered on fd=7, bluetoothd's GMainLoop stalls
>>      and can no longer send D-Bus replies or signals.
>>
>> Fix
>> ---
>> Three related changes:
>>
>> 1. Remove the broad type='signal',sender=<svc>,path_namespace=<path>
>>    match rule from g_dbus_client_new_full(). This rule was the sole
>>    feeder for the signal_func path in message_filter(). ofono never
>>    calls g_dbus_client_set_signal_watch() so signal_func is always
>>    NULL; the broad rule therefore served no purpose and caused
>>    dbus-daemon to route every bluetoothd signal to ofono.
>>
>> 2. Remove the now-empty match_rules GPtrArray infrastructure
>>    (field declaration, init, AddMatch loop, RemoveMatch loop, free).
>>    No match rules are added to this array any more.
>>
>> 3. Add a generic GDBusProxyFilterFunction callback and
>>    g_dbus_client_set_proxy_filter() API to GDBusClient. The filter
>>    is called from parse_properties() before proxy_new(), so a FALSE
>>    return prevents both proxy creation and per-device
>>    PropertiesChanged watch registration. This keeps all BlueZ-
>>    specific logic out of the gdbus layer.
>>
>>    Use this in hfp_hf_bluez5.c to skip Device1 proxies for BLE
>>    random-address devices: ofono only needs BR/EDR (AddressType=
>>    'public') devices for HFP/HSP. Skipping BLE proxies prevents
>>    dbus-daemon from registering per-device PropertiesChanged match
>>    rules for advertising peripherals and eliminates the remaining
>>    RSSI signal delivery to ofono.
> 
>> Together these changes prevent dbus-daemon from routing BLE
>> advertising signals to ofono, breaking the backpressure chain:
>> dbus-daemon memory stops growing, its write queue drains, and
>> bluetoothd's send buffer clears so that sendmsg() no longer returns
>> EAGAIN and the GMainLoop stall is resolved.
>>
>> Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
>> ---
>> Changes in v2:
>>  - Drop Change 1 (BLE address-type filter in parse_properties()) per
>>    review feedback; BlueZ-specific logic does not belong in the gdbus
>>    layer.
>>  - Add generic GDBusProxyFilterFunction callback and
>>    g_dbus_client_set_proxy_filter() API to GDBusClient. The filter is
>>    invoked before proxy_new() so a FALSE return prevents both proxy
>>    creation and per-device PropertiesChanged watch registration.
>>  - Use the new filter in hfp_hf_bluez5.c to skip Device1 proxies for
>>    BLE random-address devices, keeping all BlueZ-specific logic in the
>>    plugin as suggested.
>>  - Remove now-empty match_rules GPtrArray infrastructure (field,
>>    init, AddMatch loop, RemoveMatch loop, free) and unused variables.
>>  - Link to v1:
>>    https://lore.kernel.org/ofono/20260710075548.1072741-1-xiuzhuo.shang@oss.qualcomm.com/
>>
>>  gdbus/client.c          | 45 +++++++++++++++++++++--------------------
>>  gdbus/gdbus.h           |  8 ++++++++
>>  plugins/hfp_hf_bluez5.c | 38 ++++++++++++++++++++++++++++++++++
>>  3 files changed, 69 insertions(+), 22 deletions(-)
>>
>> diff --git a/gdbus/client.c b/gdbus/client.c
>> index 48711ae8..fa2e75c0 100644
>> --- a/gdbus/client.c
>> +++ b/gdbus/client.c
>> @@ -46,7 +46,6 @@ struct GDBusClient {
>>         guint watch;
>>         guint added_watch;
>>         guint removed_watch;
>> -       GPtrArray *match_rules;
>>         DBusPendingCall *pending_call;
>>         DBusPendingCall *get_objects_call;
>>         GDBusWatchFunction connect_func;
>> @@ -61,6 +60,8 @@ struct GDBusClient {
>>         GDBusClientFunction ready;
>>         void *ready_data;
>>         GDBusPropertyFunction property_changed;
>> +       GDBusProxyFilterFunction proxy_filter;
>> +       void *filter_user_data;
>>         void *user_data;
>>         GList *proxy_list;
>>  };
>> @@ -943,6 +944,14 @@ static void parse_properties(GDBusClient *client, const char *path,
>>                 return;
>>         }
>>
>> +       if (client->proxy_filter) {
>> +               DBusMessageIter copy = *iter;
>> +
>> +               if (!client->proxy_filter(client, path, interface,
>> +                                       &copy, client->filter_user_data))
>> +                       return;
>> +       }
>> +
>>         proxy = proxy_new(client, path, interface);
>>         if (proxy == NULL)
>>                 return;
>> @@ -1211,7 +1220,6 @@ GDBusClient *g_dbus_client_new_full(DBusConnection *connection,
>>                                                         const char *root_path)
>>  {
>>         GDBusClient *client;
>> -       unsigned int i;
>>
>>         if (!connection || !service)
>>                 return NULL;
>> @@ -1232,9 +1240,6 @@ GDBusClient *g_dbus_client_new_full(DBusConnection *connection,
>>         client->root_path = g_strdup(root_path);
>>         client->connected = FALSE;
>>
>> -       client->match_rules = g_ptr_array_sized_new(1);
>> -       g_ptr_array_set_free_func(client->match_rules, g_free);
>> -
>>         client->watch = g_dbus_add_service_watch(connection, service,
>>                                                 service_connect,
>>                                                 service_disconnect,
>> @@ -1255,14 +1260,6 @@ GDBusClient *g_dbus_client_new_full(DBusConnection *connection,
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
>>
>>         return g_dbus_client_ref(client);
>>  }
>> @@ -1279,8 +1276,6 @@ GDBusClient *g_dbus_client_ref(GDBusClient *client)
>>
>>  void g_dbus_client_unref(GDBusClient *client)
>>  {
>> -       unsigned int i;
>> -
>>         if (client == NULL)
>>                 return;
>>
>> @@ -1297,13 +1292,6 @@ void g_dbus_client_unref(GDBusClient *client)
>>                 dbus_pending_call_unref(client->get_objects_call);
>>         }
>>
>> -       for (i = 0; i < client->match_rules->len; i++) {
>> -               modify_match(client->dbus_conn, "RemoveMatch",
>> -                               g_ptr_array_index(client->match_rules, i));
>> -       }
>> -
>> -       g_ptr_array_free(client->match_rules, TRUE);
>> -
>>         dbus_connection_remove_filter(client->dbus_conn,
>>                                                 message_filter, client);
>>
>> @@ -1396,3 +1384,16 @@ gboolean g_dbus_client_set_proxy_handlers(GDBusClient *client,
>>
>>         return TRUE;
>>  }
>> +
>> +gboolean g_dbus_client_set_proxy_filter(GDBusClient *client,
>> +                                       GDBusProxyFilterFunction proxy_filter,
>> +                                       void *user_data)
>> +{
>> +       if (client == NULL)
>> +               return FALSE;
>> +
>> +       client->proxy_filter = proxy_filter;
>> +       client->filter_user_data = user_data;
>> +
>> +       return TRUE;
>> +}
>> diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
>> index d99c2549..cc3c4e16 100644
>> --- a/gdbus/gdbus.h
>> +++ b/gdbus/gdbus.h
>> @@ -347,6 +347,11 @@ typedef void (* GDBusClientFunction) (GDBusClient *client, void *user_data);
>>  typedef void (* GDBusProxyFunction) (GDBusProxy *proxy, void *user_data);
>>  typedef void (* GDBusPropertyFunction) (GDBusProxy *proxy, const char *name,
>>                                         DBusMessageIter *iter, void *user_data);
>> +typedef gboolean (* GDBusProxyFilterFunction) (GDBusClient *client,
>> +                                       const char *path,
>> +                                       const char *interface,
>> +                                       DBusMessageIter *iter,
>> +                                       void *user_data);
>>
>>  gboolean g_dbus_proxy_set_property_watch(GDBusProxy *proxy,
>>                         GDBusPropertyFunction function, void *user_data);
>> @@ -377,6 +382,9 @@ gboolean g_dbus_client_set_proxy_handlers(GDBusClient *client,
>>                                         GDBusProxyFunction proxy_removed,
>>                                         GDBusPropertyFunction property_changed,
>>                                         void *user_data);
>> +gboolean g_dbus_client_set_proxy_filter(GDBusClient *client,
>> +                                       GDBusProxyFilterFunction proxy_filter,
>> +                                       void *user_data);
>>
>>  #ifdef __cplusplus
>>  }
>> diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
>> index 5ad1674f..141dc5c4 100644
>> --- a/plugins/hfp_hf_bluez5.c
>> +++ b/plugins/hfp_hf_bluez5.c
>> @@ -791,6 +791,43 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
>>         device_changed(proxy, path);
>>  }
>>
>> +static gboolean proxy_filter(GDBusClient *client, const char *path,
>> +                               const char *interface, DBusMessageIter *iter,
>> +                               void *user_data)
>> +{
>> +       DBusMessageIter props, entry;
>> +
>> +       if (g_str_equal(BLUEZ_DEVICE_INTERFACE, interface) == FALSE)
>> +               return TRUE;
>> +
>> +       if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
>> +               return TRUE;
>> +
>> +       dbus_message_iter_recurse(iter, &props);
>> +
>> +       while (dbus_message_iter_get_arg_type(&props) == DBUS_TYPE_DICT_ENTRY) {
>> +               const char *key;
>> +
>> +               dbus_message_iter_recurse(&props, &entry);
>> +               dbus_message_iter_get_basic(&entry, &key);
>> +
>> +               if (g_str_equal(key, "AddressType") == TRUE) {
>> +                       DBusMessageIter var;
>> +                       const char *addr_type;
>> +
>> +                       dbus_message_iter_next(&entry);
>> +                       dbus_message_iter_recurse(&entry, &var);
>> +                       dbus_message_iter_get_basic(&var, &addr_type);
>> +
>> +                       return !g_str_equal(addr_type, "random");
>> +               }
>> +
>> +               dbus_message_iter_next(&props);
>> +       }
>> +
>> +       return TRUE;
>> +}
>> +
>>  static void property_changed(GDBusProxy *proxy, const char *name,
>>                                         DBusMessageIter *iter, void *user_data)
>>  {
>> @@ -844,6 +881,7 @@ static int hfp_init(void)
>>         g_dbus_client_set_connect_watch(bluez, connect_handler, NULL);
>>         g_dbus_client_set_proxy_handlers(bluez, proxy_added, NULL,
>>                                                 property_changed, NULL);
>> +       g_dbus_client_set_proxy_filter(bluez, proxy_filter, NULL);
> 
> I don't really follow; would this register a proxy filter and
> automatically remove it on the first match of an AddressType=random??
> Sounds not really useful to me, what is the difference if we don't use
> set_proxy_filter above?

Thank you for the review. Let me clarify how proxy_filter works.

The filter is a persistent callback registered on the GDBusClient
instance. It is called from parse_properties() for every device
object as it appears (via InterfacesAdded or GetManagedObjects).
Returning FALSE means "do not create a proxy for this specific
device" -- it does NOT remove or deregister the filter itself.

So the behaviour is:

  Device A (AddressType=random) -> proxy_filter called -> FALSE
                                -> proxy_new() skipped
  Device B (AddressType=random) -> proxy_filter called again -> FALSE
                                -> proxy_new() skipped
  Device C (AddressType=public) -> proxy_filter called -> TRUE
                                -> proxy created as normal

The filter stays registered for the lifetime of the GDBusClient and
is invoked once per device per interface, not just once globally.

Without set_proxy_filter:

  Every Device1 object, including BLE random-address devices, goes
  through proxy_new(). Each proxy registers a per-device
  PropertiesChanged watch via g_dbus_add_properties_watch(). In a
  dense BLE environment with 200-300 advertising peripherals, this
  results in 200-300 per-device match rules registered with
  dbus-daemon, which routes every RSSI PropertiesChanged signal for
  each of those devices to ofono. None of these signals are useful
  to ofono (it only needs BR/EDR devices for HFP/HSP), but the
  routing overhead causes dbus-daemon memory growth and eventually
  backpressures the bluetoothd socket.

With set_proxy_filter:

  BLE random-address devices are rejected before proxy_new() is
  called, so no per-device PropertiesChanged watch is registered for
  them. Only BR/EDR devices (AddressType='public') get proxies and
  watches, which is all ofono needs.

To summarise, the proxy_filter is not a one-shot mechanism; it
persistently gates every proxy creation for the lifetime of the
client. Without it, per-device watches accumulate for all BLE
peripherals in the vicinity, not just the first one encountered.

> 
>>
>>         ofono_handsfree_audio_ref();
>>
>> --
>> 2.43.0
>>
> 
> 

