Content-Type: multipart/mixed; boundary="===============4477762654018943269=="
MIME-Version: 1.0
From: Miettinen Pasi <pasi.miettinen@ixonos.com>
Subject: VS: [PATCH 09/11] Support for concatenated SMS status report. And
 ofono_history_sms is now updated according to received status reports.
Date: Mon, 31 May 2010 15:33:52 +0300
Message-ID: <EA8B5A37FEEFC048AF3F8170D2819913B8C1280A47@jklmail01.ixonos.local>
In-Reply-To: <201005281226.41699.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4477762654018943269==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Hi Pasi,
>
> > From: Pasi Miettinen <pasi.miettinen@ixonos.com>
> >
> > ---
> >  include/history.h |    2 +
> >  src/sms.c         |  157
> >  ++++++++++++++++++++++++++++++++++++++++++++++++++++- src/smsutil.h
> |
> >    6 ++
> >  3 files changed, 163 insertions(+), 2 deletions(-)
> >
>
> Some general comments:
>
> I'd like to see a status_report assembly similar to how the sms_assembly =
is
> done.  This should exist in smsutil.c/.h so that we can easily unit test =
this
> functionality (which I would also like to see.)
>
> Another desirable feature for the status report assembly is to save off t=
he
> status report fragments on disk, so that status reports (for multi-fragme=
nt
> SMSes) received across oFono / system reboots and crashes are handled
> appropriately.
>
> Regards,
> -Denis

Hi Denis,

Could you clarify a bit what do you mean by "status_report assembly silmilar
to how the sms_assembly is done"?

Currently I have a belief that status-report, which relates to sent concate=
nated
message, does not know anything about other status-reports which relate to
the same concatenated message. I have to admit that I am not sure if this
belief is correct. Is it?

If the status-reports of the concatenated message know about each other,
then I might have some kind of picture what you are looking for concidering
the status_report assembly. Otherwise I am little bit lost what you are aft=
er
if my current solution does not satisfy you at all.

Br,
-Pasi

--===============4477762654018943269==--

