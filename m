Content-Type: multipart/mixed; boundary="===============2918249033378619490=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [RFC PATCH v3 1/1] atmodem/lte: proto and authentication handling
Date: Fri, 12 Oct 2018 20:15:22 +0200
Message-ID: <CAKSBH7F8pzNHb9njcJ+tkaSbmEqqzKpBq7s1o4NDQv87ZxCq_Q@mail.gmail.com>
In-Reply-To: <e8c01c63-cac6-4b3b-865f-6e90c65d2682@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2918249033378619490==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I have already added it.

I have just greped through the code, here are some examples, from the
end of the output:

plugins/phonesim.c:18187: if (g_at_chat_send(data->chat, buf, none_prefix,
plugins/phonesim.c-18237- set_online_cb, cbd, g_free) > 0)
plugins/phonesim.c-18274- return;
plugins/phonesim.c-18284-
plugins/phonesim.c-18285- CALLBACK_WITH_FAILURE(cb, user_data);

gatchat/gatmux.c:19544: if (g_at_chat_send(chat, "AT+CMUX=3D?", cmux_prefix,
gatchat/gatmux.c-19596- mux_query_cb, msd, msd_free) > 0)
gatchat/gatmux.c-19634- return TRUE;
gatchat/gatmux.c-19649-
gatchat/gatmux.c-19650- if (msd)
gatchat/gatmux.c-19660- msd_free(msd);
// this is actually a mistake because the msd pointer won't change, freed o=
r not

drivers/xmm7modem/netmon.c:5135: if (g_at_chat_send(nmd->chat,
"AT+XMCI=3D1", xmci_prefix,
drivers/xmm7modem/netmon.c-5192- xmci_cb, cbd, g_free) > 0)
drivers/xmm7modem/netmon.c-5223- return;
drivers/xmm7modem/netmon.c-5233-
drivers/xmm7modem/netmon.c-5234- CALLBACK_WITH_FAILURE(cb, data);


On Fri, Oct 12, 2018 at 7:59 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> On 10/12/2018 11:54 AM, Giacinto Cifelli wrote:
> > Hi,
> >
> > I trust you, but I have checked the code :)
> >
> > you are right, the at_command_create may fail (on allocation error
> > from g_try_new0) and in this case it doesn't call the g_free.
> >
> > However I have to say that the code leaks alot: overall the construct
> > is used 237 times, and only 98 times the g_free is called.
>
> Umm, can you give me some examples?  Do note that we have 2 patterns
> that we use:
>
> Pattern 1 is the most common:
>
> if (g_at_chat_send(...) > 0)
>         return;
>
> g_free/destroy(...);
> CALLBACK_WITH_FAILURE();
>
> Pattern 2 is what you want:
>
> if (g_at_chat_send(...) =3D=3D 0) {
>         g_free/destroy(...);
>         CALLBACK_WITH_FAILURE();
>         return;
> }
>
> > That said, according to Denis nowadays we don't use g_try_new0 because
> > the allocation won't fail, so we are unlikely to see it in action.
> That is not really an excuse, and we can change the implementation of
> send() at any time.  So you still need to be paranoid.
>
> Regards,
> -Denis

--===============2918249033378619490==--

