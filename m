Content-Type: multipart/mixed; boundary="===============1533122163464648393=="
MIME-Version: 1.0
From: Viallard Anthony <viallard@syscom-instruments.com>
Subject: Re: Randomly SMS sent passes or fails
Date: Thu, 28 Mar 2013 10:02:02 +0100
Message-ID: <5154070A.9040108@syscom-instruments.com>
In-Reply-To: <513658D4.8040508@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1533122163464648393==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 05. 03. 13 21:43, Denis Kenzior wrote:
>>
>> [...]
>>
>> Provisioning failed
>> -------------------------------
>
> This should not affect anything, unless your operator requires SMS to be
> sent over GPRS.
>

Hi,

I try to find how i can fix the "provisioning failed" message.

Actually, I have always troubles with T-Mobile. I think I need to fix =

this provisioning issue. How can I do this ? I tried to see where this =

provisioning in the source code but I was quickly lost.

Bellow, you could see some troubles I have.

scenario:
  * enable modem power ;
  * enter pin code ;
  * set APN ;
  * and tried to enable GPRS.

------------------------------------------------------------------
[...]
ofonod[14111]: Data: > AT+CREG?\r
ofonod[14111]: Data: < \r\n+CREG: 2,1, 889D, 13EB0D\r\n\r\nOK\r\n
ofonod[14111]: src/network.c:ofono_netreg_status_notify() /simcom_1 =

status 1 tech -1
ofonod[14111]: src/cbs.c:cbs_location_changed() 1, -1, -1, -1, (null)(null)
ofonod[14111]: src/gprs.c:netreg_status_changed() 1
ofonod[14111]: Data: > AT+CGATT=3D0\r
ofonod[14111]: Data: < \r\n+CGREG: 0\r\n\r\nOK\r\n
ofonod[14111]: Data: < \r\n+CGEV: ME DETACH\r\n
ofonod[14111]: src/gprs.c:ofono_gprs_status_notify() /simcom_1 status 0
ofonod[14111]: src/gprs.c:gprs_attach_callback() /simcom_1 error =3D 0
ofonod[14111]: src/gprs.c:ofono_gprs_detached_notify() /simcom_1
ofonod[14111]: Data: > AT+COPS=3D3,2\r
------------------------------------------------------------------

First, there are no answer from modem about "AT+COPS=3D3,2" command.

And next, the "+CGEV: ME DETACH" disturb me. In the documentation of the =

SIMCOM module, I see :

"The mobile equipment has forced a Packet Domain detach. This implies =

that all active contexts have been deactivated. These are not reported =

separately."

I tried to re-attach with "Active" command but it fails :

------------------------------------------------------------------
# dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.ofono =

/simcom_1/context1 org.ofono.ConnectionContext.SetProperty =

string:"Active" variant:boolean:true
Error org.ofono.Error.NotAttached: GPRS is not attached
------------------------------------------------------------------

In ConnectionManager, I see the "Attached" variable is "False".

Can you help me ?

Regards,
Anthony.

--===============1533122163464648393==--

