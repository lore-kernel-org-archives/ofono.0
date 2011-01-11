Content-Type: multipart/mixed; boundary="===============4838387250739137353=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH] sim: check if lock is locked after code changing attempt
Date: Tue, 11 Jan 2011 12:08:54 -0200
Message-ID: <AANLkTikr1d0b4X=7SjozExp-ftsumQWcBTnDh61EJW5M@mail.gmail.com>
In-Reply-To: <20A4FB08D632914F9C09B9F05CBDF258192D753024@EXMB02.eu.tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4838387250739137353==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi

On Tue, Jan 11, 2011 at 10:17 AM,  <Jussi.Kangas@tieto.com> wrote:
> Hi,
>
> This is fix to Marit Henriksen's TODO item "Check SIM pin status if sim_c=
hange_pin fails". I've discussed with Marit and it's ok for her if I fix th=
e issue. Problem here is that issue could perhaps also be fixed with retry =
counter solution introduced by Lucas De Marchi couple of tasks ago. That wo=
uld seem however require some extra implementation in ste modem ( at least =
I was not able get the ofono show correct values without extra modification=
s ) and I think that isimodems don't have that sort of retry counter at all=
. Because of that and since I had this solution already implemented I propo=
se it to be added as well.
>

I failed to understand why you are hard-coding this and why you'd like
to use retry counters. Can't you just check the pin state by calling
sim_pin_check()?

Moreover, this is not really implementing what the TODO item says.


regards,
Lucas De Marchi

--===============4838387250739137353==--

