Content-Type: multipart/mixed; boundary="===============1801574194323490835=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: Re: Failed to reconnect after 4G LTE signaling strength level is back
Date: Mon, 30 Nov 2020 09:49:16 +0100
Message-ID: <22165064-45d2-6542-f014-47b8a33b9c4a@kerlink.fr>
In-Reply-To: <246d8a1a-6be0-6f13-d44b-ca7d5fd5a7e0@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1801574194323490835==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,


On 11/27/20 3:00 PM, Jonas Bonn wrote:
> Hi,
>
> On 27/11/2020 10:47, Jupiter wrote:
>> Hi Jonas,
>>
>> Thanks for the response and kind helps.
>>
>>> and the modem continues to reset itself.=C2=A0 Is this coincidental with
>>> you removing the antenna... I can't tell?
>>
>> My apology, a watchdog to monitor and to restart ofono when it lost
>> register was still running.
>
> That would explain it...
>
>>
>> I attached a new log which disabled watchdog.
>>
>> Here is the issue when the antenna was pulled out (simulating to lose
>> signalling), the modem was unregistered but it stuck at rssi callback:
>>
>> ofonod[27530]: ../ofono-1.30/src/gprs.c:ofono_gprs_status_notify()
>> /ubloxqmi_0 status unregistered (0)
>> ofonod[27530]: ../ofono-1.30/src/modem.c:get_modem_property() modem
>> 0x13ae0e8 property SystemPath
>> ofonod[27530]: =

>> ../ofono-1.30/drivers/qmimodem/netmon.c:qmi_netmon_request_update()
>> ofonod[27530]: ../ofono-1.30/drivers/qmimodem/netmon.c:get_rssi_cb()
>> ofonod[27530]: ../ofono-1.30/drivers/qmimodem/netmon.c:get_rssi_cb()
>> RSSI: 128 on RAT 0
>> ofonod[27530]: ../ofono-1.30/drivers/qmimodem/netmon.c:get_rssi_cb()
>> Bit error rate: 65535 on RAT 0
>> ofonod[27530]: ../ofono-1.30/src/modem.c:get_modem_property() modem
>> 0x13ae0e8 property SystemPath
>> ofonod[27530]: =

>> ../ofono-1.30/drivers/qmimodem/netmon.c:qmi_netmon_request_update()
>> ofonod[27530]: ../ofono-1.30/drivers/qmimodem/netmon.c:get_rssi_cb()
>> ofonod[27530]: ../ofono-1.30/drivers/qmimodem/netmon.c:get_rssi_cb()
>> RSSI: 128 on RAT 0
>> ofonod[27530]: ../ofono-1.30/drivers/qmimodem/netmon.c:get_rssi_cb()
>> Bit error rate: 65535 on RAT 0
>> .............
>>
>> It then stuck and repeated following statements forever:
>>
>> ofonod[27530]: =

>> ../ofono-1.30/drivers/qmimodem/netmon.c:qmi_netmon_request_update()
>> ofonod[27530]: ../ofono-1.30/drivers/qmimodem/netmon.c:get_rssi_cb()
>> ofonod[27530]: ../ofono-1.30/drivers/qmimodem/netmon.c:get_rssi_cb()
>> RSSI: 128 on RAT 0
>> ofonod[27530]: ../ofono-1.30/drivers/qmimodem/netmon.c:get_rssi_cb()
>> Bit error rate: 65535 on RAT 0
>>
>> static void qmi_netmon_request_update(struct ofono_netmon *netmon,
>> ofono_netmon_cb_t cb, void *user_data) invokes get_rssi_cb:
>> if (qmi_service_send(data->nas, QMI_NAS_GET_RSSI, param, get_rssi_cb,
>> cbd, g_free) > 0)
>>
>> static void get_rssi_cb(struct qmi_result *result, void *user_data)
>> checks signalling RSSI, RSRQ, RSRP, obviously there is no valid
>> signaling streangh as the modem is in unregistered status.
>>
>
> I wouldn't worry about these netmon functions.=C2=A0 It's the =

> network-registration driver that you should be looking at. 'netmon' is =

> only for information, I think.
>
>> My question is, where and how does ofono or qmimodem check modem
>> register status? Calling rssi_cb is not capable of finding modem
>> register status. Is the register status in src/modem.c?
>
> ss_info_notify() gets called when you get network information =

> notifications from the modem.=C2=A0 That's where the magic happens.

I agree with Jonas to say that all the magic is in ss_info_notify. At =

least that's the case outside LTE, I don't know a lot about LTE =

specificities.

Using netreg_status_changed logs:

 =C2=A0- registration OK at line 544

 =C2=A0- IP ok at line 586

 =C2=A0- registration KO (I assume this is after antenna remove) at line 687
 =C2=A0- another registration KO at line 716

So modem never says that data registration is back after antenna remove. =

Or it says so using a way that is not handled by QMI driver in ofono.

When you restart Ofono, radio stack of the modem will be reset =

(something like AT+CFUN=3D4, AT+CFUN=3D0 happens), that's why a new data =

registration process occurs.

I don't know if you have access to an AT channel or another QMI channel =

on your modem while Ofono is running. If this is the case, you could ask =

for registration status while ofono is running using AT commands or =

using qmicli. Let me know if you can do that and don't know the commands =

to do it.


Best regards,

Christophe

>
>>
>> Appreciate to shed light on how should ofono or qmimodme to handle
>> modem register status changes.
>> Thank you.
>
> Looking at the log, it sure does seem like the modem just stops =

> sending network status indications.=C2=A0 What happens if you re-assert =

> interest in these notifications regularly... something like this?
>
> --- a/drivers/qmimodem/network-registration.c
> +++ b/drivers/qmimodem/network-registration.c
> @@ -211,6 +211,9 @@ static void ss_info_notify(struct qmi_result =

> *result, void *user_data)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return;
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D remember_ss_info(da=
ta, status, lac, cellid, roaming);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qmi_service_register(data->nas, QMI=
_NAS_SS_INFO_IND,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ss_info_notify, netreg, NULL);
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono_netreg_status_notify(net=
reg, status, data->lac, =

> data->cellid,
>
> =C2=A0tech);
>
> The log file is in quite a readable state now.=C2=A0 It would be great if =

> somebody else could take a look at it...=C2=A0 I'm a bit out of the loop =

> with ofono, currently, so getting a bit rusty!
>
> /Jonas
>
>
>>
>> Kind regards,
>>
>> - jupiter
>>
> _______________________________________________
> ofono mailing list -- ofono(a)ofono.org
> To unsubscribe send an email to ofono-leave(a)ofono.org
--===============1801574194323490835==--

