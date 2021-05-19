Content-Type: multipart/mixed; boundary="===============4106690855064674634=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Quectel EC200T USB: Problems with context activation
Date: Wed, 19 May 2021 09:16:14 -0500
Message-ID: <03e52820-7410-2b98-e766-2ae267ad8d2e@gmail.com>
In-Reply-To: <CAFiQ675+H9QndW030-WkV2oivkVVChzcOTnKbaj+4VzW4k9P6w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4106690855064674634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sergei,

On 5/18/21 4:19 PM, Sergei Golubtsov wrote:
> Hi Denis and all,
> =

> I have some problems with the context activation on=C2=A0Quectel EC200T U=
SB in =

> chinese=C2=A0network although in russian networks the modem works fine.
> =

> I have the following during the activation:
> =

> 2021-05-18T23:35:50.624972+03:00 ofonod[999]: [info] Modem: < \r\nCONNECT=
\r\n
> 2021-05-18T23:35:50.625854+03:00 ofonod[999]: [debug] =

> ../git/ofono/drivers/atmodem/gprs-context.c:at_cgdata_cb() ok 1
> 2021-05-18T23:35:50.626564+03:00 ofonod[999]: [debug] =

> ../git/ofono/drivers/atmodem/gprs-context.c:setup_ppp()
> 2021-05-18T23:35:50.627463+03:00 ofonod[999]: [info] PPP: lcp: =

> pppcp_generate_event: current state 0:INITIAL
> 2021-05-18T23:35:50.628216+03:00 ofonod[999]: [info] PPP: event: 0 (Up), =
action: =

> 2, new_state: 2 (CLOSED)
> 2021-05-18T23:35:50.628884+03:00 ofonod[999]: [info] PPP: lcp: =

> pppcp_generate_event: current state 2:CLOSED
> 2021-05-18T23:35:50.629521+03:00 ofonod[999]: [info] PPP: event: 2 (Open)=
, =

> action: 1026, new_state: 6 (REQSENT)
> 2021-05-18T23:35:50.630234+03:00 ofonod[999]: [info] PPP: lcp: =

> pppcp_initialize_restart_count: current state 2:CLOSED
> 2021-05-18T23:35:50.630876+03:00 ofonod[999]: [info] PPP: lcp: =

> pppcp_send_configure_request: current state 2:CLOSED
> 2021-05-18T23:35:50.631641+03:00 ofonod[999]: [info] PPP: =

> ../git/ofono/gatchat/gatppp.c:ppp_enter_phase() 1
> 2021-05-18T23:35:50.634253+03:00 ofonod[999]: [info] PPP: lcp: =

> pppcp_process_configure_request: current state 6:REQSENT
> 2021-05-18T23:35:50.635270+03:00 ofonod[999]: [info] PPP: lcp: =

> pppcp_generate_event: current state 6:REQSENT
> 2021-05-18T23:35:50.635423+03:00 ofonod[999]: [info] PPP: event: 7 (RCR-)=
, =

> action: 4006, new_state: 6 (REQSENT)

Peer is sending us options we do not find acceptable...  Do you have a wire=
shark =

trace to see what this might be?

> 2021-05-18T23:35:50.635544+03:00 ofonod[999]: [info] PPP: lcp: =

> pppcp_send_configure_nak: current state 6:REQSENT
> 2021-05-18T23:35:50.636566+03:00 ofonod[999]: [info] PPP: lcp: =

> pppcp_process_configure_ack: current state 6:REQSENT

Looks like our options (that we're sending) are accepted by the peer

> 2021-05-18T23:35:50.636696+03:00 ofonod[999]: [info] PPP: lcp: =

> pppcp_generate_event: current state 6:REQSENT
> 2021-05-18T23:35:50.637067+03:00 ofonod[999]: [info] PPP: event: 8 (RCA), =

> action: 27, new_state: 7 (ACKRCVD)
> 2021-05-18T23:35:50.637187+03:00 ofonod[999]: [info] PPP: lcp: =

> pppcp_initialize_restart_count: current state 6:REQSENT
> 2021-05-18T23:35:50.637187+03:00 ofonod[999]: [info] PPP: lcp: =

> pppcp_initialize_restart_count: current state 6:REQSENT
> 2021-05-18T23:35:50.637597+03:00 ofonod[999]: [info] PPP: lcp: =

> pppcp_process_configure_request: current state 7:ACKRCVD
> 2021-05-18T23:35:50.637715+03:00 ofonod[999]: [info] PPP: lcp: =

> pppcp_generate_event: current state 7:ACKRCVD
> 2021-05-18T23:35:50.637826+03:00 ofonod[999]: [info] PPP: event: 7 (RCR-)=
, =

> action: 4007, new_state: 7 (ACKRCVD)
> 2021-05-18T23:35:50.637929+03:00 ofonod[999]: [info] PPP: lcp: =

> pppcp_send_configure_nak: current state 7:ACKRCVD
> 2021-05-18T23:35:50.639907+03:00 ofonod[999]: [info] PPP: lcp: =

> pppcp_process_configure_request: current state 7:ACKRCVD
> 2021-05-18T23:35:50.640246+03:00 ofonod[999]: [info] PPP: lcp: =

> pppcp_generate_event: current state 7:ACKRCVD
> 2021-05-18T23:35:50.640992+03:00 ofonod[999]: [info] PPP: event: 7 (RCR-)=
, =

> action: 4007, new_state: 7 (ACKRCVD)

and basically we get into an infinite loop with the peer trying to set some =

options we find unacceptable..

> =

> So, the following lines repeats infinitely, context is not activated and =
ofono =

> uses ~90% of the CPU until I stop it:
> 2021-05-18T23:35:50.637929+03:00 ofonod[999]: [info] PPP: lcp: =

> pppcp_send_configure_nak: current state 7:ACKRCVD
> 2021-05-18T23:35:50.639907+03:00 ofonod[999]: [info] PPP: lcp: =

> pppcp_process_configure_request: current state 7:ACKRCVD
> 2021-05-18T23:35:50.640246+03:00 ofonod[999]: [info] PPP: lcp: =

> pppcp_generate_event: current state 7:ACKRCVD
> 2021-05-18T23:35:50.640992+03:00 ofonod[999]: [info] PPP: event: 7 (RCR-)=
, =

> action: 4007, new_state: 7 (ACKRCVD)
> =

> Could someone shed a light on what is going on there and how to solve tha=
t?
> =

> Thanks in advance.
> Have a nice day.
> =

> Yours sincerely,
> Sergei Golubtsov.

Regards,
-Denis
--===============4106690855064674634==--

