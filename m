Content-Type: multipart/mixed; boundary="===============1666155253705627682=="
MIME-Version: 1.0
From: Zhang, Caiwen <Caiwen.Zhang@windriver.com>
Subject: RE: Can I modify CallingLineRestriction(the Property
 ofCallSetting)	value to "disabled" or "enabled"
Date: Thu, 11 Nov 2010 04:06:27 +0100
Message-ID: <D87B22B1FE8C0F479CA9BEAD6C25AAE805FF3E80@ism-mail03.corp.ad.wrs.com>
In-Reply-To: <CE761E84DADF2947A4AF22FB8D97A473305616E9@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1666155253705627682==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> -----Original Message-----
> From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On
> Behalf Of Gu, Yang
> Sent: Thursday, November 11, 2010 10:37 AM
> To: ofono(a)ofono.org
> Subject: RE: Can I modify CallingLineRestriction(the Property
> ofCallSetting) value to "disabled" or "enabled"
> =

> Hi,
> =

> =

> >-----Original Message-----
> >From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On
> Behalf Of
> >Pekka Pessi
> >Sent: Wednesday, November 10, 2010 8:33 PM
> >To: ofono(a)ofono.org
> >Subject: Re: Can I modify CallingLineRestriction(the Property of
> CallSetting) value to
> >"disabled" or "enabled"
> >
> >Hi all,
> >
> >2010/11/10 Gu, Yang <yang.gu@intel.com>:
> >>>According to your tip , I tried to set "HideCallerId" to "default",
> "disabled" and
> >>>"enabled", and I can verify by run list-modem script that
> "HideCallerId" had been
> >>>modified . but I still could find phone number on both called party
> and calling party ,
> >>>regardless the value of =C2=A0"HideCallerId" is what.
> >>>
> >>>How can I let phone number be withheld on incoming at called party ,
> when I make
> >a
> >>>voice call.
> >>
> >> I think the reason is your operator doesn't provide this
> supplementary service.
> >Below is my log when enable the "HideCallerId". I couldn't enable this
> feature either.
> >>
> >> ofonod[17734]: PCUI: > AT+CLIR=3D1\r
> >> ofonod[17734]: PCUI: < \r\nOK\r\n
> >> ofonod[17734]: PCUI: > AT+CLIR?\r
> >> ofonod[17734]: PCUI: < \r\n+CLIR: 1,0\r\n\r\nOK\r\n
> >> ofonod[17734]: drivers/atmodem/call-settings.c:clir_query_cb()
> clir_query_cb:
> >override: 1, network: 0
> >
> >What happens when you make a call? Does call get rejected or do you
> >get some CSSU indications?
> =

> Thank you for the comments!
> After setting HideCallerId to "enabled", and making an outgoing call,
> the call arrived at another phone as normal, and I didn't see any CSSU
> indication. The call settings are listed below, in which the
> CallingLineRestriction is always disabled. I think this means the
> network disables this feature. I also confirmed with our operator
> (CMCC), and they said they don't support CLIR.
>     [ org.ofono.CallSettings ]
>         CalledLineRestriction =3D unknown
>         HideCallerId =3D enabled
>         CallingLinePresentation =3D enabled
>         CalledLinePresentation =3D disabled
>         VoiceCallWaiting =3D enabled
>         CallingLineRestriction =3D disabled
> =


As I know only particular subscriber can subscribe Calling line restriction=
(CLIR)
service, Such as police. Normal subscriber can not use this service.

Similarly, CLIP is the same, it depends on whether subscriber subscribe the=
 service.
The setting at modem side don't take effect.

> >
> >Yang and Haitao, please set HideCallerId to "disabled", try to make
> >call, then set HideCallerId to "enabled", try to make a call, and
> >perhaps also try to make call with test/dial-number number enabled and
> >test/dial-number disabled and then post the results.
> =

> Below are the detailed logs. It looks all the same for different
> scenarios:
> =

> *********************************
> Set HideCallerId to "disabled"
> ./test-voicecall 13917758428
> *********************************
> =

> ofonod[8291]: PCUI: > ATD13917758428;\r
> ofonod[8291]: PCUI: < \r\nOK\r\n\r\n^ORIG:1,0\r\n
> ofonod[8291]: src/voicecall.c:dial_handle_result() Registering new call:
> 1
> ofonod[8291]: src/audio-settings.c:ofono_audio_settings_active_notify()
> active 1
> ofonod[8291]: Call origin: id 1 type 0
> ofonod[8291]: src/voicecall.c:ofono_voicecall_notify() Got a voicecall
> event, status: 2, id: 1, number:
> ofonod[8291]: src/voicecall.c:ofono_voicecall_notify() Found call with
> id: 1
> ofonod[8291]: PCUI: > AT^DDSETEX=3D2\r
> ofonod[8291]: PCUI: < \r\nOK\r\n
> ofonod[8291]: PCUI: < \r\n^CONF:1\r\n
> ofonod[8291]: Call setup: id 1
> ofonod[8291]: src/voicecall.c:ofono_voicecall_notify() Got a voicecall
> event, status: 3, id: 1, number:
> ofonod[8291]: src/voicecall.c:ofono_voicecall_notify() Found call with
> id: 1
> ofonod[8291]: PCUI: < \r\n^RSSI:28\r\n
> ofonod[8291]: PCUI: < \r\n^RSSI:31\r\n
> ofonod[8291]: PCUI: < \r\n^BOOT:20294233,0,0,0,20\r\n
> ofonod[8291]: PCUI: < \r\n^RSSI:29\r\n
> ofonod[8291]: PCUI: < \r\n^CEND:1,0,104,31\r\n
> ofonod[8291]: src/audio-settings.c:ofono_audio_settings_active_notify()
> active 0
> ofonod[8291]: Call end: id 1 duration 0s status 104
> ofonod[8291]: src/voicecall.c:ofono_voicecall_disconnected() Got
> disconnection event for id: 1, reason: 0
> ofonod[8291]: Call Ended on modem: 0xa0a01a0
> ofonod[8291]: Voice Call, Outgoing
> ofonod[8291]: To: 13917758428
> ofonod[8291]: StartTime: 2010-11-11T10:15:16+0800
> ofonod[8291]: EndTime: 2010-11-11T10:15:57+0800
> ofonod[8291]: PCUI: < \r\n^MODE:3,3\r\n
> ofonod[8291]: PCUI: < \r\n^BOOT:20294233,0,0,0,20\r\n
> =

> *********************************
> Set HideCallerId to "enabled"
> ./test-voicecall 13917758428
> *********************************
> =

> ofonod[8291]: PCUI: > ATD13917758428;\r
> ofonod[8291]: PCUI: < \r\nOK\r\n\r\n^ORIG:1,0\r\n
> ofonod[8291]: src/voicecall.c:dial_handle_result() Registering new call:
> 1
> ofonod[8291]: src/audio-settings.c:ofono_audio_settings_active_notify()
> active 1
> ofonod[8291]: Call origin: id 1 type 0
> ofonod[8291]: src/voicecall.c:ofono_voicecall_notify() Got a voicecall
> event, status: 2, id: 1, number:
> ofonod[8291]: src/voicecall.c:ofono_voicecall_notify() Found call with
> id: 1
> ofonod[8291]: PCUI: > AT^DDSETEX=3D2\r
> ofonod[8291]: PCUI: < \r\nOK\r\n
> ofonod[8291]: PCUI: < \r\n^CONF:1\r\n
> ofonod[8291]: Call setup: id 1
> ofonod[8291]: src/voicecall.c:ofono_voicecall_notify() Got a voicecall
> event, status: 3, id: 1, number:
> ofonod[8291]: src/voicecall.c:ofono_voicecall_notify() Found call with
> id: 1
> ofonod[8291]: PCUI: < \r\n^RSSI:26\r\n
> ofonod[8291]: PCUI: < \r\n^RSSI:21\r\n
> ofonod[8291]: PCUI: < \r\n^BOOT:20294233,0,0,0,20\r\n
> ofonod[8291]: PCUI: < \r\n^RSSI:18\r\n
> ofonod[8291]: PCUI: < \r\n^CEND:1,0,104,31\r\n
> ofonod[8291]: src/audio-settings.c:ofono_audio_settings_active_notify()
> active 0
> ofonod[8291]: Call end: id 1 duration 0s status 104
> ofonod[8291]: src/voicecall.c:ofono_voicecall_disconnected() Got
> disconnection event for id: 1, reason: 0
> ofonod[8291]: Call Ended on modem: 0xa0a01a0
> ofonod[8291]: Voice Call, Outgoing
> ofonod[8291]: To: 13917758428
> ofonod[8291]: StartTime: 2010-11-11T10:13:39+0800
> ofonod[8291]: EndTime: 2010-11-11T10:14:19+0800
> ofonod[8291]: PCUI: < \r\n^MODE:3,3\r\n
> ofonod[8291]: PCUI: < \r\n^RSSI:31\r\n
> ofonod[8291]: PCUI: < \r\n^BOOT:20294233,0,0,0,20\r\n
> =

> *********************************
> ./dial-number 13917758428 enabled
> *********************************
> =

> ofonod[8291]: PCUI: > ATD13917758428I;\r
> ofonod[8291]: PCUI: < \r\nOK\r\n
> ofonod[8291]: src/voicecall.c:dial_handle_result() Registering new call:
> 1
> ofonod[8291]: PCUI: < \r\n^ORIG:1,0\r\n
> ofonod[8291]: src/audio-settings.c:ofono_audio_settings_active_notify()
> active 1
> ofonod[8291]: Call origin: id 1 type 0
> ofonod[8291]: src/voicecall.c:ofono_voicecall_notify() Got a voicecall
> event, status: 2, id: 1, number:
> ofonod[8291]: src/voicecall.c:ofono_voicecall_notify() Found call with
> id: 1
> ofonod[8291]: PCUI: > AT^DDSETEX=3D2\r
> ofonod[8291]: PCUI: < \r\nOK\r\n
> ofonod[8291]: PCUI: < \r\n^CONF:1\r\n
> ofonod[8291]: Call setup: id 1
> ofonod[8291]: src/voicecall.c:ofono_voicecall_notify() Got a voicecall
> event, status: 3, id: 1, number:
> ofonod[8291]: src/voicecall.c:ofono_voicecall_notify() Found call with
> id: 1
> ofonod[8291]: PCUI: < \r\n^RSSI:28\r\n
> ofonod[8291]: PCUI: < \r\n^RSSI:23\r\n
> ofonod[8291]: PCUI: < \r\n^BOOT:20294233,0,0,0,20\r\n
> ofonod[8291]: PCUI: < \r\n^CEND:1,0,104,31\r\n
> ofonod[8291]: src/audio-settings.c:ofono_audio_settings_active_notify()
> active 0
> ofonod[8291]: Call end: id 1 duration 0s status 104
> ofonod[8291]: src/voicecall.c:ofono_voicecall_disconnected() Got
> disconnection event for id: 1, reason: 0
> ofonod[8291]: Call Ended on modem: 0xa0a01a0
> ofonod[8291]: Voice Call, Outgoing
> ofonod[8291]: To: 13917758428
> ofonod[8291]: StartTime: 2010-11-11T10:18:13+0800
> ofonod[8291]: EndTime: 2010-11-11T10:18:55+0800
> ofonod[8291]: PCUI: < \r\n^MODE:3,3\r\n
> ofonod[8291]: PCUI: < \r\n^RSSI:31\r\n
> =

> *********************************
> ./dial-number 13917758428 disabled
> *********************************
> =

> ofonod[8291]: PCUI: > ATD13917758428i;\r
> ofonod[8291]: PCUI: < \r\nOK\r\n\r\n^ORIG:1,0\r\n
> ofonod[8291]: src/voicecall.c:dial_handle_result() Registering new call:
> 1
> ofonod[8291]: src/audio-settings.c:ofono_audio_settings_active_notify()
> active 1
> ofonod[8291]: Call origin: id 1 type 0
> ofonod[8291]: src/voicecall.c:ofono_voicecall_notify() Got a voicecall
> event, status: 2, id: 1, number:
> ofonod[8291]: src/voicecall.c:ofono_voicecall_notify() Found call with
> id: 1
> ofonod[8291]: PCUI: > AT^DDSETEX=3D2\r
> ofonod[8291]: PCUI: < \r\nOK\r\n
> ofonod[8291]: PCUI: < \r\n^CONF:1\r\n
> ofonod[8291]: Call setup: id 1
> ofonod[8291]: src/voicecall.c:ofono_voicecall_notify() Got a voicecall
> event, status: 3, id: 1, number:
> ofonod[8291]: src/voicecall.c:ofono_voicecall_notify() Found call with
> id: 1
> ofonod[8291]: PCUI: < \r\n^RSSI:23\r\n
> ofonod[8291]: PCUI: < \r\n^RSSI:20\r\n
> ofonod[8291]: PCUI: < \r\n^BOOT:20294233,0,0,0,20\r\n
> ofonod[8291]: PCUI: < \r\n^CEND:1,0,104,31\r\n
> ofonod[8291]: src/audio-settings.c:ofono_audio_settings_active_notify()
> active 0
> ofonod[8291]: Call end: id 1 duration 0s status 104
> ofonod[8291]: src/voicecall.c:ofono_voicecall_disconnected() Got
> disconnection event for id: 1, reason: 0
> ofonod[8291]: Call Ended on modem: 0xa0a01a0
> ofonod[8291]: Voice Call, Outgoing
> ofonod[8291]: To: 13917758428
> ofonod[8291]: StartTime: 2010-11-11T10:20:16+0800
> ofonod[8291]: EndTime: 2010-11-11T10:20:55+0800
> ofonod[8291]: PCUI: < \r\n^MODE:3,3\r\n
> ofonod[8291]: PCUI: < \r\n^RSSI:30\r\n
> ofonod[8291]: PCUI: < \r\n^BOOT:20294233,0,0,0,20\r\n
> =

> =

> What's your opinion?
> =

> =

> Regards,
> -Yang
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

--===============1666155253705627682==--

