Content-Type: multipart/mixed; boundary="===============3865725814814860093=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: Re: Ublox Toby Modem
Date: Fri, 22 Apr 2016 17:36:00 +0200
Message-ID: <571A44E0.6040201@endocode.com>
In-Reply-To: <571A1047.4040507@gmx.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3865725814814860093==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yorn,

On 04/22/2016 01:51 PM, Yorn wrote:
> Hi Dragos,
> =

> many thanks for all the effort! Comments inline:
> =

> Am 22.04.2016 um 12:23 schrieb Dragos Tatulea:
>> Hi Yorn,
>>
>> On 04/21/2016 08:37 PM, Yorn wrote:
>>> Hi Dragos
>>>
>>> Am 21.04.2016 um 11:03 schrieb Dragos Tatulea:
>>>> Hi Yarn,
>>>>
>>>> On 04/20/2016 07:54 PM, Yorn wrote:
>>>>> Hi Dragos,
>>>>>
>>>>> logs + comments inline
>>>>>
>>>>> Am 20.04.2016 um 17:01 schrieb Dragos Tatulea:
>>>>>> Hi Yorn,
>>>>>>
>>>>>> On 04/20/2016 04:24 PM, Yorn wrote:
>>>>>>> Hi Dragos,
>>>>>>>
>>>>>>> it is still active=3D0 :(
>>>>>>>
>>>>>>> root(a)colibri-vf:~/test# ./list-contexts
>>>>>>> [ /ublox_0 ]
>>>>>>>        [ /ublox_0/context1 ]
>>>>>>>            Username =3D
>>>>>>>            AuthenticationMethod =3D chap
>>>>>>>            Protocol =3D ip
>>>>>>>            Name =3D Internet
>>>>>>>            Settings =3D { }
>>>>>>>            IPv6.Settings =3D { }
>>>>>>>            Active =3D 0
>>>>>>>            AccessPointName =3D
>>>>>>>            Password =3D
>>>>>>>            Type =3D internet
>>>>>>>
>>>>>> Can you run only oFono (no connman) with OFONO_AT_DEBUG env variable=
 set
>>>>>> and run the following scripts:
>>>>>>
>>>>>> enable-modem
>>>>>> online-modem
>>>>>> activate-context
>>>>>>
>>>>>> Then send the logs.
>>>>> Here they are [1]
>>> I am actually a bit lost in the ublox AT Commands manual..
>>>
>>> Do you have a chance to see something at the ofonod+AT logs with your e=
xpertice!?
>>>
>> oFono was able to register on the network an activate the context. This
>> part is interesting for you:
>>
>> ofonod[369]: drivers/ubloxmodem/gprs-context.c:ublox_gprs_activate_prima=
ry() cid 1
>> ofonod[369]: Aux: > AT\r
>> ofonod[369]: Aux: < \r\nOK\r\n
>> ofonod[369]: Aux: Finally woke up the modem
>> ofonod[369]: Aux: > AT+CGDCONT=3D1,"IP","m2m.tele2.com"\r
>> *> context defined
>>
>> ofonod[369]: Aux: < \r\nOK\r\n
>> ofonod[369]: drivers/ubloxmodem/gprs-context.c:cgdcont_cb() ok 1
>> ofonod[369]: Aux: > AT+CGACT=3D1,1\r
>> *> context activated
>>
>> ofonod[369]: Aux: < \r\nOK\r\n
>> ofonod[369]: drivers/ubloxmodem/gprs-context.c:cgact_enable_cb() ok 1
>> ofonod[369]: Aux: > AT+CGCONTRDP=3D1\r
>> ofonod[369]: Aux: < \r\n+CREG: 5,"0000","00000010",4\r\n\r\n+CGEV: ME PD=
N ACT 1\r\n
>> ofonod[369]: src/network.c:ofono_netreg_status_notify() /ublox_0 status =
5 tech 4
>> ofonod[369]: src/gprs.c:netreg_status_changed() 5
>> ofonod[369]: src/gprs.c:gprs_netreg_update() attach: 1, driver_attached:=
 1
>> ofonod[369]: Aux: < \r\n+CGCONTRDP: 1,0,"m2m.tele2.com","
>> ofonod[369]: Aux: < 100.98.55.207.255.255.255.255","100.98.55.207","130.=
244.127.161","130.244.127.169","0.0.0.0","0.0.0.0",0\r\n
>> ofonod[369]: Aux: < \r\nOK\r\n
>> *> connection properties read successfully
>>
>> ofonod[369]: drivers/ubloxmodem/gprs-context.c:cgcontrdp_cb() ok 1
>> ofonod[369]: src/modem.c:get_modem_property() modem 0x192a900 property N=
etworkInterface
>>
>>> The connman cellular service is set to "a" (association) from starting
>>> connect cellular_240075810199181_context1
>>> up until timeout.
>>>
>> Do you still run the oFono scripts? From the logs it looks like connman
>> is trying to activate an already active context.
> The technologie and the service is running, but the association does not =
end successfully. Do I need to set something else in connman? Where do I ha=
ve to look?
> =

> The try to connect ends up with:
> Error /net/connman/service/cellular_240075810199181_context1: Did not rec=
eive a reply. Possible causes include: the remote application did not send =
a reply, the message bus security policy blocked the reply, the reply timeo=
ut expired, or the network connection was broken.
> =

Can you send the connman logs as well? I'm not really sure what's
happening here.

Thanks
-- =

Dragos Tatulea
Software Developer @ Endocode AG
dragos(a)endocode.com

Endocode AG, Br=C3=BCckenstra=C3=9Fe 5A, 10179 Berlin
+49 30 1206 4472 | info(a)endocode.com | www.endocode.com

Vorstandsvorsitzender: Mirko Boehm
Vorst=C3=A4nde: Dr. Thomas Fricke, Sebastian Sucker
Aufsichtsratsvorsitzende: Alexandra Boehm

Registergericht: Amtsgericht Charlottenburg - HRB 150748 B

--===============3865725814814860093==--

