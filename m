Content-Type: multipart/mixed; boundary="===============8900869866513219007=="
MIME-Version: 1.0
From: Zheng, Wu <wu.zheng@intel.com>
Subject: RE: PPP connection is not established between DUN server(linux +
 ofono) and DUN client(Win7)
Date: Tue, 03 Jul 2012 09:06:47 +0000
Message-ID: <2CF57A644018A745B8FE029C7223E16E0FDA2465@SHSMSX102.ccr.corp.intel.com>
In-Reply-To: <4FF2A804.8070200@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8900869866513219007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zajac,

Thanks for your help. PPP connection can be established after removing some=
 PPP compression activated.

Best regards
Zheng wu

> -----Original Message-----
> From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beh=
alf
> Of Guillaume Zajac
> Sent: Tuesday, July 03, 2012 4:06 PM
> To: ofono(a)ofono.org
> Subject: Re: PPP connection is not established between DUN server(linux +
> ofono) and DUN client(Win7)
> =

> Hi Wu,
> =

> On 03/07/2012 09:29, Zheng, Wu wrote:
> > Hi,
> >
> > I am trying the DUN feature of ofono.
> >
> > DUN server: Linux kernel 3.0 and ofono-1.7
> >
> > DUN client:win7
> >
> > However, PPP connection is not established between DUN server(linux +
> ofono) and DUN client(Win7).
> >
> > DUN client(win7) keep at the status of "verifying user and password".
> >
> > The attachment is the log of ofono(DUN server).
> >
> > After checking the log,
> >
> > DUN server(ofono) got the event 7 (RCR-) firstly at ppp_enter_phase() 1.
> >
> > After DUN server(ofono) got the event 8 (RCA), DUN server(ofono) always
> non-stop to get the event 7 (RCR-).
> >
> > What is wrong in the process? Some suggestions? Thank you.
> =

> It seems you have some PPP compression activated into Win7 client.
> You have to configure your DUN properties.
> When you click on connect, you have click on properties --> options tab
> --> PPP settings --> and you clear all the boxes.
> Then it should work properly.
> =

> Kind regards,
> Guillaume
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

--===============8900869866513219007==--

