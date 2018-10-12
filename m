Content-Type: multipart/mixed; boundary="===============3308457643297060411=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [RFC PATCH v3 1/1] atmodem/lte: proto and authentication handling
Date: Fri, 12 Oct 2018 20:51:24 +0200
Message-ID: <CAKSBH7FswwLgX+Wq+76XsW71ZfAHd185miYCtgu7+KCfANpyPA@mail.gmail.com>
In-Reply-To: <902f0aa5-bb81-d198-8f4a-6615b3aaa8e5@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3308457643297060411==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, Oct 12, 2018 at 8:46 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> On 10/12/2018 01:15 PM, Giacinto Cifelli wrote:
> > I have already added it.
> >
> > I have just greped through the code, here are some examples, from the
> > end of the output:
> >
> > plugins/phonesim.c:18187: if (g_at_chat_send(data->chat, buf, none_pref=
ix,
> > plugins/phonesim.c-18237- set_online_cb, cbd, g_free) > 0)
> > plugins/phonesim.c-18274- return;
> > plugins/phonesim.c-18284-
> > plugins/phonesim.c-18285- CALLBACK_WITH_FAILURE(cb, user_data);
> >
>
> Okay, that's a bug.  Fixed.
>
> > gatchat/gatmux.c:19544: if (g_at_chat_send(chat, "AT+CMUX=3D?", cmux_pr=
efix,
> > gatchat/gatmux.c-19596- mux_query_cb, msd, msd_free) > 0)
> > gatchat/gatmux.c-19634- return TRUE;
> > gatchat/gatmux.c-19649-
> > gatchat/gatmux.c-19650- if (msd)
> > gatchat/gatmux.c-19660- msd_free(msd);
> > // this is actually a mistake because the msd pointer won't change, fre=
ed or not
> >
>
> I don't see anything wrong here?  Besides the redundant if which will
> always be true.

right. my mistake. Here there is no risk to call msd_free twice.

>
> > drivers/xmm7modem/netmon.c:5135: if (g_at_chat_send(nmd->chat,
> > "AT+XMCI=3D1", xmci_prefix,
> > drivers/xmm7modem/netmon.c-5192- xmci_cb, cbd, g_free) > 0)
> > drivers/xmm7modem/netmon.c-5223- return;
> > drivers/xmm7modem/netmon.c-5233-
> > drivers/xmm7modem/netmon.c-5234- CALLBACK_WITH_FAILURE(cb, data);
>
> And fixed this as well.
>

thanks.
Please note that I didn't go through the entire list of results of
grep, you asked for "examples".

> Regards,
> -Denis

Regards,
Giacinto

--===============3308457643297060411==--

