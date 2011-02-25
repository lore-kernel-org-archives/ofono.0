Content-Type: multipart/mixed; boundary="===============5368634668187517031=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH] Add CNAP support for isimodem
Date: Fri, 25 Feb 2011 13:53:37 -0300
Message-ID: <20110225165337.GA2107@joana>
In-Reply-To: <AANLkTimb-A6T7LynbST0kNs5NottoBmmP2P86yH=5ED8@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5368634668187517031==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hy Antoine,

Top posting is not allowed on this mailing list. Please stop using it.

* Antoine Reversat <a.reversat@gmail.com> [2011-02-25 11:33:49 -0500]:

> This one should be clean. Sorry it created a new email. I specified a
> message-id but it don't see it as a reply to my mail in gmail here.

Get yourself a proper mail client. Your message shows a reply of the previo=
us
patch.

> =

> On Fri, Feb 25, 2011 at 11:28 AM, Antoine Reversat <a.reversat@gmail.co=
m> wrote:
> > ---
> > =C2=A0drivers/isimodem/voicecall.c | =C2=A0 50 ++++++++++++++++++++++++=
+++++++++++++----
> > =C2=A0src/voicecall.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 =C2=A0 =C2=A05 ++-
> > =C2=A02 files changed, 48 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
> > index 0a32f27..37b0eb3 100644
> > --- a/drivers/isimodem/voicecall.c
> > +++ b/drivers/isimodem/voicecall.c
> > @@ -56,8 +56,10 @@ struct isi_call {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t cause;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t addr_type;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t presentation;
> > + =C2=A0 =C2=A0 =C2=A0 uint8_t name_presentation;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t reason;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0char address[20];
> > + =C2=A0 =C2=A0 =C2=A0 char name[20];
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0char addr_pad[4];
> > =C2=A0};
> >
> > @@ -210,10 +212,13 @@ static void isi_call_any_address_sb_proc(struct i=
si_voicecall *ivc,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t len;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0char *addr;
> >
> > - =C2=A0 =C2=A0 =C2=A0 if (!g_isi_sb_iter_get_byte(sb, &type, 2) ||
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 !g_isi_sb_iter_get_byte(sb, &pres, 3) ||
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 !g_isi_sb_iter_get_byte(sb, &len, 5) ||
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 !g_isi_sb_iter_get_alpha_tag(sb, &addr, 2 * len, 6))
> > + =C2=A0 =C2=A0 =C2=A0 if (!g_isi_sb_iter_get_byte(sb, &type, 2))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> > + =C2=A0 =C2=A0 =C2=A0 if (!g_isi_sb_iter_get_byte(sb, &pres, 3))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> > + =C2=A0 =C2=A0 =C2=A0 if (!g_isi_sb_iter_get_byte(sb, &len, 5))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> > + =C2=A0 =C2=A0 =C2=A0 if (!g_isi_sb_iter_get_alpha_tag(sb, &addr, 2 * =
len, 6))

A separate patch for this change.

-- =

Gustavo F. Padovan
http://profusion.mobi

--===============5368634668187517031==--

