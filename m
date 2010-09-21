Content-Type: multipart/mixed; boundary="===============6626332304619488318=="
MIME-Version: 1.0
From: linux mobile <rams.linux.mobile@gmail.com>
Subject: Re: Reg: Memory capacity exceeded
Date: Tue, 21 Sep 2010 12:04:46 +0530
Message-ID: <AANLkTi=YyOFH_4hEz7aPtb+Jd-ZziJTA0OK+Bb4EL4g_@mail.gmail.com>
In-Reply-To: <AANLkTimVVv8_NBZmWKP5Lp4yrjdWb8A-iARafAzmgCqa@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6626332304619488318==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

As my understand

Messaging application will interact with Ofono and from Ofono to  driver
specific functionality specific to h/w.(Eg: isi modem)

Incoming messages will be stored in device. If the storage capacity is over
in the device then there is a way to inform the network that memory capacity
is exceeded.

 As application can't access driver specific functions  directly  this
should be done  through Ofono .

Thanks
Rams



On Mon, Sep 20, 2010 at 10:40 PM, <ofono-request@ofono.org> wrote:

> Send ofono mailing list submissions to
>        ofono(a)ofono.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>        http://lists.ofono.org/listinfo/ofono
> or, via email, send a message with subject or body 'help' to
>        ofono-request(a)ofono.org
>
> You can reach the person managing the list at
>        ofono-owner(a)ofono.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of ofono digest..."
>
>
> Today's Topics:
>
>   1. [PATCH v2 2/2] huawei: fix online logic (Kalle Valo)
>   2. Re: Reg: Memory capacity exceeded (Denis Kenzior)
>   3. Re: ofono gprs_primary_context description (Denis Kenzior)
>   4. Re: Reg: Memory capacity exceeded (Aki Niemi)
>   5. RE: Reg: Memory capacity exceeded
>      (Jeevaka.Badrappan(a)elektrobit.com)
>   6. Re: Reg: Memory capacity exceeded (Denis Kenzior)
>   7. Re: [PATCH v2 1/2] huawei: poll sim state (Marcel Holtmann)
>   8. Re: [PATCH v2 2/2] huawei: fix online logic (Marcel Holtmann)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Mon, 20 Sep 2010 15:40:33 +0300
> From: Kalle Valo <kalle.valo@canonical.com>
> To: ofono(a)ofono.org
> Subject: [PATCH v2 2/2] huawei: fix online logic
> Message-ID: <20100920124033.12498.3545.stgit@potku.valot.fi>
> Content-Type: text/plain; charset=3D"utf-8"
>
> The recently introduced online support to huawei didn't work with my
> Huawei E1552. The problem was that with command AT+CFUN=3D1;+CFUN=3D5
> the modem didn't initialise the sim state properly.
>
> To fix this I changed the logic so that CFUN=3D5 is called only after the=
 sim
> state has switched to a valid state. Now my Huawei E1552 works with connm=
an
> again.
>
> PIN locked SIMs still won't work. The problem is that it takes some time
> for
> the sim state to go to a valid state:
>
> Sep 20 15:01:57 dell-m520 ofonod[12451]: Pcui:< \r\n+CPIN:
> READY\r\n\r\nOK\r\n
> [...]
> Sep 20 15:02:00 dell-m520 ofonod[12451]: huawei: invalid sim state in post
> online (0)
> [...]
> Sep 20 15:02:01 dell-m520 ofonod[12451]: Pcui:< \r\n^SIMST:1\r\n
>
> I don't know why it takes so long to get a valid state.
>
> There is also another issue, in "cold start" case the phonebook
> initialisation fails:
>
> Sep 20 14:34:24 dell-m520 ofonod[11939]: Pcui:> AT+CPBS=3D?\r
> Sep 20 14:34:24 dell-m520 ofonod[11939]: Pcui:< \r\n+CME ERROR: SIM
> busy\r\n
>
> But in "warm start" it seems to work:
>
> Sep 20 14:38:59 dell-m520 ofonod[12091]: Pcui:> AT+CPBS=3D?\r
> Sep 20 14:38:59 dell-m520 ofonod[12091]: Pcui:< \r\n+CPBS:
> ("SM","EN","ON")\r\n\r\nOK\r\n
>
> I consider this as a minor issue and didn't investigate it at all.
> ---
>  plugins/huawei.c |   77
> +++++++++++++++++++++++++++++++++++++-----------------
>  1 files changed, 53 insertions(+), 24 deletions(-)
>
> diff --git a/plugins/huawei.c b/plugins/huawei.c
> index 2f605ee..27473a8 100644
> --- a/plugins/huawei.c
> +++ b/plugins/huawei.c
> @@ -163,6 +163,22 @@ static void ussdmode_support_cb(gboolean ok, GAtResu=
lt
> *result,
>                                        ussdmode_query_cb, data, NULL);
>  }
>
> +static void cfun_offline(gboolean ok, GAtResult *result, gpointer
> user_data)
> +{
> +       struct ofono_modem *modem =3D user_data;
> +       struct huawei_data *data =3D ofono_modem_get_data(modem);
> +
> +       if (!ok) {
> +               ofono_modem_set_powered(modem, FALSE);
> +               return;
> +       }
> +
> +       if (data->sim =3D=3D NULL)
> +               return;
> +
> +       ofono_sim_inserted_notify(data->sim, TRUE);
> +}
> +
>  static gboolean notify_sim_state(struct ofono_modem *modem,
>                                enum huawei_sim_state sim_state)
>  {
> @@ -170,17 +186,33 @@ static gboolean notify_sim_state(struct ofono_modem
> *modem,
>
>        DBG("%d", sim_state);
>
> -       if (sim_state =3D=3D HUAWEI_SIM_STATE_NOT_EXISTENT) {
> -               ofono_sim_inserted_notify(data->sim, FALSE);
> +       data->sim_state =3D sim_state;
>
> +       switch (sim_state) {
> +       case HUAWEI_SIM_STATE_NOT_EXISTENT:
>                /* SIM is not ready, try again a bit later */
>                return TRUE;
> +       case HUAWEI_SIM_STATE_INVALID_OR_LOCKED:
> +               ofono_modem_set_powered(modem, TRUE);
> +
> +               return FALSE;
> +       case HUAWEI_SIM_STATE_VALID:
> +       case HUAWEI_SIM_STATE_INVALID_CS:
> +       case HUAWEI_SIM_STATE_INVALID_PS:
> +       case HUAWEI_SIM_STATE_INVALID_PS_AND_CS:
> +               /*
> +                * In the "warm start" case the modem skips
> +                * HUAWEI_SIM_STATE_INVALID_OR_LOCKED altogether, so need
> +                * to set power also here
> +                */
> +               ofono_modem_set_powered(modem, TRUE);
> +
> +               g_at_chat_send(data->pcui, "AT+CFUN=3D5", none_prefix,
> +                               cfun_offline, modem, NULL);
> +
> +               return FALSE;
>        }
>
> -       ofono_sim_inserted_notify(data->sim, TRUE);
> -
> -       data->sim_state =3D sim_state;
> -
>        return FALSE;
>  }
>
> @@ -347,24 +379,24 @@ static void cvoice_query_cb(gboolean ok, GAtResult
> *result,
>        gint mode, rate, bits, period;
>
>        if (!ok)
> -               goto done;
> +               return;
>
>        g_at_result_iter_init(&iter, result);
>
>        if (!g_at_result_iter_next(&iter, "^CVOICE:"))
> -               goto done;
> +               return;
>
>        if (!g_at_result_iter_next_number(&iter, &mode))
> -               goto done;
> +               return;
>
>        if (!g_at_result_iter_next_number(&iter, &rate))
> -               goto done;
> +               return;
>
>        if (!g_at_result_iter_next_number(&iter, &bits))
> -               goto done;
> +               return;
>
>        if (!g_at_result_iter_next_number(&iter, &period))
> -               goto done;
> +               return;
>
>        data->voice =3D TRUE;
>
> @@ -383,9 +415,6 @@ static void cvoice_query_cb(gboolean ok, GAtResult
> *result,
>        /* check available voice ports */
>        g_at_chat_send(data->pcui, "AT^DDSETEX=3D?", none_prefix,
>                                                NULL, NULL, NULL);
> -
> -done:
> -       ofono_modem_set_powered(modem, TRUE);
>  }
>
>  static void cvoice_support_cb(gboolean ok, GAtResult *result,
> @@ -396,21 +425,16 @@ static void cvoice_support_cb(gboolean ok, GAtResult
> *result,
>        GAtResultIter iter;
>
>        if (!ok)
> -               goto done;
> +               return;
>
>        g_at_result_iter_init(&iter, result);
>
>        if (!g_at_result_iter_next(&iter, "^CVOICE:"))
> -               goto done;
> +               return;
>
>        /* query current voice setting */
>        g_at_chat_send(data->pcui, "AT^CVOICE?", cvoice_prefix,
>                                        cvoice_query_cb, modem, NULL);
> -
> -       return;
> -
> -done:
> -       ofono_modem_set_powered(modem, TRUE);
>  }
>
>  static void cfun_enable(gboolean ok, GAtResult *result, gpointer
> user_data)
> @@ -550,7 +574,7 @@ static int huawei_enable(struct ofono_modem *modem)
>
>        g_at_chat_send(data->pcui, "ATE0", none_prefix, NULL, NULL, NULL);
>
> -       g_at_chat_send(data->pcui, "AT+CFUN=3D1;+CFUN=3D5", none_prefix,
> +       g_at_chat_send(data->pcui, "AT+CFUN=3D1", none_prefix,
>                                        cfun_enable, modem, NULL);
>
>        query_sim_state(modem);
> @@ -667,8 +691,13 @@ static void huawei_post_online(struct ofono_modem
> *modem)
>        struct ofono_netreg *netreg;
>        struct ofono_message_waiting *mw;
>
> -       if (data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_PS_AND_CS)
> +       if (data->sim_state !=3D HUAWEI_SIM_STATE_VALID &&
> +           data->sim_state !=3D HUAWEI_SIM_STATE_INVALID_CS &&
> +           data->sim_state !=3D HUAWEI_SIM_STATE_INVALID_PS) {
> +               ofono_info("huawei: invalid sim state in post online (%d)=
",
> +                               data->sim_state);
>                return;
> +       }
>
>        netreg =3D ofono_netreg_create(modem, OFONO_VENDOR_HUAWEI, "atmode=
m",
>                                                                data->pcui=
);
>
>
>
> ------------------------------
>
> Message: 2
> Date: Mon, 20 Sep 2010 07:44:45 -0500
> From: Denis Kenzior <denkenz@gmail.com>
> To: ofono(a)ofono.org
> Subject: Re: Reg: Memory capacity exceeded
> Message-ID: <4C97573D.90406@gmail.com>
> Content-Type: text/plain; charset=3DISO-8859-1
>
> Hi Jeevaka,
>
> On 09/20/2010 07:39 AM, Jeevaka.Badrappan(a)elektrobit.com wrote:
> > Hi,
> >
> >> Of course, one can argue whether this feature really has some real
> >> world relevance or is purely theoretical.
> >>
> >> I wonder if it is a type approval requirement to support?
> >
> >> I'm afraid there is a PICS case for this thing. I cannot recall how we
> > got N900 through this particular hoop, but probably we just waived this
> > particular test case irrelevant.
> >
> > correct. There is a USIM conformance case on this message capacitiy
> > exceeded information. As per the 3GPP 31.121 specification section 8.2:
> >
> > "If all SMS data field are full and furthermore all memory capacity
> > reserved for SMS inside the ME is filled up to maximum and a SM(Short
> > Message) was rejected, then this shall be indicated in the SMS Status
> > file.(EFsmss)"
>
> The thing is, oFono configures SMS for direct delivery (e.g. no SM/ME
> storage).  And even if direct delivery does not work (e.g. crappy modem
> or Class 2 / Class 3 messages) oFono still removes the SMS as soon as it
> is delivered.  We should never hit a sim/me memory full conditions.
>
> So I don't see how this test case even applies.
>
> Regards,
> -Denis
>
>
> ------------------------------
>
> Message: 3
> Date: Mon, 20 Sep 2010 07:49:48 -0500
> From: Denis Kenzior <denkenz@gmail.com>
> To: ofono(a)ofono.org
> Subject: Re: ofono gprs_primary_context description
> Message-ID: <4C97586C.8000801@gmail.com>
> Content-Type: text/plain; charset=3Dwindows-1252
>
> Hi Laurent,
>
> On 09/20/2010 04:20 AM, Laurent THOMAS wrote:
> > Hi,
> >
> >
> >
> > According to the interface org.ofono.ConnectionContext description, the
> > property ?Name? is a free short string used to describe the context.
> >
> > Extract from ?conman-api.txt?
> >
> > /Properties         string Name [readwrite]/
> >
> > / /
> >
> > /                                   The name is a free form string that
> > describes this/
> >
> > /                                   context.  The name should not be
> > empty and limited/
> >
> > /                                   to a short string for display
> purposes./
> >
> >
> >
> > But according to source code (version 0.28), this attribute is now only
> > affected with the context String Type (?internet?, ?wap? or ?mms?)
> >
> >
> >
> > is it really the expected behaviour or did I miss something ?
>
> By default the Name is set to the context type.  E.g. creating an
> "internet" context results in the name being set to "internet."  You can
> still reset the Name later to whatever you wish.
>
> ~/ofono-master$ test/list-contexts
> [ /phonesim ]
>    [ /phonesim/context1 ]
>        Username =3D
>        Protocol =3D ip
>        Name =3D Foobar
>        Settings =3D { }
>        Active =3D 0
>        AccessPointName =3D
>        Password =3D
>        Type =3D internet
>
>
> Regards,
> -Denis
>
>
> ------------------------------
>
> Message: 4
> Date: Mon, 20 Sep 2010 15:53:13 +0300
> From: Aki Niemi <aki.niemi@nokia.com>
> To: "ofono(a)ofono.org" <ofono@ofono.org>
> Subject: Re: Reg: Memory capacity exceeded
> Message-ID: <1284987193.12393.485.camel@tucson.research.nokia.com>
> Content-Type: text/plain; charset=3D"UTF-8"
>
> On Mon, 2010-09-20 at 14:29 +0200, ext Pekka Pessi wrote:
> > I'm afraid there is a PICS case for this thing. I cannot recall how we
> > got N900 through this particular hoop, but probably we just waived
> > this particular test case irrelevant.
>
> I know we have the machinery in place in N900 to report memory exceeded
> to the network. And I even remember it getting tested at some point,
> basically flooding /var/spool/sms is enough to trigger it.
>
> If this can be waived, though, good riddance.
>
> Cheers,
> Aki
>
>
>
> ------------------------------
>
> Message: 5
> Date: Mon, 20 Sep 2010 17:08:41 +0300
> From: <Jeevaka.Badrappan@elektrobit.com>
> To: <denkenz@gmail.com>, <ofono@ofono.org>
> Subject: RE: Reg: Memory capacity exceeded
> Message-ID:
>        <
> B668883EB5DD7144ADFC248A72176EA802A51A03(a)fioues07.ebgroup.elektrobit.co=
m>
>
> Content-Type: text/plain;       charset=3D"us-ascii"
>
>
> Hi Denis,
>
> > The thing is, oFono configures SMS for direct delivery (e.g. no SM/ME
> storage).  And even if direct delivery does not work (e.g. crappy modem
> or Class 2 / Class 3 messages) oFono still removes the SMS
> > as soon as it is delivered.  We should never hit a sim/me memory full
> conditions.
>
> > So I don't see how this test case even applies.
>
> Little bit lost now. Are we speaking about the sending or receiving of
> SMS?
>
> Memory capacity exceeded applies to incoming SMS. Incoming SMS can be
> stored in SIM or in ME storage. If the SMS storage for incoming SMS is
> full, then the ME can inform the network that it can't handle any more
> class 1/class 2 incoming SMS due to maximum memory capacity reached.
> Once the user frees some memory by deleting some messages, then ME can
> inform network that it is ready now to receive messages. So, I believe
> this test case applies but as Pessi Pekka said we can waive this test
> case.
>
> Regards,
> jeevaka
>
>
> ------------------------------
>
> Message: 6
> Date: Mon, 20 Sep 2010 09:11:45 -0500
> From: Denis Kenzior <denkenz@gmail.com>
> To: Jeevaka.Badrappan(a)elektrobit.com
> Cc: ofono(a)ofono.org
> Subject: Re: Reg: Memory capacity exceeded
> Message-ID: <4C976BA1.30600@gmail.com>
> Content-Type: text/plain; charset=3DISO-8859-1
>
> Hi Jeevaka,
>
> On 09/20/2010 09:08 AM, Jeevaka.Badrappan(a)elektrobit.com wrote:
> >
> > Hi Denis,
> >
> >> The thing is, oFono configures SMS for direct delivery (e.g. no SM/ME
> > storage).  And even if direct delivery does not work (e.g. crappy modem
> > or Class 2 / Class 3 messages) oFono still removes the SMS
> >> as soon as it is delivered.  We should never hit a sim/me memory full
> > conditions.
> >
> >> So I don't see how this test case even applies.
> >
> > Little bit lost now. Are we speaking about the sending or receiving of
> > SMS?
> >
> > Memory capacity exceeded applies to incoming SMS. Incoming SMS can be
> > stored in SIM or in ME storage. If the SMS storage for incoming SMS is
> > full, then the ME can inform the network that it can't handle any more
> > class 1/class 2 incoming SMS due to maximum memory capacity reached.
> > Once the user frees some memory by deleting some messages, then ME can
> > inform network that it is ready now to receive messages. So, I believe
> > this test case applies but as Pessi Pekka said we can waive this test
> > case.
>
> I know exactly the case you're talking about, but as I mentioned before,
> oFono does not configure the modem to store on SIM or ME.  The messages
> are routed directly to oFono.  See drivers/atmodem/sms.c for more
> details.  The only messages that *might* get routed to SM/ME are Class 2
> / 3 messages.  These are automatically deleted on reception by the sms
> driver.
>
> The 'memory capacity reached' can simply never happen assuming sane
> hardware.
>
> Regards,
> -Denis
>
>
> ------------------------------
>
> Message: 7
> Date: Tue, 21 Sep 2010 02:09:36 +0900
> From: Marcel Holtmann <marcel@holtmann.org>
> To: ofono(a)ofono.org
> Subject: Re: [PATCH v2 1/2] huawei: poll sim state
> Message-ID: <1285002576.20811.36.camel@localhost.localdomain>
> Content-Type: text/plain; charset=3D"UTF-8"
>
> Hi Kalle,
>
> > On my Huawei E1552 when I plug in the modem (ie. cold start) with PIN
> locked
> > SIM, the sim state is 255 (HUAWEI_SIM_STATE_NOT_EXISTENT). As the modem
> > doesn't send ^SIMST notifications, poll the sim state until it's ready.
> >
> > In theory it might be possible to do this better, for example follow
> > ^BOOT notifications or something, but it's unknown what parameter we
> > should check for.
> > ---
> >  plugins/huawei.c |   66
> +++++++++++++++++++++++++++++++++++++++++++-----------
> >  1 files changed, 53 insertions(+), 13 deletions(-)
>
> patch has been applied.
>
> Regards
>
> Marcel
>
>
>
>
> ------------------------------
>
> Message: 8
> Date: Tue, 21 Sep 2010 02:09:55 +0900
> From: Marcel Holtmann <marcel@holtmann.org>
> To: ofono(a)ofono.org
> Subject: Re: [PATCH v2 2/2] huawei: fix online logic
> Message-ID: <1285002595.20811.37.camel@localhost.localdomain>
> Content-Type: text/plain; charset=3D"UTF-8"
>
> Hi Kalle,
>
> > The recently introduced online support to huawei didn't work with my
> > Huawei E1552. The problem was that with command AT+CFUN=3D1;+CFUN=3D5
> > the modem didn't initialise the sim state properly.
> >
> > To fix this I changed the logic so that CFUN=3D5 is called only after t=
he
> sim
> > state has switched to a valid state. Now my Huawei E1552 works with
> connman
> > again.
> >
> > PIN locked SIMs still won't work. The problem is that it takes some time
> for
> > the sim state to go to a valid state:
> >
> > Sep 20 15:01:57 dell-m520 ofonod[12451]: Pcui:< \r\n+CPIN:
> READY\r\n\r\nOK\r\n
> > [...]
> > Sep 20 15:02:00 dell-m520 ofonod[12451]: huawei: invalid sim state in
> post online (0)
> > [...]
> > Sep 20 15:02:01 dell-m520 ofonod[12451]: Pcui:< \r\n^SIMST:1\r\n
> >
> > I don't know why it takes so long to get a valid state.
> >
> > There is also another issue, in "cold start" case the phonebook
> > initialisation fails:
> >
> > Sep 20 14:34:24 dell-m520 ofonod[11939]: Pcui:> AT+CPBS=3D?\r
> > Sep 20 14:34:24 dell-m520 ofonod[11939]: Pcui:< \r\n+CME ERROR: SIM
> busy\r\n
> >
> > But in "warm start" it seems to work:
> >
> > Sep 20 14:38:59 dell-m520 ofonod[12091]: Pcui:> AT+CPBS=3D?\r
> > Sep 20 14:38:59 dell-m520 ofonod[12091]: Pcui:< \r\n+CPBS:
> ("SM","EN","ON")\r\n\r\nOK\r\n
> >
> > I consider this as a minor issue and didn't investigate it at all.
> > ---
> >  plugins/huawei.c |   77
> +++++++++++++++++++++++++++++++++++++-----------------
> >  1 files changed, 53 insertions(+), 24 deletions(-)
>
> patch has been applied.
>
> Regards
>
> Marcel
>
>
>
>
> ------------------------------
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>
>
> End of ofono Digest, Vol 17, Issue 71
> *************************************
>

--===============6626332304619488318==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGksPGJyPjxicj5BcyBteSB1bmRlcnN0YW5kIDxicj48YnI+TWVzc2FnaW5nIGFwcGxpY2F0aW9u
IHdpbGwgaW50ZXJhY3Qgd2l0aCBPZm9ubyBhbmQgZnJvbSBPZm9ubyB0b6AgZHJpdmVyIHNwZWNp
ZmljIGZ1bmN0aW9uYWxpdHkgc3BlY2lmaWMgdG8gaC93LihFZzogaXNpIG1vZGVtKTxicj48YnI+
SW5jb21pbmcgbWVzc2FnZXMgd2lsbCBiZSBzdG9yZWQgaW4gZGV2aWNlLiBJZiB0aGUgc3RvcmFn
ZSBjYXBhY2l0eSBpcyBvdmVyIGluIHRoZSBkZXZpY2UgdGhlbiB0aGVyZSBpcyBhIHdheSB0byBp
bmZvcm0gdGhlIG5ldHdvcmsgdGhhdCBtZW1vcnkgY2FwYWNpdHkgaXMgZXhjZWVkZWQuIDxicj4K
PGJyPqBBcyBhcHBsaWNhdGlvbiBjYW4mIzM5O3QgYWNjZXNzIGRyaXZlciBzcGVjaWZpYyBmdW5j
dGlvbnOgIGRpcmVjdGx5oCB0aGlzIHNob3VsZCBiZSBkb25loCB0aHJvdWdoIE9mb25vIC48YnI+
PGJyPlRoYW5rczxicj5SYW1zPGJyPjxicj48YnI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3Rl
Ij5PbiBNb24sIFNlcCAyMCwgMjAxMCBhdCAxMDo0MCBQTSwgIDxzcGFuIGRpcj0ibHRyIj4mbHQ7
PGEgaHJlZj0ibWFpbHRvOm9mb25vLXJlcXVlc3RAb2Zvbm8ub3JnIiB0YXJnZXQ9Il9ibGFuayI+
b2Zvbm8tcmVxdWVzdEBvZm9uby5vcmc8L2E+Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJyPgoKPGJsb2Nr
cXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOiAwcHQgMHB0IDBwdCAwLjhl
eDsgYm9yZGVyLWxlZnQ6IDFweCBzb2xpZCByZ2IoMjA0LCAyMDQsIDIwNCk7IHBhZGRpbmctbGVm
dDogMWV4OyI+U2VuZCBvZm9ubyBtYWlsaW5nIGxpc3Qgc3VibWlzc2lvbnMgdG88YnI+CiCgIKAg
oCCgPGEgaHJlZj0ibWFpbHRvOm9mb25vQG9mb25vLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPm9mb25v
QG9mb25vLm9yZzwvYT48YnI+Cjxicj4KVG8gc3Vic2NyaWJlIG9yIHVuc3Vic2NyaWJlIHZpYSB0
aGUgV29ybGQgV2lkZSBXZWIsIHZpc2l0PGJyPgogoCCgIKAgoDxhIGhyZWY9Imh0dHA6Ly9saXN0
cy5vZm9uby5vcmcvbGlzdGluZm8vb2Zvbm8iIHRhcmdldD0iX2JsYW5rIj5odHRwOi8vbGlzdHMu
b2Zvbm8ub3JnL2xpc3RpbmZvL29mb25vPC9hPjxicj4Kb3IsIHZpYSBlbWFpbCwgc2VuZCBhIG1l
c3NhZ2Ugd2l0aCBzdWJqZWN0IG9yIGJvZHkgJiMzOTtoZWxwJiMzOTsgdG88YnI+CiCgIKAgoCCg
PGEgaHJlZj0ibWFpbHRvOm9mb25vLXJlcXVlc3RAb2Zvbm8ub3JnIiB0YXJnZXQ9Il9ibGFuayI+
b2Zvbm8tcmVxdWVzdEBvZm9uby5vcmc8L2E+PGJyPgo8YnI+CllvdSBjYW4gcmVhY2ggdGhlIHBl
cnNvbiBtYW5hZ2luZyB0aGUgbGlzdCBhdDxicj4KIKAgoCCgIKA8YSBocmVmPSJtYWlsdG86b2Zv
bm8tb3duZXJAb2Zvbm8ub3JnIiB0YXJnZXQ9Il9ibGFuayI+b2Zvbm8tb3duZXJAb2Zvbm8ub3Jn
PC9hPjxicj4KPGJyPgpXaGVuIHJlcGx5aW5nLCBwbGVhc2UgZWRpdCB5b3VyIFN1YmplY3QgbGlu
ZSBzbyBpdCBpcyBtb3JlIHNwZWNpZmljPGJyPgp0aGFuICZxdW90O1JlOiBDb250ZW50cyBvZiBv
Zm9ubyBkaWdlc3QuLi4mcXVvdDs8YnI+Cjxicj4KPGJyPgpUb2RheSYjMzk7cyBUb3BpY3M6PGJy
Pgo8YnI+CiCgIDEuIFtQQVRDSCB2MiAyLzJdIGh1YXdlaTogZml4IG9ubGluZSBsb2dpYyAoS2Fs
bGUgVmFsbyk8YnI+CiCgIDIuIFJlOiBSZWc6IE1lbW9yeSBjYXBhY2l0eSBleGNlZWRlZCAoRGVu
aXMgS2Vuemlvcik8YnI+CiCgIDMuIFJlOiBvZm9ubyBncHJzX3ByaW1hcnlfY29udGV4dCBkZXNj
cmlwdGlvbiAoRGVuaXMgS2Vuemlvcik8YnI+CiCgIDQuIFJlOiBSZWc6IE1lbW9yeSBjYXBhY2l0
eSBleGNlZWRlZCAoQWtpIE5pZW1pKTxicj4KIKAgNS4gUkU6IFJlZzogTWVtb3J5IGNhcGFjaXR5
IGV4Y2VlZGVkPGJyPgogoCCgIKAoPGEgaHJlZj0ibWFpbHRvOkplZXZha2EuQmFkcmFwcGFuQGVs
ZWt0cm9iaXQuY29tIiB0YXJnZXQ9Il9ibGFuayI+SmVldmFrYS5CYWRyYXBwYW5AZWxla3Ryb2Jp
dC5jb208L2E+KTxicj4KIKAgNi4gUmU6IFJlZzogTWVtb3J5IGNhcGFjaXR5IGV4Y2VlZGVkIChE
ZW5pcyBLZW56aW9yKTxicj4KIKAgNy4gUmU6IFtQQVRDSCB2MiAxLzJdIGh1YXdlaTogcG9sbCBz
aW0gc3RhdGUgKE1hcmNlbCBIb2x0bWFubik8YnI+CiCgIDguIFJlOiBbUEFUQ0ggdjIgMi8yXSBo
dWF3ZWk6IGZpeCBvbmxpbmUgbG9naWMgKE1hcmNlbCBIb2x0bWFubik8YnI+Cjxicj4KPGJyPgot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tPGJyPgo8YnI+Ck1lc3NhZ2U6IDE8YnI+CkRhdGU6IE1vbiwgMjAgU2VwIDIw
MTAgMTU6NDA6MzMgKzAzMDA8YnI+CkZyb206IEthbGxlIFZhbG8gJmx0OzxhIGhyZWY9Im1haWx0
bzprYWxsZS52YWxvQGNhbm9uaWNhbC5jb20iIHRhcmdldD0iX2JsYW5rIj5rYWxsZS52YWxvQGNh
bm9uaWNhbC5jb208L2E+Jmd0Ozxicj4KVG86IDxhIGhyZWY9Im1haWx0bzpvZm9ub0BvZm9uby5v
cmciIHRhcmdldD0iX2JsYW5rIj5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgpTdWJqZWN0OiBbUEFU
Q0ggdjIgMi8yXSBodWF3ZWk6IGZpeCBvbmxpbmUgbG9naWM8YnI+Ck1lc3NhZ2UtSUQ6ICZsdDs8
YSBocmVmPSJtYWlsdG86MjAxMDA5MjAxMjQwMzMuMTI0OTguMzU0NS5zdGdpdEBwb3RrdS52YWxv
dC5maSIgdGFyZ2V0PSJfYmxhbmsiPjIwMTAwOTIwMTI0MDMzLjEyNDk4LjM1NDUuc3RnaXRAcG90
a3UudmFsb3QuZmk8L2E+Jmd0Ozxicj4KQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0
PSZxdW90O3V0Zi04JnF1b3Q7PGJyPgo8YnI+ClRoZSByZWNlbnRseSBpbnRyb2R1Y2VkIG9ubGlu
ZSBzdXBwb3J0IHRvIGh1YXdlaSBkaWRuJiMzOTt0IHdvcmsgd2l0aCBteTxicj4KSHVhd2VpIEUx
NTUyLiBUaGUgcHJvYmxlbSB3YXMgdGhhdCB3aXRoIGNvbW1hbmQgQVQrQ0ZVTj0xOytDRlVOPTU8
YnI+CnRoZSBtb2RlbSBkaWRuJiMzOTt0IGluaXRpYWxpc2UgdGhlIHNpbSBzdGF0ZSBwcm9wZXJs
eS48YnI+Cjxicj4KVG8gZml4IHRoaXMgSSBjaGFuZ2VkIHRoZSBsb2dpYyBzbyB0aGF0IENGVU49
NSBpcyBjYWxsZWQgb25seSBhZnRlciB0aGUgc2ltPGJyPgpzdGF0ZSBoYXMgc3dpdGNoZWQgdG8g
YSB2YWxpZCBzdGF0ZS4gTm93IG15IEh1YXdlaSBFMTU1MiB3b3JrcyB3aXRoIGNvbm5tYW48YnI+
CmFnYWluLjxicj4KPGJyPgpQSU4gbG9ja2VkIFNJTXMgc3RpbGwgd29uJiMzOTt0IHdvcmsuIFRo
ZSBwcm9ibGVtIGlzIHRoYXQgaXQgdGFrZXMgc29tZSB0aW1lIGZvcjxicj4KdGhlIHNpbSBzdGF0
ZSB0byBnbyB0byBhIHZhbGlkIHN0YXRlOjxicj4KPGJyPgpTZXAgMjAgMTU6MDE6NTcgZGVsbC1t
NTIwIG9mb25vZFsxMjQ1MV06IFBjdWk6Jmx0OyBcclxuK0NQSU46IFJFQURZXHJcblxyXG5PS1xy
XG48YnI+ClsuLi5dPGJyPgpTZXAgMjAgMTU6MDI6MDAgZGVsbC1tNTIwIG9mb25vZFsxMjQ1MV06
IGh1YXdlaTogaW52YWxpZCBzaW0gc3RhdGUgaW4gcG9zdCBvbmxpbmUgKDApPGJyPgpbLi4uXTxi
cj4KU2VwIDIwIDE1OjAyOjAxIGRlbGwtbTUyMCBvZm9ub2RbMTI0NTFdOiBQY3VpOiZsdDsgXHJc
bl5TSU1TVDoxXHJcbjxicj4KPGJyPgpJIGRvbiYjMzk7dCBrbm93IHdoeSBpdCB0YWtlcyBzbyBs
b25nIHRvIGdldCBhIHZhbGlkIHN0YXRlLjxicj4KPGJyPgpUaGVyZSBpcyBhbHNvIGFub3RoZXIg
aXNzdWUsIGluICZxdW90O2NvbGQgc3RhcnQmcXVvdDsgY2FzZSB0aGUgcGhvbmVib29rPGJyPgpp
bml0aWFsaXNhdGlvbiBmYWlsczo8YnI+Cjxicj4KU2VwIDIwIDE0OjM0OjI0IGRlbGwtbTUyMCBv
Zm9ub2RbMTE5MzldOiBQY3VpOiZndDsgQVQrQ1BCUz0/XHI8YnI+ClNlcCAyMCAxNDozNDoyNCBk
ZWxsLW01MjAgb2Zvbm9kWzExOTM5XTogUGN1aTombHQ7IFxyXG4rQ01FIEVSUk9SOiBTSU0gYnVz
eVxyXG48YnI+Cjxicj4KQnV0IGluICZxdW90O3dhcm0gc3RhcnQmcXVvdDsgaXQgc2VlbXMgdG8g
d29yazo8YnI+Cjxicj4KU2VwIDIwIDE0OjM4OjU5IGRlbGwtbTUyMCBvZm9ub2RbMTIwOTFdOiBQ
Y3VpOiZndDsgQVQrQ1BCUz0/XHI8YnI+ClNlcCAyMCAxNDozODo1OSBkZWxsLW01MjAgb2Zvbm9k
WzEyMDkxXTogUGN1aTombHQ7IFxyXG4rQ1BCUzogKCZxdW90O1NNJnF1b3Q7LCZxdW90O0VOJnF1
b3Q7LCZxdW90O09OJnF1b3Q7KVxyXG5cclxuT0tcclxuPGJyPgo8YnI+CkkgY29uc2lkZXIgdGhp
cyBhcyBhIG1pbm9yIGlzc3VlIGFuZCBkaWRuJiMzOTt0IGludmVzdGlnYXRlIGl0IGF0IGFsbC48
YnI+Ci0tLTxicj4KoHBsdWdpbnMvaHVhd2VpLmMgfCCgIDc3ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLTxicj4KoDEgZmlsZXMgY2hhbmdlZCwg
NTMgaW5zZXJ0aW9ucygrKSwgMjQgZGVsZXRpb25zKC0pPGJyPgo8YnI+CmRpZmYgLS1naXQgYS9w
bHVnaW5zL2h1YXdlaS5jIGIvcGx1Z2lucy9odWF3ZWkuYzxicj4KaW5kZXggMmY2MDVlZS4uMjc0
NzNhOCAxMDA2NDQ8YnI+Ci0tLSBhL3BsdWdpbnMvaHVhd2VpLmM8YnI+CisrKyBiL3BsdWdpbnMv
aHVhd2VpLmM8YnI+CkBAIC0xNjMsNiArMTYzLDIyIEBAIHN0YXRpYyB2b2lkIHVzc2Rtb2RlX3N1
cHBvcnRfY2IoZ2Jvb2xlYW4gb2ssIEdBdFJlc3VsdCAqcmVzdWx0LDxicj4KIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoHVzc2Rtb2RlX3F1ZXJ5X2NiLCBkYXRhLCBOVUxM
KTs8YnI+CqB9PGJyPgo8YnI+CitzdGF0aWMgdm9pZCBjZnVuX29mZmxpbmUoZ2Jvb2xlYW4gb2ss
IEdBdFJlc3VsdCAqcmVzdWx0LCBncG9pbnRlciB1c2VyX2RhdGEpPGJyPgorezxicj4KKyCgIKAg
oCBzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtID0gdXNlcl9kYXRhOzxicj4KKyCgIKAgoCBzdHJ1
Y3QgaHVhd2VpX2RhdGEgKmRhdGEgPSBvZm9ub19tb2RlbV9nZXRfZGF0YShtb2RlbSk7PGJyPgor
PGJyPgorIKAgoCCgIGlmICghb2spIHs8YnI+CisgoCCgIKAgoCCgIKAgoCBvZm9ub19tb2RlbV9z
ZXRfcG93ZXJlZChtb2RlbSwgRkFMU0UpOzxicj4KKyCgIKAgoCCgIKAgoCCgIHJldHVybjs8YnI+
CisgoCCgIKAgfTxicj4KKzxicj4KKyCgIKAgoCBpZiAoZGF0YS0mZ3Q7c2ltID09IE5VTEwpPGJy
PgorIKAgoCCgIKAgoCCgIKAgcmV0dXJuOzxicj4KKzxicj4KKyCgIKAgoCBvZm9ub19zaW1faW5z
ZXJ0ZWRfbm90aWZ5KGRhdGEtJmd0O3NpbSwgVFJVRSk7PGJyPgorfTxicj4KKzxicj4KoHN0YXRp
YyBnYm9vbGVhbiBub3RpZnlfc2ltX3N0YXRlKHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0sPGJy
PgogoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoGVudW0gaHVhd2VpX3NpbV9zdGF0ZSBz
aW1fc3RhdGUpPGJyPgqgezxicj4KQEAgLTE3MCwxNyArMTg2LDMzIEBAIHN0YXRpYyBnYm9vbGVh
biBub3RpZnlfc2ltX3N0YXRlKHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0sPGJyPgo8YnI+CiCg
IKAgoCCgREJHKCZxdW90OyVkJnF1b3Q7LCBzaW1fc3RhdGUpOzxicj4KPGJyPgotIKAgoCCgIGlm
IChzaW1fc3RhdGUgPT0gSFVBV0VJX1NJTV9TVEFURV9OT1RfRVhJU1RFTlQpIHs8YnI+Ci0goCCg
IKAgoCCgIKAgoCBvZm9ub19zaW1faW5zZXJ0ZWRfbm90aWZ5KGRhdGEtJmd0O3NpbSwgRkFMU0Up
Ozxicj4KKyCgIKAgoCBkYXRhLSZndDtzaW1fc3RhdGUgPSBzaW1fc3RhdGU7PGJyPgo8YnI+Cisg
oCCgIKAgc3dpdGNoIChzaW1fc3RhdGUpIHs8YnI+CisgoCCgIKAgY2FzZSBIVUFXRUlfU0lNX1NU
QVRFX05PVF9FWElTVEVOVDo8YnI+CiCgIKAgoCCgIKAgoCCgIKAvKiBTSU0gaXMgbm90IHJlYWR5
LCB0cnkgYWdhaW4gYSBiaXQgbGF0ZXIgKi88YnI+CiCgIKAgoCCgIKAgoCCgIKByZXR1cm4gVFJV
RTs8YnI+CisgoCCgIKAgY2FzZSBIVUFXRUlfU0lNX1NUQVRFX0lOVkFMSURfT1JfTE9DS0VEOjxi
cj4KKyCgIKAgoCCgIKAgoCCgIG9mb25vX21vZGVtX3NldF9wb3dlcmVkKG1vZGVtLCBUUlVFKTs8
YnI+Cis8YnI+CisgoCCgIKAgoCCgIKAgoCByZXR1cm4gRkFMU0U7PGJyPgorIKAgoCCgIGNhc2Ug
SFVBV0VJX1NJTV9TVEFURV9WQUxJRDo8YnI+CisgoCCgIKAgY2FzZSBIVUFXRUlfU0lNX1NUQVRF
X0lOVkFMSURfQ1M6PGJyPgorIKAgoCCgIGNhc2UgSFVBV0VJX1NJTV9TVEFURV9JTlZBTElEX1BT
Ojxicj4KKyCgIKAgoCBjYXNlIEhVQVdFSV9TSU1fU1RBVEVfSU5WQUxJRF9QU19BTkRfQ1M6PGJy
PgorIKAgoCCgIKAgoCCgIKAgLyo8YnI+CisgoCCgIKAgoCCgIKAgoCCgKiBJbiB0aGUgJnF1b3Q7
d2FybSBzdGFydCZxdW90OyBjYXNlIHRoZSBtb2RlbSBza2lwczxicj4KKyCgIKAgoCCgIKAgoCCg
IKAqIEhVQVdFSV9TSU1fU1RBVEVfSU5WQUxJRF9PUl9MT0NLRUQgYWx0b2dldGhlciwgc28gbmVl
ZDxicj4KKyCgIKAgoCCgIKAgoCCgIKAqIHRvIHNldCBwb3dlciBhbHNvIGhlcmU8YnI+CisgoCCg
IKAgoCCgIKAgoCCgKi88YnI+CisgoCCgIKAgoCCgIKAgoCBvZm9ub19tb2RlbV9zZXRfcG93ZXJl
ZChtb2RlbSwgVFJVRSk7PGJyPgorPGJyPgorIKAgoCCgIKAgoCCgIKAgZ19hdF9jaGF0X3NlbmQo
ZGF0YS0mZ3Q7cGN1aSwgJnF1b3Q7QVQrQ0ZVTj01JnF1b3Q7LCBub25lX3ByZWZpeCw8YnI+Cisg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgY2Z1bl9vZmZsaW5lLCBtb2RlbSwgTlVMTCk7
PGJyPgorPGJyPgorIKAgoCCgIKAgoCCgIKAgcmV0dXJuIEZBTFNFOzxicj4KIKAgoCCgIKB9PGJy
Pgo8YnI+Ci0goCCgIKAgb2Zvbm9fc2ltX2luc2VydGVkX25vdGlmeShkYXRhLSZndDtzaW0sIFRS
VUUpOzxicj4KLTxicj4KLSCgIKAgoCBkYXRhLSZndDtzaW1fc3RhdGUgPSBzaW1fc3RhdGU7PGJy
PgotPGJyPgogoCCgIKAgoHJldHVybiBGQUxTRTs8YnI+CqB9PGJyPgo8YnI+CkBAIC0zNDcsMjQg
KzM3OSwyNCBAQCBzdGF0aWMgdm9pZCBjdm9pY2VfcXVlcnlfY2IoZ2Jvb2xlYW4gb2ssIEdBdFJl
c3VsdCAqcmVzdWx0LDxicj4KIKAgoCCgIKBnaW50IG1vZGUsIHJhdGUsIGJpdHMsIHBlcmlvZDs8
YnI+Cjxicj4KIKAgoCCgIKBpZiAoIW9rKTxicj4KLSCgIKAgoCCgIKAgoCCgIGdvdG8gZG9uZTs8
YnI+CisgoCCgIKAgoCCgIKAgoCByZXR1cm47PGJyPgo8YnI+CiCgIKAgoCCgZ19hdF9yZXN1bHRf
aXRlcl9pbml0KCZhbXA7aXRlciwgcmVzdWx0KTs8YnI+Cjxicj4KIKAgoCCgIKBpZiAoIWdfYXRf
cmVzdWx0X2l0ZXJfbmV4dCgmYW1wO2l0ZXIsICZxdW90O15DVk9JQ0U6JnF1b3Q7KSk8YnI+Ci0g
oCCgIKAgoCCgIKAgoCBnb3RvIGRvbmU7PGJyPgorIKAgoCCgIKAgoCCgIKAgcmV0dXJuOzxicj4K
PGJyPgogoCCgIKAgoGlmICghZ19hdF9yZXN1bHRfaXRlcl9uZXh0X251bWJlcigmYW1wO2l0ZXIs
ICZhbXA7bW9kZSkpPGJyPgotIKAgoCCgIKAgoCCgIKAgZ290byBkb25lOzxicj4KKyCgIKAgoCCg
IKAgoCCgIHJldHVybjs8YnI+Cjxicj4KIKAgoCCgIKBpZiAoIWdfYXRfcmVzdWx0X2l0ZXJfbmV4
dF9udW1iZXIoJmFtcDtpdGVyLCAmYW1wO3JhdGUpKTxicj4KLSCgIKAgoCCgIKAgoCCgIGdvdG8g
ZG9uZTs8YnI+CisgoCCgIKAgoCCgIKAgoCByZXR1cm47PGJyPgo8YnI+CiCgIKAgoCCgaWYgKCFn
X2F0X3Jlc3VsdF9pdGVyX25leHRfbnVtYmVyKCZhbXA7aXRlciwgJmFtcDtiaXRzKSk8YnI+Ci0g
oCCgIKAgoCCgIKAgoCBnb3RvIGRvbmU7PGJyPgorIKAgoCCgIKAgoCCgIKAgcmV0dXJuOzxicj4K
PGJyPgogoCCgIKAgoGlmICghZ19hdF9yZXN1bHRfaXRlcl9uZXh0X251bWJlcigmYW1wO2l0ZXIs
ICZhbXA7cGVyaW9kKSk8YnI+Ci0goCCgIKAgoCCgIKAgoCBnb3RvIGRvbmU7PGJyPgorIKAgoCCg
IKAgoCCgIKAgcmV0dXJuOzxicj4KPGJyPgogoCCgIKAgoGRhdGEtJmd0O3ZvaWNlID0gVFJVRTs8
YnI+Cjxicj4KQEAgLTM4Myw5ICs0MTUsNiBAQCBzdGF0aWMgdm9pZCBjdm9pY2VfcXVlcnlfY2Io
Z2Jvb2xlYW4gb2ssIEdBdFJlc3VsdCAqcmVzdWx0LDxicj4KIKAgoCCgIKAvKiBjaGVjayBhdmFp
bGFibGUgdm9pY2UgcG9ydHMgKi88YnI+CiCgIKAgoCCgZ19hdF9jaGF0X3NlbmQoZGF0YS0mZ3Q7
cGN1aSwgJnF1b3Q7QVReRERTRVRFWD0/JnF1b3Q7LCBub25lX3ByZWZpeCw8YnI+CiCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoE5VTEwsIE5VTEwsIE5VTEwp
Ozxicj4KLTxicj4KLWRvbmU6PGJyPgotIKAgoCCgIG9mb25vX21vZGVtX3NldF9wb3dlcmVkKG1v
ZGVtLCBUUlVFKTs8YnI+CqB9PGJyPgo8YnI+CqBzdGF0aWMgdm9pZCBjdm9pY2Vfc3VwcG9ydF9j
YihnYm9vbGVhbiBvaywgR0F0UmVzdWx0ICpyZXN1bHQsPGJyPgpAQCAtMzk2LDIxICs0MjUsMTYg
QEAgc3RhdGljIHZvaWQgY3ZvaWNlX3N1cHBvcnRfY2IoZ2Jvb2xlYW4gb2ssIEdBdFJlc3VsdCAq
cmVzdWx0LDxicj4KIKAgoCCgIKBHQXRSZXN1bHRJdGVyIGl0ZXI7PGJyPgo8YnI+CiCgIKAgoCCg
aWYgKCFvayk8YnI+Ci0goCCgIKAgoCCgIKAgoCBnb3RvIGRvbmU7PGJyPgorIKAgoCCgIKAgoCCg
IKAgcmV0dXJuOzxicj4KPGJyPgogoCCgIKAgoGdfYXRfcmVzdWx0X2l0ZXJfaW5pdCgmYW1wO2l0
ZXIsIHJlc3VsdCk7PGJyPgo8YnI+CiCgIKAgoCCgaWYgKCFnX2F0X3Jlc3VsdF9pdGVyX25leHQo
JmFtcDtpdGVyLCAmcXVvdDteQ1ZPSUNFOiZxdW90OykpPGJyPgotIKAgoCCgIKAgoCCgIKAgZ290
byBkb25lOzxicj4KKyCgIKAgoCCgIKAgoCCgIHJldHVybjs8YnI+Cjxicj4KIKAgoCCgIKAvKiBx
dWVyeSBjdXJyZW50IHZvaWNlIHNldHRpbmcgKi88YnI+CiCgIKAgoCCgZ19hdF9jaGF0X3NlbmQo
ZGF0YS0mZ3Q7cGN1aSwgJnF1b3Q7QVReQ1ZPSUNFPyZxdW90OywgY3ZvaWNlX3ByZWZpeCw8YnI+
CiCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKBjdm9pY2VfcXVlcnlfY2Is
IG1vZGVtLCBOVUxMKTs8YnI+Ci08YnI+Ci0goCCgIKAgcmV0dXJuOzxicj4KLTxicj4KLWRvbmU6
PGJyPgotIKAgoCCgIG9mb25vX21vZGVtX3NldF9wb3dlcmVkKG1vZGVtLCBUUlVFKTs8YnI+CqB9
PGJyPgo8YnI+CqBzdGF0aWMgdm9pZCBjZnVuX2VuYWJsZShnYm9vbGVhbiBvaywgR0F0UmVzdWx0
ICpyZXN1bHQsIGdwb2ludGVyIHVzZXJfZGF0YSk8YnI+CkBAIC01NTAsNyArNTc0LDcgQEAgc3Rh
dGljIGludCBodWF3ZWlfZW5hYmxlKHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0pPGJyPgo8YnI+
CiCgIKAgoCCgZ19hdF9jaGF0X3NlbmQoZGF0YS0mZ3Q7cGN1aSwgJnF1b3Q7QVRFMCZxdW90Oywg
bm9uZV9wcmVmaXgsIE5VTEwsIE5VTEwsIE5VTEwpOzxicj4KPGJyPgotIKAgoCCgIGdfYXRfY2hh
dF9zZW5kKGRhdGEtJmd0O3BjdWksICZxdW90O0FUK0NGVU49MTsrQ0ZVTj01JnF1b3Q7LCBub25l
X3ByZWZpeCw8YnI+CisgoCCgIKAgZ19hdF9jaGF0X3NlbmQoZGF0YS0mZ3Q7cGN1aSwgJnF1b3Q7
QVQrQ0ZVTj0xJnF1b3Q7LCBub25lX3ByZWZpeCw8YnI+CiCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKBjZnVuX2VuYWJsZSwgbW9kZW0sIE5VTEwpOzxicj4KPGJyPgogoCCg
IKAgoHF1ZXJ5X3NpbV9zdGF0ZShtb2RlbSk7PGJyPgpAQCAtNjY3LDggKzY5MSwxMyBAQCBzdGF0
aWMgdm9pZCBodWF3ZWlfcG9zdF9vbmxpbmUoc3RydWN0IG9mb25vX21vZGVtICptb2RlbSk8YnI+
CiCgIKAgoCCgc3RydWN0IG9mb25vX25ldHJlZyAqbmV0cmVnOzxicj4KIKAgoCCgIKBzdHJ1Y3Qg
b2Zvbm9fbWVzc2FnZV93YWl0aW5nICptdzs8YnI+Cjxicj4KLSCgIKAgoCBpZiAoZGF0YS0mZ3Q7
c2ltX3N0YXRlID09IEhVQVdFSV9TSU1fU1RBVEVfSU5WQUxJRF9QU19BTkRfQ1MpPGJyPgorIKAg
oCCgIGlmIChkYXRhLSZndDtzaW1fc3RhdGUgIT0gSFVBV0VJX1NJTV9TVEFURV9WQUxJRCAmYW1w
OyZhbXA7PGJyPgorIKAgoCCgIKAgoCBkYXRhLSZndDtzaW1fc3RhdGUgIT0gSFVBV0VJX1NJTV9T
VEFURV9JTlZBTElEX0NTICZhbXA7JmFtcDs8YnI+CisgoCCgIKAgoCCgIGRhdGEtJmd0O3NpbV9z
dGF0ZSAhPSBIVUFXRUlfU0lNX1NUQVRFX0lOVkFMSURfUFMpIHs8YnI+CisgoCCgIKAgoCCgIKAg
oCBvZm9ub19pbmZvKCZxdW90O2h1YXdlaTogaW52YWxpZCBzaW0gc3RhdGUgaW4gcG9zdCBvbmxp
bmUgKCVkKSZxdW90Oyw8YnI+CisgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgZGF0YS0m
Z3Q7c2ltX3N0YXRlKTs8YnI+CiCgIKAgoCCgIKAgoCCgIKByZXR1cm47PGJyPgorIKAgoCCgIH08
YnI+Cjxicj4KIKAgoCCgIKBuZXRyZWcgPSBvZm9ub19uZXRyZWdfY3JlYXRlKG1vZGVtLCBPRk9O
T19WRU5ET1JfSFVBV0VJLCAmcXVvdDthdG1vZGVtJnF1b3Q7LDxicj4KIKAgoCCgIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoGRhdGEtJmd0
O3BjdWkpOzxicj4KPGJyPgo8YnI+Cjxicj4KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
PGJyPgo8YnI+Ck1lc3NhZ2U6IDI8YnI+CkRhdGU6IE1vbiwgMjAgU2VwIDIwMTAgMDc6NDQ6NDUg
LTA1MDA8YnI+CkZyb206IERlbmlzIEtlbnppb3IgJmx0OzxhIGhyZWY9Im1haWx0bzpkZW5rZW56
QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmRlbmtlbnpAZ21haWwuY29tPC9hPiZndDs8YnI+
ClRvOiA8YSBocmVmPSJtYWlsdG86b2Zvbm9Ab2Zvbm8ub3JnIiB0YXJnZXQ9Il9ibGFuayI+b2Zv
bm9Ab2Zvbm8ub3JnPC9hPjxicj4KU3ViamVjdDogUmU6IFJlZzogTWVtb3J5IGNhcGFjaXR5IGV4
Y2VlZGVkPGJyPgpNZXNzYWdlLUlEOiAmbHQ7PGEgaHJlZj0ibWFpbHRvOjRDOTc1NzNELjkwNDA2
QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPjRDOTc1NzNELjkwNDA2QGdtYWlsLmNvbTwvYT4m
Z3Q7PGJyPgpDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9SVNPLTg4NTktMTxicj4K
PGJyPgpIaSBKZWV2YWthLDxicj4KPGJyPgpPbiAwOS8yMC8yMDEwIDA3OjM5IEFNLCA8YSBocmVm
PSJtYWlsdG86SmVldmFrYS5CYWRyYXBwYW5AZWxla3Ryb2JpdC5jb20iIHRhcmdldD0iX2JsYW5r
Ij5KZWV2YWthLkJhZHJhcHBhbkBlbGVrdHJvYml0LmNvbTwvYT4gd3JvdGU6PGJyPgomZ3Q7IEhp
LDxicj4KJmd0Ozxicj4KJmd0OyZndDsgT2YgY291cnNlLCBvbmUgY2FuIGFyZ3VlIHdoZXRoZXIg
dGhpcyBmZWF0dXJlIHJlYWxseSBoYXMgc29tZSByZWFsPGJyPgomZ3Q7Jmd0OyB3b3JsZCByZWxl
dmFuY2Ugb3IgaXMgcHVyZWx5IHRoZW9yZXRpY2FsLjxicj4KJmd0OyZndDs8YnI+CiZndDsmZ3Q7
IEkgd29uZGVyIGlmIGl0IGlzIGEgdHlwZSBhcHByb3ZhbCByZXF1aXJlbWVudCB0byBzdXBwb3J0
Pzxicj4KJmd0Ozxicj4KJmd0OyZndDsgSSYjMzk7bSBhZnJhaWQgdGhlcmUgaXMgYSBQSUNTIGNh
c2UgZm9yIHRoaXMgdGhpbmcuIEkgY2Fubm90IHJlY2FsbCBob3cgd2U8YnI+CiZndDsgZ290IE45
MDAgdGhyb3VnaCB0aGlzIHBhcnRpY3VsYXIgaG9vcCwgYnV0IHByb2JhYmx5IHdlIGp1c3Qgd2Fp
dmVkIHRoaXM8YnI+CiZndDsgcGFydGljdWxhciB0ZXN0IGNhc2UgaXJyZWxldmFudC48YnI+CiZn
dDs8YnI+CiZndDsgY29ycmVjdC4gVGhlcmUgaXMgYSBVU0lNIGNvbmZvcm1hbmNlIGNhc2Ugb24g
dGhpcyBtZXNzYWdlIGNhcGFjaXRpeTxicj4KJmd0OyBleGNlZWRlZCBpbmZvcm1hdGlvbi4gQXMg
cGVyIHRoZSAzR1BQIDMxLjEyMSBzcGVjaWZpY2F0aW9uIHNlY3Rpb24gOC4yOjxicj4KJmd0Ozxi
cj4KJmd0OyAmcXVvdDtJZiBhbGwgU01TIGRhdGEgZmllbGQgYXJlIGZ1bGwgYW5kIGZ1cnRoZXJt
b3JlIGFsbCBtZW1vcnkgY2FwYWNpdHk8YnI+CiZndDsgcmVzZXJ2ZWQgZm9yIFNNUyBpbnNpZGUg
dGhlIE1FIGlzIGZpbGxlZCB1cCB0byBtYXhpbXVtIGFuZCBhIFNNKFNob3J0PGJyPgomZ3Q7IE1l
c3NhZ2UpIHdhcyByZWplY3RlZCwgdGhlbiB0aGlzIHNoYWxsIGJlIGluZGljYXRlZCBpbiB0aGUg
U01TIFN0YXR1czxicj4KJmd0OyBmaWxlLihFRnNtc3MpJnF1b3Q7PGJyPgo8YnI+ClRoZSB0aGlu
ZyBpcywgb0Zvbm8gY29uZmlndXJlcyBTTVMgZm9yIGRpcmVjdCBkZWxpdmVyeSAoZS5nLiBubyBT
TS9NRTxicj4Kc3RvcmFnZSkuIKBBbmQgZXZlbiBpZiBkaXJlY3QgZGVsaXZlcnkgZG9lcyBub3Qg
d29yayAoZS5nLiBjcmFwcHkgbW9kZW08YnI+Cm9yIENsYXNzIDIgLyBDbGFzcyAzIG1lc3NhZ2Vz
KSBvRm9ubyBzdGlsbCByZW1vdmVzIHRoZSBTTVMgYXMgc29vbiBhcyBpdDxicj4KaXMgZGVsaXZl
cmVkLiCgV2Ugc2hvdWxkIG5ldmVyIGhpdCBhIHNpbS9tZSBtZW1vcnkgZnVsbCBjb25kaXRpb25z
Ljxicj4KPGJyPgpTbyBJIGRvbiYjMzk7dCBzZWUgaG93IHRoaXMgdGVzdCBjYXNlIGV2ZW4gYXBw
bGllcy48YnI+Cjxicj4KUmVnYXJkcyw8YnI+Ci1EZW5pczxicj4KPGJyPgo8YnI+Ci0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxicj4KPGJyPgpNZXNzYWdlOiAzPGJyPgpEYXRlOiBNb24s
IDIwIFNlcCAyMDEwIDA3OjQ5OjQ4IC0wNTAwPGJyPgpGcm9tOiBEZW5pcyBLZW56aW9yICZsdDs8
YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5kZW5rZW56
QGdtYWlsLmNvbTwvYT4mZ3Q7PGJyPgpUbzogPGEgaHJlZj0ibWFpbHRvOm9mb25vQG9mb25vLm9y
ZyIgdGFyZ2V0PSJfYmxhbmsiPm9mb25vQG9mb25vLm9yZzwvYT48YnI+ClN1YmplY3Q6IFJlOiBv
Zm9ubyBncHJzX3ByaW1hcnlfY29udGV4dCBkZXNjcmlwdGlvbjxicj4KTWVzc2FnZS1JRDogJmx0
OzxhIGhyZWY9Im1haWx0bzo0Qzk3NTg2Qy44MDAwODAxQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxh
bmsiPjRDOTc1ODZDLjgwMDA4MDFAZ21haWwuY29tPC9hPiZndDs8YnI+CkNvbnRlbnQtVHlwZTog
dGV4dC9wbGFpbjsgY2hhcnNldD13aW5kb3dzLTEyNTI8YnI+Cjxicj4KSGkgTGF1cmVudCw8YnI+
Cjxicj4KT24gMDkvMjAvMjAxMCAwNDoyMCBBTSwgTGF1cmVudCBUSE9NQVMgd3JvdGU6PGJyPgom
Z3Q7IEhpLDxicj4KJmd0Ozxicj4KJmd0Ozxicj4KJmd0Ozxicj4KJmd0OyBBY2NvcmRpbmcgdG8g
dGhlIGludGVyZmFjZSBvcmcub2Zvbm8uQ29ubmVjdGlvbkNvbnRleHQgZGVzY3JpcHRpb24sIHRo
ZTxicj4KJmd0OyBwcm9wZXJ0eSA/TmFtZT8gaXMgYSBmcmVlIHNob3J0IHN0cmluZyB1c2VkIHRv
IGRlc2NyaWJlIHRoZSBjb250ZXh0Ljxicj4KJmd0Ozxicj4KJmd0OyBFeHRyYWN0IGZyb20gP2Nv
bm1hbi1hcGkudHh0Pzxicj4KJmd0Ozxicj4KJmd0OyAvUHJvcGVydGllcyCgIKAgoCCgIHN0cmlu
ZyBOYW1lIFtyZWFkd3JpdGVdLzxicj4KJmd0Ozxicj4KJmd0OyAvIC88YnI+CiZndDs8YnI+CiZn
dDsgLyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgVGhlIG5hbWUgaXMgYSBmcmVl
IGZvcm0gc3RyaW5nIHRoYXQ8YnI+CiZndDsgZGVzY3JpYmVzIHRoaXMvPGJyPgomZ3Q7PGJyPgom
Z3Q7IC8goCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIGNvbnRleHQuIKBUaGUgbmFt
ZSBzaG91bGQgbm90IGJlPGJyPgomZ3Q7IGVtcHR5IGFuZCBsaW1pdGVkLzxicj4KJmd0Ozxicj4K
Jmd0OyAvIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCB0byBhIHNob3J0IHN0cmlu
ZyBmb3IgZGlzcGxheSBwdXJwb3Nlcy4vPGJyPgomZ3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7PGJyPgom
Z3Q7IEJ1dCBhY2NvcmRpbmcgdG8gc291cmNlIGNvZGUgKHZlcnNpb24gMC4yOCksIHRoaXMgYXR0
cmlidXRlIGlzIG5vdyBvbmx5PGJyPgomZ3Q7IGFmZmVjdGVkIHdpdGggdGhlIGNvbnRleHQgU3Ry
aW5nIFR5cGUgKD9pbnRlcm5ldD8sID93YXA/IG9yID9tbXM/KTxicj4KJmd0Ozxicj4KJmd0Ozxi
cj4KJmd0Ozxicj4KJmd0OyBpcyBpdCByZWFsbHkgdGhlIGV4cGVjdGVkIGJlaGF2aW91ciBvciBk
aWQgSSBtaXNzIHNvbWV0aGluZyA/PGJyPgo8YnI+CkJ5IGRlZmF1bHQgdGhlIE5hbWUgaXMgc2V0
IHRvIHRoZSBjb250ZXh0IHR5cGUuIKBFLmcuIGNyZWF0aW5nIGFuPGJyPgomcXVvdDtpbnRlcm5l
dCZxdW90OyBjb250ZXh0IHJlc3VsdHMgaW4gdGhlIG5hbWUgYmVpbmcgc2V0IHRvICZxdW90O2lu
dGVybmV0LiZxdW90OyCgWW91IGNhbjxicj4Kc3RpbGwgcmVzZXQgdGhlIE5hbWUgbGF0ZXIgdG8g
d2hhdGV2ZXIgeW91IHdpc2guPGJyPgo8YnI+Cn4vb2Zvbm8tbWFzdGVyJCB0ZXN0L2xpc3QtY29u
dGV4dHM8YnI+ClsgL3Bob25lc2ltIF08YnI+CiCgIKBbIC9waG9uZXNpbS9jb250ZXh0MSBdPGJy
PgogoCCgIKAgoFVzZXJuYW1lID08YnI+CiCgIKAgoCCgUHJvdG9jb2wgPSBpcDxicj4KIKAgoCCg
IKBOYW1lID0gRm9vYmFyPGJyPgogoCCgIKAgoFNldHRpbmdzID0geyB9PGJyPgogoCCgIKAgoEFj
dGl2ZSA9IDA8YnI+CiCgIKAgoCCgQWNjZXNzUG9pbnROYW1lID08YnI+CiCgIKAgoCCgUGFzc3dv
cmQgPTxicj4KIKAgoCCgIKBUeXBlID0gaW50ZXJuZXQ8YnI+Cjxicj4KPGJyPgpSZWdhcmRzLDxi
cj4KLURlbmlzPGJyPgo8YnI+Cjxicj4KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJy
Pgo8YnI+Ck1lc3NhZ2U6IDQ8YnI+CkRhdGU6IE1vbiwgMjAgU2VwIDIwMTAgMTU6NTM6MTMgKzAz
MDA8YnI+CkZyb206IEFraSBOaWVtaSAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFraS5uaWVtaUBub2tp
YS5jb20iIHRhcmdldD0iX2JsYW5rIj5ha2kubmllbWlAbm9raWEuY29tPC9hPiZndDs8YnI+ClRv
OiAmcXVvdDs8YSBocmVmPSJtYWlsdG86b2Zvbm9Ab2Zvbm8ub3JnIiB0YXJnZXQ9Il9ibGFuayI+
b2Zvbm9Ab2Zvbm8ub3JnPC9hPiZxdW90OyAmbHQ7PGEgaHJlZj0ibWFpbHRvOm9mb25vQG9mb25v
Lm9yZyIgdGFyZ2V0PSJfYmxhbmsiPm9mb25vQG9mb25vLm9yZzwvYT4mZ3Q7PGJyPgpTdWJqZWN0
OiBSZTogUmVnOiBNZW1vcnkgY2FwYWNpdHkgZXhjZWVkZWQ8YnI+Ck1lc3NhZ2UtSUQ6ICZsdDs8
YSBocmVmPSJtYWlsdG86MTI4NDk4NzE5My4xMjM5My40ODUuY2FtZWxAdHVjc29uLnJlc2VhcmNo
Lm5va2lhLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPjEyODQ5ODcxOTMuMTIzOTMuNDg1LmNhbWVsQHR1
Y3Nvbi5yZXNlYXJjaC5ub2tpYS5jb208L2E+Jmd0Ozxicj4KQ29udGVudC1UeXBlOiB0ZXh0L3Bs
YWluOyBjaGFyc2V0PSZxdW90O1VURi04JnF1b3Q7PGJyPgo8YnI+Ck9uIE1vbiwgMjAxMC0wOS0y
MCBhdCAxNDoyOSArMDIwMCwgZXh0IFBla2thIFBlc3NpIHdyb3RlOjxicj4KJmd0OyBJJiMzOTtt
IGFmcmFpZCB0aGVyZSBpcyBhIFBJQ1MgY2FzZSBmb3IgdGhpcyB0aGluZy4gSSBjYW5ub3QgcmVj
YWxsIGhvdyB3ZTxicj4KJmd0OyBnb3QgTjkwMCB0aHJvdWdoIHRoaXMgcGFydGljdWxhciBob29w
LCBidXQgcHJvYmFibHkgd2UganVzdCB3YWl2ZWQ8YnI+CiZndDsgdGhpcyBwYXJ0aWN1bGFyIHRl
c3QgY2FzZSBpcnJlbGV2YW50Ljxicj4KPGJyPgpJIGtub3cgd2UgaGF2ZSB0aGUgbWFjaGluZXJ5
IGluIHBsYWNlIGluIE45MDAgdG8gcmVwb3J0IG1lbW9yeSBleGNlZWRlZDxicj4KdG8gdGhlIG5l
dHdvcmsuIEFuZCBJIGV2ZW4gcmVtZW1iZXIgaXQgZ2V0dGluZyB0ZXN0ZWQgYXQgc29tZSBwb2lu
dCw8YnI+CmJhc2ljYWxseSBmbG9vZGluZyAvdmFyL3Nwb29sL3NtcyBpcyBlbm91Z2ggdG8gdHJp
Z2dlciBpdC48YnI+Cjxicj4KSWYgdGhpcyBjYW4gYmUgd2FpdmVkLCB0aG91Z2gsIGdvb2Qgcmlk
ZGFuY2UuPGJyPgo8YnI+CkNoZWVycyw8YnI+CkFraTxicj4KPGJyPgo8YnI+Cjxicj4KLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPgo8YnI+Ck1lc3NhZ2U6IDU8YnI+CkRhdGU6IE1v
biwgMjAgU2VwIDIwMTAgMTc6MDg6NDEgKzAzMDA8YnI+CkZyb206ICZsdDs8YSBocmVmPSJtYWls
dG86SmVldmFrYS5CYWRyYXBwYW5AZWxla3Ryb2JpdC5jb20iIHRhcmdldD0iX2JsYW5rIj5KZWV2
YWthLkJhZHJhcHBhbkBlbGVrdHJvYml0LmNvbTwvYT4mZ3Q7PGJyPgpUbzogJmx0OzxhIGhyZWY9
Im1haWx0bzpkZW5rZW56QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmRlbmtlbnpAZ21haWwu
Y29tPC9hPiZndDssICZsdDs8YSBocmVmPSJtYWlsdG86b2Zvbm9Ab2Zvbm8ub3JnIiB0YXJnZXQ9
Il9ibGFuayI+b2Zvbm9Ab2Zvbm8ub3JnPC9hPiZndDs8YnI+ClN1YmplY3Q6IFJFOiBSZWc6IE1l
bW9yeSBjYXBhY2l0eSBleGNlZWRlZDxicj4KTWVzc2FnZS1JRDo8YnI+CiCgIKAgoCCgJmx0Ozxh
IGhyZWY9Im1haWx0bzpCNjY4ODgzRUI1REQ3MTQ0QURGQzI0OEE3MjE3NkVBODAyQTUxQTAzQGZp
b3VlczA3LmViZ3JvdXAuZWxla3Ryb2JpdC5jb20iIHRhcmdldD0iX2JsYW5rIj5CNjY4ODgzRUI1
REQ3MTQ0QURGQzI0OEE3MjE3NkVBODAyQTUxQTAzQGZpb3VlczA3LmViZ3JvdXAuZWxla3Ryb2Jp
dC5jb208L2E+Jmd0Ozxicj4KPGJyPgpDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IKAgoCCgIGNo
YXJzZXQ9JnF1b3Q7dXMtYXNjaWkmcXVvdDs8YnI+Cjxicj4KPGJyPgpIaSBEZW5pcyw8YnI+Cjxi
cj4KJmd0OyBUaGUgdGhpbmcgaXMsIG9Gb25vIGNvbmZpZ3VyZXMgU01TIGZvciBkaXJlY3QgZGVs
aXZlcnkgKGUuZy4gbm8gU00vTUU8YnI+CnN0b3JhZ2UpLiCgQW5kIGV2ZW4gaWYgZGlyZWN0IGRl
bGl2ZXJ5IGRvZXMgbm90IHdvcmsgKGUuZy4gY3JhcHB5IG1vZGVtPGJyPgpvciBDbGFzcyAyIC8g
Q2xhc3MgMyBtZXNzYWdlcykgb0Zvbm8gc3RpbGwgcmVtb3ZlcyB0aGUgU01TPGJyPgomZ3Q7IGFz
IHNvb24gYXMgaXQgaXMgZGVsaXZlcmVkLiCgV2Ugc2hvdWxkIG5ldmVyIGhpdCBhIHNpbS9tZSBt
ZW1vcnkgZnVsbDxicj4KY29uZGl0aW9ucy48YnI+Cjxicj4KJmd0OyBTbyBJIGRvbiYjMzk7dCBz
ZWUgaG93IHRoaXMgdGVzdCBjYXNlIGV2ZW4gYXBwbGllcy48YnI+Cjxicj4KTGl0dGxlIGJpdCBs
b3N0IG5vdy4gQXJlIHdlIHNwZWFraW5nIGFib3V0IHRoZSBzZW5kaW5nIG9yIHJlY2VpdmluZyBv
Zjxicj4KU01TPzxicj4KPGJyPgpNZW1vcnkgY2FwYWNpdHkgZXhjZWVkZWQgYXBwbGllcyB0byBp
bmNvbWluZyBTTVMuIEluY29taW5nIFNNUyBjYW4gYmU8YnI+CnN0b3JlZCBpbiBTSU0gb3IgaW4g
TUUgc3RvcmFnZS4gSWYgdGhlIFNNUyBzdG9yYWdlIGZvciBpbmNvbWluZyBTTVMgaXM8YnI+CmZ1
bGwsIHRoZW4gdGhlIE1FIGNhbiBpbmZvcm0gdGhlIG5ldHdvcmsgdGhhdCBpdCBjYW4mIzM5O3Qg
aGFuZGxlIGFueSBtb3JlPGJyPgpjbGFzcyAxL2NsYXNzIDIgaW5jb21pbmcgU01TIGR1ZSB0byBt
YXhpbXVtIG1lbW9yeSBjYXBhY2l0eSByZWFjaGVkLjxicj4KT25jZSB0aGUgdXNlciBmcmVlcyBz
b21lIG1lbW9yeSBieSBkZWxldGluZyBzb21lIG1lc3NhZ2VzLCB0aGVuIE1FIGNhbjxicj4KaW5m
b3JtIG5ldHdvcmsgdGhhdCBpdCBpcyByZWFkeSBub3cgdG8gcmVjZWl2ZSBtZXNzYWdlcy4gU28s
IEkgYmVsaWV2ZTxicj4KdGhpcyB0ZXN0IGNhc2UgYXBwbGllcyBidXQgYXMgUGVzc2kgUGVra2Eg
c2FpZCB3ZSBjYW4gd2FpdmUgdGhpcyB0ZXN0PGJyPgpjYXNlLjxicj4KPGJyPgpSZWdhcmRzLDxi
cj4KamVldmFrYTxicj4KPGJyPgo8YnI+Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxi
cj4KPGJyPgpNZXNzYWdlOiA2PGJyPgpEYXRlOiBNb24sIDIwIFNlcCAyMDEwIDA5OjExOjQ1IC0w
NTAwPGJyPgpGcm9tOiBEZW5pcyBLZW56aW9yICZsdDs8YSBocmVmPSJtYWlsdG86ZGVua2VuekBn
bWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7PGJyPgpU
bzogPGEgaHJlZj0ibWFpbHRvOkplZXZha2EuQmFkcmFwcGFuQGVsZWt0cm9iaXQuY29tIiB0YXJn
ZXQ9Il9ibGFuayI+SmVldmFrYS5CYWRyYXBwYW5AZWxla3Ryb2JpdC5jb208L2E+PGJyPgpDYzog
PGEgaHJlZj0ibWFpbHRvOm9mb25vQG9mb25vLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPm9mb25vQG9m
b25vLm9yZzwvYT48YnI+ClN1YmplY3Q6IFJlOiBSZWc6IE1lbW9yeSBjYXBhY2l0eSBleGNlZWRl
ZDxicj4KTWVzc2FnZS1JRDogJmx0OzxhIGhyZWY9Im1haWx0bzo0Qzk3NkJBMS4zMDYwMEBnbWFp
bC5jb20iIHRhcmdldD0iX2JsYW5rIj40Qzk3NkJBMS4zMDYwMEBnbWFpbC5jb208L2E+Jmd0Ozxi
cj4KQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PUlTTy04ODU5LTE8YnI+Cjxicj4K
SGkgSmVldmFrYSw8YnI+Cjxicj4KT24gMDkvMjAvMjAxMCAwOTowOCBBTSwgPGEgaHJlZj0ibWFp
bHRvOkplZXZha2EuQmFkcmFwcGFuQGVsZWt0cm9iaXQuY29tIiB0YXJnZXQ9Il9ibGFuayI+SmVl
dmFrYS5CYWRyYXBwYW5AZWxla3Ryb2JpdC5jb208L2E+IHdyb3RlOjxicj4KJmd0Ozxicj4KJmd0
OyBIaSBEZW5pcyw8YnI+CiZndDs8YnI+CiZndDsmZ3Q7IFRoZSB0aGluZyBpcywgb0Zvbm8gY29u
ZmlndXJlcyBTTVMgZm9yIGRpcmVjdCBkZWxpdmVyeSAoZS5nLiBubyBTTS9NRTxicj4KJmd0OyBz
dG9yYWdlKS4goEFuZCBldmVuIGlmIGRpcmVjdCBkZWxpdmVyeSBkb2VzIG5vdCB3b3JrIChlLmcu
IGNyYXBweSBtb2RlbTxicj4KJmd0OyBvciBDbGFzcyAyIC8gQ2xhc3MgMyBtZXNzYWdlcykgb0Zv
bm8gc3RpbGwgcmVtb3ZlcyB0aGUgU01TPGJyPgomZ3Q7Jmd0OyBhcyBzb29uIGFzIGl0IGlzIGRl
bGl2ZXJlZC4goFdlIHNob3VsZCBuZXZlciBoaXQgYSBzaW0vbWUgbWVtb3J5IGZ1bGw8YnI+CiZn
dDsgY29uZGl0aW9ucy48YnI+CiZndDs8YnI+CiZndDsmZ3Q7IFNvIEkgZG9uJiMzOTt0IHNlZSBo
b3cgdGhpcyB0ZXN0IGNhc2UgZXZlbiBhcHBsaWVzLjxicj4KJmd0Ozxicj4KJmd0OyBMaXR0bGUg
Yml0IGxvc3Qgbm93LiBBcmUgd2Ugc3BlYWtpbmcgYWJvdXQgdGhlIHNlbmRpbmcgb3IgcmVjZWl2
aW5nIG9mPGJyPgomZ3Q7IFNNUz88YnI+CiZndDs8YnI+CiZndDsgTWVtb3J5IGNhcGFjaXR5IGV4
Y2VlZGVkIGFwcGxpZXMgdG8gaW5jb21pbmcgU01TLiBJbmNvbWluZyBTTVMgY2FuIGJlPGJyPgom
Z3Q7IHN0b3JlZCBpbiBTSU0gb3IgaW4gTUUgc3RvcmFnZS4gSWYgdGhlIFNNUyBzdG9yYWdlIGZv
ciBpbmNvbWluZyBTTVMgaXM8YnI+CiZndDsgZnVsbCwgdGhlbiB0aGUgTUUgY2FuIGluZm9ybSB0
aGUgbmV0d29yayB0aGF0IGl0IGNhbiYjMzk7dCBoYW5kbGUgYW55IG1vcmU8YnI+CiZndDsgY2xh
c3MgMS9jbGFzcyAyIGluY29taW5nIFNNUyBkdWUgdG8gbWF4aW11bSBtZW1vcnkgY2FwYWNpdHkg
cmVhY2hlZC48YnI+CiZndDsgT25jZSB0aGUgdXNlciBmcmVlcyBzb21lIG1lbW9yeSBieSBkZWxl
dGluZyBzb21lIG1lc3NhZ2VzLCB0aGVuIE1FIGNhbjxicj4KJmd0OyBpbmZvcm0gbmV0d29yayB0
aGF0IGl0IGlzIHJlYWR5IG5vdyB0byByZWNlaXZlIG1lc3NhZ2VzLiBTbywgSSBiZWxpZXZlPGJy
PgomZ3Q7IHRoaXMgdGVzdCBjYXNlIGFwcGxpZXMgYnV0IGFzIFBlc3NpIFBla2thIHNhaWQgd2Ug
Y2FuIHdhaXZlIHRoaXMgdGVzdDxicj4KJmd0OyBjYXNlLjxicj4KPGJyPgpJIGtub3cgZXhhY3Rs
eSB0aGUgY2FzZSB5b3UmIzM5O3JlIHRhbGtpbmcgYWJvdXQsIGJ1dCBhcyBJIG1lbnRpb25lZCBi
ZWZvcmUsPGJyPgpvRm9ubyBkb2VzIG5vdCBjb25maWd1cmUgdGhlIG1vZGVtIHRvIHN0b3JlIG9u
IFNJTSBvciBNRS4goFRoZSBtZXNzYWdlczxicj4KYXJlIHJvdXRlZCBkaXJlY3RseSB0byBvRm9u
by4goFNlZSBkcml2ZXJzL2F0bW9kZW0vc21zLmMgZm9yIG1vcmU8YnI+CmRldGFpbHMuIKBUaGUg
b25seSBtZXNzYWdlcyB0aGF0ICptaWdodCogZ2V0IHJvdXRlZCB0byBTTS9NRSBhcmUgQ2xhc3Mg
Mjxicj4KLyAzIG1lc3NhZ2VzLiCgVGhlc2UgYXJlIGF1dG9tYXRpY2FsbHkgZGVsZXRlZCBvbiBy
ZWNlcHRpb24gYnkgdGhlIHNtczxicj4KZHJpdmVyLjxicj4KPGJyPgpUaGUgJiMzOTttZW1vcnkg
Y2FwYWNpdHkgcmVhY2hlZCYjMzk7IGNhbiBzaW1wbHkgbmV2ZXIgaGFwcGVuIGFzc3VtaW5nIHNh
bmU8YnI+CmhhcmR3YXJlLjxicj4KPGJyPgpSZWdhcmRzLDxicj4KLURlbmlzPGJyPgo8YnI+Cjxi
cj4KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPgo8YnI+Ck1lc3NhZ2U6IDc8YnI+
CkRhdGU6IFR1ZSwgMjEgU2VwIDIwMTAgMDI6MDk6MzYgKzA5MDA8YnI+CkZyb206IE1hcmNlbCBI
b2x0bWFubiAmbHQ7PGEgaHJlZj0ibWFpbHRvOm1hcmNlbEBob2x0bWFubi5vcmciIHRhcmdldD0i
X2JsYW5rIj5tYXJjZWxAaG9sdG1hbm4ub3JnPC9hPiZndDs8YnI+ClRvOiA8YSBocmVmPSJtYWls
dG86b2Zvbm9Ab2Zvbm8ub3JnIiB0YXJnZXQ9Il9ibGFuayI+b2Zvbm9Ab2Zvbm8ub3JnPC9hPjxi
cj4KU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzJdIGh1YXdlaTogcG9sbCBzaW0gc3RhdGU8YnI+
Ck1lc3NhZ2UtSUQ6ICZsdDsxMjg1MDAyNTc2LjIwODExLjM2LmNhbWVsQGxvY2FsaG9zdC5sb2Nh
bGRvbWFpbiZndDs8YnI+CkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD0mcXVvdDtV
VEYtOCZxdW90Ozxicj4KPGJyPgpIaSBLYWxsZSw8YnI+Cjxicj4KJmd0OyBPbiBteSBIdWF3ZWkg
RTE1NTIgd2hlbiBJIHBsdWcgaW4gdGhlIG1vZGVtIChpZS4gY29sZCBzdGFydCkgd2l0aCBQSU4g
bG9ja2VkPGJyPgomZ3Q7IFNJTSwgdGhlIHNpbSBzdGF0ZSBpcyAyNTUgKEhVQVdFSV9TSU1fU1RB
VEVfTk9UX0VYSVNURU5UKS4gQXMgdGhlIG1vZGVtPGJyPgomZ3Q7IGRvZXNuJiMzOTt0IHNlbmQg
XlNJTVNUIG5vdGlmaWNhdGlvbnMsIHBvbGwgdGhlIHNpbSBzdGF0ZSB1bnRpbCBpdCYjMzk7cyBy
ZWFkeS48YnI+CiZndDs8YnI+CiZndDsgSW4gdGhlb3J5IGl0IG1pZ2h0IGJlIHBvc3NpYmxlIHRv
IGRvIHRoaXMgYmV0dGVyLCBmb3IgZXhhbXBsZSBmb2xsb3c8YnI+CiZndDsgXkJPT1Qgbm90aWZp
Y2F0aW9ucyBvciBzb21ldGhpbmcsIGJ1dCBpdCYjMzk7cyB1bmtub3duIHdoYXQgcGFyYW1ldGVy
IHdlPGJyPgomZ3Q7IHNob3VsZCBjaGVjayBmb3IuPGJyPgomZ3Q7IC0tLTxicj4KJmd0OyCgcGx1
Z2lucy9odWF3ZWkuYyB8IKAgNjYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tPGJyPgomZ3Q7IKAxIGZpbGVzIGNoYW5nZWQsIDUzIGluc2VydGlv
bnMoKyksIDEzIGRlbGV0aW9ucygtKTxicj4KPGJyPgpwYXRjaCBoYXMgYmVlbiBhcHBsaWVkLjxi
cj4KPGJyPgpSZWdhcmRzPGJyPgo8YnI+Ck1hcmNlbDxicj4KPGJyPgo8YnI+Cjxicj4KPGJyPgot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+Cjxicj4KTWVzc2FnZTogODxicj4KRGF0
ZTogVHVlLCAyMSBTZXAgMjAxMCAwMjowOTo1NSArMDkwMDxicj4KRnJvbTogTWFyY2VsIEhvbHRt
YW5uICZsdDs8YSBocmVmPSJtYWlsdG86bWFyY2VsQGhvbHRtYW5uLm9yZyIgdGFyZ2V0PSJfYmxh
bmsiPm1hcmNlbEBob2x0bWFubi5vcmc8L2E+Jmd0Ozxicj4KVG86IDxhIGhyZWY9Im1haWx0bzpv
Zm9ub0BvZm9uby5vcmciIHRhcmdldD0iX2JsYW5rIj5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgpT
dWJqZWN0OiBSZTogW1BBVENIIHYyIDIvMl0gaHVhd2VpOiBmaXggb25saW5lIGxvZ2ljPGJyPgpN
ZXNzYWdlLUlEOiAmbHQ7MTI4NTAwMjU5NS4yMDgxMS4zNy5jYW1lbEBsb2NhbGhvc3QubG9jYWxk
b21haW4mZ3Q7PGJyPgpDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9JnF1b3Q7VVRG
LTgmcXVvdDs8YnI+Cjxicj4KSGkgS2FsbGUsPGJyPgo8YnI+CiZndDsgVGhlIHJlY2VudGx5IGlu
dHJvZHVjZWQgb25saW5lIHN1cHBvcnQgdG8gaHVhd2VpIGRpZG4mIzM5O3Qgd29yayB3aXRoIG15
PGJyPgomZ3Q7IEh1YXdlaSBFMTU1Mi4gVGhlIHByb2JsZW0gd2FzIHRoYXQgd2l0aCBjb21tYW5k
IEFUK0NGVU49MTsrQ0ZVTj01PGJyPgomZ3Q7IHRoZSBtb2RlbSBkaWRuJiMzOTt0IGluaXRpYWxp
c2UgdGhlIHNpbSBzdGF0ZSBwcm9wZXJseS48YnI+CiZndDs8YnI+CiZndDsgVG8gZml4IHRoaXMg
SSBjaGFuZ2VkIHRoZSBsb2dpYyBzbyB0aGF0IENGVU49NSBpcyBjYWxsZWQgb25seSBhZnRlciB0
aGUgc2ltPGJyPgomZ3Q7IHN0YXRlIGhhcyBzd2l0Y2hlZCB0byBhIHZhbGlkIHN0YXRlLiBOb3cg
bXkgSHVhd2VpIEUxNTUyIHdvcmtzIHdpdGggY29ubm1hbjxicj4KJmd0OyBhZ2Fpbi48YnI+CiZn
dDs8YnI+CiZndDsgUElOIGxvY2tlZCBTSU1zIHN0aWxsIHdvbiYjMzk7dCB3b3JrLiBUaGUgcHJv
YmxlbSBpcyB0aGF0IGl0IHRha2VzIHNvbWUgdGltZSBmb3I8YnI+CiZndDsgdGhlIHNpbSBzdGF0
ZSB0byBnbyB0byBhIHZhbGlkIHN0YXRlOjxicj4KJmd0Ozxicj4KJmd0OyBTZXAgMjAgMTU6MDE6
NTcgZGVsbC1tNTIwIG9mb25vZFsxMjQ1MV06IFBjdWk6Jmx0OyBcclxuK0NQSU46IFJFQURZXHJc
blxyXG5PS1xyXG48YnI+CiZndDsgWy4uLl08YnI+CiZndDsgU2VwIDIwIDE1OjAyOjAwIGRlbGwt
bTUyMCBvZm9ub2RbMTI0NTFdOiBodWF3ZWk6IGludmFsaWQgc2ltIHN0YXRlIGluIHBvc3Qgb25s
aW5lICgwKTxicj4KJmd0OyBbLi4uXTxicj4KJmd0OyBTZXAgMjAgMTU6MDI6MDEgZGVsbC1tNTIw
IG9mb25vZFsxMjQ1MV06IFBjdWk6Jmx0OyBcclxuXlNJTVNUOjFcclxuPGJyPgomZ3Q7PGJyPgom
Z3Q7IEkgZG9uJiMzOTt0IGtub3cgd2h5IGl0IHRha2VzIHNvIGxvbmcgdG8gZ2V0IGEgdmFsaWQg
c3RhdGUuPGJyPgomZ3Q7PGJyPgomZ3Q7IFRoZXJlIGlzIGFsc28gYW5vdGhlciBpc3N1ZSwgaW4g
JnF1b3Q7Y29sZCBzdGFydCZxdW90OyBjYXNlIHRoZSBwaG9uZWJvb2s8YnI+CiZndDsgaW5pdGlh
bGlzYXRpb24gZmFpbHM6PGJyPgomZ3Q7PGJyPgomZ3Q7IFNlcCAyMCAxNDozNDoyNCBkZWxsLW01
MjAgb2Zvbm9kWzExOTM5XTogUGN1aTomZ3Q7IEFUK0NQQlM9P1xyPGJyPgomZ3Q7IFNlcCAyMCAx
NDozNDoyNCBkZWxsLW01MjAgb2Zvbm9kWzExOTM5XTogUGN1aTombHQ7IFxyXG4rQ01FIEVSUk9S
OiBTSU0gYnVzeVxyXG48YnI+CiZndDs8YnI+CiZndDsgQnV0IGluICZxdW90O3dhcm0gc3RhcnQm
cXVvdDsgaXQgc2VlbXMgdG8gd29yazo8YnI+CiZndDs8YnI+CiZndDsgU2VwIDIwIDE0OjM4OjU5
IGRlbGwtbTUyMCBvZm9ub2RbMTIwOTFdOiBQY3VpOiZndDsgQVQrQ1BCUz0/XHI8YnI+CiZndDsg
U2VwIDIwIDE0OjM4OjU5IGRlbGwtbTUyMCBvZm9ub2RbMTIwOTFdOiBQY3VpOiZsdDsgXHJcbitD
UEJTOiAoJnF1b3Q7U00mcXVvdDssJnF1b3Q7RU4mcXVvdDssJnF1b3Q7T04mcXVvdDspXHJcblxy
XG5PS1xyXG48YnI+CiZndDs8YnI+CiZndDsgSSBjb25zaWRlciB0aGlzIGFzIGEgbWlub3IgaXNz
dWUgYW5kIGRpZG4mIzM5O3QgaW52ZXN0aWdhdGUgaXQgYXQgYWxsLjxicj4KJmd0OyAtLS08YnI+
CiZndDsgoHBsdWdpbnMvaHVhd2VpLmMgfCCgIDc3ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLTxicj4KJmd0OyCgMSBmaWxlcyBjaGFuZ2VkLCA1
MyBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSk8YnI+Cjxicj4KcGF0Y2ggaGFzIGJlZW4g
YXBwbGllZC48YnI+Cjxicj4KUmVnYXJkczxicj4KPGJyPgpNYXJjZWw8YnI+Cjxicj4KPGJyPgo8
YnI+Cjxicj4KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPgo8YnI+Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fPGJyPgpvZm9ubyBtYWlsaW5n
IGxpc3Q8YnI+CjxhIGhyZWY9Im1haWx0bzpvZm9ub0BvZm9uby5vcmciIHRhcmdldD0iX2JsYW5r
Ij5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgo8YSBocmVmPSJodHRwOi8vbGlzdHMub2Zvbm8ub3Jn
L2xpc3RpbmZvL29mb25vIiB0YXJnZXQ9Il9ibGFuayI+aHR0cDovL2xpc3RzLm9mb25vLm9yZy9s
aXN0aW5mby9vZm9ubzwvYT48YnI+Cjxicj4KPGJyPgpFbmQgb2Ygb2Zvbm8gRGlnZXN0LCBWb2wg
MTcsIElzc3VlIDcxPGJyPgoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqPGJy
Pgo8L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPgo=

--===============6626332304619488318==--

