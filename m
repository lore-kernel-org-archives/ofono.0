Content-Type: multipart/mixed; boundary="===============6143292777210474753=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: Failed to reconnect after 4G LTE signaling strength level is back
Date: Fri, 27 Nov 2020 08:12:49 +0100
Message-ID: <83c90a37-67a5-b60b-6c12-cc2e586d0350@norrbonn.se>
In-Reply-To: <CAA=hcWRV7hQ6eo2YsR0NOa3fjt3C0hVwo8yRgJqBhuuwSQ38nw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6143292777210474753==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 20/11/2020 06:26, Jupiter wrote:
> Hmm, strange, I tried to restart ofonod several times, the last one
> was able to reconnect the 4G and network automatically after removing
> the antenna to lose network, then adding the antenna, the only
> difference was there were many messages popped out in the console
> screen:
> =

> [33383.892047] IPv6: ADDRCONF(NETDEV_UP): mlan0: link is not ready
> [33383.961208] IPv6: ADDRCONF(NETDEV_UP): wwan0: link is not ready
> [33385.634408] mwifiex_sdio mmc0:0001:1: info: trying to associate to 'Ju=
piterIo
> T' bssid 34:08:04:12:b1:a2
> [33385.658542] mwifiex_sdio mmc0:0001:1: info: associated to bssid 34:08:=
04:12:b
> 1:a2 successfully
> [33385.800544] IPv6: ADDRCONF(NETDEV_CHANGE): mlan0: link becomes ready
> [33385.874181] mwifiex_sdio mmc0:0001:1: CMD_RESP: cmd 0x23f error, resul=
t=3D0x2
> [33453.714288] mwifiex_sdio mmc0:0001:1: info: successfully disconnected =
from 34
> :08:04:12:b1:a2: reason code 3
> [33453.771463] IPv6: ADDRCONF(NETDEV_UP): mlan0: link is not ready
> [33453.836374] IPv6: ADDRCONF(NETDEV_UP): wwan0: link is not ready

You're probably grounding something when disconnecting the antenna...


> =

> it looks like when it did not work that some monitoring and callback
> process was not activated, when it worked, the some process was
> activated.
> =

> What I might missing here? Please see the attached log file
> ofono_debug6.txt which is able to reconnect.
> =


Again, this log shows a bunch of modem resets.

This pattern is repeated a couple of times:

ofonod[20465]: =

../ofono-1.30/drivers/qmimodem/network-registration.c:event_notify()
ofonod[20465]: =

../ofono-1.30/drivers/qmimodem/network-registration.c:event_notify() =

signal with 40%(-77 dBm) on 8
ofonod[20465]: =

../ofono-1.30/src/network.c:ofono_netreg_strength_notify() strength 40
ofonod[20465]: ../ofono-1.30/src/modem.c:get_modem_property() modem =

0x567908 property SystemPath
ofonod[20465]: =

../ofono-1.30/drivers/qmimodem/netmon.c:qmi_netmon_request_update()
ofonod[20465]: QMI: > 01 11 00 00 03 01 00 45 01 20 00 05 00 10 02 00 =

.......E. ......
ofonod[20465]: QMI:   ff 00 =

..
ofonod[20465]: QMI:     NAS_req msg=3D32 len=3D5 =

[client=3D1,type=3D0,tid=3D325,len=3D17]
ofonod[20465]: QMI:        {type=3D16,len=3D2}
ofonod[20465]: QMI: < 01 48 00 80 03 01 02 45 01 20 00 3c 00 02 04 00 =

.H.....E. .<....
ofonod[20465]: QMI:   00 00 00 00 01 02 00 b3 08 11 04 00 01 00 4d 08 =

..............M.
ofonod[20465]: QMI:   12 04 00 01 00 3f 08 13 04 00 96 ff ff ff 14 01 =

.....?..........
ofonod[20465]: QMI:   00 08 15 05 00 01 00 ff ff 08 16 02 00 f2 08 17 =

................
ofonod[20465]: QMI:   02 00 fe ff 18 02 00 96 ff =

.........
ofonod[20465]: QMI:     NAS_resp msg=3D32 len=3D60 =

[client=3D1,type=3D2,tid=3D325,len=3D72]
ofonod[20465]: QMI:        {type=3D2,error=3DNONE} {type=3D1,len=3D2} =

{type=3D17,len=3D4} {type=3D18,len=3D4}
ofonod[20465]: QMI:        {type=3D19,len=3D4} {type=3D20,len=3D1} =

{type=3D21,len=3D5} {type=3D22,len=3D2}
ofonod[20465]: QMI:        {type=3D23,len=3D2} {type=3D24,len=3D2}
ofonod[20465]: ../ofono-1.30/drivers/qmimodem/netmon.c:get_rssi_cb()
ofonod[20465]: ../ofono-1.30/drivers/qmimodem/netmon.c:get_rssi_cb() =

RSSI: 77 on RAT 8
ofonod[20465]: ../ofono-1.30/drivers/qmimodem/netmon.c:get_rssi_cb() Bit =

error rate: 65535 on RAT 8
ofonod[20465]: ../ofono-1.30/drivers/qmimodem/netmon.c:get_rssi_cb() =

RSRQ: -14 on RAT 8
ofonod[20465]: ../ofono-1.30/drivers/qmimodem/netmon.c:get_rssi_cb() Got =

LTE RSRP: -106
ofonod[20465]: QMI: < 01 11 00 80 03 01 04 0c 00 02 00 05 00 10 02 00 =

................
ofonod[20465]: QMI:   b7 08 =

..
ofonod[20465]: QMI:     NAS_ind msg=3D2 len=3D5 [client=3D1,type=3D4,tid=3D=
12,len=3D17]
ofonod[20465]: QMI:        {type=3D16,len=3D2}
ofonod[20465]: =

../ofono-1.30/drivers/qmimodem/network-registration.c:event_notify()
ofonod[20465]: =

../ofono-1.30/drivers/qmimodem/network-registration.c:event_notify() =

signal with 60%(-73 dBm) on 8
ofonod[20465]: =

../ofono-1.30/src/network.c:ofono_netreg_strength_notify() strength 60
ofonod[20465]: ../ofono-1.30/src/modem.c:modem_change_state() old state: =

3, new state: 0
ofonod[20465]: ../ofono-1.30/src/modem.c:flush_atoms()
ofonod[20465]: ../ofono-1.30/src/gprs.c:gprs_context_unregister() =

0x565c00, 0x55b7f0
ofonod[20465]: ../ofono-1.30/src/gprs.c:gprs_context_remove() atom: 0x565c28
ofonod[20465]: =

../ofono-1.30/drivers/qmimodem/gprs-context.c:qmi_gprs_context_remove()
ofonod[20465]: ../ofono-1.30/src/gprs.c:gprs_unregister() 0x55b7f0
ofonod[20465]: =

../ofono-1.30/src/network.c:__ofono_netreg_remove_status_watch() 0x5549a8
ofonod[20465]: ../ofono-1.30/src/gprs.c:gprs_remove() atom: 0x55e198
ofonod[20465]: ../ofono-1.30/drivers/qmimodem/gprs.c:qmi_gprs_remove()
ofonod[20465]: ../ofono-1.30/drivers/qmimodem/netmon.c:qmi_netmon_remove()
ofonod[20465]: ../ofono-1.30/src/sim.c:ofono_sim_remove_spn_watch() 0x55e060
ofonod[20465]: ../ofono-1.30/src/network.c:netreg_remove() atom: 0x573510
...

...and the modem continues to reset itself.  Is this coincidental with =

you removing the antenna... I can't tell?

/Jonas

> I'll do more test, something is not stable or missing.
> =

> Thank you.
> =

> =

> =

> On 11/20/20, Jupiter <jupiter.hce@gmail.com> wrote:
>> Hi,
>>
>> I am running ofono version 1.30 for uBlox SARA-R4 QMI on iMX6, it is
>> functional well, but there is one problem, it failed to be reconnected
>> when the 4G LTE signaling strength level is back to normal. Here is
>> what I tested:
>>
>> - Connect antenna, it was running fine, network is connected.
>>
>> - Remove the antenna, the network is down.
>>
>> - Wait for a while, reconnect the antenna, the ofono could not
>> reconnect, the driver was still there.
>>
>> - If I restart ofnono the connection would be back.
>>
>> I tested the same sequence on SARA EVK which is not running ofono, it
>> is capable of re-register automatically.
>>
>> Appreciate your sight comments if it is ofono issue or QMI issue or
>> something else, please find the attached debug file.
>>
>> Thank you.
>>
>> Kind regards,
>>
>> - jupiter
>>
> =

> =

> =

> _______________________________________________
> ofono mailing list -- ofono(a)ofono.org
> To unsubscribe send an email to ofono-leave(a)ofono.org
>=20
--===============6143292777210474753==--

