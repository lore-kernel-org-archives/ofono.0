Content-Type: multipart/mixed; boundary="===============6998635877292756582=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 7/9] huaweimodme: prevent use of uninitialized variable
Date: Fri, 26 Oct 2018 13:33:09 +0200
Message-ID: <CAKSBH7FqYCYUUgdqMtqS2aEqH2uujya=kRYuExim6mUDMO-mAw@mail.gmail.com>
In-Reply-To: <158169b0-e5c5-68e0-dd4a-4eea8259c7a4@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6998635877292756582==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 26, 2018 at 12:45 PM Jonas Bonn <jonas@southpole.se> wrote:
>
>
> On 26/10/2018 12:32, Giacinto Cifelli wrote:
> > hi Jonas,
> >
> > On Fri, 26 Oct 2018, 12:13 Jonas Bonn, <jonas@norrbonn.se
> > <mailto:jonas@norrbonn.se>> wrote:
> >
> >     From: Jonas Bonn <jonas(a)southpole.se <mailto:jonas@southpole.se=
>>
> >
> >     Move initialization of 'dcs' ahead of 'content' fetch to prevent
> >     uninitialized use.
> >     ---
> >       drivers/huaweimodem/ussd.c | 6 +++---
> >       1 file changed, 3 insertions(+), 3 deletions(-)
> >
> >     diff --git a/drivers/huaweimodem/ussd.c b/drivers/huaweimodem/ussd.c
> >     index fbed3cd0..f4001108 100644
> >     --- a/drivers/huaweimodem/ussd.c
> >     +++ b/drivers/huaweimodem/ussd.c
> >     @@ -62,12 +62,12 @@ static void cusd_parse(GAtResult *result, struct
> >     ofono_ussd *ussd)
> >              if (!g_at_result_iter_next_number(&iter, &status))
> >                      return;
> >
> >     -       if (!g_at_result_iter_next_string(&iter, &content))
> >     -               goto out;
> >     -
> >              if (!g_at_result_iter_next_number(&iter, &dcs))
> >                      dcs =3D 0;
> >
> >     +       if (!g_at_result_iter_next_string(&iter, &content))
> >     +               goto out;
> >     +
> >
> >
> > aren't you changing the order of the parameters in the command response?
>
> Ah, of course.  Good catch.
>
> Disregard this patch... it's not the right fix.
>
> > Have you tested this on an actual modem?
>
> Don't have one of these.  This patch was addressing a compiler warning,
> but the fix is obviously wrong.

here and in patch 8/9 the it looks like you can get rid of the warning
by initializing the variable:
    int dcs =3D 0;
>
> Thanks,
> Jonas
>
> >
> >              msg_ptr =3D decode_hex_own_buf(content, -1, &msg_len, 0, m=
sg);
> >
> > regards,
> > Giacinto
> >
Regards,
Giacinto

--===============6998635877292756582==--

