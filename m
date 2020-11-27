Content-Type: multipart/mixed; boundary="===============6640022086076977356=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: Failed to reconnect after 4G LTE signaling strength level is back
Date: Fri, 27 Nov 2020 15:00:06 +0100
Message-ID: <246d8a1a-6be0-6f13-d44b-ca7d5fd5a7e0@norrbonn.se>
In-Reply-To: <CAA=hcWRNMsMA_GEJJmU1a1YMcDuKVQ4UCD=0_yj2WMtatLh+bg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6640022086076977356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 27/11/2020 10:47, Jupiter wrote:
> Hi Jonas,
> =

> Thanks for the response and kind helps.
> =

>> and the modem continues to reset itself.  Is this coincidental with
>> you removing the antenna... I can't tell?
> =

> My apology, a watchdog to monitor and to restart ofono when it lost
> register was still running.

That would explain it...

> =

> I attached a new log which disabled watchdog.
> =

> Here is the issue when the antenna was pulled out (simulating to lose
> signalling), the modem was unregistered but it stuck at rssi callback:
> =

> ofonod[27530]: ../ofono-1.30/src/gprs.c:ofono_gprs_status_notify()
> /ubloxqmi_0 status unregistered (0)
> ofonod[27530]: ../ofono-1.30/src/modem.c:get_modem_property() modem
> 0x13ae0e8 property SystemPath
> ofonod[27530]: ../ofono-1.30/drivers/qmimodem/netmon.c:qmi_netmon_request=
_update()
> ofonod[27530]: ../ofono-1.30/drivers/qmimodem/netmon.c:get_rssi_cb()
> ofonod[27530]: ../ofono-1.30/drivers/qmimodem/netmon.c:get_rssi_cb()
> RSSI: 128 on RAT 0
> ofonod[27530]: ../ofono-1.30/drivers/qmimodem/netmon.c:get_rssi_cb()
> Bit error rate: 65535 on RAT 0
> ofonod[27530]: ../ofono-1.30/src/modem.c:get_modem_property() modem
> 0x13ae0e8 property SystemPath
> ofonod[27530]: ../ofono-1.30/drivers/qmimodem/netmon.c:qmi_netmon_request=
_update()
> ofonod[27530]: ../ofono-1.30/drivers/qmimodem/netmon.c:get_rssi_cb()
> ofonod[27530]: ../ofono-1.30/drivers/qmimodem/netmon.c:get_rssi_cb()
> RSSI: 128 on RAT 0
> ofonod[27530]: ../ofono-1.30/drivers/qmimodem/netmon.c:get_rssi_cb()
> Bit error rate: 65535 on RAT 0
> .............
> =

> It then stuck and repeated following statements forever:
> =

> ofonod[27530]: ../ofono-1.30/drivers/qmimodem/netmon.c:qmi_netmon_request=
_update()
> ofonod[27530]: ../ofono-1.30/drivers/qmimodem/netmon.c:get_rssi_cb()
> ofonod[27530]: ../ofono-1.30/drivers/qmimodem/netmon.c:get_rssi_cb()
> RSSI: 128 on RAT 0
> ofonod[27530]: ../ofono-1.30/drivers/qmimodem/netmon.c:get_rssi_cb()
> Bit error rate: 65535 on RAT 0
> =

> static void qmi_netmon_request_update(struct ofono_netmon *netmon,
> ofono_netmon_cb_t cb, void *user_data) invokes get_rssi_cb:
> if (qmi_service_send(data->nas, QMI_NAS_GET_RSSI, param, get_rssi_cb,
> cbd, g_free) > 0)
> =

> static void get_rssi_cb(struct qmi_result *result, void *user_data)
> checks signalling RSSI, RSRQ, RSRP, obviously there is no valid
> signaling streangh as the modem is in unregistered status.
> =


I wouldn't worry about these netmon functions.  It's the =

network-registration driver that you should be looking at.  'netmon' is =

only for information, I think.

> My question is, where and how does ofono or qmimodem check modem
> register status? Calling rssi_cb is not capable of finding modem
> register status. Is the register status in src/modem.c?

ss_info_notify() gets called when you get network information =

notifications from the modem.  That's where the magic happens.

> =

> Appreciate to shed light on how should ofono or qmimodme to handle
> modem register status changes.
> Thank you.

Looking at the log, it sure does seem like the modem just stops sending =

network status indications.  What happens if you re-assert interest in =

these notifications regularly... something like this?

--- a/drivers/qmimodem/network-registration.c
+++ b/drivers/qmimodem/network-registration.c
@@ -211,6 +211,9 @@ static void ss_info_notify(struct qmi_result =

*result, void *user_data)
                 return;

         status =3D remember_ss_info(data, status, lac, cellid, roaming);
+
+       qmi_service_register(data->nas, QMI_NAS_SS_INFO_IND,
+                                       ss_info_notify, netreg, NULL);

         ofono_netreg_status_notify(netreg, status, data->lac, data->cellid,
 =

  tech);

The log file is in quite a readable state now.  It would be great if =

somebody else could take a look at it...  I'm a bit out of the loop with =

ofono, currently, so getting a bit rusty!

/Jonas


> =

> Kind regards,
> =

> - jupiter
>=20
--===============6640022086076977356==--

