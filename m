Content-Type: multipart/mixed; boundary="===============8752680360943340489=="
MIME-Version: 1.0
From: Chrisopher Vogl <christopher.vogl@hale.at>
Subject: Re: Re-activating a context.
Date: Wed, 29 Aug 2012 20:40:51 +0200
Message-ID: <1646126421.203726.1346265651893.JavaMail.root@mail.hale>
In-Reply-To: <50002519.3060105@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8752680360943340489==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume and Denis,

<snip>

>> pppcp_initialize_restart_count: current state 6:REQSENT
>> Jan  1 01:20:21 mx31tt01 daemon.info ofonod[810]: PPP: ipcp: =

>> pppcp_send_configure_request: current state 6:REQSENT

>> Jan  1 01:20:21 mx31tt01 daemon.info ofonod[810]: Aux: < \r\n+CGEV: ME =

>> DEACT IP, , 1\r\n

> It seems IP Control Protocol is failing so that modem cannot receive the =

> IP configuration from the network.
> IP phase is deactivated by the modem itself.
> I don't know what is happening there.

<snip>

> Although ConnMan is correctly waiting for the modem to be attached to =

> the network before trying to reconnect, maybe modem is not internally =

> ready to reconnect. The reason might be PPP session ending is initiated =

> by oFono core and not the modem itself.
> With Huawei modems we also noticed that automatic reconnection was =

> sometime failing also. But testing conditions were not the same as we =

> could not disconnect the antenna.
> Anyway I am not a PPP expert but something wrong is happening between =

> the network and your modem because not IP configuration is sent by the =

> network.


I now know why I receive '+CGEV: ME DEACT IP, , 1\r\n'.
According to Telit support this happens because the context does not get de=
activated
and ofono is trying to request a new IP address although the previous one i=
s still valid.

After the antenna gets disconnected, the modem sends '+CREG: 2' and '+CGREG=
: 2'.
In consequence drivers/atmodem/gprs-context.c:telit_gprs_detach_shutdown() =
is called to end ppp connection and
'AT+CGATT=3D0' is sent.
'AT+CGATT=3D0' should normally deactivate all active contexts, but it retur=
ns '+CME ERROR: 30'.
When I try to deactivate the context with +CGACT like ifx does in
drivers/ifxmodem/gprs-context.c:ifx_gprs_deactivate_primary(), then I get '=
+CME ERROR: 0' (phone failure).

Furthermore I thought that when I receive 'NO CARRIER' at least then all co=
ntext should be deactivated.
From a Cinterion manual (as the Telit manual is very poor):
"If the TE wants to close the LCP link the MT may perform an LCP terminatio=
n request procedure on PPP level.
After this LCP termination procedure the MT deactivates the PDP context aut=
omatically and the MT returns to
V.250 command mode and issues the final result code NO CARRIER."

I don't know if this is a firmware or ofono issue as I don't know how this =
should be handled correctly.


Regards,

Christopher






--
Scanned by MailScanner.


--===============8752680360943340489==--

