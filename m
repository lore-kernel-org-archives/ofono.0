Content-Type: multipart/mixed; boundary="===============6986825800162572005=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: PPP LCP configuration issue
Date: Thu, 01 Apr 2010 18:00:17 -0700
Message-ID: <1270170017.22331.52.camel@localhost.localdomain>
In-Reply-To: <1270106746.22331.28.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6986825800162572005==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> so I added some debug code to actually print the options during the
> configuration stage. And something seems to be wrong here.
> =

> lcp: pppcp_open_event: current state 0:INITIAL
> lcp: pppcp_up_event: current state 1:STARTING
> lcp: pppcp_initialize_restart_count: current state 1:STARTING
> lcp: pppcp_send_configure_request: current state 1:STARTING
> lcp: option 2 len 6 (Async-Control-Character-Map) 00 00 00 00
> lcp: pppcp_process_configure_request: current state 6:REQSENT
> lcp: option 2 len 6 (Async-Control-Character-Map) 00 00 00 00
> lcp: option 3 len 5 (Authentication-Protocol) c2 23 05
> lcp: option 5 len 6 (Magic-Number) 01 ff ef e0
> lcp: option 7 len 2 (Protocol-Field-Compression)
> lcp: option 8 len 2 (Address-and-Control-Field-Compression)
> lcp: pppcp_rcr_plus_event: current state 6:REQSENT
> lcp: pppcp_send_configure_ack: current state 6:REQSENT
> lcp: option 2 len 6 (Async-Control-Character-Map) 00 00 00 00
> lcp: option 3 len 5 (Authentication-Protocol) c2 23 05
> lcp: option 5 len 6 (Magic-Number) 01 ff ef e0
> lcp: option 7 len 2 (Protocol-Field-Compression)
> lcp: option 8 len 2 (Address-and-Control-Field-Compression)
> lcp: pppcp_process_configure_ack: current state 8:ACKSENT
> lcp: option 2 len 6 (Async-Control-Character-Map) 00 00 00 00
> oops -- found acked option 2 we didn't request
> lcp: pppcp_rca_event: current state 8:ACKSENT
> lcp: pppcp_initialize_restart_count: current state 8:ACKSENT
> =

> I see the oops comment here, but we clearly requested the async control
> character map. So why does it get recognized as not requested? This is
> clearly a bug and needs to be fixed.

so I added pppdump support to GAtPPP and gsmdial. This allows us to
create log files that can be read by pppdump and Wireshark. The method
of debugging with strace is just not feasible. The attached log file is
one of these. I see a couple of confirmation requests that were send
twice in a row. That seems to be wrong. Can you explain what is going
on.

Regards

Marcel


--===============6986825800162572005==
Content-Type: text/x-log
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ppptest.log"

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
IH0k8OJ+B0u1E3gCAA4NCk5PIENBUlJJRVINCg==

--===============6986825800162572005==--

