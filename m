Content-Type: multipart/mixed; boundary="===============2153856347663119768=="
MIME-Version: 1.0
From: Mike Williams <mike@mikebwilliams.com>
Subject: Re: Query on ppp0 interface for HE910 device
Date: Fri, 29 May 2015 15:44:41 -0400
Message-ID: <CANPyyuOOtC6p9pb29bRq2fpO9cCr6o3zQpO_Bsnzheh5VfzgAQ@mail.gmail.com>
In-Reply-To: <CAC3zGv8bGVJ71eoxca2j6HqDOF7QPv8W49UMuGmLtf900cKbcg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2153856347663119768==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Alexey,

On Fri, May 29, 2015 at 2:32 PM, Alexey Mednyy <swexru@gmail.com> wrote:
> Hello Mike,
> AFAIK if you want to connman and ofono work well together, your modem must
> implement set_online interface in driver.
>
> I've posted patch for he910
>
> https://lists.ofono.org/pipermail/ofono/2014-December/015527.html

Hmm. I don't see any difference in behavior. AT+CFUN=3D4,0 is never sent
with or without the patch so I guess that makes sense.

Mike

>
> But it works only if you have recent firmware version.
>
> _________________________________
> Best regards, Mednyy Alexey.
>
> On Fri, May 29, 2015 at 8:24 PM, Mike Williams <mike@mikebwilliams.com>
> wrote:
>>
>> >Whenever the connman daemon switches from cellular to wifi automaticall=
y,
>> > ofonod >removes the ppp0 interface.
>> >On the oterhway round the ofono daemon is not doing the addition of the
>> > ppp0 interface.
>>
>> I can reproduce this on an HE910 I just started testing. Basically,
>> the ofono cellular service never reappears to connman after connman
>> disconnects it.
>>
>> # connmanctl technologies
>> /net/connman/technology/cellular
>>  Name =3D Cellular
>>  Type =3D cellular
>>  Powered =3D True
>>  Connected =3D False
>>  Tethering =3D False
>> /net/connman/technology/ethernet
>>  Name =3D Wired
>>  Type =3D ethernet
>>  Powered =3D True
>>  Connected =3D False
>>  Tethering =3D False
>> # connmanctl services
>> *AR Wired                ethernet_001122edb058_cable
>> *A  T-Mobile             cellular_310260008772362_context1
>> # connmanctl disable ethernet
>> Disabled ethernet
>> # macb f0028000.ethernet eth0: link down
>> # connmanctl services
>> *AR T-Mobile             cellular_310260008772362_context1
>> # connmanctl enable ethernet
>> IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
>> Enabled ethernet
>> # macb f0028000.ethernet eth0: link up (100/Full)
>> IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
>> # connmanctl services
>> *AR Wired                ethernet_001122edb058_cable
>> #
>>
>> The cellular service will never reappear.
>>
>> ofono debug log:
>>
>> ofonod[1543]: PPP: lcp: pppcp_process_terminate_ack: current state
>> 4:CLOSING
>> ofonod[1543]: PPP: lcp: pppcp_generate_event: current state 4:CLOSING
>> ofonod[1543]: PPP: event: 11 (RTA), action: 802, new_state: 2 (CLOSED)
>> ofonod[1543]: PPP: lcp: pppcp_this_layer_finished: current state 2:CLOSED
>> ofonod[1543]: PPP: gatchat/gatppp.c:ppp_enter_phase() 0
>> ofonod[1543]: PPP: gatchat/gatppp.c:ppp_dead()
>> ofonod[1543]: drivers/atmodem/gprs-context.c:ppp_disconnect() Reason: 6
>> ofonod[1543]: Aux: < \r\n+CGEV: ME DEACT IP, "22.226.202.227", 1\r\n
>> ofonod[1543]: Aux: < \r\n
>> ofonod[1543]: Aux: < +CGREG: 0\r\n\r\n+CGEV: NW DETACH\r\n
>> ofonod[1543]: src/gprs.c:ofono_gprs_status_notify() /he910_0 status 0
>> ofonod[1543]: src/gprs.c:ofono_gprs_detached_notify() /he910_0
>> ofonod[1543]: Aux: < \r\n
>> ofonod[1543]: Aux: < +CGREG: 0\r\n\r\n+CREG: 1,"2004","076277F",2\r\n
>> ofonod[1543]: src/gprs.c:ofono_gprs_status_notify() /he910_0 status 0
>> ofonod[1543]: src/network.c:ofono_netreg_status_notify() /he910_0
>> status 1 tech 2
>> ofonod[1543]: src/gprs.c:netreg_status_changed() 1
>> ofonod[1543]: Aux: > AT+COPS=3D3,2\r
>> ofonod[1543]: Aux: < \r\nOK\r\n
>> ofonod[1543]: Aux: > AT+COPS?\r
>> ofonod[1543]: Aux: < \r\n
>> ofonod[1543]: Aux: < +COPS: 0,2,"310260",2\r\n\r\nOK\r\n
>> ofonod[1543]: drivers/atmodem/network-registration.c:cops_numeric_cb()
>> Cops numeric got mcc: 310, mnc: 260
>> ofonod[1543]: Aux: > AT+CIND?\r
>> ofonod[1543]: Aux: < \r\n
>> ofonod[1543]: Aux: < +CIND: 0,3,1,0,0,0,0,0,2\r\n\r\nOK\r\n
>> ofonod[1543]: Aux: > AT+COPS=3D3,0\r
>> ofonod[1543]: Aux: < \r\nOK\r\n
>> ofonod[1543]: Aux: > AT+COPS?\r
>> ofonod[1543]: Aux: < \r\n
>> ofonod[1543]: Aux: < +COPS: 0,0,"T-Mobile",2\r\n\r\nOK\r\n
>> ofonod[1543]: drivers/atmodem/network-registration.c:cops_cb()
>> cops_cb: T-Mobile, 310 260 2
>> ofonod[1543]: src/network.c:current_operator_callback() 0xcb600, 0xd0cb0
>>
>>
>> Contexts for that modem still appear when when listing them via dbus:
>> dbus-send --system --print-reply --dest=3Dorg.ofono /he910_0
>> org.ofono.ConnectionManager.GetContexts
>>
>>
>> method return sender=3D:1.36 -> dest=3D:1.48 reply_serial=3D2
>>   array [
>>      struct {
>>         object path "/he910_0/context1"
>>         array [
>>            dict entry(
>>               string "Name"
>>               variant                   string "LTE"
>>            )
>>            dict entry(
>>               string "Active"
>>               variant                   boolean false
>>            )
>>            dict entry(
>>               string "Type"
>>               variant                   string "internet"
>>            )
>> <Truncated>
>>
>>
>> Manually trying to activate that context fails:
>> # dbus-send --system --print-reply --dest=3Dorg.ofono /he910_0/context1
>> org.ofono.
>> ConnectionContext.SetProperty string:Active variant:boolean:true
>> Error org.ofono.Error.NotAttached: GPRS is not attached
>>
>>
>> Thanks,
>> Mike
>> _______________________________________________
>> ofono mailing list
>> ofono(a)ofono.org
>> https://lists.ofono.org/mailman/listinfo/ofono
>
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>

--===============2153856347663119768==--

