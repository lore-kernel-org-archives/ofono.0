Content-Type: multipart/mixed; boundary="===============0297092734509162481=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: VS: [PATCH 09/11] Support for concatenated SMS status report. And
 ofono_history_sms is now updated according to received status reports.
Date: Mon, 31 May 2010 11:18:30 -0500
Message-ID: <201005311118.31480.denkenz@gmail.com>
In-Reply-To: <EA8B5A37FEEFC048AF3F8170D2819913B8C1280A47@jklmail01.ixonos.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0297092734509162481==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pasi,

> > I'd like to see a status_report assembly similar to how the sms_assembly
> > is done.  This should exist in smsutil.c/.h so that we can easily unit
> > test this functionality (which I would also like to see.)
> >
> > Another desirable feature for the status report assembly is to save off
> > the status report fragments on disk, so that status reports (for
> > multi-fragment SMSes) received across oFono / system reboots and crashes
> > are handled appropriately.
> =

> Could you clarify a bit what do you mean by "status_report assembly
>  silmilar to how the sms_assembly is done"?

The function of sms_assembly is twofold:
- It takes care of all the de-fragmentation logic and only gives back a lis=
t =

of sms fragments once the entire list is received.  This is done outside of =

src/sms.c so that we can easily unit test this functionality and to keep =

clutter out of the main core logic.
- It takes care of writing fragments out to disk, so that in case of reset =
/ =

reboot the received fragments are not lost.  This storage is keyed by the I=
MSI =

of SIM card, so even if the SIM is removed and a new inserted things just =

work.

For status reports I'd like something similar.  E.g. if I send a concatenat=
ed =

message with 3 fragments, and only 2 status reports come in before reboot, =
the =

next time I startup and receive the 3rd status report, the message state =

should be updated appropriately.

> =

> Currently I have a belief that status-report, which relates to sent
>  concatenated message, does not know anything about other status-reports
>  which relate to the same concatenated message. I have to admit that I am
>  not sure if this belief is correct. Is it?

You are correct in that each status report is handled / delivered separatel=
y.  =

However, just relying on MR is not enough.  If you're sending lots of messa=
ges =

it is quite easy to overflow the MR.  So you must at least take the destina=
tion =

address into account.

Also, for sms fragments containing a udh, you can set some bits indicating =
to =

the SMSC to preserve the outgoing headers.  This way you can actually =

correlate the outgoing fragmentation information to the incoming status =

reports.  See Service Center Control Parameters IEI.  Whether this is usefu=
l =

in practice, I'm not sure...

> =

> If the status-reports of the concatenated message know about each other,
> then I might have some kind of picture what you are looking for concideri=
ng
> the status_report assembly. Otherwise I am little bit lost what you are
>  after if my current solution does not satisfy you at all.

If the SMSC sends you the original headers, then you have a pretty good cha=
nce =

of reliably correlating between sent message fragments and incoming status =

reports.  If you don't, then fall back to the regular MR + destination addr=
ess =

approach.

The status_report_assembly can actually take some information as input.  Su=
ch =

as the fragment concatentation header, message reference, outgoing address =
and =

expiration time.

So in summary:
- should be in src/smsutil.c
- store intermediate state on disk and restore the state as needed on start=
up
- takes mr + destination address into account
- only notifies once all fragments are received or first fails

Regards,
-Denis

--===============0297092734509162481==--

