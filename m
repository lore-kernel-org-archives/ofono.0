Content-Type: multipart/mixed; boundary="===============3536503478212591882=="
MIME-Version: 1.0
From: Joo <joo_hong@yahoo.com>
Subject: Motorola H.24 does not send its IP address during IPCP negotiation
Date: Sun, 17 Jun 2012 18:01:39 +0000
Message-ID: <loom.20120617T195329-141@post.gmane.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3536503478212591882==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I am using Motorola H.24 modem module with the external TCP/IP stack. It se=
ems
like the H.24 modem module never send the network side (remote side) IP add=
ress
during the PPP negotiation. The following trace (from bottom to top) is cap=
ture
that turn on the IPCP negotiation:

119 : ipcp: down
119 : Could not determine remote IP address
119 : ipcp: up
119 : fsmOut:8-FF03802102050004
119 : ipcp: returning Configure-ACK
119 : input: 01050004
119 : fsmOut: FF0380210304000A030600000000
119 : ipcp: returning Configure-NAK
119 : input: 01040004
119 : fsmOut: FF0380210303000A030600000000
119 : ipcp: returning Configure-NAK
119 : input: 01030004
119 : input: 0203001603060AD3830D81060A0002FE83060A020224
119 : fsmOut: FF0380210302000A030600000000
119 : ipcp: returning Configure-NAK
119 : input: 01020004
119 : fsmOut: FF0380210103001603060AD3830D81060A0002FE83060A020224
119 : local IP address 10.211.131.13
119 : input: 0302001603060AD3830D81060A0002FE83060A020224
119 : fsmOut: FF0380210301000A030600000000
119 : ipcp: returning Configure-NAK
119 : input: 01010004
119 : fsmOut: FF03802101020016030600000000810600000000830600000000
119 : input: 0401000A0206002D0F01
119 : fsmOut:FF0380210300000A030600000000
119 : ipcp: returning Configure-NAK
119 : input: 01000004
116 : fsmOut: FF0380210101001C0306000000000206002D0F01810600000000830600000=
000
116 : Connect: ppp0 <--> /dev/ser0
116 : synxModuleConnectPSD: Success..
113 : synxModuleConnectPSD..
109 : synxModuleInit: success..
106 : synxModuleInit: ATE1..
101 : synxModuleInit: ATZ..
101 : synxModuleInit..
98 : synxModuleOn: Success..
97 : synxModuleOn..
96 : thttpd/2.20c 21nov01 starting on port 80
96 : Using interface ppp0



--===============3536503478212591882==--

