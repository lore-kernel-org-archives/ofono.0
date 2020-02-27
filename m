Content-Type: multipart/mixed; boundary="===============1600625143748561994=="
MIME-Version: 1.0
From: nick83ola <nick83ola@gmail.com>
Subject: Re: Telit ME910C1-WW not detected
Date: Thu, 27 Feb 2020 11:49:25 +0000
Message-ID: <CABPh3UP1bYPJRDjJwtR1nZxAXSmFNxS+mDfTZx4mRvKOO7hcDg@mail.gmail.com>
In-Reply-To: <CABPh3UOuR8+47G4v1f910A_FCZ2qYk3By5O1nygbrQq1gxE7-g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1600625143748561994==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anibal,
I was dragged in other things and I forgot to respond to you.
When I was in the US I had some issue with the network provider ->
they hadn't registered the sim for the right area where i was testing
it ->
so I couldn't test this patch thoroughly.

If there's anyone there with a telit ME910C1 in the US could be very
helpful if we can test this through.
From what I've seen the modem is recognized and when I did the test
from remote with the right SIM it was working fine.
But I didn't test the auto-attach patch and now we switched for the
moment to another modem so I'm not in the condition of testing this.

Cheers
Nicola Lunghi


On Mon, 21 Oct 2019 at 13:45, nick83ola <nick83ola@gmail.com> wrote:
>
> Hi Anibal,
>
> Sorry but i was dragged along with other tasks and didn't test this throu=
gly.
> Next week I will be in the US (I am based in Ireland) to do some
> testing on the reliability of ME910
> and I will be able to thoroughly test this.
> For now (from remote) it seems to be working fine but next week I will
> have more information on this
>
> Thanks for your patience
> Nicola Lunghi
>
> On Thu, 3 Oct 2019 at 23:09, Anibal Lim=C3=B3n <limon.anibal@gmail.com>=
 wrote:
> >
> > Hi,
> >
> > I fix a bug in the code due to auto-attach, see [1] and the specific ch=
ange [2].
> > Please test and let me know before send the patch.
> >
> > Cheers.
> > Anibal
> >
> > [1] https://github.com/alimon/ofono/tree/me910_fix_v2
> > [2] https://github.com/alimon/ofono/commit/682fd656afaf637b915d5d6b78a4=
211dd6e0884d
> >
> > On Wed, Oct 2, 2019 at 9:39 AM Anibal Lim=C3=B3n <limon.anibal@gmail.=
com> wrote:
> >>
> >>
> >>
> >> On Wed, Oct 2, 2019 at 9:32 AM nick83ola <nick83ola@gmail.com> wrote:
> >>>
> >>> Thanks
> >>>
> >>> do you think that you can submit it to ofono mailing list?
> >>>
> >>> in particular I don;t know if
> >>>
> >>> if (data->model =3D=3D ME910C1)
> >>> ofono_netreg_create(modem, OFONO_VENDOR_TELIT_ME910C1, "atmodem", dat=
a->chat);
> >>> else
> >>> ofono_netreg_create(modem, OFONO_VENDOR_TELIT, "atmodem", data->chat);
> >>
> >>
> >> That's because this specific model dosen't support  signal strength re=
porting via CIND.
> >>
> >> https://github.com/alimon/ofono/commit/920712e184ffaf1143e9ce13c3bec8a=
c1deeda5c#diff-2bbda16023120e26f58cfa7335520fb4
> >>
> >> Anibal
> >>
> >>>
> >>>
> >>> is acceptable
> >>>
> >>> Cheers
> >>> Nicola Lunghi
> >>>
> >>>
> >>> On Wed, 2 Oct 2019 at 15:29, Anibal Lim=C3=B3n <limon.anibal@gmail.=
com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On Wed, Oct 2, 2019 at 9:00 AM nick83ola <nick83ola@gmail.com> wro=
te:
> >>>>>
> >>>>> Hi Anibal,
> >>>>> I'm interested as well in the patch
> >>>>>
> >>>>> I saw that there you have two branches (me910 and v1.30+me910) can =
you tell me what branch have you tested?
> >>>>> the diff is this
> >>>>
> >>>>
> >>>> Yeah the latest one is me910, I was making a mistake to enable GPRS =
instead of disable it, that's the change.
> >>>>
> >>>> Anibal
> >>>>
> >>>>>
> >>>>>
> >>>>> git diff me910
> >>>>> diff --git a/plugins/telit.c b/plugins/telit.c
> >>>>> index f36995dc..50344281 100644
> >>>>> --- a/plugins/telit.c
> >>>>> +++ b/plugins/telit.c
> >>>>> @@ -239,16 +239,19 @@ static void cfun_enable_cb(gboolean ok, GAtRe=
sult *result, gpointer user_data)
> >>>>>
> >>>>>         ofono_modem_set_powered(modem, TRUE);
> >>>>>
> >>>>> -       /*
> >>>>> -        * Tell the modem not to automatically initiate auto-attach
> >>>>> -        * proceedures on its own.
> >>>>> -        */
> >>>>> -       if (data->model =3D=3D ME910C1)
> >>>>> -               g_at_chat_send(data->chat, "AT+CGATT=3D0", NULL, NU=
LL, NULL, NULL);
> >>>>> -       else
> >>>>> -
> >>>>> +       if (data->model =3D=3D ME910C1) {
> >>>>> +               /*
> >>>>> +                * Telit ME910C1 needs to activate the GPRS to auto=
-attach the network.
> >>>>> +                */
> >>>>> +               g_at_chat_send(data->chat, "AT+CGATT=3D1", NULL, NU=
LL, NULL, NULL);
> >>>>> +       } else {
> >>>>> +               /*
> >>>>> +                * Tell the modem not to automatically initiate aut=
o-attach
> >>>>> +                * proceedures on its own.
> >>>>> +                */
> >>>>>                 g_at_chat_send(data->chat, "AT#AUTOATT=3D0", none_p=
refix,
> >>>>>                                         NULL, NULL, NULL);
> >>>>> +       }
> >>>>>
> >>>>>         /* Follow sim state */
> >>>>>         g_at_chat_register(data->chat, "#QSS:", telit_qss_notify,
> >>>>>
> >>>>>
> >>>>> Thanks
> >>>>> Nicola Lunghi
> >>>>>
> >>>>>
> >>>>> On Tue, 1 Oct 2019 at 22:54, <limon.anibal@gmail.com> wrote:
> >>>>>>
> >>>>>> Hi Dresdo,
> >>>>>>
> >>>>>> I have a patch that adds support for Telit ME910 but it is upon Of=
ono 1.30, i plan to send for review.
> >>>>>>
> >>>>>> https://github.com/alimon/ofono/commit/920712e184ffaf1143e9ce13c3b=
ec8ac1deeda5c
> >>>>>>
> >>>>>> Regards!,
> >>>>>> Anibal
> >>>>>> _______________________________________________
> >>>>>> ofono mailing list -- ofono(a)ofono.org
> >>>>>> To unsubscribe send an email to ofono-leave(a)ofono.org
--===============1600625143748561994==--

