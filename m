Content-Type: multipart/mixed; boundary="===============0528472864638173344=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: Re: Re-activating a context.
Date: Mon, 16 Jul 2012 14:31:53 +0200
Message-ID: <500409B9.5050804@hale.at>
In-Reply-To: <50002519.3060105@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0528472864638173344==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 13/07/12 15:39, Guillaume Zajac wrote:
> Hi Christopher,
>
> On 13/07/2012 12:12, Christopher Vogl wrote:
>>>>
>>>> I am trying to simulate a connection loss and after a valid ppp
>>>> connection I disconnect the antenna to get detached from GPRS.
>>>> After reconnecting the antenna everything seems to work fine just =

>>>> until
>>>> activating the context.
>>>>
>>>> Ofono seems to get stuck in
>>>> drivers/atmodem/gprs-context.c:at_gprs_activate_primary() and
>>>> AT+CGDCONT=3D1 is missing on the debug output.
>>>> When I retry to activate the context after some minutes with a =

>>>> dbus-send
>>>> call, I receive an operation in progress error.
>>>>
>>>> Below I have attached ofono's debug output and dbus-send calls for
>>>> important interfaces
>>>> - before removing the antenna
>>>> - after removing the antenna
>>>> - after reconnecting the antenna
>>>>
>>>> Modem in use: Telit UC864-G
>>>>
>>>> connMan in the debug output is my own simple connection manger. I =

>>>> am not
>>>> sure if I missed to set some ofono state or if there is a known issue.
>>>> I really would appreciate a hint in this case.
>>>>
>>>
>>> To me it looks like your PPP connection has not been dropped when =

>>> the antenna has been removed.  Today oFono assumes that the PPP =

>>> connection will be dropped by the modem in this case, and your modem =

>>> does not do this.  This leads to problems because the AT channel on =

>>> which the PPP connection is being run can not accept additional =

>>> commands.  This is why you're not seeing the CGDCONT.
>>>
>>> A while ago Guillaume posted a patch to fix this problem (we saw =

>>> this with Huawei PPP based devices).  The patch looked good to me =

>>> but needed further testing (e.g. for regressions). Can you dig the =

>>> mailing archives and test that patch?
>>>
>>> Or maybe Guillaume will be nice enough to repost it to the mailing =

>>> list.
>>
>>
>> Thanks Denis!
>> I found the patch from Guillaume and applied it (ofono 1.7 & 1.8).
>> The ppp connection seems to get dropped now when I remove the antenna =

>> but does not come up again correctly when I reconnect the antenna.
>>
>
> I have a new version but only naming is changed but the main goal of =

> this set of patches is to end properly the PPP connection which goal =

> you seem to have reached.
> I guess you are using upstream oFono and ConnMan version right?

Thank you very much for your patches, they seem to do what they were =

intended for.

Sorry for the misleading name in the debug output, but we are not using =

THE ConnMan. It is just our own simple connection manager which emerged =

from the ofono test scripts.
We did not start with THE ConnMan because we needed special features =

like sim switching - we have two sim slots.

Basically we are using upstream ofono but with some patches. Some parts =

will be submitted for review soon, e.g. sim retry counter, gprs bearer, =

AT&C0 after PPP link was dropped.
We are also using separate serials for the AT chat and the data/PPP.
With some parts we are not sure yet if we can commit anything of it. =

These parts are hardware specific and set GPIO pins to switch the sim =

cards. i.e. activate one of two sim slots.
These patches are currently implemented as hooks in telit.c. Maybe there =

is an elegant generic way to provide the ability to extend ofono with =

hardware specific features.

>>
>> After disconnecting the antenna:
>>
>> Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: Aux: < \r\n+CREG: =

>> 2\r\n
>> Jan  1 01:18:53 mx31tt01 daemon.debug ofonod[810]: =

>> src/network.c:ofono_netreg_status_notify() /telit_0 status 2 tech -1
>> Jan  1 01:18:53 mx31tt01 daemon.debug ofonod[810]: =

>> src/network.c:current_operator_callback() 0x1bed30, (nil)
>> Jan  1 01:18:53 mx31tt01 daemon.debug ofonod[810]: =

>> src/gprs.c:netreg_status_changed() 2
>> Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: Aux: > AT+CGATT=3D0\r
>> Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: Aux: < \r\n+CGREG: =

>> 2\r\n
>> Jan  1 01:18:53 mx31tt01 daemon.debug ofonod[810]: =

>> src/gprs.c:ofono_gprs_status_notify() /telit_0 status 2
>> Jan  1 01:18:53 mx31tt01 daemon.debug ofonod[810]: =

>> drivers/atmodem/gprs-context.c:at_gprs_release_primary() cid 1
>> Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

>> pppcp_generate_event: current state 9:OPENED
>> Jan  1 01:18:53 mx31tt01 user.debug connMan[803]: Got network =

>> registration signal Status: 'searching'
>> Jan  1 01:18:53 mx31tt01 user.err connMan[803]: =

>> checkAndSetOperatorSelection()
>> Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: PPP: event: 3 =

>> (Close), action: 8224, new_state: 4 (CLOSING)
>> Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

>> pppcp_initialize_restart_count: current state 9:OPENED
>> Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

>> pppcp_send_terminate_request: current state 9:OPENED
>> Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

>> pppcp_generate_event: current state 9:OPENED
>> Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: PPP: event: 1 =

>> (Down), action: 201, new_state: 1 (STARTING)
>> Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: PPP: =

>> gatchat/gatppp.c:ppp_enter_phase() 5
>> Jan  1 01:18:53 mx31tt01 daemon.debug ofonod[810]: =

>> plugins/udevng.c:remove_device() /sys/devices/virtual/net/ppp0
>> Jan  1 01:18:53 mx31tt01 daemon.debug ofonod[810]: =

>> plugins/udev.c:udev_event() subsystem net remove
>> Jan  1 01:18:53 mx31tt01 daemon.debug ofonod[810]: =

>> plugins/udev.c:remove_modem() /devices/virtual/net/ppp0
>> Jan  1 01:18:53 mx31tt01 daemon.debug ofonod[810]: =

>> plugins/udev.c:udev_event() subsystem net finished
>> Jan  1 01:18:53 mx31tt01 user.debug connMan[803]: Got connection =

>> manager signal Attached, Val =3D false
>> Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

>> pppcp_process_terminate_ack: current state 4:CLOSING
>> Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

>> pppcp_generate_event: current state 4:CLOSING
>> Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: PPP: event: 11 =

>> (RTA), action: 802, new_state: 2 (CLOSED)
>> Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

>> pppcp_this_layer_finished: current state 2:CLOSED
>> Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: PPP: =

>> gatchat/gatppp.c:ppp_enter_phase() 0
>> Jan  1 01:18:53 mx31tt01 daemon.debug ofonod[810]: =

>> drivers/atmodem/gprs-context.c:at_gprs_deactivate_primary() cid 1
>> Jan  1 01:18:53 mx31tt01 daemon.info ofonod[810]: PPP: =

>> gatchat/gatppp.c:ppp_dead()
>> Jan  1 01:18:53 mx31tt01 daemon.debug ofonod[810]: =

>> drivers/atmodem/gprs-context.c:ppp_disconnect()
>> Jan  1 01:18:53 mx31tt01 daemon.debug ofonod[810]: =

>> src/gprs.c:gprs_remove_context() Unregistering context: =

>> /telit_0/context1
>> Jan  1 01:18:53 mx31tt01 user.debug connMan[803]: Got connection =

>> manager signal Powered, Val =3D false
>> Jan  1 01:18:57 mx31tt01 daemon.info ofonod[810]: Aux: < \r\n+CME =

>> ERROR: 30\r\n
>> Jan  1 01:18:57 mx31tt01 daemon.debug ofonod[810]: =

>> src/gprs.c:gprs_attach_callback() /telit_0 error =3D 1
>> Jan  1 01:18:57 mx31tt01 daemon.info ofonod[810]: Aux: > AT+CGREG?\r
>> Jan  1 01:18:57 mx31tt01 daemon.info ofonod[810]: Aux: < \r\n+CGREG: =

>> 2,2\r\n\r\nOK\r\n
>> Jan  1 01:18:57 mx31tt01 daemon.debug ofonod[810]: =

>> src/gprs.c:registration_status_cb() /telit_0 error 0 status 2
>> Jan  1 01:18:57 mx31tt01 daemon.debug ofonod[810]: =

>> src/gprs.c:ofono_gprs_status_notify() /telit_0 status 2
>>
>> Jan  1 01:19:30 mx31tt01 daemon.info ofonod[810]: Modem: < \r\nNO =

>> CARRIER\r\n
>>
>>
>
> So your PPP session seems to be well ended.
>
>>
>>
>> After reconnecting the antenna:
>>
>> Jan  1 01:20:12 mx31tt01 daemon.info ofonod[810]: Modem: < \r\n+CGEV: =

>> ME DETACH\r\n
>> Jan  1 01:20:12 mx31tt01 daemon.info ofonod[810]: Aux: < \r\n+CGEV: =

>> ME DETACH\r\n
>> Jan  1 01:20:12 mx31tt01 daemon.debug ofonod[810]: =

>> src/gprs.c:ofono_gprs_detached_notify() /telit_0
>> Jan  1 01:20:12 mx31tt01 daemon.info ofonod[810]: Modem: < \r\n+CREG: =

>> 1,"0340","C149"\r\n
>> Jan  1 01:20:12 mx31tt01 daemon.info ofonod[810]: Aux: < \r\n+CREG: =

>> 1,"0340","C149"\r\n
>> Jan  1 01:20:12 mx31tt01 daemon.debug ofonod[810]: =

>> src/network.c:ofono_netreg_status_notify() /telit_0 status 1 tech 3
>> Jan  1 01:20:12 mx31tt01 user.debug connMan[803]: Got network =

>> registration signal Status: 'registered'
>> {...}
>> Jan  1 01:20:14 mx31tt01 user.debug connMan[803]: Setting and =

>> Activating the Internet connection context.
>> Jan  1 01:20:14 mx31tt01 user.debug connMan[803]: mccmnc =3D '26202', =

>> len =3D 5
>> Jan  1 01:20:15 mx31tt01 user.debug connMan[803]: Provider name '1&1'
>> Jan  1 01:20:15 mx31tt01 user.debug connMan[803]: Set =

>> AccessPointName: web.vodafone.de
>> Jan  1 01:20:15 mx31tt01 user.debug connMan[803]: Set Username:
>> Jan  1 01:20:15 mx31tt01 user.debug connMan[803]: Set Password:
>> Jan  1 01:20:15 mx31tt01 user.debug connMan[803]: Trying to set =

>> context:web.vodafone.de
>> Jan  1 01:20:15 mx31tt01 daemon.debug ofonod[810]: =

>> drivers/atmodem/gprs-context.c:at_gprs_activate_primary() cid 1
>> Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: Modem: > =

>> AT+CGDCONT=3D1,"IP","web.vodafone.de"\r
>> Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: Modem: < \r\nOK\r\n
>> Jan  1 01:20:15 mx31tt01 daemon.debug ofonod[810]: =

>> drivers/atmodem/gprs-context.c:at_cgdcont_cb() ok 1
>> Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: Modem: > =

>> AT+CGDATA=3D"PPP",1\r
>> Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: Modem: < =

>> \r\nCONNECT\r\n
>> Jan  1 01:20:15 mx31tt01 daemon.debug ofonod[810]: =

>> drivers/atmodem/gprs-context.c:at_cgdata_cb() ok 1
>> Jan  1 01:20:15 mx31tt01 daemon.debug ofonod[810]: =

>> drivers/atmodem/gprs-context.c:setup_ppp()
>> Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

>> pppcp_generate_event: current state 0:INITIAL
>> Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: event: 0 (Up), =

>> action: 2, new_state: 2 (CLOSED)
>> Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

>> pppcp_generate_event: current state 2:CLOSED
>> Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: event: 2 =

>> (Open), action: 1026, new_state: 6 (REQSENT)
>> Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

>> pppcp_initialize_restart_count: current state 2:CLOSED
>> Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

>> pppcp_send_configure_request: current state 2:CLOSED
>> Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: =

>> gatchat/gatppp.c:ppp_enter_phase() 1
>> Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

>> pppcp_process_configure_request: current state 6:REQSENT
>> Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

>> pppcp_generate_event: current state 6:REQSENT
>> Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: event: 6 =

>> (RCR+), action: 2008, new_state: 8 (ACKSENT)
>> Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

>> pppcp_send_configure_ack: current state 6:REQSENT
>> Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

>> pppcp_process_configure_ack: current state 8:ACKSENT
>> Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

>> pppcp_generate_event: current state 8:ACKSENT
>> Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: event: 8 =

>> (RCA), action: 129, new_state: 9 (OPENED)
>> Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

>> pppcp_initialize_restart_count: current state 8:ACKSENT
>> Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: =

>> gatchat/gatppp.c:ppp_enter_phase() 2
>
> As you use no username and no password authentication phase is passed =

> through. It is ok.

For this APN there is no username and password provided and it also =

works like that before I remove the antenna.

>
>> Jan  1 01:20:15 mx31tt01 daemon.info ofonod[810]: PPP: =

>> gatchat/gatppp.c:ppp_enter_phase() 3
>> {...}
>> Jan  1 01:20:21 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

>> pppcp_send_configure_request: current state 6:REQSENT
>
>> Jan  1 01:20:21 mx31tt01 daemon.info ofonod[810]: Aux: < \r\n+CGEV: =

>> ME DEACT IP, , 1\r\n
>
> It seems IP Control Protocol is failing so that modem cannot receive =

> the IP configuration from the network.
> IP phase is deactivated by the modem itself.
> I don't know what is happening there.
>
>> Jan  1 01:20:24 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

>> pppcp_timeout: current state 6:REQSENT
>> Jan  1 01:20:24 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

>> pppcp_generate_event: current state 6:REQSENT
>> {...}
>> Jan  1 01:20:48 mx31tt01 daemon.info ofonod[810]: PPP: event: 4 =

>> (TO+), action: 1006, new_state: 6 (REQSENT)
>> Jan  1 01:20:48 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

>> pppcp_send_configure_request: current state 6:REQSENT
>> Jan  1 01:20:51 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

>> pppcp_timeout: current state 6:REQSENT
>> Jan  1 01:20:51 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

>> pppcp_generate_event: current state 6:REQSENT
>> Jan  1 01:20:51 mx31tt01 daemon.info ofonod[810]: PPP: event: 5 =

>> (TO-), action: 803, new_state: 3 (STOPPED)
>> Jan  1 01:20:51 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

>> pppcp_this_layer_finished: current state 3:STOPPED
>> Jan  1 01:20:51 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

>> pppcp_generate_event: current state 3:STOPPED
>> Jan  1 01:20:51 mx31tt01 daemon.info ofonod[810]: PPP: event: 3 =

>> (Close), action: 2, new_state: 2 (CLOSED)
>> Jan  1 01:20:51 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

>> pppcp_generate_event: current state 9:OPENED
>> Jan  1 01:20:51 mx31tt01 daemon.info ofonod[810]: PPP: event: 3 =

>> (Close), action: 8224, new_state: 4 (CLOSING)
>> Jan  1 01:20:51 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

>> pppcp_initialize_restart_count: current state 9:OPENED
>> Jan  1 01:20:51 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

>> pppcp_send_terminate_request: current state 9:OPENED
>> Jan  1 01:20:51 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

>> pppcp_generate_event: current state 2:CLOSED
>> Jan  1 01:20:51 mx31tt01 daemon.info ofonod[810]: PPP: event: 1 =

>> (Down), action: 0, new_state: 0 (INITIAL)
>> Jan  1 01:20:51 mx31tt01 daemon.info ofonod[810]: PPP: =

>> gatchat/gatppp.c:ppp_enter_phase() 5
>> Jan  1 01:20:54 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

>> pppcp_timeout: current state 4:CLOSING
>> Jan  1 01:20:54 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

>> pppcp_generate_event: current state 4:CLOSING
>> Jan  1 01:20:54 mx31tt01 daemon.info ofonod[810]: PPP: event: 4 =

>> (TO+), action: 8004, new_state: 4 (CLOSING)
>> Jan  1 01:20:54 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

>> pppcp_send_terminate_request: current state 4:CLOSING
>> Jan  1 01:20:57 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

>> pppcp_timeout: current state 4:CLOSING
>> Jan  1 01:20:57 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

>> pppcp_generate_event: current state 4:CLOSING
>> Jan  1 01:20:57 mx31tt01 daemon.info ofonod[810]: PPP: event: 5 =

>> (TO-), action: 802, new_state: 2 (CLOSED)
>> Jan  1 01:20:57 mx31tt01 daemon.info ofonod[810]: PPP: lcp: =

>> pppcp_this_layer_finished: current state 2:CLOSED
>> Jan  1 01:20:57 mx31tt01 daemon.info ofonod[810]: PPP: =

>> gatchat/gatppp.c:ppp_enter_phase() 0
>> Jan  1 01:20:57 mx31tt01 daemon.info ofonod[810]: PPP: =

>> gatchat/gatppp.c:ppp_dead()
>
>> Jan  1 01:20:57 mx31tt01 daemon.debug ofonod[810]: =

>> drivers/atmodem/gprs-context.c:ppp_disconnect()
>
> I guess the disconnect reason is G_AT_PPP_REASON_IPCP_FAIL( according =

> to gatppp.h enum) but you could still add a trace in ppp_disconnect() =

> into  drivers/atmodem/gprs-context.c:
>
> DBG("Reason: %d", reason);
>
> to be sure.

Yes, you are right! Here the the trace:

Jan  1 03:33:21 mx31tt01 daemon.info ofonod[471]: PPP: =

gatchat/gatppp.c:ppp_enter_phase() 0
Jan  1 03:33:21 mx31tt01 daemon.info ofonod[471]: PPP: =

gatchat/gatppp.c:ppp_dead()
Jan  1 03:33:21 mx31tt01 daemon.debug ofonod[471]: =

drivers/atmodem/gprs-context.c:ppp_disconnect() Reason: 2
Jan  1 03:33:21 mx31tt01 daemon.debug ofonod[471]: =

src/gprs.c:pri_activate_callback() 0x1ebdbb0
Jan  1 03:33:21 mx31tt01 daemon.debug ofonod[471]: =

src/gprs.c:pri_activate_callback() Activating context failed with error: =

Unknown error type


>> Jan  1 01:20:57 mx31tt01 daemon.debug ofonod[810]: =

>> src/gprs.c:pri_activate_callback() 0x1ce500
>> Jan  1 01:20:57 mx31tt01 daemon.debug ofonod[810]: =

>> src/gprs.c:pri_activate_callback() Activating context failed with =

>> error: Unknown error type
>>
>
> Did you try to activate manually the context from oFono test scripts =

> after this failure?

I tried that before applying your patches and I always got a "in =

progress error" from ofono.

Now with your patches the activation of the context works for the retry =

and I get a valid ppp connection.

Trace after activating the context a second time (manually):

Jan  1 03:34:28 mx31tt01 user.debug connMan[402]: Got connection context =

signal Settings, Val =3D {'Interface': <'ppp0'>, 'Method': <'static'>, =

'Address': <'2.205.178.119'>, 'Netmask': <'255.255.255.255'>, 'D
omainNameServers': <['139.7.30.126', '139.7.30.125']>}
Jan  1 03:34:28 mx31tt01 daemon.debug ofonod[471]: =

plugins/udev.c:udev_event() subsystem net add
Jan  1 03:34:28 mx31tt01 daemon.debug ofonod[471]: =

plugins/udev.c:udev_event() subsystem net finished
Jan  1 03:34:28 mx31tt01 user.debug connMan[402]: Got connection context =

signal Active, Val =3D true
Jan  1 03:34:28 mx31tt01 user.info connMan[402]: Connection context has =

been activated.
Jan  1 03:34:28 mx31tt01 user.debug connMan[402]: Method is a string static
Jan  1 03:34:28 mx31tt01 user.info connMan[402]: Set up ip ip addr add =

2.205.178.119/32 dev ppp0
Jan  1 03:34:28 mx31tt01 user.info connMan[402]: Domain name servers:
Jan  1 03:34:28 mx31tt01 user.info connMan[402]: 139.7.30.126
Jan  1 03:34:28 mx31tt01 user.info connMan[402]: Adding route ip route =

add 139.7.30.126/32 dev ppp0
Jan  1 03:34:28 mx31tt01 user.info connMan[402]: 139.7.30.125
Jan  1 03:34:28 mx31tt01 user.info connMan[402]: Adding route ip route =

add 139.7.30.125/32 dev ppp0
Jan  1 03:34:28 mx31tt01 user.info connMan[402]: resolv.conf file will =

look like this:
Jan  1 03:34:28 mx31tt01 user.info connMan[402]: nameserver 139.7.30.126 =

nameserver 139.7.30.125
Jan  1 03:34:28 mx31tt01 user.info connMan[402]: Writing resolv.conf
Jan  1 03:34:29 mx31tt01 user.info connMan[402]: Setting default route =

for interface ppp0
Jan  1 03:34:29 mx31tt01 user.info connMan[402]: Adding default route =

route add default gw 2.205.178.119 ppp0
Jan  1 03:34:30 mx31tt01 daemon.debug ofonod[471]: =

plugins/udevng.c:check_modem_list()

> Although ConnMan is correctly waiting for the modem to be attached to =

> the network before trying to reconnect, maybe modem is not internally =

> ready to reconnect. The reason might be PPP session ending is =

> initiated by oFono core and not the modem itself.
> With Huawei modems we also noticed that automatic reconnection was =

> sometime failing also. But testing conditions were not the same as we =

> could not disconnect the antenna.
> Anyway I am not a PPP expert but something wrong is happening between =

> the network and your modem because not IP configuration is sent by the =

> network.

Thanks a lot for your help so far. You have given me some good points to =

dig into ofono.

Kind regards,
Christopher

--
Scanned by MailScanner.


--===============0528472864638173344==--

