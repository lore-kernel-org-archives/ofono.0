Content-Type: multipart/mixed; boundary="===============8552845464966502291=="
MIME-Version: 1.0
From: Eric Nelson <eric.nelson@boundarydevices.com>
Subject: Re: Setting 'legacy' property for GSM modem
Date: Fri, 04 Apr 2014 16:09:19 -0700
Message-ID: <533F3B9F.7090209@boundarydevices.com>
In-Reply-To: <5330636B.1090008@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8552845464966502291==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanks for the tip, Denis.

On 03/24/2014 09:55 AM, Denis Kenzior wrote:
> Hi Eric,
>
> On 03/21/2014 05:51 PM, Eric Nelson wrote:
>> Hi all,
>>
>> I'm an Ofono N00b trying to figure out how configuration
>> should happen, and I'm a bit stuck.
>>
>> I'm trying to get a Novatel 3G modem configured, and seem
>> to be quite close.
>>
>> Using the nice OFONO_AT_DEBUG=3D1 switch, I can see what appears
>> to be proper traffic to the point of connection:
>>
>>      ofonod[1928]: Modem: > AT+CGDATA=3D"PPP",1\r
>>      ofonod[1928]: Modem: < \r\nCONNECT HSDPA 3.6\r\n
>>
>> And using strace, I see a bunch of writes following this:
>>
>>          write(11, "~\377}#\300!}!}!} }$\321\265~", 17) =3D 17
>>          write(11, "\377}#\300!}!}!} }$\321\265~", 16) =3D 16
>>
>> but no returned data.
>>
>> If I contrast this with the same card in my laptop running
>> Network Manager, I see that the "ATD*99**1#\r" string is
>> used to make the connection:
>>
>>      read(27, "\r\n+CGDCONT: 1,\"IP\",\"roam\",\"\",0,0"..., 1024) =3D 1=
15
>>      read(27, 0x130f623, 1024)               =3D -1 EAGAIN (Resource
>> temporarily unavailable)
>>      write(27, "A", 1)                       =3D 1
>>      write(27, "T", 1)                       =3D 1
>>      write(27, "D", 1)                       =3D 1
>>      write(27, "*", 1)                       =3D 1
>>      write(27, "9", 1)                       =3D 1
>>      write(27, "9", 1)                       =3D 1
>>      write(27, "*", 1)                       =3D 1
>>      write(27, "*", 1)                       =3D 1
>>      write(27, "*", 1)                       =3D 1
>>      write(27, "1", 1)                       =3D 1
>>      write(27, "#", 1)                       =3D 1
>>      write(27, "\r", 1)                      =3D 1
>>      read(27, "\r\nCONNECT HSDPA 3.6\r\n", 1024) =3D 21
>>
>> And data flows thereafter.
>>
>> Reading the code, it appears that this form of dialing string is
>> supported in Ofono, by using the 'legacy' option:
>>
>> http://git.kernel.org/cgit/network/ofono/ofono.git/tree/gatchat/gsmdial.=
c#n397
>>
>>
>
> gsmdial is just a developer / debug tool.  If you think that this model
> will require using ATD*99 syntax, then you will need to set a vendor
> quirk. The only vendor that currently requires using ATD*99 instead of
> +CGDATA is SIMCOM.
>
> Try the following as a quick test, change plugins/novatel.c post_sim():
> to do
>          gc =3D ofono_gprs_context_create(modem,
> OFONO_VENDOR_SIMCOM_SIM900, "atmodem", data->modem);
>
This didn't change things for me, and I actually found out that
the command was being sent by atmodem/gprs-context.c, which
doesn't support the legacy thing.

> and see if that solves your problem.  We have tested several Novatel
> modems and they seem to work just fine with +CGDATA, but you may have
> one that we have not tested.
>

Changing the connect string by hacking gprs-context.c didn't make a
difference for me (no surprise).

I think I have some other N00b configuration issue.

Setting OFONO_PPP_DEBUG shows this after the connect:

ofonod[1934]: PPP: lcp: pppcp_generate_event: current state 0:INITIAL
ofonod[1934]: PPP: event: 0 (Up), action: 2, new_state: 2 (CLOSED)
ofonod[1934]: PPP: lcp: pppcp_generate_event: current state 2:CLOSED
ofonod[1934]: PPP: event: 2 (Open), action: 1026, new_state: 6 (REQSENT)
ofonod[1934]: PPP: lcp: pppcp_initialize_restart_count: current state =

2:CLOSED
ofonod[1934]: PPP: lcp: pppcp_send_configure_request: current state 2:CLOSED

Oddly, shutting down connman and ofono allowed me to connect using
pppd though.

Regards,


Eric

--===============8552845464966502291==--

