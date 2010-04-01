Content-Type: multipart/mixed; boundary="===============7858193146767352053=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: PPP LCP configuration issue
Date: Thu, 01 Apr 2010 00:25:45 -0700
Message-ID: <1270106746.22331.28.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7858193146767352053==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

so I added some debug code to actually print the options during the
configuration stage. And something seems to be wrong here.

lcp: pppcp_open_event: current state 0:INITIAL
lcp: pppcp_up_event: current state 1:STARTING
lcp: pppcp_initialize_restart_count: current state 1:STARTING
lcp: pppcp_send_configure_request: current state 1:STARTING
lcp: option 2 len 6 (Async-Control-Character-Map) 00 00 00 00
lcp: pppcp_process_configure_request: current state 6:REQSENT
lcp: option 2 len 6 (Async-Control-Character-Map) 00 00 00 00
lcp: option 3 len 5 (Authentication-Protocol) c2 23 05
lcp: option 5 len 6 (Magic-Number) 01 ff ef e0
lcp: option 7 len 2 (Protocol-Field-Compression)
lcp: option 8 len 2 (Address-and-Control-Field-Compression)
lcp: pppcp_rcr_plus_event: current state 6:REQSENT
lcp: pppcp_send_configure_ack: current state 6:REQSENT
lcp: option 2 len 6 (Async-Control-Character-Map) 00 00 00 00
lcp: option 3 len 5 (Authentication-Protocol) c2 23 05
lcp: option 5 len 6 (Magic-Number) 01 ff ef e0
lcp: option 7 len 2 (Protocol-Field-Compression)
lcp: option 8 len 2 (Address-and-Control-Field-Compression)
lcp: pppcp_process_configure_ack: current state 8:ACKSENT
lcp: option 2 len 6 (Async-Control-Character-Map) 00 00 00 00
oops -- found acked option 2 we didn't request
lcp: pppcp_rca_event: current state 8:ACKSENT
lcp: pppcp_initialize_restart_count: current state 8:ACKSENT

I see the oops comment here, but we clearly requested the async control
character map. So why does it get recognized as not requested? This is
clearly a bug and needs to be fixed.

Regards

Marcel



--===============7858193146767352053==--

