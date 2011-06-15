Content-Type: multipart/mixed; boundary="===============2075383526281358800=="
MIME-Version: 1.0
From: Claudio Degioanni <claudio.degioanni@zirak.it>
Subject: Re: Re: Problems ofono 0.45 and Nokia 6760
Date: Wed, 15 Jun 2011 09:23:27 +0200
Message-ID: <4DF85DEF.4030603@zirak.it>
In-Reply-To: <BANLkTikLft+D2ShS6p7EOokdv_3qyS0STQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2075383526281358800==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Il 08/06/2011 17.17, Jeevaka Prabu Badrappan ha scritto:
> Hi Claudio,
>
> On Wed, Jun 8, 2011 at 5:22 PM, Claudio Degioanni
> <claudio.degioanni@zirak.it> wrote:
>> Hi all,
>>
>> I have attacched a nokia 6760 to ofono for using it as gprs modem.
>>
>> I have started the daemon with
>>
>> OFONO_ISI_TRACE=3D1 OFONO_ISI_DEBUG=3D1 ofonod -nd
>>
>>
>> After enabling the modem and activate the profile using
>>
>> dbus-send --system --print-reply --reply-timeout=3D120000
>> --type=3Dmethod_call --dest=3D'org.ofono' /isiusb0
>> org.ofono.Modem.SetProperty string:Powered variant:boolean:true
>>
>> dbus-send --system --print-reply --reply-timeout=3D120000
>> --type=3Dmethod_call --dest=3D'org.ofono' /isiusb0
>> org.ofono.Modem.SetProperty string:Online variant:boolean:true
>>
>> dbus-send --system --print-reply --reply-timeout=3D120000
>> --type=3Dmethod_call --dest=3D'org.ofono' /isiusb0/context1
>> org.ofono.ConnectionContext.SetProperty string:AccessPointName
>> variant:string:ibox.tim.it
>>
>> dbus-send --system --print-reply --reply-timeout=3D120000
>> --type=3Dmethod_call --dest=3D'org.ofono' /isiusb0/context1
>> org.ofono.ConnectionContext.SetProperty string:Active variant:boolean:tr=
ue
>>
>> We obtain on last method calls the follow error:
>>
>> Error org.ofono.Error.NotAttached: GPRS is not attached
>>
>> You can help me ?
>>
>> PS: I have attacced the log on ofono.
> As per the log, there is some issue with the network registration
> status query. Log statement:
>
> "src/network.c:init_registration_status() Error during registration
> status query"
>
> isimodem people can help you on this issue.

Any news ?

regs
Claufio
> Regards,
> Jeevaka
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono


--===============2075383526281358800==--

