Content-Type: multipart/mixed; boundary="===============8134683216486742720=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Randomly SMS sent passes or fails
Date: Thu, 28 Mar 2013 09:24:16 -0500
Message-ID: <51545290.5000804@gmail.com>
In-Reply-To: <5154070A.9040108@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8134683216486742720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anthony,

> Actually, I have always troubles with T-Mobile. I think I need to fix
> this provisioning issue. How can I do this ? I tried to see where this
> provisioning in the source code but I was quickly lost.
>

plugins/provision.c

> Bellow, you could see some troubles I have.
>
> scenario:
> * enable modem power ;
> * enter pin code ;
> * set APN ;
> * and tried to enable GPRS.
>
> ------------------------------------------------------------------
> [...]
> ofonod[14111]: Data: > AT+CREG?\r
> ofonod[14111]: Data: < \r\n+CREG: 2,1, 889D, 13EB0D\r\n\r\nOK\r\n
> ofonod[14111]: src/network.c:ofono_netreg_status_notify() /simcom_1
> status 1 tech -1
> ofonod[14111]: src/cbs.c:cbs_location_changed() 1, -1, -1, -1, (null)(nul=
l)
> ofonod[14111]: src/gprs.c:netreg_status_changed() 1
> ofonod[14111]: Data: > AT+CGATT=3D0\r
> ofonod[14111]: Data: < \r\n+CGREG: 0\r\n\r\nOK\r\n
> ofonod[14111]: Data: < \r\n+CGEV: ME DETACH\r\n
> ofonod[14111]: src/gprs.c:ofono_gprs_status_notify() /simcom_1 status 0
> ofonod[14111]: src/gprs.c:gprs_attach_callback() /simcom_1 error =3D 0
> ofonod[14111]: src/gprs.c:ofono_gprs_detached_notify() /simcom_1
> ofonod[14111]: Data: > AT+COPS=3D3,2\r
> ------------------------------------------------------------------
>

Is the modem auto-attaching to GPRS by default?  You might want to turn =

off that behavior if posible.

> First, there are no answer from modem about "AT+COPS=3D3,2" command.

Looks like a firmware bug

>
> And next, the "+CGEV: ME DETACH" disturb me. In the documentation of the
> SIMCOM module, I see :
>
> "The mobile equipment has forced a Packet Domain detach. This implies
> that all active contexts have been deactivated. These are not reported
> separately."

That is the result of AT+CGATT=3D0 command.

>
> I tried to re-attach with "Active" command but it fails :
>
> ------------------------------------------------------------------
> # dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.ofono
> /simcom_1/context1 org.ofono.ConnectionContext.SetProperty
> string:"Active" variant:boolean:true
> Error org.ofono.Error.NotAttached: GPRS is not attached
> ------------------------------------------------------------------
>
> In ConnectionManager, I see the "Attached" variable is "False".
>

Try toggling the ConnectionManager Powered property off and then on. =

Also a fuller log might be helpful.

> Can you help me ?
>
> Regards,
> Anthony.

Regards,
-Denis

--===============8134683216486742720==--

