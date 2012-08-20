Content-Type: multipart/mixed; boundary="===============1646680399853171701=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Unable to establish a complete PPP link on Sagem Hilo GPRS modem
Date: Mon, 20 Aug 2012 08:29:31 -0500
Message-ID: <50323BBB.3020008@gmail.com>
In-Reply-To: <2F3DAB62ECFFCE41A6C553644B76A1AF0106718B@HEFRMBX01.sofr.hefr.lan>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1646680399853171701==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

<snip>

> Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: Aux:>  ATD*99***1#\r
> Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: Aux:<  \r\nCONNECT\=
r\n
> Jan  2 16:25:14 109656587698 daemon.debug ofonod[600]: drivers/atmodem/gp=
rs-context.c:at_cgdata_cb() ok 1
> Jan  2 16:25:14 109656587698 daemon.debug ofonod[600]: drivers/atmodem/gp=
rs-context.c:setup_ppp()
> Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_gen=
erate_event: current state 0:INITIAL
> Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: event: 0 (Up),=
 action: 2, new_state: 2 (CLOSED)
> Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_gen=
erate_event: current state 2:CLOSED
> Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: event: 2 (Open=
), action: 1026, new_state: 6 (REQSENT)
> Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_ini=
tialize_restart_count: current state 2:CLOSED
> Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_sen=
d_configure_request: current state 2:CLOSED
>
> Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: gatchat/gatppp=
.c:ppp_enter_phase() 1
> Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_pro=
cess_configure_ack: current state 6:REQSENT
> Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_gen=
erate_event: current state 6:REQSENT
> Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: event: 8 (RCA)=
, action: 27, new_state: 7 (ACKRCVD)
> Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_ini=
tialize_restart_count: current state 6:REQSENT
>
> Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_pro=
cess_configure_request: current state 7:ACKRCVD
> Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_gen=
erate_event: current state 7:ACKRCVD
> Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: event: 7 (RCR-=
), action: 4007, new_state: 7 (ACKRCVD)
>
> Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_sen=
d_configure_nak: current state 7:ACKRCVD
> Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_pro=
cess_configure_request: current state 7:ACKRCVD
> Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_gen=
erate_event: current state 7:ACKRCVD
> Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: event: 6 (RCR+=
), action: 2109, new_state: 9 (OPENED)
>
> Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_sen=
d_configure_ack: current state 7:ACKRCVD
> Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: gatchat/gatppp=
.c:ppp_enter_phase() 2
> Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: gatchat/gatppp=
.c:ppp_enter_phase() 3
> Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_ge=
nerate_event: current state 0:INITIAL
> Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: event: 2 (Open=
), action: 401, new_state: 1 (STARTING)
>
> Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_ge=
nerate_event: current state 1:STARTING
> Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: event: 0 (Up),=
 action: 1026, new_state: 6 (REQSENT)
> Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_in=
itialize_restart_count: current state 1:STARTING
> Jan  2 16:25:14 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_se=
nd_configure_request: current state 1:STARTING
> Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_ti=
meout: current state 6:REQSENT
>
> Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_ge=
nerate_event: current state 6:REQSENT
>
>
> Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: event: 4 (TO+)=
, action: 1006, new_state: 6 (REQSENT)
> Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_se=
nd_configure_request: current state 6:REQSENT
> Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_pr=
ocess_configure_request: current state 6:REQSENT
> Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_ge=
nerate_event: current state 6:REQSENT
> Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: event: 6 (RCR+=
), action: 2008, new_state: 8 (ACKSENT)
> Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_se=
nd_configure_ack: current state 6:REQSENT
> Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_pr=
ocess_configure_reject: current state 8:ACKSENT
> Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_ge=
nerate_event: current state 8:ACKSENT
> Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: event: 9 (RCN)=
, action: 1028, new_state: 8 (ACKSENT)
> Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_in=
itialize_restart_count: current state 8:ACKSENT
> Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_se=
nd_configure_request: current state 8:ACKSENT
> Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_pr=
ocess_configure_nak: current state 8:ACKSENT
> Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_ge=
nerate_event: current state 8:ACKSENT
> Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: event: 9 (RCN)=
, action: 1028, new_state: 8 (ACKSENT)
> Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_in=
itialize_restart_count: current state 8:ACKSENT
> Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_se=
nd_configure_request: current state 8:ACKSENT
> Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_pr=
ocess_configure_ack: current state 8:ACKSENT
> Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_ge=
nerate_event: current state 8:ACKSENT
> Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: event: 8 (RCA)=
, action: 129, new_state: 9 (OPENED)
> Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: ipcp: pppcp_in=
itialize_restart_count: current state 8:ACKSENT
> Jan  2 16:25:18 109656587698 daemon.info ofonod[600]: PPP: lcp: pppcp_gen=
erate_event: current state 9:OPENED

So we were able to negotiate IPCP parameters but network setup failed.

Are you running as root and is your tun module loaded?

Regards,
-Denis

--===============1646680399853171701==--

