Content-Type: multipart/mixed; boundary="===============8150426720837492299=="
MIME-Version: 1.0
From: Lars Poeschel <poeschel@lemonage.de>
Subject: Re: Unable to establish ppp connection with Huawei dongle
Date: Mon, 31 Aug 2020 16:14:10 +0200
Message-ID: <20200831141410.pxslwzm5nyiw7yq5@lem-wkst-02.lemonage>
In-Reply-To: <20200827042640.2753.53584@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8150426720837492299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I do notice two things looking at your logs:

On Thu, Aug 27, 2020 at 04:26:40AM -0000, rakespani(a)gmail.com wrote:
> Hi ,
> =

> I am trying to enable lte connection with huawei dongle , but I am gettin=
g below error log for activat/context. =

> =

> Aug 26 11:36:28 raspberrypi3 daemon.info ofonod[147]: Modem: > AT+CGDCONT=
=3D1,"IP","airtelgprs.com"\r
> Aug 26 11:36:28 raspberrypi3 daemon.info ofonod[147]: Modem: < \r\nOK\r\n
> Aug 26 11:36:28 raspberrypi3 daemon.debug ofonod[147]: ../ofono-1.24/driv=
ers/atmodem/gprs-context.c:at_cgdcont_cb() ok 1

1. You use ofono-1.24 which is fairly old. Latest release is 1.31 so
far.

> Aug 26 11:36:28 raspberrypi3 daemon.info ofonod[147]: Modem: > AT+CGDATA=
=3D"PPP",1\r
> Aug 26 11:36:28 raspberrypi3 daemon.info ofonod[147]: Modem: < \r\nCONNEC=
T 100000000\r\n
> Aug 26 11:36:28 raspberrypi3 daemon.debug ofonod[147]: ../ofono-1.24/driv=
ers/atmodem/gprs-context.c:at_cgdata_cb() ok 1
> Aug 26 11:36:28 raspberrypi3 daemon.debug ofonod[147]: ../ofono-1.24/driv=
ers/atmodem/gprs-context.c:setup_ppp()
> Aug 26 11:36:28 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_gen=
erate_event: current state 0:INITIAL
> Aug 26 11:36:28 raspberrypi3 daemon.info ofonod[147]: PPP: event: 0 (Up),=
 action: 2, new_state: 2 (CLOSED)
> Aug 26 11:36:28 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_gen=
erate_event: current state 2:CLOSED
> Aug 26 11:36:28 raspberrypi3 daemon.info ofonod[147]: PPP: event: 2 (Open=
), action: 1026, new_state: 6 (REQSENT)
> Aug 26 11:36:28 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_ini=
tialize_restart_count: current state 2:CLOSED
> Aug 26 11:36:28 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_sen=
d_configure_request: current state 2:CLOSED
> Aug 26 11:36:28 raspberrypi3 daemon.info ofonod[147]: PPP: ../ofono-1.24/=
gatchat/gatppp.c:ppp_enter_phase() 1
> Aug 26 11:36:29 raspberrypi3 daemon.info ofonod[147]: PCUI: < \r\n^BOOT:1=
113056,0,0,0,99\r\n
> Aug 26 11:36:30 raspberrypi3 daemon.info ofonod[147]: PCUI: < \r\n^RSSI:3=
1\r\n
> Aug 26 11:36:30 raspberrypi3 daemon.info ofonod[147]: PCUI: < \r\n^LTERSR=
P:-76,-6\r\n
> Aug 26 11:36:31 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_tim=
eout: current state 6:REQSENT
> Aug 26 11:36:31 raspberrypi3 daemon.info ofonod[147]: PPP: lcp: pppcp_gen=
erate_event: current state 6:REQSENT
> Aug 26 11:36:31 raspberrypi3 daemon.info ofonod[147]: PPP: event: 4 (TO+)=
, action: 1006, new_state: 6 (REQSENT)

2. Ofono is trying to communicate with your provider here and sending
ppp configuration requests. It does timeout several times. That means
your mobile provider is not answering this requests.
At some time you should receive something other than a "(TO+)".
If I should guess, I would say this is because of wrong apn settings.
(username/password)

Regards,
Lars
--===============8150426720837492299==--

