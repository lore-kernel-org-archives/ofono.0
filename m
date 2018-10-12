Content-Type: multipart/mixed; boundary="===============8308977516245512075=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH v3 1/1] atmodem/lte: proto and authentication handling
Date: Fri, 12 Oct 2018 13:46:36 -0500
Message-ID: <902f0aa5-bb81-d198-8f4a-6615b3aaa8e5@gmail.com>
In-Reply-To: <CAKSBH7F8pzNHb9njcJ+tkaSbmEqqzKpBq7s1o4NDQv87ZxCq_Q@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8308977516245512075==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 10/12/2018 01:15 PM, Giacinto Cifelli wrote:
> I have already added it.
> =

> I have just greped through the code, here are some examples, from the
> end of the output:
> =

> plugins/phonesim.c:18187: if (g_at_chat_send(data->chat, buf, none_prefix,
> plugins/phonesim.c-18237- set_online_cb, cbd, g_free) > 0)
> plugins/phonesim.c-18274- return;
> plugins/phonesim.c-18284-
> plugins/phonesim.c-18285- CALLBACK_WITH_FAILURE(cb, user_data);
> =


Okay, that's a bug.  Fixed.

> gatchat/gatmux.c:19544: if (g_at_chat_send(chat, "AT+CMUX=3D?", cmux_pref=
ix,
> gatchat/gatmux.c-19596- mux_query_cb, msd, msd_free) > 0)
> gatchat/gatmux.c-19634- return TRUE;
> gatchat/gatmux.c-19649-
> gatchat/gatmux.c-19650- if (msd)
> gatchat/gatmux.c-19660- msd_free(msd);
> // this is actually a mistake because the msd pointer won't change, freed=
 or not
> =


I don't see anything wrong here?  Besides the redundant if which will =

always be true.

> drivers/xmm7modem/netmon.c:5135: if (g_at_chat_send(nmd->chat,
> "AT+XMCI=3D1", xmci_prefix,
> drivers/xmm7modem/netmon.c-5192- xmci_cb, cbd, g_free) > 0)
> drivers/xmm7modem/netmon.c-5223- return;
> drivers/xmm7modem/netmon.c-5233-
> drivers/xmm7modem/netmon.c-5234- CALLBACK_WITH_FAILURE(cb, data);

And fixed this as well.

Regards,
-Denis

--===============8308977516245512075==--

