Content-Type: multipart/mixed; boundary="===============7707234157180374214=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Quectel EC200T USB: Problems with context activation
Date: Thu, 31 Dec 2020 10:20:01 -0600
Message-ID: <e6d719d8-21cc-b883-eb0a-340958ec4fe5@gmail.com>
In-Reply-To: <CAFiQ675WayirV30rx+k=Gy-8nZ2KNMFgVCMN=f7wBBjokETNdg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7707234157180374214==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sergei,

> I still cannot understand=C2=A0why ofono does not try to use PAP if the =

> authentication method is set to CHAP by default (because no method set wh=
ile =

> context creation) and it is "obvious" that PAP should be used. pppd does =
this =

> BTW, that's why I assumed that it could be "obvious". I am not an expert =
in this =

> field. Maybe someone could shed a light on the fact that pppd chooses a c=
orrect =

> authentication method without a problem and ofono does not?

It has been a very long time since we developed PPP (about 10 years now), s=
o my =

memory may be fuzzy now.  But the answer to your question is that it isn't =

possible to auto-detect this.

The issue is, that the 'PPP server' running in the firmware has no clue wha=
t the =

authentication should be.  It is literally taking auth frames from the clie=
nt =

and forwarding them to the network.  The network is the one that actually k=
nows =

what the authentication details are.  3GPP mandates that CHAP is the 'defau=
lt' =

method for such cases.  But seems some providers had legacy software that =

demanded PAP, and instead of fixing the backend they pushed all these detai=
ls =

out to the front-end.  Hence why you have a need of provisioning data bases=
 like =

'mobile-broadband-provider-info' or the android APN db, etc.

So, the LCP configuration stage (where the auth options are chosen) is perf=
ormed =

prior to any of the frames being exchanged between the modem and the networ=
k. =

You can see this in your log 'ppp_dump_single_port.txt', where gsmdial is =

configured for CHAP, NAKs the PAP auth proto and the modem firmware happily =

switches to CHAP.  Why the subsequent CHALLENGE messages from the modem go =

unanswered by gsmdial is not clear to me.

> =

> Am I correct that my SW has to know which authentication must be used bef=
ore it =

> attempts to activate context for the first time? This is a big inconvenie=
nce. =

> Actually the fact that the context must be activated manually at the firs=
t time =

> is the big inconvenience too for embedded systems. But this is not the bi=
ggest =

> issue for me right now of course.

Unfortunately yes.  Look into provisioning contexts automatically.  See =

plugin/provision.c,  plugins/file-provision.c

> =

>  > Never tried this myself, but I never really had a reason to.=C2=A0 Not=
 sure if there
>  > is an easy way of doing that given you're running over a MUX.=C2=A0 If=
 you come up
>  > with a nice way, please share.
> =

> Sorry, I have not got your point about MUX. I have successfully=C2=A0obta=
ined the =

> dumps. I have 2 ttyUSB devices and gsmdial=C2=A0works fine with one tty a=
s well as =

> with both. Could you elaborate=C2=A0a little bit more on the MUX issue?

Didn't you say you have a Quectel  device?  Some of those are a serial port =

based modem and require a multiplexer.  I guess you have the USB variant so=
 what =

I said doesn't apply.

> =

> Please find the dumps attached. I did not find any problems in them. DTE =
sent a =

> termination request but why? I tried to use the CHAP, PAP and NONE auth =

> metnods=C2=A0but NONE hands with gsm dial.

I don't see pppd getting any IPCP protocol going, so I'm not really sure an=
y of =

this is working.

> I am going to debug ofono as you suggested:
> =

>  > Maybe put a few debug statements in ppp_auth.c, ppp_pap_start, ppp_pap=
_timeout
>  > and ppp_pap_process_packet.=C2=A0 See if PAP even occurs.
> =

> Also I have made a small patch for gsmdial=C2=A0that helps to choose auth=
 method. =

> Please find it attached.

Feel free to send this in using git send-email.  I don't review patches in =

attachments.  Note that the last time I looked at gsmdial was ~9 years ago,=
 so =

not sure how up to date it is compared to the ppp based gprs context code i=
n =

drivers/atmodem.  You may want to use g_at_ppp_set_recording (maybe via =

environment variable) from drivers/atmodem/gprs-context.c directly in order=
 to =

obtain dumps of what is happening when oFono is attempting to activate the =
context.

> I use=C2=A0cf9e6d048d65ff4a87f5707b0cc4fd3c036d62fb in my patch because t=
he last =

> commit in master de0d5a19c16bbb3eaba473e0eaaade7f55c48bcb=C2=A0 does not =
build for me =

> because of=C2=A0=C2=A0goto was left in a function without any label. Plea=
se see the error =

> below and in the file attached:
> | ../git/ofono/drivers/gemaltomodem/gprs-context.c: In function =

> 'gemalto_gprs_activate_primary':
> | ../git/ofono/drivers/gemaltomodem/gprs-context.c:156:3: error: label 'e=
rror' =

> used but not defined
> | =C2=A0 =C2=A0goto error;
> | =C2=A0 =C2=A0^~~~
> =


Please git pull --rebase.  I fixed this several days ago and there have bee=
n =

other commits applied since.

> Maybe I should add some "properties" to context for this modem before =

> activation?=C2=A0 Also I am not happy with the idea that I probably need =
to set an =

> authentication method by hand. Could this really be necessary with ofono =
in some =

> situations? I added the pppd configuration files of the modem vendor whic=
h work =

> fine. Do I need to add something=C2=A0to the context in ofono before acti=
vation?

See above about provisioning.

> =

> I strongly believe that ofono as embedded system software has to be as au=
tomated =

> as possible. Do you agree?
> =


Yes, and we try pretty hard to set sane defaults and auto-configure wheneve=
r we =

can.  But in some cases there are constraints we can't work around.

Regards,
-Denis
--===============7707234157180374214==--

