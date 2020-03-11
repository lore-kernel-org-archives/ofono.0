Content-Type: multipart/mixed; boundary="===============7476736109480725740=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: How to handle modems with additional wwan connect stage?
Date: Wed, 11 Mar 2020 10:44:21 -0500
Message-ID: <c8f07c2e-c997-c795-9579-b67da89a6355@gmail.com>
In-Reply-To: <20200311124609.2753.5269@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7476736109480725740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mattias,

On 3/11/20 7:46 AM, mattias.mansson(a)verisure.com wrote:
> We are writing a ofono driver/plugin for a new Quectel modem based on a q=
ualcomm chipset. This modem has a wwan interface that needs to be "connecte=
d" after the context is activated, partially to allow the host to run dhcp.=
 It can be done either using QMI or with a special qualcomm command AT$QCRM=
CALL. We want to control it using AT, as we have found several issues with =
QMI. But we are having some trouble figuring out where this command should =
be called in the ofono state machine, at least in the LTE case where the co=
ntext is automatically activated. If we activate the context manually, we c=
ould just add that call in the end of the context activation. But if we for=
 the automatic case add this command when we receive PDN ACT 1 and the AT c=
ommand fails (which right now happens sometimes), we end up in a state wher=
e we can't try again, because the context is already activated. So we can't=
 really find the best way to do this...

I guess you would have to build in logic to retry the command as part of =

the .read_settings operation. In other words, try to retry your AT$MAGIC =

command several times prior to giving up.  Or contact your modem vendor =

to fix their firmware :)

> =

> Another issue I wanted to ask is that when we get an automatic context ac=
tivation on 4G, we don't get the APN set from the network in the AT+CGDCONT=
? response. According to Quectel, this is just how their modem work. It wil=
l only show manually set APN from that response. Is this normal for any oth=
er modules? And how to solve the problem that ofono wants the APN when call=
ing ofono_gprs_cid_activated when we get the CGEV saying the PDN is active?

By 4G you mean UMTS/UTRAN, not LTE/EUTRAN, right?  Not sure anyone =

really tested UMTS network-activated contexts, all testing was focused =

on LTE, but in theory they should work just the same.  The key =

difference might be that the default bearer for LTE is usually still =

defined on the ME, so +CGDCONT would work for those contexts and not for =

truly dynamic network activated ones.

According to 27.007, +CGDCONT is only used to define parameters.  For =

obtaining 'dynamic' parameters, CGCONTRDP should be used instead. =

Perhaps the AT modem driver should be using CGCONTRDP instead of =

+CGDCONT when issuing ofono_gprs_cid_activated.

Regards,
-Denis

--===============7476736109480725740==--

