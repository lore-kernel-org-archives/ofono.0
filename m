Content-Type: multipart/mixed; boundary="===============3918216915201954248=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Problems ofono 0.45 and Nokia 6760
Date: Mon, 06 Jun 2011 15:13:25 -0500
Message-ID: <4DED34E5.3070602@gmail.com>
In-Reply-To: <4DEF85AF.8000900@zirak.it>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3918216915201954248==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Claudio,

On 06/08/2011 09:22 AM, Claudio Degioanni wrote:
> Hi all,
> =

> I have attacched a nokia 6760 to ofono for using it as gprs modem.
> =

> I have started the daemon with
> =

> OFONO_ISI_TRACE=3D1 OFONO_ISI_DEBUG=3D1 ofonod -nd
> =

> =

> After enabling the modem and activate the profile using
> =

> dbus-send --system --print-reply --reply-timeout=3D120000
> --type=3Dmethod_call --dest=3D'org.ofono' /isiusb0
> org.ofono.Modem.SetProperty string:Powered variant:boolean:true
> =

> dbus-send --system --print-reply --reply-timeout=3D120000
> --type=3Dmethod_call --dest=3D'org.ofono' /isiusb0
> org.ofono.Modem.SetProperty string:Online variant:boolean:true
> =

> dbus-send --system --print-reply --reply-timeout=3D120000
> --type=3Dmethod_call --dest=3D'org.ofono' /isiusb0/context1
> org.ofono.ConnectionContext.SetProperty string:AccessPointName
> variant:string:ibox.tim.it
> =

> dbus-send --system --print-reply --reply-timeout=3D120000
> --type=3Dmethod_call --dest=3D'org.ofono' /isiusb0/context1
> org.ofono.ConnectionContext.SetProperty string:Active variant:boolean:true
> =

> We obtain on last method calls the follow error:
> =

> Error org.ofono.Error.NotAttached: GPRS is not attached
> =


You have to wait for the modem to attach to GPRS first.  Track the
status of the ConnectionManager 'Attached' property.  Once it changes to
TRUE, then you can try to activate a context.

Regards,
-Denis

--===============3918216915201954248==--

