Content-Type: multipart/mixed; boundary="===============3960578018450569537=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: PPP broken by 6fc119d9eaee5f9cc37a5a7198d1c55ef98fd645
Date: Fri, 04 Jan 2019 15:56:42 +0100
Message-ID: <8d58e401-3a72-c1e9-1d7c-dd97f8aaedb1@geanix.com>
In-Reply-To: <CAKSBH7E+jaBNUVv8BzaK=SifqhDEqMrLh9pXzpvZoBUgXixh6g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3960578018450569537==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 04/01/2019 15.30, Giacinto Cifelli wrote:
>> Seems commit  6fc119d9eaee5f9cc37a5a7198d1c55ef98fd645 broke PPP for
>> me in 1.27 (updating from 1.24) After reverting the commit (without
>> removing the header file include to not break compilation) PPP was
>> back to working for me.
>>
>> The comments for a88662d23c45f49d9af5a508d4d0a778950b2420 made me
>> suspect it is this part of the patch that broke it:
>>
>> diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
>> index df9cd0ef..3fe38217 100644
>> --- a/gatchat/ppp_lcp.c
>> +++ b/gatchat/ppp_lcp.c
>> @@ -279,6 +279,9 @@ static enum rcr_result lcp_rcr(struct pppcp_data *pp=
pcp,
>>                                  *new_len =3D 4;
>>
>>                                  return RCR_NAK;
>> +
>> +                       case G_AT_PPP_AUTH_METHOD_NONE:
>> +                               return RCR_REJECT;
> =

> I remember this, I added it because of a suggestion that couldn't just
> ignore it.
> Is your PDP context configured for AUTH_NONE, PAP or CHAP?
> And what happens if you change it?
> =

> =


I was just debugging the very same issue. I can add one more data point:
The issue only occurs when using a context created with the provision =

plugin, and not when provisioning fails. This is with AUTH_METHOD_NONE =

in both cases.

// Martin

>>                          }
>>                          break;
>>                  }
>>
>>
>> As I got the following log when it was not working:
>> ofonod[1069]: Setup: > AT+CGDCONT=3D1,"IP","internet"\r
>> ofonod[1069]: Setup: < \r\nO
>> ofonod[1069]: Setup: < K\r\n
>> ofonod[1069]: ../ofono-1.27/drivers/atmodem/gprs-context.c:at_cgdcont_cb=
() ok 1
>> ofonod[1069]: Setup: > ATD*99***1#\r
>> ofonod[1069]: Setup: < \r\nC
>> ofonod[1069]: Setup: < ONNECT 150
>> ofonod[1069]: Setup: < 000000\r
>> ofonod[1069]: ../ofono-1.27/drivers/atmodem/gprs-context.c:at_cgdata_cb(=
) ok 1
>> ofonod[1069]: ../ofono-1.27/drivers/atmodem/gprs-context.c:setup_ppp()
>> ofonod[1069]: PPP: lcp: pppcp_generate_event: current state 0:INITIAL
>> ofonod[1069]: PPP: event: 0 (Up), action: 2, new_state: 2 (CLOSED)
>> ofonod[1069]: PPP: lcp: pppcp_generate_event: current state 2:CLOSED
>> ofonod[1069]: PPP: event: 2 (Open), action: 1026, new_state: 6 (REQSENT)
>> ofonod[1069]: PPP: lcp: pppcp_initialize_restart_count: current state 2:=
CLOSED
>> ofonod[1069]: PPP: lcp: pppcp_send_configure_request: current state 2:CL=
OSED
>> ofonod[1069]: PPP: ../ofono-1.27/gatchat/gatppp.c:ppp_enter_phase() 1
>> ofonod[1069]: PPP: lcp: pppcp_process_configure_request: current state 6=
:REQSENT
>> ofonod[1069]: PPP: lcp: pppcp_generate_event: current state 6:REQSENT
>> ofonod[1069]: PPP: event: 7 (RCR-), action: 4006, new_state: 6 (REQSENT)
>> ofonod[1069]: PPP: lcp: pppcp_send_configure_nak: current state 6:REQSENT
>> ofonod[1069]: PPP: lcp: pppcp_process_configure_ack: current state 6:REQ=
SENT
>> ofonod[1069]: PPP: lcp: pppcp_generate_event: current state 6:REQSENT
>> ofonod[1069]: PPP: event: 8 (RCA), action: 27, new_state: 7 (ACKRCVD)
>> ofonod[1069]: PPP: lcp: pppcp_initialize_restart_count: current state 6:=
REQSENT
>> ofonod[1069]: PPP: lcp: pppcp_process_configure_request: current state 7=
:ACKRCVD
>> ofonod[1069]: PPP: lcp: pppcp_generate_event: current state 7:ACKRCVD
>> ofonod[1069]: PPP: event: 7 (RCR-), action: 4007, new_state: 7 (ACKRCVD)
>> ....
>>
>> And it kept looping with those RCR-...
>>
>> After reverting:
>>
>>
>> ofonod[1034]: Setup: > AT+CGDCONT=3D1,"IP","internet"\r
>> ofonod[1034]: Setup: < \r\nO
>> ofonod[1034]: Setup: < K\r\n
>> ofonod[1034]: ../ofono-1.27/drivers/atmodem/gprs-context.c:at_cgdcont_cb=
() ok 1
>> ofonod[1034]: Setup: > ATD*99***1#\r
>> ofonod[1034]: Setup: < \r\nC
>> ofonod[1034]: Setup: < ONNECT 15
>> ofonod[1034]: Setup: < 0000000\r
>> ofonod[1034]: ../ofono-1.27/drivers/atmodem/gprs-context.c:at_cgdata_cb(=
) ok 1
>> ofonod[1034]: ../ofono-1.27/drivers/atmodem/gprs-context.c:setup_ppp()
>> ofonod[1034]: PPP: lcp: pppcp_generate_event: current state 0:INITIAL
>> ofonod[1034]: PPP: event: 0 (Up), action: 2, new_state: 2 (CLOSED)
>> ofonod[1034]: PPP: lcp: pppcp_generate_event: current state 2:CLOSED
>> ofonod[1034]: PPP: event: 2 (Open), action: 1026, new_state: 6 (REQSENT)
>> ofonod[1034]: PPP: lcp: pppcp_initialize_restart_count: current state 2:=
CLOSED
>> ofonod[1034]: PPP: lcp: pppcp_send_configure_request: current state 2:CL=
OSED
>> ofonod[1034]: PPP: ../ofono-1.27/gatchat/gatppp.c:ppp_enter_phase() 1
>> ofonod[1034]: PPP: lcp: pppcp_process_configure_request: current state 6=
:REQSENT
>> ofonod[1034]: PPP: lcp: pppcp_generate_event: current state 6:REQSENT
>> ofonod[1034]: PPP: event: 6 (RCR+), action: 2008, new_state: 8 (ACKSENT)
>> ofonod[1034]: PPP: lcp: pppcp_send_configure_ack: current state 6:REQSENT
>> ofonod[1034]: PPP: lcp: pppcp_process_configure_ack: current state 8:ACK=
SENT
>> ofonod[1034]: PPP: lcp: pppcp_generate_event: current state 8:ACKSENT
>> ofonod[1034]: PPP: event: 8 (RCA), action: 129, new_state: 9 (OPENED)
>> ofonod[1034]: PPP: lcp: pppcp_initialize_restart_count: current state 8:=
ACKSENT
>> ofonod[1034]: PPP: ../ofono-1.27/gatchat/gatppp.c:ppp_enter_phase() 2
>> ofonod[1034]: PPP: ../ofono-1.27/gatchat/gatppp.c:ppp_enter_phase() 3
>> ofonod[1034]: PPP: ipcp: pppcp_generate_event: current state 0:INITIAL
>> ofonod[1034]: PPP: event: 2 (Open), action: 401, new_state: 1 (STARTING)
>> ofonod[1034]: PPP: ipcp: pppcp_generate_event: current state 1:STARTING
>> ofonod[1034]: PPP: event: 0 (Up), action: 1026, new_state: 6 (REQSENT)
>> ofonod[1034]: PPP: ipcp: pppcp_initialize_restart_count: current state
>> 1:STARTING
>> ofonod[1034]: PPP: ipcp: pppcp_send_configure_request: current state 1:S=
TARTING
>> ofonod[1034]: PPP: ipcp: pppcp_process_configure_request: current
>> state 6:REQSENT
>> ofonod[1034]: PPP: ipcp: pppcp_generate_event: current state 6:REQSENT
>> ofonod[1034]: PPP: event: 6 (RCR+), action: 2008, new_state: 8 (ACKSENT)
>> ofonod[1034]: PPP: ipcp: pppcp_send_configure_ack: current state 6:REQSE=
NT
>> ofonod[1034]: PPP: ipcp: pppcp_process_configure_reject: current state 8=
:ACKSENT
>> ofonod[1034]: PPP: ipcp: pppcp_generate_event: current state 8:ACKSENT
>> ofonod[1034]: PPP: event: 9 (RCN), action: 1028, new_state: 8 (ACKSENT)
>> ofonod[1034]: PPP: ipcp: pppcp_initialize_restart_count: current state 8=
:ACKSENT
>> ofonod[1034]: PPP: ipcp: pppcp_send_configure_request: current state 8:A=
CKSENT
>> ofonod[1034]: PPP: ipcp: pppcp_process_configure_nak: current state 8:AC=
KSENT
>> ofonod[1034]: PPP: ipcp: pppcp_generate_event: current state 8:ACKSENT
>> ofonod[1034]: PPP: event: 9 (RCN), action: 1028, new_state: 8 (ACKSENT)
>> ofonod[1034]: PPP: ipcp: pppcp_initialize_restart_count: current state 8=
:ACKSENT
>> ofonod[1034]: PPP: ipcp: pppcp_send_configure_request: current state 8:A=
CKSENT
>> ofonod[1034]: PPP: ipcp: pppcp_process_configure_ack: current state 8:AC=
KSENT
>> ofonod[1034]: PPP: ipcp: pppcp_generate_event: current state 8:ACKSENT
>> ofonod[1034]: PPP: event: 8 (RCA), action: 129, new_state: 9 (OPENED)
>> ofonod[1034]: PPP: ipcp: pppcp_initialize_restart_count: current state 8=
:ACKSENT
>> ofonod[1034]: PPP: ../ofono-1.27/gatchat/gatppp.c:ppp_enter_phase() 4
>> ofonod[1034]: ../ofono-1.27/drivers/atmodem/gprs-context.c:ppp_connect()
>> ofonod[1034]: IP: *.*.*.*
>> ofonod[1034]: DNS: *.*.*.* *.*.*.*
>> ofonod[1034]: ../ofono-1.27/src/gprs.c:pri_activate_callback() 0x13fbad0
>> ofonod[1034]: ../ofono-1.27/plugins/udevng.c:add_serial_device()
>> Device is missing required OFONO_DRIVER property
>> ofonod[1034]: ../ofono-1.27/plugins/udevng.c:check_modem_list()
>>
>> We can see no RCR- coming and it works now. (IP and DNS anonymized)
>>
>> Hope this is enough info to fix this issue.
>>
>> Regards,
>>
>> Philippe
>> _______________________________________________
>> ofono mailing list
>> ofono(a)ofono.org
>> https://lists.ofono.org/mailman/listinfo/ofono
> =

> Regards,
> Giacinto
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
> =


-- =

Kind regards,
Martin Hundeb=C3=B8ll
Embedded Linux Consultant

+45 61 65 54 61
martin(a)geanix.com

Geanix IVS
https://geanix.com
DK39600706

--===============3960578018450569537==--

