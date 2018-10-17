Content-Type: multipart/mixed; boundary="===============3753190425286557674=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 1/2] Gemalto: voicecall atom
Date: Wed, 17 Oct 2018 22:24:53 +0200
Message-ID: <CAKSBH7HwuXMVKkL4mk3NLcYTG+GCvydRjO=2rS8gj05JvN43pA@mail.gmail.com>
In-Reply-To: <cfb47359-7dc5-1cd9-8a66-46a362c508ad@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3753190425286557674==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 17, 2018 at 9:41 PM Jonas Bonn <jonas@norrbonn.se> wrote:
>
> Hi,
>
>
> On 17/10/18 19:10, Giacinto Cifelli wrote:
> > Added voicecall atom specific for Gemalto modems.
> > This atom uses the URC ^SLCC to monitor the call status, as well as
> > incoming calls.
> > Note the use in the atom of the variable GemaltoVtsQuotes: this is
> > needed to support future modules, as of today not yet available in the
> > plugin.
> > ---
> >   Makefile.am                         | 3 ++-
> >   drivers/gemaltomodem/gemaltomodem.c | 3 +++
> >   drivers/gemaltomodem/gemaltomodem.h | 5 +++++
> >   3 files changed, 10 insertions(+), 1 deletion(-)
>
> What happened here?  You seem to have lost voicecall.c...
>

thanks - I resubmit

> /Jonas

Giacinto

--===============3753190425286557674==--

