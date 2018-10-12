Content-Type: multipart/mixed; boundary="===============6483227017397639675=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 1/5] lte-api: protocol and authentication properties
Date: Fri, 12 Oct 2018 17:25:25 +0200
Message-ID: <CAKSBH7HBDrzZP3PRXh+4VNZZHDByE+2N+GktE+ioaC22SuHt_w@mail.gmail.com>
In-Reply-To: <CAKSBH7GgVmK7B7G3JEtj4v3yfo+=i63HmMgCE0W+aim9hzGuLg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6483227017397639675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

it turns out we have setup in our testnet an apn with authentication,
so I didn't need to wait until next week for this test.

However, as I was going to test, I have noticed a few things:
- the current patch adds a 'standard' feature. As such, it doesn't
really apply to Gemalto modules. For this, I need to submit afterwards
another patch for the vendor-specific code. Au passage, it would help
answering my question about where to put shared vendor code in the
atmodem driver. Now that I know the process, I might as well submit my
proposal as --rfc. I am therefore in a very frustrating situation that
I cannot test exactly this code. Also, I am some 150-200 commits away
from being able to run properly our modules, with the plugin quite
different from how it is today. Bottom line: I test my code, but when
I need to abstract some parts like the one under discussion, it gets
harder until the whole sequence gets more concrete. I understand that
these steps must be followed to have clean commits, but I need some
latitude here.

- what would an ofono trace show? practically nothing. In order to see
something significant, I would need to make an STT or a QXDM trace
(that I am not allowed to share), or a network-side trace, that I
cannot do.

- the second best thing is however a plain AT trace, and this is
below, with some comments. I took it with "microcom port |
timestamp_script". The pipe might produce the time difference on the
next line because of this, but it is informative nevertheless. I have
configured first a normal apn (ber2-ericsson), then the one that
requires authentication (ber-auth.ericsson), but without supplying the
needed parameters, which is the current situation of the ofono
project: as expected, it tries a few times, the timer T3346 kicks in
and it attaches to 3G. Then I give the authentication information, and
gets LTE coverage.

Regards,
Giacinto

[2018-10-12 16:16:27+0200] at+cgdcont?
[2018-10-12 16:16:27+0200] +CGDCONT:
1,"IP","ber2.ericsson","0.0.0.0",0,0,0,0,0,0
[2018-10-12 16:16:27+0200] +CGDCONT:
2,"IPV4V6","ims","0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0",0,0,0,0,1,1
[2018-10-12 16:16:27+0200] +CGDCONT:
3,"IPV4V6","sos","0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0",0,0,0,1,1,1
[2018-10-12 16:16:27+0200]
[2018-10-12 16:16:27+0200] OK
[2018-10-12 16:16:32+0200] at+cfun=3D1
[2018-10-12 16:16:32+0200] OK
[2018-10-12 16:16:32+0200]
[2018-10-12 16:16:32+0200] ^SYSSTART
[2018-10-12 16:16:32+0200]
[2018-10-12 16:16:32+0200] +CREG: 4
[2018-10-12 16:16:32+0200]
[2018-10-12 16:16:32+0200] +CREG: 2
[2018-10-12 16:16:32+0200]
           // 0 seconds
[2018-10-12 16:16:32+0200] +CREG: 1,"009B","0009B03",7
[2018-10-12 16:16:37+0200] at+cops?
[2018-10-12 16:16:37+0200] +COPS: 0,0,"EDAV",7
[2018-10-12 16:16:37+0200]
[2018-10-12 16:16:37+0200] OK
[2018-10-12 16:16:43+0200] at+cfun=3D4
[2018-10-12 16:16:43+0200] OK
[2018-10-12 16:16:43+0200]
[2018-10-12 16:16:43+0200] ^SYSSTART AIRPLANE MODE
[2018-10-12 16:16:43+0200]
[2018-10-12 16:16:43+0200] +CREG: 0
[2018-10-12 16:17:33+0200] at+cgdcont=3D1,"IP","ber-auth.ericsson"
[2018-10-12 16:17:33+0200] OK
[2018-10-12 16:17:39+0200] at+cfun=3D1
[2018-10-12 16:17:39+0200] OK
[2018-10-12 16:17:39+0200]
[2018-10-12 16:17:39+0200] ^SYSSTART
[2018-10-12 16:17:39+0200]
[2018-10-12 16:17:39+0200] +CREG: 4
[2018-10-12 16:17:40+0200]
[2018-10-12 16:17:40+0200] +CREG: 2
[2018-10-12 16:18:02+0200]
           // 22 seconds
[2018-10-12 16:18:02+0200] +CREG: 1,"012F","12F3C3D",6
[2018-10-12 16:18:25+0200] at+cops?
[2018-10-12 16:18:25+0200] +COPS: 0,0,"EDAV",6
[2018-10-12 16:18:25+0200]
[2018-10-12 16:18:25+0200] OK
[2018-10-12 16:18:30+0200] at+cfun=3D4
[2018-10-12 16:18:30+0200] OK
[2018-10-12 16:18:31+0200]
[2018-10-12 16:18:31+0200] ^SYSSTART AIRPLANE MODE
[2018-10-12 16:18:31+0200]
[2018-10-12 16:18:31+0200] +CREG: 0
[2018-10-12 16:19:04+0200] at^sgauth=3D1,2,"gemalto","gemalto"
[2018-10-12 16:19:04+0200] OK
[2018-10-12 16:19:24+0200] at+cgdcont?
[2018-10-12 16:19:24+0200] +CGDCONT:
1,"IP","ber-auth.ericsson","0.0.0.0",0,0,0,0,0,0
[2018-10-12 16:19:24+0200] +CGDCONT:
2,"IPV4V6","ims","0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0",0,0,0,0,1,1
[2018-10-12 16:19:24+0200] +CGDCONT:
3,"IPV4V6","sos","0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0",0,0,0,1,1,1
[2018-10-12 16:19:24+0200]
[2018-10-12 16:19:24+0200] OK
[2018-10-12 16:19:32+0200] at+cfun=3D1
[2018-10-12 16:19:32+0200] OK
[2018-10-12 16:19:32+0200]
[2018-10-12 16:19:32+0200] ^SYSSTART
[2018-10-12 16:19:32+0200]
[2018-10-12 16:19:32+0200] +CREG: 4
[2018-10-12 16:19:32+0200]
[2018-10-12 16:19:32+0200] +CREG: 2
[2018-10-12 16:19:32+0200]
           0 seconds, last network
[2018-10-12 16:19:32+0200] +CREG: 1,"012F","12F3C3D",6
[2018-10-12 16:19:38+0200]
           6 seconds, reselection on idle
[2018-10-12 16:19:38+0200] +CREG: 1,"009B","0009B03",7
[2018-10-12 16:19:49+0200] at+cfun=3D4
[2018-10-12 16:19:49+0200] OK
[2018-10-12 16:19:49+0200]
[2018-10-12 16:19:49+0200] ^SYSSTART AIRPLANE MODE
[2018-10-12 16:19:49+0200]
[2018-10-12 16:19:49+0200] +CREG: 0
[2018-10-12 16:19:52+0200] at+cfun=3D1
[2018-10-12 16:19:52+0200] OK
[2018-10-12 16:19:52+0200]
[2018-10-12 16:19:52+0200] ^SYSSTART
[2018-10-12 16:19:52+0200]
[2018-10-12 16:19:52+0200] +CREG: 4
[2018-10-12 16:19:53+0200]
[2018-10-12 16:19:53+0200] +CREG: 2
[2018-10-12 16:19:53+0200]
           // 0 seconds
[2018-10-12 16:19:53+0200] +CREG: 1,"009B","0009B03",7
[2018-10-12 16:19:57+0200] at+cgdcont?
[2018-10-12 16:19:57+0200] +CGDCONT:
1,"IP","ber-auth.ericsson","0.0.0.0",0,0,0,0,0,0
[2018-10-12 16:19:57+0200] +CGDCONT:
2,"IPV4V6","ims","0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0",0,0,0,0,1,1
[2018-10-12 16:19:57+0200] +CGDCONT:
3,"IPV4V6","sos","0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0",0,0,0,1,1,1
[2018-10-12 16:19:57+0200]
[2018-10-12 16:19:57+0200] OK
[2018-10-12 16:20:00+0200] at+cops?
[2018-10-12 16:20:00+0200] +COPS: 0,0,"EDAV",7
[2018-10-12 16:20:00+0200]
[2018-10-12 16:20:00+0200] OK


On Fri, Oct 12, 2018 at 10:33 AM Giacinto Cifelli <gciofono@gmail.com> wr=
ote:
>
> Hi,
>
> On Fri, Oct 12, 2018 at 10:17 AM Jonas Bonn <jonas@southpole.se> wrote:
> >
> > Hi Giacinto,
> >
> > Could you provide an ofono log showing the network registration
> > behaviour for both the case where you pass incorrect authentication
> > parameters via the default context and the case where you pass valid
> > parameters?
> >
>
> ok, I can do it with a network simulator. I will try to do it next week.
>
> By the way, now that I remember, authentication on the default context
> is a requirement for the Softbank certification.
>
> > /Jonas
> >
> >
>
> Giacinto

--===============6483227017397639675==--

