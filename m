Content-Type: multipart/mixed; boundary="===============1813098523678482038=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: Re: Telit LE920A4 - aux/modem channels and events
Date: Tue, 21 Mar 2017 18:06:20 +0000
Message-ID: <73c6db7a-b2f3-0ddc-13a8-c38bd676813f@gmail.com>
In-Reply-To: <CANmGHYvw-CeJg5CxW0wP9zNvci5hzRpBOnK62G_XkU5+FfPF9g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1813098523678482038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daryl

On 21/03/17 17:06, Daryl Nebrich wrote:
> Hi Lukasz,
> =

> On Tue, Mar 21, 2017 at 12:07 PM, Lukasz Nowak <lnowak.tyco@gmail.com> =
wrote:
>> Hi Daryl,
>>
>> I am currently working on LE910-SVG modem. Reading Telit docs, if your
>> modem is a 0x1201 variant, you should probably be using QMI for it.
>> Having said that, ppp through the Telit firmware should work too.
>>
>> I can see you are missing qmi_wwan driver in your kernel. I am not sure
>> if qmicli should work without it. I can use qmicli to query modem's stat=
us
>> without issues, over cdc-wdm0.
>>
> =

> Interesting.  I'm running Linux 3.14.61 and I verified
> drivers/net/usb/qmi_wwan.c has the Telit 1bc7 vendor with product
> 1201.  And it's tied to ID 2 as shown below.  That matches what Telit
> has in their "CD/DE/LE910, HE/LE920 linux USB Driver - User Guide".
> =

>     {QMI_FIXED_INTF(0x1bc7, 0x1200, 5)},    /* Telit LE920 */
>     {QMI_FIXED_INTF(0x1bc7, 0x1201, 2)},    /* Telit LE920 */
> =

> The driver shows up in lsmod -
> =

> option                28725  0
> usb_wwan          8187  1 option
> qmi_wwan          11059  0
> cdc_wdm           10204  1 qmi_wwan
> usbnet               25057  1 qmi_wwan
> usbserial            26130  2 option,usb_wwan
> =

> Did you do anything else to get qmicli working?
No, it worked out of the box. I am using a newer kernel though: 4.4
In your previous log, ofono was not listing wwan0 device in udevng enumerat=
ion.

Did you check dmesg? Does it create a wwan0 device? I am getting this:
[75192.701431] qmi_wwan 1-1:1.2: cdc-wdm0: USB WDM device
[75192.707877] qmi_wwan 1-1:1.2 wwan0: register 'qmi_wwan' at usb-101c0000.=
ehci-1, WWAN/QMI device, 0e:cc:c2:b4:c3:41

It shows in "ip link" right after the modem is powered on:

11: wwan0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN qlen 1000
    link/ether 0e:cc:c2:b4:c3:41 brd ff:ff:ff:ff:ff:ff

And then you should see two devices enumerate by udevng:
ofonod[10260]: ../git/plugins/udevng.c:setup_gobi() /dev/cdc-wdm0 255/255/2=
55 02 (null) usbmisc
ofonod[10260]: ../git/plugins/udevng.c:setup_gobi() wwan0 255/255/255 02 (n=
ull) net


> =

>> If you are interested, I could send you my patch (work in progress) to o=
fono,
>> enumerating the 0x1201 telit modems to use qmimodem driver. But I suppos=
e it
>> would be best to get qmicli working first.
>>
>> When you are getting +CREG - what state is it indicating?
> =

> I'd appreciate you sharing what you've done, as getting QMI going may

I have just posted the patch:
[PATCH] gobi: Telit LE910V1 qmi support
A lot of it was originally provided by Piotr Haber.

Your modem seems to have the same vid/pid so it should work without modific=
ations.

> be my only hope.  I've submitted patches for connman, but have mostly
> debug for ofono.  I did have to modify udevng to setup the aux and
> modem channels.  For now, I've got gps and net set to null.  The log
> snippet is below.  It shows as registered.  The issue is that the
> +CREG event comes in after PPP is connected.  If I get it before, the
> PPP session keeps working.
> =

> ofonod[1194]: PPP:
> /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-neon-poky-li=
nux-gnueabi/ofono/261ba46-r0/ofono-261ba46/gatchat/gatppp.c:ppp_enter_phase=
()
> 4
> ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vf=
p-neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/drivers/atmodem/gp=
rs-context.c:ppp_connect()
> ofonod[1194]: IP: 10.154.216.252
> ofonod[1194]: DNS: 172.26.38.1, 0.0.0.0
> ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vf=
p-neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/src/gprs.c:pri_act=
ivate_callback()
> 0xab0800
> ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vf=
p-neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/plugins/udev.c:ude=
v_event()
> subsystem net add
> ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vf=
p-neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/plugins/udev.c:ude=
v_event()
> subsystem net finished
> ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vf=
p-neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/plugins/udevng.c:c=
heck_modem_list()
> ofonod[1194]: Aux: < \r\n+CREG: 1,"4C12","AE2210A",7\r\n\r\n+CGREG:
> 1,"4C12","AE2210A",7,03\r\n
> ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vf=
p-neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/src/network.c:ofon=
o_netreg_status_notify()
> /telit_0 status 1 tech 7
> ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vf=
p-neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/src/gprs.c:netreg_=
status_changed()
> 1
> ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vf=
p-neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/src/gprs.c:gprs_ne=
treg_update()
> attach: 1, driver_attached: 1
> ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vf=
p-neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/src/gprs.c:ofono_g=
prs_status_notify()
> /telit_0 status 1
> ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vf=
p-neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/src/gprs.c:gprs_at=
tached_update()
> 1 - 1, 1, 1, 1
> ofonod[1194]: Aux: > AT+COPS=3D3,2\r
> ofonod[1194]: Aux: < \r\nOK\r\n
> ofonod[1194]: Aux: > AT+COPS?\r
> ofonod[1194]: Aux: < \r\n+COPS: 0,2,"310410",7\r\n\r\nOK\r\n
> ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vf=
p-neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/drivers/atmodem/ne=
twork-registration.c:cops_numeric_cb()
> Cops numeric got mcc: 310, mnc: 410
> ofonod[1194]: Aux: > AT+CIND?\r
> ofonod[1194]: Aux: < \r\n+CIND: 0,2,1,0,0,0,0,0,5,1,0\r\n\r\nOK\r\n
> ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vf=
p-neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/src/network.c:ofon=
o_netreg_strength_notify()
> strength 100
> ofonod[1194]: Aux: > AT+COPS=3D3,0\r
> ofonod[1194]: Aux: < \r\nOK\r\n
> ofonod[1194]: Aux: > AT+COPS?\r
> ofonod[1194]: Aux: < \r\n+COPS: 0,0,"AT&T",7\r\n\r\nOK\r\n
> ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vf=
p-neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/drivers/atmodem/ne=
twork-registration.c:cops_cb()
> cops_cb: AT&T, 310 410 7
> ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vf=
p-neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/src/network.c:curr=
ent_operator_callback()
> 0xab2260, 0xac1fb0
> ofonod[1194]: PPP: lcp: pppcp_generate_event: current state 9:OPENED
> ofonod[1194]: PPP: event: 1 (Down), action: 201, new_state: 1 (STARTING)
> ofonod[1194]: PPP: ipcp: pppcp_generate_event: current state 9:OPENED
> ofonod[1194]: PPP: event: 1 (Down), action: 201, new_state: 1 (STARTING)
> ofonod[1194]: PPP:
> /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-neon-poky-li=
nux-gnueabi/ofono/261ba46-r0/ofono-261ba46/gatchat/gatppp.c:ppp_enter_phase=
()
> 5
> ofonod[1194]: PPP: lcp: pppcp_generate_event: current state 1:STARTING
> ofonod[1194]: PPP: event: 3 (Close), action: 800, new_state: 0 (INITIAL)
> ofonod[1194]: PPP: lcp: pppcp_this_layer_finished: current state 0:INITIAL
> ofonod[1194]: PPP:
> /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-neon-poky-li=
nux-gnueabi/ofono/261ba46-r0/ofono-261ba46/gatchat/gatppp.c:ppp_enter_phase=
()
> 0
> ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vf=
p-neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/plugins/udevng.c:r=
emove_device()
> /sys/devices/virtual/net/ppp0
> ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vf=
p-neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/plugins/udev.c:ude=
v_event()
> subsystem net remove
> ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vf=
p-neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/plugins/udev.c:rem=
ove_modem()
> /devices/virtual/net/ppp0
> ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vf=
p-neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/plugins/udev.c:ude=
v_event()
> subsystem net finished
> ofonod[1194]: PPP:
> /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vfp-neon-poky-li=
nux-gnueabi/ofono/261ba46-r0/ofono-261ba46/gatchat/gatppp.c:ppp_dead()
> ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vf=
p-neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/drivers/atmodem/gp=
rs-context.c:ppp_disconnect()
> Reason: 5, state: 3
> ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vf=
p-neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/src/gprs.c:ofono_g=
prs_context_deactivated()
> 1
> ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vf=
p-neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/src/gprs.c:ofono_g=
prs_context_deactivated()
> 2
> ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vf=
p-neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/src/gprs.c:ofono_g=
prs_context_deactivated()
> 3
> ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vf=
p-neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/src/gprs.c:ofono_g=
prs_context_deactivated()
> 4
> ofonod[1194]: /home/daryl/working/mecs-yocto/build/tmp/work/cortexa9hf-vf=
p-neon-poky-linux-gnueabi/ofono/261ba46-r0/ofono-261ba46/src/gprs.c:gprs_at=
tached_update()
> 1 - 1, 1, 1, 1
> io_disconnect 1
> =

>>
>> btw my modem is LTE only, and it always shows +CREG as 2,0 - "not regist=
ered",
>> so ofono logic is never setting up the ppp context. Hence I switched to =
using
>> qmimodem.
>>
>> Lukasz
>>
> =

> Ok.  I've tried changing the network mode using +WS46 as I first saw
> the problem with HSDPA.  But I'm seeing it with other types too.
> =

> Thanks,
> Daryl
> =

>>
>> On 21/03/17 14:49, Daryl Nebrich wrote:
>>> Hi,
>>>
>>> I'm using the latest of ofono and connman.  I'm having an issue with a
>>> PPP connection and async events.  With the latest ofono code, I added
>>> LE920A4 to plugins/telit.c.  So it's using atmodem driver for gprs and
>>> gprs-context.  The modem is running in mode 0x1201, so below is the
>>> mapping of aux and modem.
>>>
>>> /dev/ttyUSB0 (telit) 255/255/255 [00] =3D=3D> (null) (null)
>>> /dev/cdc-wdm0 (gobi) 255/255/255 [02] =3D=3D> (null) (null)
>>> /dev/ttyUSB1 (telit) 255/0/0 [03] =3D=3D> (null) (null)
>>> /dev/ttyUSB2 (telit) 255/0/0 [04] =3D=3D> (null) (null) -- for mode
>>> 0x1201, used for creating PPP connection
>>> /dev/ttyUSB3 (telit) 255/0/0 [05] =3D=3D> (null) (null) -- for mode
>>> 0x1201, used as chat for AT commands
>>> /dev/ttyUSB4 (telit) 255/0/0 [06] =3D=3D> (null) (null)
>>>
>>> Initially after the PPP session is established, everything is fine.  I
>>> can ping using the ppp0 interface.  But as soon as I get an async
>>> event (+CREG, +CIEV, etc), ping stops working.  If I leave ping
>>> running, I'll eventually get a ppp_disconnect with Reason 5 and state
>>> 3.  The events are logged on the aux channel, but I'm not sure if
>>> they're coming on modem channel also.
>>>
>>> This can happen without any associated NWDETACH (sometimes I'll just
>>> see a +CREG after PPP is connected).  In this case ppp_disconnect
>>> calls ofono_gprs_context_deactivated followed by g_at_chat_resume.  It
>>> looks like at_chat_resume ends up calling io_disconnect because of the
>>> below code.
>>>
>>>     if (g_at_io_get_channel(chat->io) =3D=3D NULL) {
>>>         io_disconnect(chat);
>>>         return;
>>>     }
>>>
>>> Is it expected that chat->io goes away because of the ppp_disconnect?
>>> When this happens the connman ofono plugin still thinks there's a
>>> network so it will repeatedly try to attach.  But the attach fails as
>>> it can't send AT commands anymore.
>>>
>>> I've tried changing how events are handling while a PPP session is
>>> active by changing settings similar to below -
>>>
>>>     g_at_chat_send(gcd->chat, "AT+CMER=3D1,0,0,0", none_prefix, NULL, N=
ULL, NULL);
>>>     g_at_chat_send(gcd->chat, "AT+CGEREP=3D2,1", none_prefix, NULL, NUL=
L, NULL);
>>>     g_at_chat_send(gcd->chat, "AT+CAOC=3D1", none_prefix, NULL, NULL, N=
ULL);
>>>
>>> The above changes are in gprs-context.c/at_cgdcont_cb right before
>>> sending AT+CGDATA so I would expect them to suppress events on the
>>> modem channel.  But I still sometimes get a +CREG update which appears
>>> to disrupt the PPP session.  Any ideas?
>>>
>>> BTW, I've trying using QMI on /dev/cdc-wdm0 using qmicli and
>>> qmi-network without any luck.  It just times out.
>>>
>>> Thanks,
>>> Daryl
>>> _______________________________________________
>>> ofono mailing list
>>> ofono(a)ofono.org
>>> https://lists.ofono.org/mailman/listinfo/ofono
>>>

--===============1813098523678482038==--

