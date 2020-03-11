Content-Type: multipart/mixed; boundary="===============1390914353471093122=="
MIME-Version: 1.0
From: mattias.mansson@verisure.com
Subject: How to handle modems with additional wwan connect stage?
Date: Wed, 11 Mar 2020 12:46:09 +0000
Message-ID: <20200311124609.2753.5269@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1390914353471093122==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We are writing a ofono driver/plugin for a new Quectel modem based on a qua=
lcomm chipset. This modem has a wwan interface that needs to be "connected"=
 after the context is activated, partially to allow the host to run dhcp. I=
t can be done either using QMI or with a special qualcomm command AT$QCRMCA=
LL. We want to control it using AT, as we have found several issues with QM=
I. But we are having some trouble figuring out where this command should be=
 called in the ofono state machine, at least in the LTE case where the cont=
ext is automatically activated. If we activate the context manually, we cou=
ld just add that call in the end of the context activation. But if we for t=
he automatic case add this command when we receive PDN ACT 1 and the AT com=
mand fails (which right now happens sometimes), we end up in a state where =
we can't try again, because the context is already activated. So we can't r=
eally find the best way to do this...

Another issue I wanted to ask is that when we get an automatic context acti=
vation on 4G, we don't get the APN set from the network in the AT+CGDCONT? =
response. According to Quectel, this is just how their modem work. It will =
only show manually set APN from that response. Is this normal for any other=
 modules? And how to solve the problem that ofono wants the APN when callin=
g ofono_gprs_cid_activated when we get the CGEV saying the PDN is active?
--===============1390914353471093122==--

