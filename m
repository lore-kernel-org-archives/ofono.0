Content-Type: multipart/mixed; boundary="===============7338801345019928431=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: PPP connection to a private APN
Date: Wed, 07 Aug 2013 10:41:08 -0500
Message-ID: <52026A94.2000503@gmail.com>
In-Reply-To: <loom.20130807T155127-216@post.gmane.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7338801345019928431==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Etienne,

 >
> Thank you for your help, I managed to obtain a dump of the ppp connection
> and I compared it with the ppp debug info from ofono.
>
> The modem negociates with the DCE for the correct DNS and IP addresses. B=
ut
> the modem receives a "CGEV: NW DEACT X25" message before obtaining the IP
> address. I checked the dump with wireshark, there is no exchange of usern=
ame
> and password. Do you know if this is supposed to happen before or after
> obtention of the IP address ?

The way this is setup is slightly weird in GSM.  The PPP stack runs on =

the modem and it is supposed to ask for credential information and =

transparently forward it to the network during context activation.

 From your log it seems that the modem never asks for authentication =

information.  There could be several reasons for this, it might not =

support any authentication protocol, it might not support the auth =

protocol we support (CHAP + MD5), etc.  You will need to examine the =

wireshark results for why this happens.  But essentially the =

authentication phase is skipped.

>
> I am also wondering what are the possible causes of a "NW DEACT" ?

The network drops the GPRS connection.  Speculating here, but I suspect =

it is because the credentials are invalid ;)

>
> I tried with the same computer, sim card, APN, credentials, but another
> modem (Option GTM382, does not use the PPP module from ofono) and it
> connects fine.
>

I would try also with pppd and generate pppdump information.  If this =

succeeds then I would compare the two wireshark logs to figure out what =

goes wrong.  oFono supports the bare minimum of PPP that works on 99% of =

the hardware.  But honestly we never tried VPN style GPRS contexts, so =

it may be that we are missing something.

> Here is the log from ofono :
>
> ofonod[1911]: drivers/atmodem/network-registration.c:cops_cb() cops_cb:
> BOUYGTEL, 208 20 2
> ofonod[1911]: src/network.c:current_operator_callback() 0x82ea648, 0x82f0=
a68
> ofonod[1911]: Aux: < \r\n+CIEV: rssi,3\r\n\r\n+CIEV: service,1\r\n\r\n+CI=
EV:
> roam,0\r\n
> ofonod[1911]: drivers/atmodem/gprs-context.c:at_gprs_activate_primary() c=
id 1
> ofonod[1911]: Modem: > AT+CGDCONT=3D1,"IP","alstom-france-locomotive.fr"\r
> ofonod[1911]: Modem: < \r\nOK\r\n
> ofonod[1911]: drivers/atmodem/gprs-context.c:at_cgdcont_cb() ok 1
> ofonod[1911]: Modem: > AT+CGDATA=3D"PPP",1\r
> ofonod[1911]: Modem: < \r\nCONNECT\r\n
> ofonod[1911]: drivers/atmodem/gprs-context.c:at_cgdata_cb() ok 1
> ofonod[1911]: drivers/atmodem/gprs-context.c:setup_ppp()
> ofonod[1911]: PPP: lcp: pppcp_generate_event: current state 0:INITIAL
> ofonod[1911]: PPP: event: 0 (Up), action: 2, new_state: 2 (CLOSED)
> ofonod[1911]: PPP: lcp: pppcp_generate_event: current state 2:CLOSED
> ofonod[1911]: PPP: event: 2 (Open), action: 1026, new_state: 6 (REQSENT)
> ofonod[1911]: PPP: lcp: pppcp_initialize_restart_count: current state 2:C=
LOSED
> ofonod[1911]: PPP: lcp: pppcp_send_configure_request: current state 2:CLO=
SED
> ofonod[1911]: PPP: gatchat/gatppp.c:ppp_enter_phase() 1

Just FYI: Here we enter PPP_PHASE_ESTABLISHMENT

> ofonod[1911]: PPP: lcp: pppcp_process_configure_request: current state 6:=
REQSENT
> ofonod[1911]: PPP: lcp: pppcp_generate_event: current state 6:REQSENT
> ofonod[1911]: PPP: event: 6 (RCR+), action: 2008, new_state: 8 (ACKSENT)
> ofonod[1911]: PPP: lcp: pppcp_send_configure_ack: current state 6:REQSENT
> ofonod[1911]: PPP: lcp: pppcp_process_configure_ack: current state 8:ACKS=
ENT
> ofonod[1911]: PPP: lcp: pppcp_generate_event: current state 8:ACKSENT
> ofonod[1911]: PPP: event: 8 (RCA), action: 129, new_state: 9 (OPENED)
> ofonod[1911]: PPP: lcp: pppcp_initialize_restart_count: current state 8:A=
CKSENT
> ofonod[1911]: PPP: gatchat/gatppp.c:ppp_enter_phase() 3

Here we enter PPP_PHASE_NETWORK.  The PPP_PHASE_AUTHENTICATION is =

skipped because it was never negotiated in the ESTABLISHMENT phase.

Regards,
-Denis

--===============7338801345019928431==--

