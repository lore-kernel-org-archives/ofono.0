Content-Type: multipart/mixed; boundary="===============7165618191969706867=="
MIME-Version: 1.0
From: Daryl Nebrich <darylnebrich@gmail.com>
Subject: Re: Telit LE920A4 - aux/modem channels and events
Date: Tue, 21 Mar 2017 13:06:45 -0400
Message-ID: <CANmGHYvw-CeJg5CxW0wP9zNvci5hzRpBOnK62G_XkU5+FfPF9g@mail.gmail.com>
In-Reply-To: <df05ade2-27b7-78dc-26b3-506a162537de@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7165618191969706867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Tue, Mar 21, 2017 at 12:07 PM, Lukasz Nowak <lnowak.tyco@gmail.com> wr=
ote:
> Hi Daryl,
>
> I am currently working on LE910-SVG modem. Reading Telit docs, if your
> modem is a 0x1201 variant, you should probably be using QMI for it.
> Having said that, ppp through the Telit firmware should work too.
>
> I can see you are missing qmi_wwan driver in your kernel. I am not sure
> if qmicli should work without it. I can use qmicli to query modem's status
> without issues, over cdc-wdm0.
>

Interesting.  I'm running Linux 3.14.61 and I verified
drivers/net/usb/qmi_wwan.c has the Telit 1bc7 vendor with product
1201.  And it's tied to ID 2 as shown below.  That matches what Telit
has in their "CD/DE/LE910, HE/LE920 linux USB Driver - User Guide".

    {QMI_FIXED_INTF(0x1bc7, 0x1200, 5)},    /* Telit LE920 */
    {QMI_FIXED_INTF(0x1bc7, 0x1201, 2)},    /* Telit LE920 */

The driver shows up in lsmod -

option                28725  0
usb_wwan          8187  1 option
qmi_wwan          11059  0
cdc_wdm           10204  1 qmi_wwan
usbnet               25057  1 qmi_wwan
usbserial            26130  2 option,usb_wwan

Did you do anything else to get qmicli working?

> If you are interested, I could send you my patch (work in progress) to of=
ono,
> enumerating the 0x1201 telit modems to use qmimodem driver. But I suppose=
 it
> would be best to get qmicli working first.
>
> When you are getting +CREG - what state is it indicating?

I'd appreciate you sharing what you've done, as getting QMI going may
be my only hope.  I've submitted patches for connman, but have mostly
debug for ofono.  I did have to modify udevng to setup the aux and
modem channels.  For now, I've got gps and net set to null.  The log
snippet is below.  It shows as registered.  The issue is that the
+CREG event comes in after PPP is connected.  If I get it before, the
PPP session keeps working.

ofonod[1194]: PPP:
/home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-neon-poky-linu=
x-gnueabi/ofono/261ba46-r0/ofono-261ba46/gatchat/gatppp.c:ppp_enter_phase()
4
ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-=
neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/drivers/atmodem/gprs=
-context.c:ppp_connect()
ofonod[1194]: IP: 10.154.216.252
ofonod[1194]: DNS: 172.26.38.1, 0.0.0.0
ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-=
neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/src/gprs.c:pri_activ=
ate_callback()
0xab0800
ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-=
neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/plugins/udev.c:udev_=
event()
subsystem net add
ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-=
neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/plugins/udev.c:udev_=
event()
subsystem net finished
ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-=
neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/plugins/udevng.c:che=
ck_modem_list()
ofonod[1194]: Aux: < \r\n+CREG: 1,"4C12","AE2210A",7\r\n\r\n+CGREG:
1,"4C12","AE2210A",7,03\r\n
ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-=
neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/src/network.c:ofono_=
netreg_status_notify()
/telit_0 status 1 tech 7
ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-=
neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/src/gprs.c:netreg_st=
atus_changed()
1
ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-=
neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/src/gprs.c:gprs_netr=
eg_update()
attach: 1, driver_attached: 1
ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-=
neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/src/gprs.c:ofono_gpr=
s_status_notify()
/telit_0 status 1
ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-=
neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/src/gprs.c:gprs_atta=
ched_update()
1 - 1, 1, 1, 1
ofonod[1194]: Aux: > AT+COPS=3D3,2\r
ofonod[1194]: Aux: < \r\nOK\r\n
ofonod[1194]: Aux: > AT+COPS?\r
ofonod[1194]: Aux: < \r\n+COPS: 0,2,"310410",7\r\n\r\nOK\r\n
ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-=
neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/drivers/atmodem/netw=
ork-registration.c:cops_numeric_cb()
Cops numeric got mcc: 310, mnc: 410
ofonod[1194]: Aux: > AT+CIND?\r
ofonod[1194]: Aux: < \r\n+CIND: 0,2,1,0,0,0,0,0,5,1,0\r\n\r\nOK\r\n
ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-=
neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/src/network.c:ofono_=
netreg_strength_notify()
strength 100
ofonod[1194]: Aux: > AT+COPS=3D3,0\r
ofonod[1194]: Aux: < \r\nOK\r\n
ofonod[1194]: Aux: > AT+COPS?\r
ofonod[1194]: Aux: < \r\n+COPS: 0,0,"AT&T",7\r\n\r\nOK\r\n
ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-=
neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/drivers/atmodem/netw=
ork-registration.c:cops_cb()
cops_cb: AT&T, 310 410 7
ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-=
neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/src/network.c:curren=
t_operator_callback()
0xab2260, 0xac1fb0
ofonod[1194]: PPP: lcp: pppcp_generate_event: current state 9:OPENED
ofonod[1194]: PPP: event: 1 (Down), action: 201, new_state: 1 (STARTING)
ofonod[1194]: PPP: ipcp: pppcp_generate_event: current state 9:OPENED
ofonod[1194]: PPP: event: 1 (Down), action: 201, new_state: 1 (STARTING)
ofonod[1194]: PPP:
/home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-neon-poky-linu=
x-gnueabi/ofono/261ba46-r0/ofono-261ba46/gatchat/gatppp.c:ppp_enter_phase()
5
ofonod[1194]: PPP: lcp: pppcp_generate_event: current state 1:STARTING
ofonod[1194]: PPP: event: 3 (Close), action: 800, new_state: 0 (INITIAL)
ofonod[1194]: PPP: lcp: pppcp_this_layer_finished: current state 0:INITIAL
ofonod[1194]: PPP:
/home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-neon-poky-linu=
x-gnueabi/ofono/261ba46-r0/ofono-261ba46/gatchat/gatppp.c:ppp_enter_phase()
0
ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-=
neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/plugins/udevng.c:rem=
ove_device()
/sys/devices/virtual/net/ppp0
ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-=
neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/plugins/udev.c:udev_=
event()
subsystem net remove
ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-=
neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/plugins/udev.c:remov=
e_modem()
/devices/virtual/net/ppp0
ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-=
neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/plugins/udev.c:udev_=
event()
subsystem net finished
ofonod[1194]: PPP:
/home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-neon-poky-linu=
x-gnueabi/ofono/261ba46-r0/ofono-261ba46/gatchat/gatppp.c:ppp_dead()
ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-=
neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/drivers/atmodem/gprs=
-context.c:ppp_disconnect()
Reason: 5, state: 3
ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-=
neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/src/gprs.c:ofono_gpr=
s_context_deactivated()
1
ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-=
neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/src/gprs.c:ofono_gpr=
s_context_deactivated()
2
ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-=
neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/src/gprs.c:ofono_gpr=
s_context_deactivated()
3
ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-=
neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/src/gprs.c:ofono_gpr=
s_context_deactivated()
4
ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-=
neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/src/gprs.c:gprs_atta=
ched_update()
1 - 1, 1, 1, 1
io_disconnect 1

>
> btw my modem is LTE only, and it always shows +CREG as 2,0 - "not registe=
red",
> so ofono logic is never setting up the ppp context. Hence I switched to u=
sing
> qmimodem.
>
> Lukasz
>

Ok.  I've tried changing the network mode using +WS46 as I first saw
the problem with HSDPA.  But I'm seeing it with other types too.

Thanks,
Daryl

>
> On 21/03/17 14:49, Daryl Nebrich wrote:
>> Hi,
>>
>> I'm using the latest of ofono and connman.  I'm having an issue with a
>> PPP connection and async events.  With the latest ofono code, I added
>> LE920A4 to plugins/telit.c.  So it's using atmodem driver for gprs and
>> gprs-context.  The modem is running in mode 0x1201, so below is the
>> mapping of aux and modem.
>>
>> /dev/ttyUSB0 (telit) 255/255/255 [00] =3D=3D> (null) (null)
>> /dev/cdc-wdm0 (gobi) 255/255/255 [02] =3D=3D> (null) (null)
>> /dev/ttyUSB1 (telit) 255/0/0 [03] =3D=3D> (null) (null)
>> /dev/ttyUSB2 (telit) 255/0/0 [04] =3D=3D> (null) (null) -- for mode
>> 0x1201, used for creating PPP connection
>> /dev/ttyUSB3 (telit) 255/0/0 [05] =3D=3D> (null) (null) -- for mode
>> 0x1201, used as chat for AT commands
>> /dev/ttyUSB4 (telit) 255/0/0 [06] =3D=3D> (null) (null)
>>
>> Initially after the PPP session is established, everything is fine.  I
>> can ping using the ppp0 interface.  But as soon as I get an async
>> event (+CREG, +CIEV, etc), ping stops working.  If I leave ping
>> running, I'll eventually get a ppp_disconnect with Reason 5 and state
>> 3.  The events are logged on the aux channel, but I'm not sure if
>> they're coming on modem channel also.
>>
>> This can happen without any associated NWDETACH (sometimes I'll just
>> see a +CREG after PPP is connected).  In this case ppp_disconnect
>> calls ofono_gprs_context_deactivated followed by g_at_chat_resume.  It
>> looks like at_chat_resume ends up calling io_disconnect because of the
>> below code.
>>
>>     if (g_at_io_get_channel(chat->io) =3D=3D NULL) {
>>         io_disconnect(chat);
>>         return;
>>     }
>>
>> Is it expected that chat->io goes away because of the ppp_disconnect?
>> When this happens the connman ofono plugin still thinks there's a
>> network so it will repeatedly try to attach.  But the attach fails as
>> it can't send AT commands anymore.
>>
>> I've tried changing how events are handling while a PPP session is
>> active by changing settings similar to below -
>>
>>     g_at_chat_send(gcd->chat, "AT+CMER=3D1,0,0,0", none_prefix, NULL, NU=
LL, NULL);
>>     g_at_chat_send(gcd->chat, "AT+CGEREP=3D2,1", none_prefix, NULL, NULL=
, NULL);
>>     g_at_chat_send(gcd->chat, "AT+CAOC=3D1", none_prefix, NULL, NULL, NU=
LL);
>>
>> The above changes are in gprs-context.c/at_cgdcont_cb right before
>> sending AT+CGDATA so I would expect them to suppress events on the
>> modem channel.  But I still sometimes get a +CREG update which appears
>> to disrupt the PPP session.  Any ideas?
>>
>> BTW, I've trying using QMI on /dev/cdc-wdm0 using qmicli and
>> qmi-network without any luck.  It just times out.
>>
>> Thanks,
>> Daryl
>> _______________________________________________
>> ofono mailing list
>> ofono(a)ofono.org
>> https://lists.ofono.org/mailman/listinfo/ofono
>>

--===============7165618191969706867==--

