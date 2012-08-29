Content-Type: multipart/mixed; boundary="===============2226347292045626689=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Re-activating a context.
Date: Wed, 29 Aug 2012 18:56:50 -0500
Message-ID: <503EAC42.3070104@gmail.com>
In-Reply-To: <1646126421.203726.1346265651893.JavaMail.root@mail.hale>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2226347292045626689==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

<snip>

> I now know why I receive '+CGEV: ME DEACT IP, , 1\r\n'.
> According to Telit support this happens because the context does not get =
deactivated
> and ofono is trying to request a new IP address although the previous one=
 is still valid.
>
> After the antenna gets disconnected, the modem sends '+CREG: 2' and '+CGR=
EG: 2'.
> In consequence drivers/atmodem/gprs-context.c:telit_gprs_detach_shutdown(=
) is called to end ppp connection and
> 'AT+CGATT=3D0' is sent.
> 'AT+CGATT=3D0' should normally deactivate all active contexts, but it ret=
urns '+CME ERROR: 30'.

That sounds like a firmware bug, we should be able to tell the modem to =

abort the attach procedure or detach at any time.

> When I try to deactivate the context with +CGACT like ifx does in
> drivers/ifxmodem/gprs-context.c:ifx_gprs_deactivate_primary(), then I get=
 '+CME ERROR: 0' (phone failure).
>

Does sending 'AT+CGACT=3D0' per 3GPP 27.007 10.1.10 work?

> Furthermore I thought that when I receive 'NO CARRIER' at least then all =
context should be deactivated.
>  From a Cinterion manual (as the Telit manual is very poor):
> "If the TE wants to close the LCP link the MT may perform an LCP terminat=
ion request procedure on PPP level.
> After this LCP termination procedure the MT deactivates the PDP context a=
utomatically and the MT returns to
> V.250 command mode and issues the final result code NO CARRIER."

Yes, that is the expected behavior, NO CARRIER means context is =

deactivated.  We've had problems with Huawei modems that try to keep the =

PPP link alive when network registration is lost.  We then had to =

force-deactivate them by sending the relevant LCP close procedure.  But =

that doesn't seem to be the issue here...

>
> I don't know if this is a firmware or ofono issue as I don't know how thi=
s should be handled correctly.
>

Sounds like firmware is at fault, or maybe the Telit modem has to be =

driven 'differently', but I do not see how.

Regards,
-Denis

--===============2226347292045626689==--

