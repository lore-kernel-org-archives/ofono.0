Content-Type: multipart/mixed; boundary="===============3954522426912308478=="
MIME-Version: 1.0
From: Etienne <mabille.etienne@gmail.com>
Subject: Re: PPP connection to a private APN
Date: Wed, 07 Aug 2013 14:10:25 +0000
Message-ID: <loom.20130807T155127-216@post.gmane.org>
In-Reply-To: <51FBD793.8050001@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3954522426912308478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Denis Kenzior <denkenz@...> writes:

> =

> Hi Etienne,
> =

> On 08/02/2013 10:31 AM, Etienne Mabille wrote:
> > Hi everyone,
> >
> > I am forced to work with version 1.3 of oFono and I want to setup a ppp
> > connection on a private APN.
> > It works well on a public APN but not on the private one. I looked at
> > the debug trace and it seems like oFono doesn't give the username and
> > password anywhere in the AT commands.
> > Is this function possible ? If so, does anyone know when this feature
> > was added so I can add a patch to my version ?
> >
> =

> Your subject mentions a 'PPP' connection.  So I assume you're using a =

> modem which uses PPP.  If so, then the user/password exchange is done =

> over the PPP link and not AT commands.  You will have to debug the PPP =

> connection in order to understand what fails.
> =

> The gatchat library actually has a nice tool that might help.  It uses =

> the oFono internal PPP implementation and can make basic context =

> activations.  See gatchat/gsmdial.c for reference.
> =

> The tool also supports PPPdump file output (use --pppdump option to set =

> a filename).  You can then view the detailed transaction log with =

> wireshark or another protocol analyzer.
> =

> Regards,
> -Denis
> =

> =


Hi Denis

Thank you for your help, I managed to obtain a dump of the ppp connection
and I compared it with the ppp debug info from ofono. =


The modem negociates with the DCE for the correct DNS and IP addresses. But
the modem receives a "CGEV: NW DEACT X25" message before obtaining the IP
address. I checked the dump with wireshark, there is no exchange of username
and password. Do you know if this is supposed to happen before or after
obtention of the IP address ?

I am also wondering what are the possible causes of a "NW DEACT" ? =


I tried with the same computer, sim card, APN, credentials, but another
modem (Option GTM382, does not use the PPP module from ofono) and it
connects fine.

Here is the log from ofono :

ofonod[1911]: drivers/atmodem/network-registration.c:cops_cb() cops_cb:
BOUYGTEL, 208 20 2
ofonod[1911]: src/network.c:current_operator_callback() 0x82ea648, 0x82f0a68
ofonod[1911]: Aux: < \r\n+CIEV: rssi,3\r\n\r\n+CIEV: service,1\r\n\r\n+CIEV:
roam,0\r\n
ofonod[1911]: drivers/atmodem/gprs-context.c:at_gprs_activate_primary() cid=
 1
ofonod[1911]: Modem: > AT+CGDCONT=3D1,"IP","alstom-france-locomotive.fr"\r
ofonod[1911]: Modem: < \r\nOK\r\n
ofonod[1911]: drivers/atmodem/gprs-context.c:at_cgdcont_cb() ok 1
ofonod[1911]: Modem: > AT+CGDATA=3D"PPP",1\r
ofonod[1911]: Modem: < \r\nCONNECT\r\n
ofonod[1911]: drivers/atmodem/gprs-context.c:at_cgdata_cb() ok 1
ofonod[1911]: drivers/atmodem/gprs-context.c:setup_ppp()
ofonod[1911]: PPP: lcp: pppcp_generate_event: current state 0:INITIAL
ofonod[1911]: PPP: event: 0 (Up), action: 2, new_state: 2 (CLOSED)
ofonod[1911]: PPP: lcp: pppcp_generate_event: current state 2:CLOSED
ofonod[1911]: PPP: event: 2 (Open), action: 1026, new_state: 6 (REQSENT)
ofonod[1911]: PPP: lcp: pppcp_initialize_restart_count: current state 2:CLO=
SED
ofonod[1911]: PPP: lcp: pppcp_send_configure_request: current state 2:CLOSED
ofonod[1911]: PPP: gatchat/gatppp.c:ppp_enter_phase() 1
ofonod[1911]: PPP: lcp: pppcp_process_configure_request: current state 6:RE=
QSENT
ofonod[1911]: PPP: lcp: pppcp_generate_event: current state 6:REQSENT
ofonod[1911]: PPP: event: 6 (RCR+), action: 2008, new_state: 8 (ACKSENT)
ofonod[1911]: PPP: lcp: pppcp_send_configure_ack: current state 6:REQSENT
ofonod[1911]: PPP: lcp: pppcp_process_configure_ack: current state 8:ACKSENT
ofonod[1911]: PPP: lcp: pppcp_generate_event: current state 8:ACKSENT
ofonod[1911]: PPP: event: 8 (RCA), action: 129, new_state: 9 (OPENED)
ofonod[1911]: PPP: lcp: pppcp_initialize_restart_count: current state 8:ACK=
SENT
ofonod[1911]: PPP: gatchat/gatppp.c:ppp_enter_phase() 3
ofonod[1911]: PPP: ipcp: pppcp_generate_event: current state 0:INITIAL
ofonod[1911]: PPP: event: 2 (Open), action: 401, new_state: 1 (STARTING)
ofonod[1911]: PPP: ipcp: pppcp_generate_event: current state 1:STARTING
ofonod[1911]: PPP: event: 0 (Up), action: 1026, new_state: 6 (REQSENT)
ofonod[1911]: PPP: ipcp: pppcp_initialize_restart_count: current state
1:STARTING
ofonod[1911]: PPP: ipcp: pppcp_send_configure_request: current state 1:STAR=
TING
ofonod[1911]: PPP: ipcp: pppcp_process_configure_nak: current state 6:REQSE=
NT
ofonod[1911]: PPP: ipcp: pppcp_generate_event: current state 6:REQSENT
ofonod[1911]: PPP: event: 9 (RCN), action: 1026, new_state: 6 (REQSENT)
ofonod[1911]: PPP: ipcp: pppcp_initialize_restart_count: current state 6:RE=
QSENT
ofonod[1911]: PPP: ipcp: pppcp_send_configure_request: current state 6:REQS=
ENT
ofonod[1911]: PPP: ipcp: pppcp_process_configure_nak: current state 6:REQSE=
NT
ofonod[1911]: PPP: ipcp: pppcp_generate_event: current state 6:REQSENT
ofonod[1911]: PPP: event: 9 (RCN), action: 1026, new_state: 6 (REQSENT)
ofonod[1911]: PPP: ipcp: pppcp_initialize_restart_count: current state 6:RE=
QSENT
ofonod[1911]: PPP: ipcp: pppcp_send_configure_request: current state 6:REQS=
ENT
ofonod[1911]: Aux: < \r\n+CGEV: NW DEACT X25, "", 1\r\n
ofonod[1911]: drivers/atmodem/gprs-context.c:cgev_notify() cid 1
ofonod[1911]: PPP: lcp: pppcp_generate_event: current state 9:OPENED
ofonod[1911]: PPP: event: 3 (Close), action: 8224, new_state: 4 (CLOSING)
ofonod[1911]: PPP: lcp: pppcp_initialize_restart_count: current state 9:OPE=
NED
ofonod[1911]: PPP: lcp: pppcp_send_terminate_request: current state 9:OPENED
ofonod[1911]: PPP: ipcp: pppcp_generate_event: current state 6:REQSENT
ofonod[1911]: PPP: event: 1 (Down), action: 1, new_state: 1 (STARTING)
ofonod[1911]: PPP: gatchat/gatppp.c:ppp_enter_phase() 5
ofonod[1911]: Aux: < \r\n
ofonod[1911]: Aux: < +CGEV: ME DEACT X25, "", 1\r\n
ofonod[1911]: PPP: lcp: pppcp_process_terminate_request: current state 4:CL=
OSING
ofonod[1911]: PPP: lcp: pppcp_generate_event: current state 4:CLOSING
ofonod[1911]: PPP: event: 10 (RTR), action: 10004, new_state: 4 (CLOSING)
ofonod[1911]: PPP: lcp: pppcp_send_terminate_ack: current state 4:CLOSING
ofonod[1911]: PPP: gatchat/gatppp.c:sta_sent()
ofonod[1911]: Aux: < \r\n+CGREG: 0\r\n\r\n+CGEV: NW DETACH\r\n
ofonod[1911]: src/gprs.c:ofono_gprs_status_notify() /telit_0 status 0
ofonod[1911]: src/gprs.c:ofono_gprs_detached_notify() /telit_0
ofonod[1911]: PPP: lcp: pppcp_timeout: current state 4:CLOSING
ofonod[1911]: PPP: lcp: pppcp_generate_event: current state 4:CLOSING
ofonod[1911]: PPP: event: 4 (TO+), action: 8004, new_state: 4 (CLOSING)
ofonod[1911]: PPP: lcp: pppcp_send_terminate_request: current state 4:CLOSI=
NG
ofonod[1911]: PPP: lcp: pppcp_timeout: current state 4:CLOSING
ofonod[1911]: PPP: lcp: pppcp_generate_event: current state 4:CLOSING
ofonod[1911]: PPP: event: 5 (TO-), action: 802, new_state: 2 (CLOSED)
ofonod[1911]: PPP: lcp: pppcp_this_layer_finished: current state 2:CLOSED
ofonod[1911]: PPP: gatchat/gatppp.c:ppp_enter_phase() 0
ofonod[1911]: PPP: gatchat/gatppp.c:ppp_dead()
ofonod[1911]: drivers/atmodem/gprs-context.c:ppp_disconnect()
ofonod[1911]: src/gprs.c:pri_activate_callback() 0x82f0430
ofonod[1911]: src/gprs.c:pri_activate_callback() Activating context failed
with error: Unknown error type

Regards,

Etienne



--===============3954522426912308478==--

